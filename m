Return-Path: <SRS0=GCUE=C3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D916C43466
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 01:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CAC20872
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 01:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mpZsUV3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIRB4x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Sep 2020 21:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRB4x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 21:56:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95ECC06174A;
        Thu, 17 Sep 2020 18:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2vCDwiPR2yaZdRJxWxgBGGfBruV3oiY2jDxmJ1dPfyo=; b=mpZsUV3iI6ME1iCtPwx9U99TlA
        0ZfoagZAb4dVB+cyPmH41GaHhHtB+BlVvd6r36kL2xoOqwzkl8JAmZAHbF/cNqnO39UKHenqfth1T
        1kwEpObXDx6XJPYQEKERAKHcvMks33r7A83lLSJrz3PZQSJbDUR4Yf4wKem+U8N0dr37MvGZGU7y0
        bi1u883t8b9N03102tksoVnbhyyy7cxHTJeZmiesqs6nPT6R5jpTdZdHo45mY07Uo/V6DTQAP4uOr
        vuliLZd+CNneK5dprmMajckBnuiUUKz7nPWjrZr7J921cUxukwKrAo3J48YefZ2a93iUkWQZxDxf9
        vzmZzIWQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ5dr-0007g2-5n; Fri, 18 Sep 2020 01:56:51 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Karel Zak <kzak@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Mares <mj@ucw.cz>, linux-video@atrey.karlin.mff.cuni.cz,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [RFC PATCH v2 2/2] Documentation/admin-guide: blockdev/ramdisk: remove use of "rdev"
Date:   Thu, 17 Sep 2020 18:56:40 -0700
Message-Id: <20200918015640.8439-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918015640.8439-1-rdunlap@infradead.org>
References: <20200918015640.8439-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove use of "rdev" from blockdev/ramdisk.rst and update
admin-guide/kernel-parameters.txt.

"rdev" is considered antiquated, ancient, archaic, obsolete, deprecated
{choose any or all}.

"rdev" was removed from util-linux in 2010:
  https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=a3e40c14651fccf18e7954f081e601389baefe3f

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Karel Zak <kzak@redhat.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Martin Mares <mj@ucw.cz>
Cc: linux-video@atrey.karlin.mff.cuni.cz
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
v2: modify Changelog date format.

No email address for these:
 nCc: Werner Almesberger
 nCc: Stephen Tweedie
 nCc: Peter MacDonald

 Documentation/admin-guide/blockdev/ramdisk.rst  |   70 ++++----------
 Documentation/admin-guide/kernel-parameters.txt |    9 -
 2 files changed, 27 insertions(+), 52 deletions(-)

--- lnx-59-rc5.orig/Documentation/admin-guide/blockdev/ramdisk.rst
+++ lnx-59-rc5/Documentation/admin-guide/blockdev/ramdisk.rst
@@ -6,7 +6,7 @@ Using the RAM disk block device with Lin
 
 	1) Overview
 	2) Kernel Command Line Parameters
-	3) Using "rdev -r"
+	3) Using "rdev"
 	4) An Example of Creating a Compressed RAM Disk
 
 
@@ -59,51 +59,27 @@ default is 4096 (4 MB).
 	rd_size
 		See ramdisk_size.
 
-3) Using "rdev -r"
-------------------
+3) Using "rdev"
+---------------
 
-The usage of the word (two bytes) that "rdev -r" sets in the kernel image is
-as follows. The low 11 bits (0 -> 10) specify an offset (in 1 k blocks) of up
-to 2 MB (2^11) of where to find the RAM disk (this used to be the size). Bit
-14 indicates that a RAM disk is to be loaded, and bit 15 indicates whether a
-prompt/wait sequence is to be given before trying to read the RAM disk. Since
-the RAM disk dynamically grows as data is being written into it, a size field
-is not required. Bits 11 to 13 are not currently used and may as well be zero.
-These numbers are no magical secrets, as seen below::
-
-  ./arch/x86/kernel/setup.c:#define RAMDISK_IMAGE_START_MASK     0x07FF
-  ./arch/x86/kernel/setup.c:#define RAMDISK_PROMPT_FLAG          0x8000
-  ./arch/x86/kernel/setup.c:#define RAMDISK_LOAD_FLAG            0x4000
-
-Consider a typical two floppy disk setup, where you will have the
-kernel on disk one, and have already put a RAM disk image onto disk #2.
-
-Hence you want to set bits 0 to 13 as 0, meaning that your RAM disk
-starts at an offset of 0 kB from the beginning of the floppy.
-The command line equivalent is: "ramdisk_start=0"
-
-You want bit 14 as one, indicating that a RAM disk is to be loaded.
-The command line equivalent is: "load_ramdisk=1"
-
-You want bit 15 as one, indicating that you want a prompt/keypress
-sequence so that you have a chance to switch floppy disks.
-The command line equivalent is: "prompt_ramdisk=1"
-
-Putting that together gives 2^15 + 2^14 + 0 = 49152 for an rdev word.
-So to create disk one of the set, you would do::
-
-	/usr/src/linux# cat arch/x86/boot/zImage > /dev/fd0
-	/usr/src/linux# rdev /dev/fd0 /dev/fd0
-	/usr/src/linux# rdev -r /dev/fd0 49152
+"rdev" is an obsolete, deprecated, antiquated utility that could be used
+to set the boot device in a Linux kernel image.
 
