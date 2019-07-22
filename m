Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C018C76190
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 17:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418EC2199C
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 17:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfGVRMX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:12:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37134 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfGVRMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 13:12:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id i70so7224326pgd.4
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 10:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqoaFJKKtuDybvlan6o9m4gt+0Kdy7e3U+7tKu6y8b0=;
        b=rD6uNC7BPejQe2GGCGqPw9vwODp/vTYyea6Jrb0+xsY7YGxNbZomnLGH/lm+uy/uWS
         Dlyz2HeEDVNyLtbseNl6Ewct7VVjxgVmzxstPjU3EySXMMUx4laXX+aueiwpFe3GYkr2
         2laWCccNkrJql1ewZzLWqGsmeyTsylbuVHAmRIlYPqJfSpd+heqAFhD89OEpd9iWz8Dy
         2b0ZgkfiCCvcVZ1yHta/63f4jSO/kVqrm37A34Bs/M2SbiIn7Je0HRLwZee779jupm3T
         UlkV8APEcM3SfxxeSS5cLUbhQl/1+s1gbIkHfFJJedpUQUGMoaInfxuSo4wNmet2ZSUf
         qnqw==
X-Gm-Message-State: APjAAAUmxvERfS7xoZuAoRRlRgSEJvl0cQbGI1gDZy1jKKJnsNK9r4Yy
        5ytSTnvwq/MS9X4JE831gTNSwuuH
X-Google-Smtp-Source: APXvYqxf5P6SxgtcRDjKNrrx4AzKeCAvNQKyEiBgB/rVVsQAPZDM8N509VDflzfEL50hewnL0JZ0Yw==
X-Received: by 2002:a63:7a01:: with SMTP id v1mr74186075pgc.310.1563815542503;
        Mon, 22 Jul 2019 10:12:22 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t26sm31196528pgu.43.2019.07.22.10.12.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 10:12:21 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 2/5] block: Document the bio splitting functions
Date:   Mon, 22 Jul 2019 10:12:07 -0700
Message-Id: <20190722171210.149443-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722171210.149443-1-bvanassche@acm.org>
References: <20190722171210.149443-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since what the bio splitting functions do is nontrivial, document these
functions.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bio.c       |  4 ++--
 block/blk-merge.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 299a0e7651ec..0fff4eb9eb1e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1842,8 +1842,8 @@ EXPORT_SYMBOL(bio_endio);
  * @bio, and updates @bio to represent the remaining sectors.
  *
  * Unless this is a discard request the newly allocated bio will point
- * to @bio's bi_io_vec; it is the caller's responsibility to ensure that
- * @bio is not freed before the split.
+ * to @bio's bi_io_vec. It is the caller's responsibility to ensure that
+ * neither @bio nor @bs are freed before the split bio.
  */
 struct bio *bio_split(struct bio *bio, int sectors,
 		      gfp_t gfp, struct bio_set *bs)
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8344d94f13e0..51ed971709c3 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -195,6 +195,25 @@ static bool bvec_split_segs(const struct request_queue *q,
 	return !!len;
 }
 
+/**
+ * blk_bio_segment_split - split a bio in two bios
+ * @q:    [in] request queue pointer
+ * @bio:  [in] bio to be split
+ * @bs:	  [in] bio set to allocate the clone from
+ * @segs: [out] number of segments in the bio with the first half of the sectors
+ *
+ * Clone @bio, update the bi_iter of the clone to represent the first sectors
+ * of @bio and update @bio->bi_iter to represent the remaining sectors. The
+ * following is guaranteed for the cloned bio:
+ * - That it has at most get_max_io_size(@q, @bio) sectors.
+ * - That it has at most queue_max_segments(@q) segments.
+ *
+ * Except for discard requests the cloned bio will point at the bi_io_vec of
+ * the original bio. It is the responsibility of the caller to ensure that the
+ * original bio is not freed before the cloned bio. The caller is also
+ * responsible for ensuring that @bs is only destroyed after processing of the
+ * split bio has finished.
+ */
 static struct bio *blk_bio_segment_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
@@ -251,6 +270,19 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
 
+/**
+ * __blk_queue_split - split a bio and submit the second half
+ * @q:       [in] request queue pointer
+ * @bio:     [in, out] bio to be split
+ * @nr_segs: [out] number of segments in the first bio
+ *
+ * Split a bio into two bios, chain the two bios, submit the second half and
+ * store a pointer to the first half in *@bio. If the second bio is still too
+ * big it will be split by a recursive call to this function. Since this
+ * function may allocate a new bio from @q->bio_split, it is the responsibility
+ * of the caller to ensure that @q is only released after processing of the
+ * split bio has finished.
+ */
 void __blk_queue_split(struct request_queue *q, struct bio **bio,
 		unsigned int *nr_segs)
 {
@@ -295,6 +327,17 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 	}
 }
 
+/**
+ * blk_queue_split - split a bio and submit the second half
+ * @q:   [in] request queue pointer
+ * @bio: [in, out] bio to be split
+ *
+ * Split a bio into two bios, chains the two bios, submit the second half and
+ * store a pointer to the first half in *@bio. Since this function may allocate
+ * a new bio from @q->bio_split, it is the responsibility of the caller to
+ * ensure that @q is only released after processing of the split bio has
+ * finished.
+ */
 void blk_queue_split(struct request_queue *q, struct bio **bio)
 {
 	unsigned int nr_segs;
-- 
2.22.0.657.g960e92d24f-goog

