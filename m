Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AD9C433E0
	for <linux-block@archiver.kernel.org>; Sat,  2 Jan 2021 17:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C186207C8
	for <linux-block@archiver.kernel.org>; Sat,  2 Jan 2021 17:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbhABRtG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Jan 2021 12:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbhABRtF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Jan 2021 12:49:05 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C016C061573;
        Sat,  2 Jan 2021 09:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=S7p51Lc5xMAOvOoX3ZSkMHpgztR/f405LG72Dxg/pYg=; b=3Wwz9rEfYBVqO9g7/aHnjYrqIs
        hKiNeLHEqh4ap7PBYNcyz+eU2y3nINfqxTcS7FaQihsQZq3TkOoevQ4VrbuL5Gm/OVVvVXwAboLcC
        nk+z0MQaMT2VX3mqEMPjVjEpRVYBm16xDEdM6vG2kq4FkbmNhi5soOnLAz2RvtGJ/hr/V6ouEiU1Q
        1iaCIMaV17BlazLTE6Lf2/Z1cjkL65ITrWZngo159NwG0iOWzFluCGi3GrypGWesLn7sFbtJntYaR
        vZXMtq2+KyOjQfYENo6WA+bGfDAoU4yM0HrtXUuwrYYTsGKbH09udFTJmadfc728th7QxP66novNT
        TCIrQoZQ==;
Received: from [2601:1c0:6280:3f0::2c43] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kvl0n-0003Gi-IP; Sat, 02 Jan 2021 17:48:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH] fs: block_dev.c: use consistent function doc. notation
Date:   Sat,  2 Jan 2021 09:48:14 -0800
Message-Id: <20210102174814.10636-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use only one hyphen in kernel-doc notation between the function name
and its short description.

The is the documented kerenl-doc format. It also fixes the html
presentation to be consistent with other functions.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 fs/block_dev.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- lnx-511-rc1.orig/fs/block_dev.c
+++ lnx-511-rc1/fs/block_dev.c
@@ -533,7 +533,7 @@ int fsync_bdev(struct block_device *bdev
 EXPORT_SYMBOL(fsync_bdev);
 
 /**
- * freeze_bdev  --  lock a filesystem and force it into a consistent state
+ * freeze_bdev - lock a filesystem and force it into a consistent state
  * @bdev:	blockdevice to lock
  *
  * If a superblock is found on this device, we take the s_umount semaphore
@@ -577,7 +577,7 @@ done:
 EXPORT_SYMBOL(freeze_bdev);
 
 /**
- * thaw_bdev  -- unlock filesystem
+ * thaw_bdev - unlock filesystem
  * @bdev:	blockdevice to unlock
  *
  * Unlocks the filesystem and marks it writeable again after freeze_bdev().
@@ -907,7 +907,7 @@ static struct block_device *bdget(dev_t
 }
 
 /**
- * bdgrab -- Grab a reference to an already referenced block device
+ * bdgrab - Grab a reference to an already referenced block device
  * @bdev:	Block device to grab a reference to.
  *
  * Returns the block_device with an additional reference when successful,
