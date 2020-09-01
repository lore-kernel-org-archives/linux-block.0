Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF81C433E7
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 05:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BAE2098B
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 05:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SNGPMTiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIAFil (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAFij (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 01:38:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67555C061290;
        Mon, 31 Aug 2020 22:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=80mHTn31aHCL/8XD5wYu0PJaFNajTzgos6luJ5PtEyc=; b=SNGPMTiJOVg9hCVs3/7gs4UM+Q
        G+BZjNm3L30SIDj6kD5rk+f/laUkl4CAkwDdI2rNot3FeZ1T+m9+zagwExaI4ov/6lSrxLcw6bYte
        vsPvpXDTSmjrwVLXvKloq3+4zDKyYQUt7LXpW06yOdw94QSl9ITn3/OTdQa/3zOxmZNcnqhWEtbcc
        mgdDu27QAxSVj65W8a2ugLCr309J+nfl9ZfHCKR4ZqGupNOFSRhjTqJ92Z6ikhDa03LneEUpfPteK
        /bBIsQrmLF34a+SA0/Ps1Z5rHkyEXbg6PHkKUXZk18K9UTt4uWlCHyrjE39uqFaaVKJ7I4SNCdXck
        bkvdYDsQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCz09-0000U6-0Z; Tue, 01 Sep 2020 05:38:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Karel Zak <kzak@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Mares <mj@ucw.cz>, linux-video@atrey.karlin.mff.cuni.cz,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [RFC PATCH 2/2] Documentation/admin-guide: blockdev/ramdisk: remove use of "rdev"
Date:   Mon, 31 Aug 2020 22:38:22 -0700
Message-Id: <20200901053822.9374-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901053822.9374-1-rdunlap@infradead.org>
References: <20200901053822.9374-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
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
No email address for these:
 nCc: Werner Almesberger
 nCc: Stephen Tweedie
 nCc: Peter MacDonald

 Documentation/admin-guide/blockdev/ramdisk.rst  |   70 ++++----------
 Documentation/admin-guide/kernel-parameters.txt |    9 -
 2 files changed, 27 insertions(+), 52 deletions(-)

--- linux-next-20200828.orig/Documentation/admin-guide/blockdev/ramdisk.rst
+++ linux-next-20200828/Documentation/admin-guide/blockdev/ramdisk.rst
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
 
+09-2020 :
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
--- linux-next-20200828.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20200828/Documentation/admin-guide/kernel-parameters.txt
@@ -2441,8 +2441,7 @@
 
 	memblock=debug	[KNL] Enable memblock debug messages.
 
-	load_ramdisk=	[RAM] List of ramdisks to load from floppy
-			See Documentation/admin-guide/blockdev/ramdisk.rst.
+	load_ramdisk=	[RAM] [Deprecated]
 
 	lockd.nlm_grace_period=P  [NFS] Assign grace period.
 			Format: <integer>
@@ -3925,9 +3924,7 @@
 			Param: <number> - step/bucket size as a power of 2 for
 				statistical time based profiling.
 
-	prompt_ramdisk=	[RAM] List of RAM disks to prompt for floppy disk
-			before loading.
-			See Documentation/admin-guide/blockdev/ramdisk.rst.
+	prompt_ramdisk=	[RAM] [Deprecated]
 
 	prot_virt=	[S390] enable hosting protected virtual machines
 			isolated from the hypervisor (if hardware supports
@@ -3985,6 +3982,8 @@
 	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
 			See Documentation/admin-guide/blockdev/ramdisk.rst.
 
+	ramdisk_start=	[RAM] RAM disk image start address
+
 	random.trust_cpu={on,off}
 			[KNL] Enable or disable trusting the use of the
 			CPU's random number generator (if available) to
