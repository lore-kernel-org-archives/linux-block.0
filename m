Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89760ECAAD8
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 18:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiIVSbe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 14:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiIVSaz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 14:30:55 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8B410B5AA
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 11:28:09 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v128so8424888ioe.12
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KOdha0xZ2/QYkK5YkfhyDv4n+7NP1qIjesr4vuNTao8=;
        b=I3ozfRpCO+8sfk1czHqJkuud5fbhOBBjBPNani3SoWO5IZrr+n/xykd4BYCj6iF/yZ
         YUgMhkihNpdD90pGDqffGeTVe1Lb9NSQnHeRoD8cgg2gFQ/EmHGBP46WBRkepSKacBe9
         0/BDSuaDvLg45rQ8CzKBSAt8/NtYunQdrfrc0/qYd/SHmQXOTUhVkzxgGGcPxLM8Q6yG
         Pnxpp3iPWxoszKqZD6piQndRMfFxGNQXSl6LEm2shcEG/V1F+VDWoYsayPrD5S/hJS3w
         /DgQMp06IIBo+G6qQyJy0W2qJ9hcQXFC9VwcVse6SFsPWkJYASV0uNPVG/clm0ofomyV
         cjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KOdha0xZ2/QYkK5YkfhyDv4n+7NP1qIjesr4vuNTao8=;
        b=V+7JenpsLW0fUtvyi/359BIdxyFDlQUn8Iq7FuwoLClbPSiKUkrAAcZElTQv8R0KsG
         /msiy2yNoKDeY3yYck/Wd3+OnTFuXMMO74RwwWRNWMgnMMKlaec5/w2f6P+GosBQVsYx
         CNPfkUz/8HvZXeXZlN/okzY3fx3mIS886FPGIcwWxxoqYwiHqpuJC/loKYEGY7GfWtE0
         2i7oHn+dt7XV0x2T4AgD1IRj27rkL2GqzMsisi5G1p1qje0HgpRpDm+wZXQWztK1oL75
         e6CL4ysxF6T4QNboYeX0FDB/U7bRzk7njGdxvaAz62FnfbUIxzuOOf4pl/OG+FWUblXf
         UXUA==
X-Gm-Message-State: ACrzQf2/MpBrcm2+F4/iOqbQP3RdskHGYgrQRv1TPf6IEgm3wzYYgVM3
        b/LVK4VGpRt1HN+s/foLGBe2+n4Qv0v07g==
X-Google-Smtp-Source: AMsMyM6q1U2zUDZ6fq1ZHALNlDos6d1f2IhUDrAzg+XF/fY3dxFEtLxvEozxHX6pNVp/47zfuhfqkg==
X-Received: by 2002:a05:6602:2d09:b0:688:f387:aab5 with SMTP id c9-20020a0566022d0900b00688f387aab5mr2274193iow.107.1663871288335;
        Thu, 22 Sep 2022 11:28:08 -0700 (PDT)
Received: from m1max.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q20-20020a05663810d400b0035a468b7fbesm2440646jad.71.2022.09.22.11.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 11:28:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] block: enable batched allocation for blk_mq_alloc_request()
Date:   Thu, 22 Sep 2022 12:28:01 -0600
Message-Id: <20220922182805.96173-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922182805.96173-1-axboe@kernel.dk>
References: <20220922182805.96173-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The filesystem IO path can take advantage of allocating batches of
requests, if the underlying submitter tells the block layer about it
through the blk_plug. For passthrough IO, the exported API is the
blk_mq_alloc_request() helper, and that one does not allow for
request caching.

Wire up request caching for blk_mq_alloc_request(), which is generally
done without having a bio available upfront.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c11949d66163..d3a9f8b9c7ee 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -510,25 +510,87 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 					alloc_time_ns);
 }
 
-struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
-		blk_mq_req_flags_t flags)
+static struct request *blk_mq_rq_cache_fill(struct request_queue *q,
+					    struct blk_plug *plug,
+					    blk_opf_t opf,
+					    blk_mq_req_flags_t flags)
 {
 	struct blk_mq_alloc_data data = {
 		.q		= q,
 		.flags		= flags,
 		.cmd_flags	= opf,
-		.nr_tags	= 1,
+		.nr_tags	= plug->nr_ios,
+		.cached_rq	= &plug->cached_rq,
 	};
 	struct request *rq;
-	int ret;
 
-	ret = blk_queue_enter(q, flags);
-	if (ret)
-		return ERR_PTR(ret);
+	if (blk_queue_enter(q, flags))
+		return NULL;
+
+	plug->nr_ios = 1;
 
 	rq = __blk_mq_alloc_requests(&data);
-	if (!rq)
-		goto out_queue_exit;
+	if (unlikely(!rq))
+		blk_queue_exit(q);
+	return rq;
+}
+
+static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
+						   blk_opf_t opf,
+						   blk_mq_req_flags_t flags)
+{
+	struct blk_plug *plug = current->plug;
+	struct request *rq;
+
+	if (!plug)
+		return NULL;
+	if (rq_list_empty(plug->cached_rq)) {
+		if (plug->nr_ios == 1)
+			return NULL;
+		rq = blk_mq_rq_cache_fill(q, plug, opf, flags);
+		if (rq)
+			goto got_it;
+		return NULL;
+	}
+	rq = rq_list_peek(&plug->cached_rq);
+	if (!rq || rq->q != q)
+		return NULL;
+
+	if (blk_mq_get_hctx_type(opf) != rq->mq_hctx->type)
+		return NULL;
+	if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
+		return NULL;
+
+	plug->cached_rq = rq_list_next(rq);
+got_it:
+	rq->cmd_flags = opf;
+	INIT_LIST_HEAD(&rq->queuelist);
+	return rq;
+}
+
+struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
+		blk_mq_req_flags_t flags)
+{
+	struct request *rq;
+
+	rq = blk_mq_alloc_cached_request(q, opf, flags);
+	if (!rq) {
+		struct blk_mq_alloc_data data = {
+			.q		= q,
+			.flags		= flags,
+			.cmd_flags	= opf,
+			.nr_tags	= 1,
+		};
+		int ret;
+
+		ret = blk_queue_enter(q, flags);
+		if (ret)
+			return ERR_PTR(ret);
+
+		rq = __blk_mq_alloc_requests(&data);
+		if (!rq)
+			goto out_queue_exit;
+	}
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
 	rq->bio = rq->biotail = NULL;
-- 
2.35.1

