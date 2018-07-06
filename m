Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:38268 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbeGFXPS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jul 2018 19:15:18 -0400
Received: by mail-pf0-f174.google.com with SMTP id j17-v6so9528533pfn.5
        for <linux-block@vger.kernel.org>; Fri, 06 Jul 2018 16:15:18 -0700 (PDT)
Date: Fri, 6 Jul 2018 16:15:16 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 3/3] Add tests for the SRP initiator and
 target drivers
Message-ID: <20180706231516.GI25954@vader>
References: <20180628234305.GB14953@vader>
 <90b8682d-7010-5f57-9ecd-3a4c733ccc18@wdc.com>
 <20180703194913.GA25954@vader>
 <20180703195010.GB25954@vader>
 <20180703213918.GC25954@vader>
 <69e800ccba7644a5a0b26e6d83483310926a907b.camel@wdc.com>
 <20180706212144.GF25954@vader>
 <20180706230328.GG25954@vader>
 <e62c7749ff73f1cb7ab91fccffb5f353dd8d7c58.camel@wdc.com>
 <20180706231057.GH25954@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180706231057.GH25954@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This might also be useful:

# /sbin/multipathd -d -s -v 3
--------start up--------
read /etc/multipath.conf
loading /lib64/multipath/libchecktur.so checker
loading /lib64/multipath/libprioconst.so prioritizer
foreign library "nvme" loaded successfully
set open fds limit to 1048576/1048576
path checkers start up
uxsock: startup listener
No configuration dir '/etc/multipath/conf.d'
sdb: udev property DEVLINKS whitelisted
sdb: mask = 0x1f
sdb: dev_t = 8:16
sdb: size = 65536
sdb: vendor = LIO-ORG
sdb: product = IBLOCK
sdb: rev = 4.0
sdb: h:b:t:l = 1:0:0:0
sdb: tgt_node_name =
sdb: path state = running
sdb: 1024 cyl, 2 heads, 32 sectors/track, start at 0
sdb: serial = 72616d6469736b31000000000
sdb: get_state
sdb: detect_checker = yes (setting: multipath internal)
failed to issue vpd inquiry for pgc9
sdb: path_checker = tur (setting: storage device autodetected)
sdb: checker timeout = 30 s (setting: kernel sysfs)
sdb: tur state = up
sdb: uid_attribute = ID_SERIAL (setting: multipath internal)
sdb: uid = 3600140572616d6469736b31000000000 (udev)
sdb: detect_prio = yes (setting: multipath internal)
failed to issue vpd inquiry for pgc9
loading /lib64/multipath/libpriosysfs.so prioritizer
sdb: prio = sysfs (setting: storage device autodetected)
sdb: prio args = "" (setting: storage device autodetected)
sdb: sysfs prio = 50
sdd: udev property DEVLINKS whitelisted
sdd: mask = 0x1f
sdd: dev_t = 8:48
sdd: size = 65536
sdd: vendor = LIO-ORG
sdd: product = IBLOCK
sdd: rev = 4.0
sdd: h:b:t:l = 1:0:0:1
sdd: tgt_node_name =
sdd: path state = running
sdd: 1024 cyl, 2 heads, 32 sectors/track, start at 0
sdd: serial = 72616d6469736b32000000000
sdd: get_state
sdd: detect_checker = yes (setting: multipath internal)
failed to issue vpd inquiry for pgc9
sdd: path_checker = tur (setting: storage device autodetected)
sdd: checker timeout = 30 s (setting: kernel sysfs)
sdd: tur state = up
sdd: uid_attribute = ID_SERIAL (setting: multipath internal)
sdd: uid = 3600140572616d6469736b32000000000 (udev)
sdd: detect_prio = yes (setting: multipath internal)
failed to issue vpd inquiry for pgc9
sdd: prio = sysfs (setting: storage device autodetected)
sdd: prio args = "" (setting: storage device autodetected)
sdd: sysfs prio = 50
sdc: udev property DEVLINKS whitelisted
sdc: mask = 0x1f
sdc: dev_t = 8:32
sdc: size = 65536
sdc: vendor = LIO-ORG
sdc: product = IBLOCK
sdc: rev = 4.0
sdc: h:b:t:l = 1:0:0:2
sdc: tgt_node_name =
sdc: path state = running
sdc: 1024 cyl, 2 heads, 32 sectors/track, start at 0
sdc: serial = 7363736964626700000000000
sdc: get_state
sdc: detect_checker = yes (setting: multipath internal)
failed to issue vpd inquiry for pgc9
sdc: path_checker = tur (setting: storage device autodetected)
sdc: checker timeout = 30 s (setting: kernel sysfs)
sdc: tur state = up
sdc: uid_attribute = ID_SERIAL (setting: multipath internal)
sdc: uid = 360014057363736964626700000000000 (udev)
sdc: detect_prio = yes (setting: multipath internal)
failed to issue vpd inquiry for pgc9
sdc: prio = sysfs (setting: storage device autodetected)
sdc: prio args = "" (setting: storage device autodetected)
sdc: sysfs prio = 50
nvme0n1: udev property DEVLINKS whitelisted
nvme0n1: device node name whitelisted
nvme0n1: mask = 0x1f
nvme0n1: dev_t = 259:0
nvme0n1: size = 16777216
nvme0n1: vendor = NVME
nvme0n1: product = QEMU NVMe Ctrl
nvme0n1: serial = 1337
nvme0n1: rev = 1.0
nvme0n1: path state = live
nvme0n1: 8192 cyl, 64 heads, 32 sectors/track, start at 0
nvme0n1: get_state
nvme0n1: detect_checker = yes (setting: multipath internal)
nvme0n1: path_checker = none (setting: storage device configuration)
nvme0n1: checker timeout = 30 s (setting: multipath internal)
nvme0n1: none state = up
nvme0n1: uid_attribute = ID_WWN (setting: storage device configuration)
nvme0n1: uid = nvme.8086-31333337-51454d55204e564d65204374726c-00000001
(udev)
nvme0n1: detect_prio = yes (setting: multipath internal)
nvme0n1: prio = const (setting: multipath internal)
nvme0n1: prio args = "" (setting: multipath internal)
nvme0n1: const prio = 1
vda: udev property DEVLINKS whitelisted
vda: device node name blacklisted
vdb: udev property DEVLINKS whitelisted
vdb: device node name blacklisted
vdc: udev property DEVLINKS whitelisted
vdc: device node name blacklisted
vdd: udev property DEVLINKS whitelisted
vdd: device node name blacklisted
sda: udev property DEVLINKS whitelisted
sda: mask = 0x1f
sda: dev_t = 8:0
sda: size = 65536
sda: vendor = Linux
sda: product = scsi_debug
sda: rev = 0188
sda: h:b:t:l = 0:0:0:0
sda: tgt_node_name =
sda: path state = running
sda: 1024 cyl, 2 heads, 32 sectors/track, start at 0
sda: serial = 2000
sda: get_state
sda: detect_checker = yes (setting: multipath internal)
failed to issue vpd inquiry for pgc9
sda: path_checker = tur (setting: multipath internal)
sda: checker timeout = 30 s (setting: kernel sysfs)
sda: tur state = up
sda: uid_attribute = ID_SERIAL (setting: multipath internal)
sda: uid = 333333330000007d0 (udev)
sda: detect_prio = yes (setting: multipath internal)
sda: prio = const (setting: multipath internal)
sda: prio args = "" (setting: multipath internal)
sda: const prio = 1
ram0: udev property DEVNAME whitelisted
ram0: device node name blacklisted
ram1: udev property DEVNAME whitelisted
ram1: device node name blacklisted
ram2: udev property DEVNAME whitelisted
ram2: device node name blacklisted
sdb: udev property DEVLINKS whitelisted
sdd: udev property DEVLINKS whitelisted
sdc: udev property DEVLINKS whitelisted
nvme0n1: udev property DEVLINKS whitelisted
sda: udev property DEVLINKS whitelisted
sda: (Linux:scsi_debug) vendor/product blacklisted
tur checker refcount 4
const prioritizer refcount 2
libdevmapper version 1.02.146 (2017-12-18)
DM multipath kernel driver v1.13.0
sdb: udev property DEVLINKS whitelisted
wwid 3600140572616d6469736b31000000000 not in wwids file, skipping sdb
sdb: orphan path, only one path
sysfs prioritizer refcount 3
tur checker refcount 3
sdd: udev property DEVLINKS whitelisted
wwid 3600140572616d6469736b32000000000 not in wwids file, skipping sdd
sdd: orphan path, only one path
sysfs prioritizer refcount 2
tur checker refcount 2
sdc: udev property DEVLINKS whitelisted
wwid 360014057363736964626700000000000 not in wwids file, skipping sdc
sdc: orphan path, only one path
sysfs prioritizer refcount 1
tur checker refcount 1
nvme0n1: udev property DEVLINKS whitelisted
wwid nvme.8086-31333337-51454d55204e564d65204374726c-00000001 not in
wwids file, skipping nvme0n1
nvme0n1: orphan path, only one path
const prioritizer refcount 1
none checker refcount 1
exit (signal)
^CReleasing uevent_monitor() resources
Releasing uevent_listen() resources
unloading none checker
unloading tur checker
unloading sysfs prioritizer
unloading const prioritizer
unlink pidfile
--------shut down-------
