Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56465C433E6
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 05:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A67208CA
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 05:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tuSpFvkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgIAFig (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAFif (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 01:38:35 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CF5C061290;
        Mon, 31 Aug 2020 22:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0zemR9R4/VH69rJ6GlaHFni0BDRWTXD6MEBJ9YyD5nQ=; b=tuSpFvkBIzzptspwfS85ssJACe
        S+dO7dWu/EeQdcrsjpDDwYWkLIgsNOOA9pVe2c201Tzon6cN+mZFf1LaHBl2oY2I+Bu+dqG3DUg2+
        uqjDohLkzpV9If9/riS4hg9/Lq2MZncXrYA+xhSqxnrVZP54aLpXoGOFN342nzt9SiVMJJE3YB1K7
        pqPU0DY5X25Yf37nlgz74ksTVUXZxCWCFGhcs/8+uCABUXDrWJCyQCG7tMob5DJuhNNOSqLLeniBR
        rZGJ2Dfc9tp3k1BVxDmftCqKLiMMHG0mBoxR6hINcDePRdmn+55S+QGi4foaiyWpiOrd4SKbvJPJC
        GD8x3Bdg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCz05-0000U6-0y; Tue, 01 Sep 2020 05:38:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Karel Zak <kzak@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Mares <mj@ucw.cz>, linux-video@atrey.karlin.mff.cuni.cz,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [RFC PATCH 1/2] Documentation/admin-guide: README & svga: remove use of "rdev"
Date:   Mon, 31 Aug 2020 22:38:21 -0700
Message-Id: <20200901053822.9374-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901053822.9374-1-rdunlap@infradead.org>
References: <20200901053822.9374-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

"rdev" is considered antiquated, ancient, archaic, obsolete, deprecated
{choose any or all}.

Remove use of "rdev" and "vidmode" (a symlink to rdev) in
admin-guide/README.rst and admin-guide/svga.rst.

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

 Documentation/admin-guide/README.rst |    6 +++---
 Documentation/admin-guide/svga.rst   |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20200828.orig/Documentation/admin-guide/README.rst
+++ linux-next-20200828/Documentation/admin-guide/README.rst
@@ -322,9 +322,9 @@ Compiling the kernel
    reboot, and enjoy!
 
    If you ever need to change the default root device, video mode,
-   ramdisk size, etc.  in the kernel image, use the ``rdev`` program (or
-   alternatively the LILO boot options when appropriate).  No need to
-   recompile the kernel to change these parameters.
+   etc. in the kernel image, use your bootloader's boot options
+   where appropriate.  No need to recompile the kernel to change
+   these parameters.
 
  - Reboot with the new kernel and enjoy.
 
--- linux-next-20200828.orig/Documentation/admin-guide/svga.rst
+++ linux-next-20200828/Documentation/admin-guide/svga.rst
@@ -12,7 +12,7 @@ Intro
 This small document describes the "Video Mode Selection" feature which
 allows the use of various special video modes supported by the video BIOS. Due
 to usage of the BIOS, the selection is limited to boot time (before the
-kernel decompression starts) and works only on 80X86 machines.
+kernel decompression starts) and works only on 32-bit 80X86 machines.
 
 .. note::
 
@@ -23,7 +23,7 @@ kernel decompression starts) and works o
 
 The video mode to be used is selected by a kernel parameter which can be
 specified in the kernel Makefile (the SVGA_MODE=... line) or by the "vga=..."
-option of LILO (or some other boot loader you use) or by the "vidmode" utility
+option of LILO (or some other boot loader you use) or by the "xrandr" utility
 (present in standard Linux utility packages). You can use the following values
 of this parameter::
 
@@ -41,7 +41,7 @@ of this parameter::
       better to use absolute mode numbers instead.
 
    0x.... - Hexadecimal video mode ID (also displayed on the menu, see below
-      for exact meaning of the ID). Warning: rdev and LILO don't support
+      for exact meaning of the ID). Warning: LILO doesn't support
       hexadecimal numbers -- you have to convert it to decimal manually.
 
 Menu
