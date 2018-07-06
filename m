Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43970 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932239AbeGFXDa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jul 2018 19:03:30 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so9499529pfm.10
        for <linux-block@vger.kernel.org>; Fri, 06 Jul 2018 16:03:30 -0700 (PDT)
Date: Fri, 6 Jul 2018 16:03:28 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 3/3] Add tests for the SRP initiator and
 target drivers
Message-ID: <20180706230328.GG25954@vader>
References: <20180627214908.26379-1-bart.vanassche@wdc.com>
 <20180627214908.26379-4-bart.vanassche@wdc.com>
 <20180628234305.GB14953@vader>
 <90b8682d-7010-5f57-9ecd-3a4c733ccc18@wdc.com>
 <20180703194913.GA25954@vader>
 <20180703195010.GB25954@vader>
 <20180703213918.GC25954@vader>
 <69e800ccba7644a5a0b26e6d83483310926a907b.camel@wdc.com>
 <20180706212144.GF25954@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180706212144.GF25954@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 06, 2018 at 02:21:44PM -0700, Omar Sandoval wrote:
> On Wed, Jul 04, 2018 at 04:24:42PM +0000, Bart Van Assche wrote:
> > On Tue, 2018-07-03 at 14:39 -0700, Omar Sandoval wrote:
> > > Alright, I installed multipath-tools from source and the segfaults are
> > > gone, but I still don't get these symlinks. Instead, they show up as
> > > 
> > > /dev/disk/by-id/scsi-3600140572616d6469736b32000000000
> > > 
> > > Any ideas?
> > 
> > Hello Omar,
> > 
> > The dm-uuid symlink is created by a udev rule. Apparently that udev rule is not
> > in the same software package as multipathd. Can you run the following command to
> > check whether that udev rule is available on your setup?
> > 
> > grep -r dm-uuid /lib/udev/rules.d/
> 
> $ grep -r dm-uuid /lib/udev/rules.d/
> /lib/udev/rules.d/13-dm-disk.rules:ENV{DM_UUID}=="?*", SYMLINK+="disk/by-id/dm-uuid-$env{DM_UUID}"
> 
> 
> > The name of the package that includes the dm-uuid rule depends on the distro,
> > e.g. dmsetup or device-mapper. According to the git history of git repository
> > https://sourceware.org/git/?p=lvm2.git the dm-uuid udev rule was added to that
> > repository in August 2009, almost nine years ago.
> 
> Yup, it's in the device-mapper package for me on Arch Linux (and Arch
> has very up-to-date versions of everything). I'll try some udev
> debugging.

Alright, I'm not getting the udev events at all (even after enabling
CONFIG_DM_UEVENT in addition to everything mentioned in the README). I
have no idea where to go from here.

After, e.g., srp/002 fails, this is the state of my system:

$ sudo multipath -l
$ ls /sys/class/block
nvme0n1  ram0  ram1  ram2  sda  sdb  sdc  sdd  vda  vda1  vdb  vdc  vdd
$ lsblk
NAME    MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda       8:0    0  32M  0 disk
sdb       8:16   0  32M  0 disk
sdc       8:32   0  32M  0 disk
sdd       8:48   0  32M  0 disk
vda     254:0    0  16G  0 disk
└─vda1  254:1    0  16G  0 part /
vdb     254:16   0   8G  0 disk
vdc     254:32   0   8G  0 disk
vdd     254:48   0   8G  0 disk
nvme0n1 259:0    0   8G  0 disk
$ lsscsi
[0:0:0:0]    disk    Linux    scsi_debug       0188  /dev/sda
[1:0:0:0]    disk    LIO-ORG  IBLOCK           4.0   /dev/sdb
[1:0:0:1]    disk    LIO-ORG  IBLOCK           4.0   /dev/sdd
[1:0:0:2]    disk    LIO-ORG  IBLOCK           4.0   /dev/sdc
