Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459B0C4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 22:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJSWXq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiJSWXo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 18:23:44 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA43FA22
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:44 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so1528680pji.1
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cf3IxJkfIFwEhrBZgsBaHfnMYJl9CSMzf1EADx4T3qs=;
        b=dK1hQB/r7ChlFytUBoYkcRXZ9vkJZHGWMvWAI9919MqNHfODEUXL34HctpcDCleIwq
         Zner6Ro4ITWoGivbvdjUWwkKWb2amFu3zjN0uwqGqK9UVVHrKufail7MoTQpLPc0GlGV
         DIO4YuWm4GnJXNY5//X0KD2AqeWHFK7czmNrx915/8mN2oeJML1YiaJSWpVIaMf77NLE
         NFN1ZJa90cli+3lycKmnXK0mogyyBhS82gnKp8w/qcT0WfZhf8p/dChFtx4BKrpEdvHn
         imGIY+KX32YgqINE92YxJ36rC695rXvfyYMelKmYTe0csCHsxJmEPIfsNSRpvZZVz4AK
         GSXw==
X-Gm-Message-State: ACrzQf0hBPDfYyitPKzRX23xn49q7T7ah4Hl3Ya0AU4IxK2eS0dDbDth
        y6BTbJHEAlkGgmzo9jgv2pfxpkxuOG4=
X-Google-Smtp-Source: AMsMyM7mCPf2bhuWoZ+Z8DGOCDKkpZYLSpunt0duIa5b1AEp9K99qe8wOKmCd8j1v9wttsZN5LPEGw==
X-Received: by 2002:a17:902:da90:b0:185:5537:f388 with SMTP id j16-20020a170902da9000b001855537f388mr11080989plx.113.1666218223721;
        Wed, 19 Oct 2022 15:23:43 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8280:2606:af57:d34])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b00174d9bbeda4sm11486866plg.197.2022.10.19.15.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:23:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 05/10] block: Introduce QUEUE_FLAG_SUB_PAGE_SEGMENTS
Date:   Wed, 19 Oct 2022 15:23:19 -0700
Message-Id: <20221019222324.362705-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019222324.362705-1-bvanassche@acm.org>
References: <20221019222324.362705-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for introducing support for segments smaller than the page size
one driver at a time by introducing the request queue flag
QUEUE_FLAG_SUB_PAGE_SEGMENTS. Although I am not aware of any storage
controller that restricts the segment size to 512 bytes, supporting 512
bytes as minimum segment size makes it easy to test small segment support
on systems with PAGE_SIZE = 4096.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-settings.c   | 10 ++++++----
 include/linux/blkdev.h |  3 +++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 1cba5c2a2796..1b7687d0ece2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -277,10 +277,12 @@ EXPORT_SYMBOL_GPL(blk_queue_max_discard_segments);
  **/
 void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
 {
-	if (max_size < PAGE_SIZE) {
-		max_size = PAGE_SIZE;
-		printk(KERN_INFO "%s: set to minimum %d\n",
-		       __func__, max_size);
+	unsigned int min_segment_size = blk_queue_sub_page_segments(q) ?
+		SECTOR_SIZE : PAGE_SIZE;
+
+	if (max_size < min_segment_size) {
+		max_size = min_segment_size;
+		printk(KERN_INFO "%s: set to minimum %d\n", __func__, max_size);
 	}
 
 	/* see blk_queue_virt_boundary() for the explanation */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50e358a19d98..6757f836fd57 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -579,6 +579,7 @@ struct request_queue {
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
+#define QUEUE_FLAG_SUB_PAGE_SEGMENTS 31	/* segments smaller than one page */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
 				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
@@ -619,6 +620,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
+#define blk_queue_sub_page_segments(q)				\
+	test_bit(QUEUE_FLAG_SUB_PAGE_SEGMENTS, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
