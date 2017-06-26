#!/usr/bin/perl
# Copyright 2017 Uwe Kleine-König
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License version 2 as published by the
# Free Software Foundation.

open(my $cpuinfo, "</proc/cpuinfo") or die "failed to open cpuinfo\n";

my $cpunum, $vendor, $family, $model, $stepping, $microcoderev, $hyperthreading;

while (<$cpuinfo>) {
	if (/^$/) {
		print "cpu $cpunum: ";
		if ($vendor eq "GenuineIntel" and $family == 6) {
			if ($model == 78 or $model == 94) {
				if ($stepping eq "3") {
					print "Your CPU is affected, ";
					if (hex($microcoderev) >= 0xb9) {
						print "but your microcode is new enough\n";
					} elsif ($hyperthreading ne "on") {
						print "but hyper threading is off, which works around the problem\n";
					} else {
						print "you should install the latest intel-microcode\n";
					}
				} else {
					print "You may need a BIOS/UEFI update (unknown Skylake-Y/H/U/S stepping)\n";
				}
			} elsif ($model == 85 or $model == 142 or $model == 158) {
				print "You may need a BIOS/UEFI update (Kaby Lake, or Skylake-X processor)\n";
			} else {
				print "You're likely not affected\n";
			}
		} else {
			print "You're not affected\n";
		}

		$cpunum = undef;
		$vendor = undef;
		$family = undef;
		$stepping = undef;
		$microcoderev = undef;
		$hyperthreading = undef;

		next;
	}

	$cpunum = $1 if /^processor\s*:\s(.*)/;
	$vendor = $1 if /^vendor_id\s*:\s(.*)/;
	$family = $1 if /^cpu family\s*:\s(.*)/;
	$model = $1 if /^model\s*:\s(.*)/;
	$stepping = $1 if /^stepping\s*:\s(.*)/;
	$microcoderev = $1 if /^microcode\s*:\s(.*)/;

	if (/^flags\s*:/) {
		if (/^flags\s*:.*\bht\b/) {
			$hyperthreading = "on";
		} else {
			$hyperthreading = "off";
		}
	}
}
