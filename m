Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B93C4167B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 07:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1CE323D4D
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 07:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbgLJH4b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 02:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgLJH4b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 02:56:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E1CC061794
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 23:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qcycuec7K6ybKgAUSiZdVIk33j0bEAd1+25l2H8+U1o=; b=C/oipVn19eWw25EI+mhMcz/Ofz
        hoEwpycDrINlYxLlZhkUyuoLwnNpOlxD7Gokz3S6OKumtRBUaXZsNWLCM7q+4uBfMekQo406mPzM0
        W6+vR82VZalM6Ro3i8uiyuOeeKvGDlGCYpb3Fp6n20QwvIA9r0HG1rbubQ55VJVRDzg1WPh48upnA
        KpOxYtAGt33LR7moMihA/AA0fGs1teQwjjMR/fhO5opOBVfQGpHSpf6HPwn1+htf+/ZCgx4kNQXF2
        7+MeAGWMn6Y/Otmt+VeV1aGBT2QKrO0EgCC1FF9iPvbr7NWCD/wV9c/ixC+mbfroMwV2oK/1EaQY0
        dmL2W4TQ==;
Received: from [2001:4bb8:199:f14c:a24a:d231:8d9c:a947] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knGnl-0002Zt-7p; Thu, 10 Dec 2020 07:55:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: update some copyrights
Date:   Thu, 10 Dec 2020 08:55:44 +0100
Message-Id: <20201210075544.2715861-4-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210075544.2715861-1-hch@lst.de>
References: <20201210075544.2715861-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update copyrights for files that have gotten some major rewrites lately.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c           | 2 ++
 block/partitions/core.c | 1 +
 fs/block_dev.c          | 1 +
 3 files changed, 4 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index b84b8671e6270a..73faec438e49a8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  *  gendisk handling
+ *
+ * Portions Copyright (C) 2020 Christoph Hellwig
  */
 
 #include <linux/module.h>
diff --git a/block/partitions/core.c b/block/partitions/core.c
index deca253583bd3f..e7d776db803b12 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 1991-1998  Linus Torvalds
  * Re-organised Feb 1998 Russell King
+ * Copyright (C) 2020 Christoph Hellwig
  */
 #include <linux/fs.h>
 #include <linux/slab.h>
diff --git a/fs/block_dev.c b/fs/block_dev.c
index d2fa5009d5a481..9293045e128cdc 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2,6 +2,7 @@
 /*
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *  Copyright (C) 2001  Andrea Arcangeli <andrea@suse.de> SuSE
+ *  Copyright (C) 2016 - 2020 Christoph Hellwig
  */
 
 #include <linux/init.h>
-- 
2.29.2