-If you make a boot disk that has LILO, then for the above, you would use::
+Instead of using rdev, just place the boot device information on the
+kernel command line and pass it to the kernel from the bootloader.
+
+You can also pass arguments to the kernel by setting FDARGS in
+arch/x86/boot/Makefile and specify in initrd image by setting FDINITRD in
+arch/x86/boot/Makefile.
 
-	append = "ramdisk_start=0 load_ramdisk=1 prompt_ramdisk=1"
+Some of the kernel command line boot options that may apply here are::
 
-Since the default start = 0 and the default prompt = 1, you could use::
+  ramdisk_start=N
+  ramdisk_size=M
 
-	append = "load_ramdisk=1"
+If you make a boot disk that has LILO, then for the above, you would use::
 
+	append = "ramdisk_start=N ramdisk_size=M"
 
 4) An Example of Creating a Compressed RAM Disk
 -----------------------------------------------
@@ -151,12 +127,9 @@ f) Put the RAM disk image onto the flopp
 
 	dd if=/tmp/ram_image.gz of=/dev/fd0 bs=1k seek=400
 
-g) Use "rdev" to set the boot device, RAM disk offset, prompt flag, etc.
-   For prompt_ramdisk=1, load_ramdisk=1, ramdisk_start=400, one would
-   have 2^15 + 2^14 + 400 = 49552::
-
-	rdev /dev/fd0 /dev/fd0
-	rdev -r /dev/fd0 49552
+g) Make sure that you have already specified the boot information in
+   FDARGS and FDINITRD or that you use a bootloader to pass kernel
+   command line boot options to the kernel.
 
 That is it. You now have your boot/root compressed RAM disk floppy. Some
 users may wish to combine steps (d) and (f) by using a pipe.
@@ -167,11 +140,14 @@ users may wish to combine steps (d) and
 Changelog:
 ----------
 
+SEPT-2020 :
+
+                Removed usage of "rdev"
+
 10-22-04 :
 		Updated to reflect changes in command line options, remove
 		obsolete references, general cleanup.
 		James Nelson (james4765@gmail.com)
 
-
 12-95 :
 		Original Document
--- lnx-59-rc5.orig/Documentation/admin-guide/kernel-parameters.txt
+++ lnx-59-rc5/Documentation/admin-guide/kernel-parameters.txt
@@ -2441,8 +2441,7 @@
 
 	memblock=debug	[KNL] Enable memblock debug messages.
 
-	load_ramdisk=	[RAM] List of ramdisks to load from floppy
-			See Documentation/admin-guide/blockdev/ramdisk.rst.
+	load_ramdisk=	[RAM] [Deprecated]
 
 	lockd.nlm_grace_period=P  [NFS] Assign grace period.
 			Format: <integer>
@@ -3921,9 +3920,7 @@
 			Param: <number> - step/bucket size as a power of 2 for
 				statistical time based profiling.
 
-	prompt_ramdisk=	[RAM] List of RAM disks to prompt for floppy disk
-			before loading.
-			See Documentation/admin-guide/blockdev/ramdisk.rst.
+	prompt_ramdisk=	[RAM] [Deprecated]
 
 	prot_virt=	[S390] enable hosting protected virtual machines
 			isolated from the hypervisor (if hardware supports
@@ -3981,6 +3978,8 @@
 	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
 			See Documentation/admin-guide/blockdev/ramdisk.rst.
 
+	ramdisk_start=	[RAM] RAM disk image start address
+
 	random.trust_cpu={on,off}
 			[KNL] Enable or disable trusting the use of the
 			CPU's random number generator (if available) to
