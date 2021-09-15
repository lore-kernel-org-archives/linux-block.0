Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B72C433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535686103E
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhIOGyC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 02:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhIOGyC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 02:54:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0502AC061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 23:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nE1rzcP+uxAtim1Xl9bMmZThKHSxIApngt/BrvVLTQQ=; b=vx1nG4UWorxbocEYBK8qRBrURt
        HNZ7hOrVEy8rbUOXUPkZ5LppUzZTb2bVsmV6OdSvLRuQurPsqvTFkI8lvtIKiadUEaS6BLvudlDyn
        v8ZQDpBW962faMn0wlwJeL7ws/dotTwX4iX56ahAhYzQIE8tuAwUvrFvaQ6Jes0OMEUrrnXOf9zzM
        zLKiiMmstKD/FvupFYFxQwXaQsnd4qHVtxVemAR3yJc6LP4xnTNGkwVk69kd8Y5D8sLZM3E/NXGh4
        HLd8nGbNVboY7+9GGF5K7wQjnopHK3mKaTAIASwqsBLBtg8h4JODa1rGsnW87XGszNDkq1dVzPTod
        lcoN3Syg==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOlq-00FR7S-Fn; Wed, 15 Sep 2021 06:51:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 13/17] block: drop unused includes in <linux/blkdev.h>
Date:   Wed, 15 Sep 2021 08:40:40 +0200
Message-Id: <20210915064044.950534-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915064044.950534-1-hch@lst.de>
References: <20210915064044.950534-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drop various include not actually used in blkdev.h itself.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-ps-historical-service-time.c | 1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c     | 1 +
 include/linux/blkdev.h                     | 7 -------
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-ps-historical-service-time.c b/drivers/md/dm-ps-historical-service-time.c
index 1856a1b125cc1..875bca30a0dd5 100644
--- a/drivers/md/dm-ps-historical-service-time.c
+++ b/drivers/md/dm-ps-historical-service-time.c
@@ -27,6 +27,7 @@
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/sched/clock.h>
 
 
 #define DM_MSG_PREFIX	"multipath historical-service-time"
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 3ab669dc806f6..27884f3106ab8 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2017 Hisilicon Limited.
  */
 
+#include <linux/sched/clock.h>
 #include "hisi_sas.h"
 #define DRV_NAME "hisi_sas_v3_hw"
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d815238f61ed9..46a703394f7f4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -3,8 +3,6 @@
 #define _LINUX_BLKDEV_H
 
 #include <linux/sched.h>
-#include <linux/sched/clock.h>
-#include <linux/major.h>
 #include <linux/genhd.h>
 #include <linux/list.h>
 #include <linux/llist.h>
@@ -12,17 +10,12 @@
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 #include <linux/wait.h>
-#include <linux/mempool.h>
-#include <linux/pfn.h>
 #include <linux/bio.h>
-#include <linux/stringify.h>
 #include <linux/gfp.h>
-#include <linux/smp.h>
 #include <linux/rcupdate.h>
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
-#include <linux/pm.h>
 #include <linux/sbitmap.h>
 
 struct module;
-- 
2.30.2

