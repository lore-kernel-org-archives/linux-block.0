Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:50574 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751872AbdKOAgU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Nov 2017 19:36:20 -0500
Received: from [192.168.43.38] ([2.247.241.167]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4CB5-1f4fuy0T9X-00rs9J for
 <linux-block@vger.kernel.org>; Wed, 15 Nov 2017 01:36:19 +0100
To: linux-block@vger.kernel.org
From: "peter.boettcher@gmx.net" <peter.boettcher@gmx.net>
Subject: GPT (more than 256 partitions)
Message-ID: <4fc498fe-fa3a-d0e1-1bb5-ce29704bc699@gmx.net>
Date: Wed, 15 Nov 2017 01:36:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Peter Böttcher
Hingbergstrasse 363
45472 Muelheim Ruhr
NRW
Germany

mail: peter.boettcher@gmx.net


First! Sorry for this english.

I wrote a partition program just for the GUID Partition Table (GPT). 5 
years ago.

The program can generate volumes from 4 to 4096  partitions (my own limit).
GPT header pos. 80 is an unsigned 32 Bit field.

The program can e.g. create partitions with the numbers 1, 10, 100, 200, 
300, 1000, 2000 etc. on the volume.

Windows, FREE/BSD Unix, Mac OS X manage a volume without problems.
They mount all partitions without problems.

So that Linux can do such a volume management, I had to patch the file 
include/linux/genhd.h up to the Linux kernel 4.13.12.
It worked fine for many years.

---------------------------------------------------------------------
patch: include/linux/genhd.h

old: #define DISK_MAX_PARTS  256
new: #define DISK_MAX_PARTS  4096


---------------------------------------------------------------------

In Linux Kernel 4.14.0 I have to patch the following files.

---------------------------------------------------------------------
patch: include/linux/genhd.h

old: #define DISK_MAX_PARTS  256
new: #define DISK_MAX_PARTS  4096

---------------------------------------------------------------------
patch: include/linux/fs.h

struct block_device  {

                                 old: u8 bd_partno;
                                 new: u16 bd_partno;


---------------------------------------------------------------------
patch: include/linux/blk_types.h

struct bio {
                 old: u8 bio_partno;
                 new: u16 bio_partno;

---------------------------------------------------------------------
patch: driver/md/dm-bio-record.h

struct dm_bio_details {
                   old: u8 bio_partno;
                   new: u16 bio_partno;

---------------------------------------------------------------------
patch: driver/md/dm-bio-integrity.c

struct dm_integrity_io {
                 old: u8 bio_partno;
                 new: u16 bio_partno;

---------------------------------------------------------------------


This works well (admittedly short time).


Peter Böttcher
