Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 0.mx.nanl.de ([217.115.11.12]:44389 "EHLO 0.mx.nanl.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753560AbdCGKwk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Mar 2017 05:52:40 -0500
Received: from [217.115.11.14] (unknown [217.115.11.14])
        by 0.mx.nanl.de (Postfix) with ESMTPSA id 118E2497FD
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2017 10:32:39 +0000 (UTC)
To: linux-block@vger.kernel.org
From: Mirko Vogt <lkml@nanl.de>
Subject: LOOP_CLR_FD on partition removes mapping for whole device
Message-ID: <56123a0c-2841-339e-23c7-c5f5e906124e@nanl.de>
Date: Tue, 7 Mar 2017 11:34:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

I'm experiencing unexpected behaviour with the ioctl LOOP_CLR_FD on a
*partition* of a loop device: it disassociates the whole (parent) loop
*device*, rather than (trying to) remove the mapping of the addressed
partition.

== Scenario / Environment / Use

In my scenario, I `partprobe` a loop device for having convenient access
to its partitions (I think it uses ioctl(BLKRRPART), but I'm not totally
sure..).

When now calling ioctl(LOOP_CLR_FD) on the loop *partition*, the mapping
of its parent - the overall loop *device* - is removed.

A `strace` reveals, that umount indeed opens the loop partition, so the
ioctl is called on the right inode (I first assumed it being a bug in
umount calling the parent device).

I would not expect ioctl(LOOP_CLR_FD) being called on a loop partition
would result in disassociation of the overall device holding that partition.

Long story short (userland is busybox which behaves slightly different
than the typical tools from util-linux, e.g. umount *by default* gets
rid of the loop device mapping when being called on a dir mounting a
loop device[1]):

root@LEDE:/# loop=$(losetup -f)
root@LEDE:/# echo ${loop}
/dev/loop2
root@LEDE:/# losetup ${loop} /IMAGE
root@LEDE:/# ls -l ${loop}*
brw-------  1 root root     7,   2 Mar  6 20:09 /dev/loop2
root@LEDE:/# partprobe ${loop}
root@LEDE:/# ls -l ${loop}*
brw-------  1 root  root    7,   2 Mar  6 20:09 /dev/loop2
brw-------  1 root  root  259,   8 Mar  6 21:59 /dev/loop2p1
brw-------  1 root  root  259,   9 Mar  6 21:59 /dev/loop2p2
brw-------  1 root  root  259,  10 Mar  6 21:59 /dev/loop2p3
brw-------  1 root  root  259,  11 Mar  6 21:59 /dev/loop2p4
brw-------  1 root  root  259,  12 Mar  6 21:59 /dev/loop2p5
brw-------  1 root  root  259,  13 Mar  6 21:59 /dev/loop2p6
brw-------  1 root  root  259,  14 Mar  6 21:59 /dev/loop2p7
brw-------  1 root  root  259,  15 Mar  6 21:59 /dev/loop2p8
root@LEDE:/# mount ${loop}p8 /MOUNT       # mount loop partition
root@LEDE:/# losetup -a | grep $loop      # loop dev mapping still there
/dev/loop2: 0 /mnt/IMAGE
root@LEDE:/# strace umount /MOUNT 2> /log # unmount loop partition
root@LEDE:/# losetup -a | grep ${loop}    # loop device mapping is gone
root@LEDE:/# grep -i loop /log
open("/dev/loop2p7", O_RDONLY|O_LARGEFILE) = 3
ioctl(3, LOOP_CLR_FD)                   = 0
root@LEDE:/#

Is this intended behaviour or a bug?

Cheers

  mirko


http://lists.busybox.net/pipermail/busybox/2012-April/077619.html
