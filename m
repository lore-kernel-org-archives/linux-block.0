Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E8BC433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 23:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813FB611CA
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 23:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhJFXP3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 19:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhJFXP2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 19:15:28 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF612C061746
        for <linux-block@vger.kernel.org>; Wed,  6 Oct 2021 16:13:35 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 134so4621792iou.12
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3ile7Y+Lk23ZR7EdRYyUdG6ABjNHxlyVI4hZ5R+jUM=;
        b=XA7mV0yGcVRHdSZ+QmTvpQav5MhU6JKmpDPoYFju3LI6oQwDflQnRAWHmEqL6XTgSx
         Q31GKdwIQnEyS2A86adwPe9NSkhuC0plzfeLPQzKfyFroLnCoydJ/JHs9qr0GmWnUBYR
         x9oxPq1WVGC/K42PzptC4tCGSWP2ovyAFDGCIBZJJkOY6EKwQ2H87D/xnPoKo3kSIq47
         lypSZHt2FwjD97FcYXbUI1yx+L3wRXVje941OyoaZlWoY3CsM7e7c7vPSMoQPIAq+ZbZ
         Hu4JJCqZWgRzLxcH0MKV4x2SjrKwg6Adbf7Hnm+PDDP07FfdTTpT/dztzdT07IVPLkVf
         5b3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3ile7Y+Lk23ZR7EdRYyUdG6ABjNHxlyVI4hZ5R+jUM=;
        b=vJVr1oSRYRbRJI+JF6aNEt7iW76Iyva2QKwnJ34VpPlw4UgDuuwThrcJKYdBqG86hZ
         t5eGMOkDQ6OHECzYCY249URtv05rZtpECrqPGtVsDqFJqIkyw5KIj3eKdUZMsbC1AHX3
         d2UCF0+OHr9IMnN9/4wwiSjPc/EFFKAELvkIPc/sFyQgkBqHP+gYyJ20N907wGjtfkff
         xKQ8Uxsn6NxWwPuvoAKl/83N41l/Gd4pfOCIAmXV1580ikWO2R65NLhphM61xKHADqFr
         Mmd1xwemNPtNWhA9ot86gDCcEZ1l5Xla/dsM7yDL+K/NMuhcjP/hMGm2lC+OaQbKQBI4
         5Cmg==
X-Gm-Message-State: AOAM533xZz0Ur4B+9FYE8CBaT1VzGhkb1ebQs9NWPOdgh0gYG2PppXTc
        ZmjNx8QubMsp6c87CjC33FB/1rMtxXJVbQ==
X-Google-Smtp-Source: ABdhPJzFmIMLO9P4hPZ1WlUrCzVnrP6wI3Jb3t19SwxcmGZ1mFYzmnZqp/IKSaihmrUI2OamW+cdog==
X-Received: by 2002:a05:6638:2482:: with SMTP id x2mr405176jat.32.1633562014890;
        Wed, 06 Oct 2021 16:13:34 -0700 (PDT)
Received: from p1.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o1sm12955203ilj.41.2021.10.06.16.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 16:13:34 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] block: bump max plugged deferred size from 16 to 32
Date:   Wed,  6 Oct 2021 17:13:28 -0600
Message-Id: <20211006231330.20268-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006231330.20268-1-axboe@kernel.dk>
References: <20211006231330.20268-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Particularly for NVMe with efficient deferred submission for many
requests, there are nice benefits to be seen by bumping the default max
plug count from 16 to 32. This is especially true for virtualized setups,
where the submit part is more expensive. But can be noticed even on
native hardware.

Reduce the multiple queue factor from 4 to 2, since we're changing the
default size.

While changing it, move the defines into the block layer private header.
These aren't values that anyone outside of the block layer uses, or
should use.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 4 ++--
 block/blk.h            | 6 ++++++
 include/linux/blkdev.h | 2 --
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a40c94505680..5327abbefbab 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2145,14 +2145,14 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 }
 
 /*
- * Allow 4x BLK_MAX_REQUEST_COUNT requests on plug queue for multiple
+ * Allow 2x BLK_MAX_REQUEST_COUNT requests on plug queue for multiple
  * queues. This is important for md arrays to benefit from merging
  * requests.
  */
 static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
 {
 	if (plug->multiple_queues)
-		return BLK_MAX_REQUEST_COUNT * 4;
+		return BLK_MAX_REQUEST_COUNT * 2;
 	return BLK_MAX_REQUEST_COUNT;
 }
 
diff --git a/block/blk.h b/block/blk.h
index 21283541a99f..38867b4c5c7e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -222,6 +222,12 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 void blk_account_io_start(struct request *req);
 void blk_account_io_done(struct request *req, u64 now);
 
+/*
+ * Plug flush limits
+ */
+#define BLK_MAX_REQUEST_COUNT	32
+#define BLK_PLUG_FLUSH_SIZE	(128 * 1024)
+
 /*
  * Internal elevator interface
  */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b19172db7eef..472b4ab007c6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -727,8 +727,6 @@ struct blk_plug {
 	bool multiple_queues;
 	bool nowait;
 };
-#define BLK_MAX_REQUEST_COUNT 16
-#define BLK_PLUG_FLUSH_SIZE (128 * 1024)
 
 struct blk_plug_cb;
 typedef void (*blk_plug_cb_fn)(struct blk_plug_cb *, bool);
-- 
2.33.0

