Return-Path: <linux-block-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([138.201.34.84]:35518 "EHLO
        mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdISK2l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Sep 2017 06:28:41 -0400
Date: Tue, 19 Sep 2017 13:22:49 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linux-block@vger.kernel.org
Subject: blkdiscard apparently failing to fully discard a SATA SSD
Message-ID: <20170919102249.GN1169@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello!

When I use blkdiscard to trim a SATA SSD in its entirety, it seems that
not all sectors are getting trimmed.  I initially ran into this on a
Sandisk SDSSDA240G, but I reproduced it on a Samsung 850 EVO M.2 250GB
and a few other SATA SSDs.  This happens on Fedora kernel
"4.11.11-300.fc26.x86_64" and a few other Fedora kernels.

For this test, I have the following SSD:

	[root@testbox ~]# smartctl -a /dev/sda
	smartctl 6.5 2016-05-07 r4318 [x86_64-linux-4.11.11-300.fc26.x86_64] (local build)
	Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

	=== START OF INFORMATION SECTION ===
	Model Family:     SandForce Driven SSDs
	Device Model:     SanDisk SDSSDA240G
	Serial Number:    154307402302
	LU WWN Device Id: 5 001b44 ef905163e
	Firmware Version: Z22000RL
	User Capacity:    240,057,409,536 bytes [240 GB]
	[...]

Which at the start of the test is completely "empty":

	[root@testbox ~]# cat /dev/sda | od -t x1 -Ax -
	000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	*
	37e4896000
	[root@testbox ~]#

I then write a 64 bit byte offset from the start of the disk to every
64 bit word, which looks as follows:

	[root@testbox ~]# cat /dev/sda | od -Ax -t x1 - | head -5
	000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08
	000010 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 18
	000020 00 00 00 00 00 00 00 20 00 00 00 00 00 00 00 28
	000030 00 00 00 00 00 00 00 30 00 00 00 00 00 00 00 38
	000040 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 48
	[root@testbox ~]# cat /dev/sda | od -Ax -t x1 - | head -1048576 | tail -5
	ffffb0 00 00 00 00 00 ff ff b0 00 00 00 00 00 ff ff b8
	ffffc0 00 00 00 00 00 ff ff c0 00 00 00 00 00 ff ff c8
	ffffd0 00 00 00 00 00 ff ff d0 00 00 00 00 00 ff ff d8
	ffffe0 00 00 00 00 00 ff ff e0 00 00 00 00 00 ff ff e8
	fffff0 00 00 00 00 00 ff ff f0 00 00 00 00 00 ff ff f8
	[root@testbox ~]#

I then blkdiscard the whole SSD in one go:

	[root@testbox ~]# blkdiscard -v /dev/sda
	/dev/sda: Discarded 240057409536 bytes from the offset 0
	[root@testbox ~]#

>From summing iostat kB_wrtn column data during the blkdiscard, it seems
that all of the sectors on the SSD should have been covered by the trim
operation, but this doesn't seem to zero all of the sectors -- some of
them keep their original contents:

	[root@testbox ~]# cat /dev/sda | od -Ax -t x1 - | head -10
	000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	*
	1fff000 00 00 00 00 01 ff f0 00 00 00 00 00 01 ff f0 08
	1fff010 00 00 00 00 01 ff f0 10 00 00 00 00 01 ff f0 18
	1fff020 00 00 00 00 01 ff f0 20 00 00 00 00 01 ff f0 28
	1fff030 00 00 00 00 01 ff f0 30 00 00 00 00 01 ff f0 38
	1fff040 00 00 00 00 01 ff f0 40 00 00 00 00 01 ff f0 48
	1fff050 00 00 00 00 01 ff f0 50 00 00 00 00 01 ff f0 58
	1fff060 00 00 00 00 01 ff f0 60 00 00 00 00 01 ff f0 68
	1fff070 00 00 00 00 01 ff f0 70 00 00 00 00 01 ff f0 78
	[...]

More specifically, there's this pattern:

	[root@testbox ~]# cat /dev/sda | od -Ax -t x1 - | grep -A1 -B2 '^*' | head -20
	000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	*
	1fff000 00 00 00 00 01 ff f0 00 00 00 00 00 01 ff f0 08
	--
	1fffff0 00 00 00 00 01 ff ff f0 00 00 00 00 01 ff ff f8
	2000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	*
	3fff000 00 00 00 00 03 ff f0 00 00 00 00 00 03 ff f0 08
	--
	3fffff0 00 00 00 00 03 ff ff f0 00 00 00 00 03 ff ff f8
	4000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	*
	5fff000 00 00 00 00 05 ff f0 00 00 00 00 00 05 ff f0 08
	--
	5fffff0 00 00 00 00 05 ff ff f0 00 00 00 00 05 ff ff f8
	6000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	*
	7fff000 00 00 00 00 07 ff f0 00 00 00 00 00 07 ff f0 08
	--
	7fffff0 00 00 00 00 07 ff ff f0 00 00 00 00 07 ff ff f8
	[...]

Even if trimming a sector doesn't guarantee that subsequent reads will
return zeroes, the weird thing is is that this behavior seems to be
consistent across different SSD models, down to which specific sectors
are zeroed and which are not.

If I blkdiscard the whole SSD again, the same pattern remains on the
disk, but if I blkdiscard it again with an appropriate offset:

	[root@testbox ~]# blkdiscard -v -o 1048576 /dev/sda
	/dev/sda: Discarded 240056360960 bytes from the offset 1048576
	[root@testbox ~]#

I then get an SSD that returns zeroes again from every sector:

	[root@testbox ~]# cat /dev/sda | od -t x1 -Ax -
	000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	*
	37e4896000
	[root@testbox ~]#

Since the pattern seems to be a consistent untrimmed 4096 bytes every
32 MiB, I wonder if there is maybe some off-by-one in discard request
processing somewhere.

Can anyone other than me reproduce this?


Cheers,
Lennert
