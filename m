Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82852C7EE29
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 22:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjEVW0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 18:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjEVW0J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 18:26:09 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70A6121
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:06 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-25374c9be49so4096178a91.3
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684794366; x=1687386366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TL+ap5gd7gtWXMfSwU0Gj8d95pJD9y7yNk5iOjg0vpE=;
        b=Yo2rAj0O0xkoNoxPBsoZUdEAB9vLqvmdzSw3m7E/Gklg5RjbzyD98PD2nhDzE36RUq
         dxlJWrczSoMLxtRLzzPRESOABMx6XD6p/FDQ/rxX2BQ44dP/0LAvQhbYzwJ6ks1kudNz
         vhWe7lIeIP8EAiMSlSh9xnHlOG1bs9pkhO0SGqZEo92Qcozi81DicfaG/XWCqJAqpoug
         RLyL6wknDsDL4Slu5hrE+KLaUW2Zl4o571XslOUPYCMEOX2DerNj0HJh6Iv1PVtPkbHv
         nVIIDXGx5ja5XdXWYgFA70/Frb+CTrOO2RQFCPxa/8WmpUkxJRXJodzAd0IB8EgEkwn7
         XZIA==
X-Gm-Message-State: AC+VfDw+klNBqueTrP2ivBzcEbjGTbh1WgSpLYe7dyjV5aZ8yHuKgyLT
        9Dfw5QN9CJ6neVR1P6JCcp0=
X-Google-Smtp-Source: ACHHUZ56Fyw19zF5VwFFavcuPbHNHoVb9mpCGZrfK4/vfX2MWZxp8hlPANwTriNWiv7ihn9b9noelg==
X-Received: by 2002:a17:90b:154a:b0:24e:3254:5d94 with SMTP id ig10-20020a17090b154a00b0024e32545d94mr10289750pjb.40.1684794366432;
        Mon, 22 May 2023 15:26:06 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id y8-20020a634b08000000b00520f4ecd71esm4725364pga.93.2023.05.22.15.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:26:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        jyescas@google.com, mcgrof@kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v5 5/9] block: Support submitting passthrough requests with small segments
Date:   Mon, 22 May 2023 15:25:37 -0700
Message-ID: <20230522222554.525229-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522222554.525229-1-bvanassche@acm.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the segment size is smaller than the page size there may be multiple
segments per bvec even if a bvec only contains a single page. Hence this
patch.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-map.c |  2 +-
 block/blk.h     | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 04c55f1c492e..e1355331019a 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -535,7 +535,7 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
 	unsigned int nr_segs = 0;
 
 	bio_for_each_bvec(bv, bio, iter)
-		nr_segs++;
+		nr_segs += blk_segments(&rq->q->limits, bv.bv_len);
 
 	if (!rq->bio) {
 		blk_rq_bio_prep(rq, bio, nr_segs);
diff --git a/block/blk.h b/block/blk.h
index 3c63ec0f1721..dfeebbb55a42 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -86,6 +86,24 @@ struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
 		gfp_t gfp_mask);
 void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned short nr_vecs);
 
+/* Number of DMA segments required to transfer @bytes data. */
+static inline unsigned int blk_segments(const struct queue_limits *limits,
+					unsigned int bytes)
+{
+	if (!blk_queue_sub_page_limits(limits))
+		return 1;
+
+	{
+		const unsigned int mss = limits->max_segment_size;
+
+		if (bytes <= mss)
+			return 1;
+		if (is_power_of_2(mss))
+			return round_up(bytes, mss) >> ilog2(mss);
+		return (bytes + mss - 1) / mss;
+	}
+}
+
 static inline bool biovec_phys_mergeable(struct request_queue *q,
 		struct bio_vec *vec1, struct bio_vec *vec2)
 {
