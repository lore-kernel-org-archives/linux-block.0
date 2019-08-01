Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B79C19759
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FB82084C
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfHAWvD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:51:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39276 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbfHAWu4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 18:50:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so30903510pfn.6
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 15:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFknHuGrAVuRUIDZ0JwPLjzFM/nqpojzKm+Ph0JQmZA=;
        b=HWEAl3xWIN+voenZC1Kx6Dt3zcW5nztirJ2lPfahh4BUrAPdqJVWiGTdKroFLIOhxn
         TInQhTvNyqHrfJxvohYXRH9IcjcxqY2YfQhwCHCT1nhNkzcHTxLrdpS/rcArSlvoKqlA
         GcS78zWy14+DB9SMueeHJRzu1sdJ4hzL6EFa0dXfLYrIyW+BYmN0ZOgYt3Wc6yc6MfSK
         2ph/cP7n2q/PWcUz6xAWLVTsRVO5JdEeJIpYaBtJhdHbgotKxoyuuBsvM0D3YAHJ1zlF
         2Izd8GIunhRXJo4SiNfMJapX8mo0WPVb5aTInTgfuDAqva55CrSwFGGVMF3abDCWuUy2
         6CKA==
X-Gm-Message-State: APjAAAX/IdoHZpeY/WWSZMskFYuG54H82r72Wg14BhP8dlXHhTDqLS0S
        AzLGLm9MznFRKwN+OCb32RNUrDFP
X-Google-Smtp-Source: APXvYqymGJgSsA5bCsSzCP3bljvW6IYDAGFmgcxvVCkoVk49SiahFOEaQhCcvHh/hIv6fLjeNEQC7w==
X-Received: by 2002:a62:8643:: with SMTP id x64mr57818429pfd.7.1564699855526;
        Thu, 01 Aug 2019 15:50:55 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d12sm35472010pfn.11.2019.08.01.15.50.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:50:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 2/5] block: Document the bio splitting functions
Date:   Thu,  1 Aug 2019 15:50:41 -0700
Message-Id: <20190801225044.143478-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801225044.143478-1-bvanassche@acm.org>
References: <20190801225044.143478-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since what the bio splitting functions do is nontrivial, document these
functions.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
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
2.22.0.770.g0f2c4a37fd-goog

