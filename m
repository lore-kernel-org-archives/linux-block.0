Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613A2C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 22:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8FB2192C
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 22:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qrWB6fLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfBIWob (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 17:44:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34929 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfBIWob (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 17:44:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so3402359pfi.2
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 14:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4iaik1NNNkflWeumAUAMoMatTr1YQFbqizFJN4SjbBs=;
        b=qrWB6fLni5kkzchl6WnQ5u5IXATEC117XDEkQcwCP5JHmk8hnoNU76n6K3F2x0PcEA
         cBQ0XATnrsDN2AxgFNLFORvJuvoYDX1AkgnNGTipsdq64BR0sj6dELzX9llo7NUl4AFi
         snH6KnUOzAylkTQPtHVauPR8jK4QDlmX874EX09/y3ptYu4FyBEdVyYFhoO/E6UstdaL
         SLCCx5AraJCny1/spdhNoCkgdZ9DBwnopoibIi+XJ9f/q+wQwIvv2X8Sv7zxfrbG22TL
         izftDNey5jM8xNpM1GJaq3rx8B3iy9j4ObaAFm5orjVODNRdvIdJuninO3oejS5nHU7v
         YDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4iaik1NNNkflWeumAUAMoMatTr1YQFbqizFJN4SjbBs=;
        b=fHBwhuRNxIVsdCCEYE8/Q9eYt6AD3GsKUG6r4gFdHYuJomEOcucTVhTqt21xJb4JFy
         nCKcV4NrRKOFkxrmN/l/EIwCllZdlDBCUN/MZOfIzaUJaoP532D82mjjQiteUb/ZrCXM
         jdleDcoOw6l5KfVmbMlAVusMNCOhculipy6bCnu7Ivi8sNDyqH9plRFR5cuYXx4VffIs
         dkxzU1JsfF28tGENMzVA40EhVaUx9A3zShEhr9d3Cc0DIEJZGFt//CTibZj9bRp+kfs2
         teCPgWK2sYTxuyYG3Kk3Nz8oiwfYS7zL+aJuxeqv8SP3Yq2sssBCk3vyu5CsKFsWW2WF
         Hx/Q==
X-Gm-Message-State: AHQUAuYlss+G3/xUOC7PVtK9qMySgfgwwV2/cVPIGb2kc1m3p2SFLpAQ
        GxZpcWOz0K+c5uAjfLXA9/I6E8haXZCzrQ==
X-Google-Smtp-Source: AHgI3IZPdfDLtvxtzB9kaiLhQITEQauA34G+ogmtE8FgcttnqX+CpACyzyhHNZhSY65WFm3n+NjgAQ==
X-Received: by 2002:a62:ca48:: with SMTP id n69mr23319753pfg.162.1549752269783;
        Sat, 09 Feb 2019 14:44:29 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b26sm8779147pfe.91.2019.02.09.14.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 14:44:28 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] block: kill QUEUE_FLAG_FLUSH_NQ
Date:   Sat,  9 Feb 2019 15:44:23 -0700
Message-Id: <20190209224424.7560-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209224424.7560-1-axboe@kernel.dk>
References: <20190209224424.7560-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have various helpers for setting/clearing this flag, and also
a helper to check if the queue supports queueable flushes or not.
But nobody uses them anymore, kill it with fire.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-debugfs.c        | 1 -
 block/blk-settings.c          | 9 ---------
 drivers/ata/libata-scsi.c     | 2 --
 drivers/block/null_blk_main.c | 1 -
 include/linux/blkdev.h        | 7 -------
 5 files changed, 20 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f8120832ca7b..c782e81db627 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -132,7 +132,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(POLL),
 	QUEUE_FLAG_NAME(WC),
 	QUEUE_FLAG_NAME(FUA),
-	QUEUE_FLAG_NAME(FLUSH_NQ),
 	QUEUE_FLAG_NAME(DAX),
 	QUEUE_FLAG_NAME(STATS),
 	QUEUE_FLAG_NAME(POLL_STATS),
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 3e7038e475ee..6375afaedcec 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -799,15 +799,6 @@ void blk_queue_update_dma_alignment(struct request_queue *q, int mask)
 }
 EXPORT_SYMBOL(blk_queue_update_dma_alignment);
 
-void blk_queue_flush_queueable(struct request_queue *q, bool queueable)
-{
-	if (queueable)
-		blk_queue_flag_clear(QUEUE_FLAG_FLUSH_NQ, q);
-	else
-		blk_queue_flag_set(QUEUE_FLAG_FLUSH_NQ, q);
-}
-EXPORT_SYMBOL_GPL(blk_queue_flush_queueable);
-
 /**
  * blk_set_queue_depth - tell the block layer about the device queue depth
  * @q:		the request queue for the device
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3d4887d0e84a..dfe66d00dd5b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1318,8 +1318,6 @@ static int ata_scsi_dev_config(struct scsi_device *sdev,
 		scsi_change_queue_depth(sdev, depth);
 	}
 
-	blk_queue_flush_queueable(q, false);
-
 	if (dev->flags & ATA_DFLAG_TRUSTED)
 		sdev->security_supported = 1;
 
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 62c9654b9ce8..83c38a6217d7 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1678,7 +1678,6 @@ static int null_add_dev(struct nullb_device *dev)
 	if (dev->cache_size > 0) {
 		set_bit(NULLB_DEV_FL_CACHE, &nullb->dev->flags);
 		blk_queue_write_cache(nullb->q, true, true);
-		blk_queue_flush_queueable(nullb->q, true);
 	}
 
 	if (dev->zoned) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 338604dff7d0..24ccab51085f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -592,7 +592,6 @@ struct request_queue {
 #define QUEUE_FLAG_POLL	       19	/* IO polling enabled if set */
 #define QUEUE_FLAG_WC	       20	/* Write back caching */
 #define QUEUE_FLAG_FUA	       21	/* device supports FUA writes */
-#define QUEUE_FLAG_FLUSH_NQ    22	/* flush not queueuable */
 #define QUEUE_FLAG_DAX         23	/* device supports DAX */
 #define QUEUE_FLAG_STATS       24	/* track IO start and completion times */
 #define QUEUE_FLAG_POLL_STATS  25	/* collecting stats for hybrid polling */
@@ -1069,7 +1068,6 @@ extern void blk_queue_virt_boundary(struct request_queue *, unsigned long);
 extern void blk_queue_dma_alignment(struct request_queue *, int);
 extern void blk_queue_update_dma_alignment(struct request_queue *, int);
 extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
-extern void blk_queue_flush_queueable(struct request_queue *q, bool queueable);
 extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
 
 /*
@@ -1446,11 +1444,6 @@ static inline unsigned int block_size(struct block_device *bdev)
 	return bdev->bd_block_size;
 }
 
-static inline bool queue_flush_queueable(struct request_queue *q)
-{
-	return !test_bit(QUEUE_FLAG_FLUSH_NQ, &q->queue_flags);
-}
-
 typedef struct {struct page *v;} Sector;
 
 unsigned char *read_dev_sector(struct block_device *, sector_t, Sector *);
-- 
2.17.1

