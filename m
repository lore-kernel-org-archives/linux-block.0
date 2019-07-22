Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CBEC76194
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 17:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C67F2190F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 17:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfGVRMY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:12:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44808 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfGVRMY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 13:12:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so17965725pgl.11
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 10:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jq2pZEjtAzuyucvqSgELmmCJOFoY2SOnEEkwGFrFqKo=;
        b=OYCzDTS4n1UCCEQoONttNpVCUhQWmxUOChHpLZ2cKia2F4dm9LPwNl986J5taSSv0L
         +BnYr9OQUdH9lUD97OFbvIWiPHBoCtewba7dp58SDJDlaju9VbWGoc8/3ggDf91QJQms
         9Mcj6AjKqYOnVUIFnsi97kd9Sfvk02Ymcp5AxVNi9rLYZW1215FH+/Xc+3/x72y7rm6t
         9cgcxNkKf2mmQAZiCMTUIun5S0bafsLja33ClcUjtYcX2XmDJU3xbBRPsQGe+ExiddH0
         zJsgfsIzYiEoPIhWxUfquZer34u5mMXfadcaI1MC+kF3/Ptbn1nCAi+7ner0Nrk6mOOF
         xBTg==
X-Gm-Message-State: APjAAAVto737pLzX/vm/xAcCwwhXTuVL6XvKUZ/FYRLhvX/B0WBzCKwX
        Q1dDm7CfWHubTwmRLG8rAv0=
X-Google-Smtp-Source: APXvYqxhygMuebo/fszLq4zxq91f0xY0CA+3QF6CtiwHesDMbQzzewWci4SNuyH62hBm3BafQLA8zQ==
X-Received: by 2002:a63:f048:: with SMTP id s8mr44523372pgj.26.1563815543737;
        Mon, 22 Jul 2019 10:12:23 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t26sm31196528pgu.43.2019.07.22.10.12.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 10:12:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 3/5] block: Micro-optimize bvec_split_segs()
Date:   Mon, 22 Jul 2019 10:12:08 -0700
Message-Id: <20190722171210.149443-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722171210.149443-1-bvanassche@acm.org>
References: <20190722171210.149443-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since bvec_split_segs() is in the hot path, optimize this function
by removing two if-tests. Other than requiring that the @sectors pointer
is not NULL, this patch does not change the behavior of bvec_split_segs().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 51ed971709c3..7cea5050bbcf 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -167,17 +167,17 @@ static bool bvec_split_segs(const struct request_queue *q,
 {
 	unsigned len = bv->bv_len;
 	unsigned total_len = 0;
-	unsigned new_nsegs = 0, seg_size = 0;
+	unsigned seg_size = 0;
 
 	/*
 	 * Multi-page bvec may be too big to hold in one segment, so the
 	 * current bvec has to be splitted as multiple segments.
 	 */
-	while (len && new_nsegs + *nsegs < max_segs) {
+	while (len && *nsegs < max_segs) {
 		seg_size = get_max_segment_size(q, bv->bv_offset + total_len);
 		seg_size = min(seg_size, len);
 
-		new_nsegs++;
+		(*nsegs)++;
 		total_len += seg_size;
 		len -= seg_size;
 
@@ -185,11 +185,7 @@ static bool bvec_split_segs(const struct request_queue *q,
 			break;
 	}
 
-	if (new_nsegs) {
-		*nsegs += new_nsegs;
-		if (sectors)
-			*sectors += total_len >> 9;
-	}
+	*sectors += total_len >> 9;
 
 	/* split in the middle of the bvec if len != 0 */
 	return !!len;
@@ -349,6 +345,7 @@ EXPORT_SYMBOL(blk_queue_split);
 unsigned int blk_recalc_rq_segments(struct request *rq)
 {
 	unsigned int nr_phys_segs = 0;
+	unsigned int nr_sectors = 0;
 	struct req_iterator iter;
 	struct bio_vec bv;
 
@@ -365,7 +362,8 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 	}
 
 	rq_for_each_bvec(bv, rq, iter)
-		bvec_split_segs(rq->q, &bv, &nr_phys_segs, NULL, UINT_MAX);
+		bvec_split_segs(rq->q, &bv, &nr_phys_segs, &nr_sectors,
+				UINT_MAX);
 	return nr_phys_segs;
 }
 
-- 
2.22.0.657.g960e92d24f-goog

