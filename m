Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECC4C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3234E20660
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ONUpHv0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3234E20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeLAIYc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:24:32 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34162 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAIYc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 03:24:32 -0500
Received: by mail-io1-f65.google.com with SMTP id f6so5700335iob.1
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 13:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=3FoJ0IpHwNiRlzvolK1fJ4pzRFoSWtpcolEH8iMSJPk=;
        b=ONUpHv0ac9b4DLIxcF1sFQGZkcUbbYDAC6u5L2N5gAgQucsYKjuG5OGcziuB847CaB
         gQSrzkpRHQKNoBRDPjwv9Pjatwr4qR0dIQpmyVXylOmkrY65iislvGsnkcD+JR42Gqb6
         8E2y5Ck3iUXpJTaoirspi3ABhDeN7+NkpTjMbpdU4UOXnUtLiEbWGECSfd4bDCYtGPAM
         zZnC0YPvafSE3DNY2w2XbzVneSXaqEL+09DWCYdow3pETuyy11CRkHEEPD7FZ3sYiCug
         vb+BCOscwcHV9LW3Hf15X5Bc4c59aAyf7kMP6jtiPjH5VZvWflfGDYdE7t+HDIbqZynK
         eKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=3FoJ0IpHwNiRlzvolK1fJ4pzRFoSWtpcolEH8iMSJPk=;
        b=Sc9wGnPM2koM99K+R1ZhHyKruvdQJnOOWCNEuqNU1JtyJeYNjYC87ToHpkeQYUpWM6
         nMj0KJfjf3swcQe8f7HbOfnr2NtRyQO4CXKabSsBSbtOdZrFgAVJX4jwfmFmW76mp6yz
         /FEaWmBo3CwYRHHPAqrmaybVTfKlK5lN0TbMW855AYiLsNOI+jiStheWoysorgJTWP9L
         NcRyTvvtwwUegR9JWYf5kHmD1GOZYzmGVm3ZxKsft4a3pt3UvjkVNuglKYxeZSTqGJop
         cWS6zebnyOvj0kS9QXSw73vPb7afvqdqvxdA8P5u7x4oXQE+cUJac32aX42PbgCtuSlR
         EUwA==
X-Gm-Message-State: AA+aEWZqC2x1OFWOQ4Za+eP3JmETo9eKcRX9V4mXULT3HLt4S1yATEzx
        e1pfrYaKcFPKAP0sd/d4xR8zd27vDKs=
X-Google-Smtp-Source: AFSGD/UsmNi7QIww+JpBskRRVFMnYsj4b85XNdwvMssIfvAXckuYWMY2BcnUYKHOkpI7orl2vhBaPA==
X-Received: by 2002:a6b:a0d:: with SMTP id z13mr5939509ioi.57.1543612436117;
        Fri, 30 Nov 2018 13:13:56 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b192sm148756itb.12.2018.11.30.13.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 13:13:55 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] blk-mq: don't call ktime_get_ns() if we don't need it
Message-ID: <73f58a60-cfa8-5736-d42a-9297601a1f71@kernel.dk>
Date:   Fri, 30 Nov 2018 14:13:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We only need the request fields and the end_io time if we have
stats enabled, or if we have a scheduler attached as those may
use it for completion time stats.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

v2: add helper, use it in both spots. also clear ->start_time_ns
    so merging doesn't read garbage.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7dcef565dc0f..e09d7f500077 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -281,6 +281,15 @@ bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
 }
 EXPORT_SYMBOL(blk_mq_can_queue);
 
+/*
+ * Only need start/end time stamping if we have stats enabled, or using
+ * an IO scheduler.
+ */
+static inline bool blk_mq_need_time_stamp(struct request *rq)
+{
+	return (rq->rq_flags & RQF_IO_STAT) || rq->q->elevator;
+}
+
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		unsigned int tag, unsigned int op)
 {
@@ -316,7 +325,10 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	RB_CLEAR_NODE(&rq->rb_node);
 	rq->rq_disk = NULL;
 	rq->part = NULL;
-	rq->start_time_ns = ktime_get_ns();
+	if (blk_mq_need_time_stamp(rq))
+		rq->start_time_ns = ktime_get_ns();
+	else
+		rq->start_time_ns = 0;
 	rq->io_start_time_ns = 0;
 	rq->nr_phys_segments = 0;
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
@@ -522,7 +534,10 @@ EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
-	u64 now = ktime_get_ns();
+	u64 now = 0;
+
+	if (blk_mq_need_time_stamp(rq))
+		now = ktime_get_ns();
 
 	if (rq->rq_flags & RQF_STATS) {
 		blk_mq_poll_stats_start(rq->q);
-- 
Jens Axboe

