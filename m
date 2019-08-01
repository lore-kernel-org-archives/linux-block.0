Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6CEC32753
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B458C2080C
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390104AbfHAWu5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:50:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39277 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732058AbfHAWu5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 18:50:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so30903544pfn.6
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 15:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v78JLgMrSx/P5onOsxF4EDc4WPnU4qR8t9YihlIqQaU=;
        b=reu7sh9Hfb+pNwzBG9PzCusDvikglDMANnB2uHYp4GV5snAU6JKnKc4Vmdb6w/7+Te
         /dYcMf0ejGcTr+VrYd4ODkQdFn93b6I/qJFGx0xil5AEuvw8BFwcYEAIT9m3hs2Pvqiy
         YyLVE6p/ztLwZJnifiaevS9JAIw4Jr54c+GqbRHyivbgbhToj8h4FY7UDBEnnz2rxEmx
         WLJnpCnXXLLL0ZJ6bUlg6QdRYcGWbOT1r698+jD4D+KsUD6cuLn4Vl3/Xa6a0vfpdjre
         IOZsSmOd0zilLF6iZS65J8PStpKD4DjwexBoV9v2Fd1Gx+Mq7sWfOU/mJLnsNYKPeRmd
         EiYQ==
X-Gm-Message-State: APjAAAVlKriORo89ZgHnFIQxFAsZJRKMk6UnDoc2eM6Zhe71H/QBYegz
        Vi3WcJMHdUubgJEwt1nfhcw=
X-Google-Smtp-Source: APXvYqwGNpkamVrKl+/oxfrJHBlcmf+w3fU1mK05os9fKX6DQFDTeW0dfDtmK7paeuufjwZdq/C2ZA==
X-Received: by 2002:a17:90a:384d:: with SMTP id l13mr1175179pjf.86.1564699856632;
        Thu, 01 Aug 2019 15:50:56 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d12sm35472010pfn.11.2019.08.01.15.50.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:50:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 3/5] block: Simplify bvec_split_segs()
Date:   Thu,  1 Aug 2019 15:50:42 -0700
Message-Id: <20190801225044.143478-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801225044.143478-1-bvanassche@acm.org>
References: <20190801225044.143478-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Simplify this function by by removing two if-tests. Other than requiring
that the @sectors pointer is not NULL, this patch does not change the
behavior of bvec_split_segs().

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
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
2.22.0.770.g0f2c4a37fd-goog

