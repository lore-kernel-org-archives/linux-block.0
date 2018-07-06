Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45925 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbeGFXK7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jul 2018 19:10:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9-v6so58655pgp.12
        for <linux-block@vger.kernel.org>; Fri, 06 Jul 2018 16:10:59 -0700 (PDT)
Date: Fri, 6 Jul 2018 16:10:57 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 3/3] Add tests for the SRP initiator and
 target drivers
Message-ID: <20180706231057.GH25954@vader>
References: <20180627214908.26379-4-bart.vanassche@wdc.com>
 <20180628234305.GB14953@vader>
 <90b8682d-7010-5f57-9ecd-3a4c733ccc18@wdc.com>
 <20180703194913.GA25954@vader>
 <20180703195010.GB25954@vader>
 <20180703213918.GC25954@vader>
 <69e800ccba7644a5a0b26e6d83483310926a907b.camel@wdc.com>
 <20180706212144.GF25954@vader>
 <20180706230328.GG25954@vader>
 <e62c7749ff73f1cb7ab91fccffb5f353dd8d7c58.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <e62c7749ff73f1cb7ab91fccffb5f353dd8d7c58.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 06, 2018 at 11:07:06PM +0000, Bart Van Assche wrote:
> On Fri, 2018-07-06 at 16:03 -0700, Omar Sandoval wrote:
> > Alright, I'm not getting the udev events at all (even after enabling
> > CONFIG_DM_UEVENT in addition to everything mentioned in the README). I
> > have no idea where to go from here.
> > 
> > After, e.g., srp/002 fails, this is the state of my system:
> > 
> > $ sudo multipath -l
> > $ ls /sys/class/block
> > nvme0n1  ram0  ram1  ram2  sda  sdb  sdc  sdd  vda  vda1  vdb  vdc  vdd
> > $ lsblk
> > NAME    MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
> > sda       8:0    0  32M  0 disk
> > sdb       8:16   0  32M  0 disk
> > sdc       8:32   0  32M  0 disk
> > sdd       8:48   0  32M  0 disk
> > vda     254:0    0  16G  0 disk
> > └─vda1  254:1    0  16G  0 part /
> > vdb     254:16   0   8G  0 disk
> > vdc     254:32   0   8G  0 disk
> > vdd     254:48   0   8G  0 disk
> > nvme0n1 259:0    0   8G  0 disk
> > $ lsscsi
> > [0:0:0:0]    disk    Linux    scsi_debug       0188  /dev/sda
> > [1:0:0:0]    disk    LIO-ORG  IBLOCK           4.0   /dev/sdb
> > [1:0:0:1]    disk    LIO-ORG  IBLOCK           4.0   /dev/sdd
> > [1:0:0:2]    disk    LIO-ORG  IBLOCK           4.0   /dev/sdc
> 
> That's weird. If you want I can install Arch Linux myself and debug this
> further.

At this point, that might be easier.

> Something that would also help is if you could run the following
> commands as root and provide their output:
> 
> echo reconfigure | multipathd -k
> multipath -ll

# cat /etc/multipath.conf
defaults {
    user_friendly_names     yes
    queue_without_daemon    no
}
devices {
    device {
        vendor       "LIO-ORG|SCST_BIO|FUSIONIO"
        product      ".*"
        features     "1 queue_if_no_path"
        path_checker tur
    }
}
blacklist {
    device {
        vendor  "ATA"
    }
    device {
        vendor  "QEMU"
    }
    device {
        vendor  "Linux"
        product "scsi_debug"
    }
    devnode     "^nullb.*"
}
blacklist_exceptions {
    property        ".*"
    devnode         "^nvme"
}
# echo reconfigure | multipathd -k
multipathd> reconfigure
ok
multipathd>
# multipath -ll

So, no output.
