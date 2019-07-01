Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7DCC0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 16:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF4620B7C
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 16:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfGAQXg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:23:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40182 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfGAQXg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 12:23:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so6820753pfp.7
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 09:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2wasO0hGQU50Xqo+aBfpO73qKpsy3b+tGp+OMPkmUx4=;
        b=aWwqq5gVbBHHDpCLmDHKsBwAj09nhgTKgIHUma8+/xvgBOyfmHqPXDLQtLDppeyQWv
         SRKvObbuB87CXXngBvFl76XVv7/M79EGMXPN6NTRUfsgXfmrs9hWcsT5WTdD4ys5x7Ue
         JFGaY9Z8+ZFbalvSxomwc8zLXWArFsQwPA0f9u6YZcsw0LN3Yo0XXmOWzEBkSLObA/nv
         11ltxwUT+PqJ5bNau1yaKlI9H6Z94OSuqlSfpbqBMhD0/iKBd5K3O07nT6s9/oK2ihVc
         6sP2Njm1k6dhIW2ltQ+nKRHVaQy+IoR9pSVs5E9LuwYrk8Aa3ctZwwkEiBr8MYprFjma
         Dn0w==
X-Gm-Message-State: APjAAAUu5UMkI5mRafM8fsMAFuCX9AuGYo0peokZS+IK+SECSU6H7vdf
        sc32zUgag8J6g8SWuHLFAYg=
X-Google-Smtp-Source: APXvYqyoSvVLvLDjl4/1KXMS8QIarE5YDuKYodslNge9lMzODZdqUyTbLpPW1s0Ddxnw3/JhQGamMg==
X-Received: by 2002:a63:c14c:: with SMTP id p12mr25783046pgi.138.1561998215464;
        Mon, 01 Jul 2019 09:23:35 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id o16sm24646076pgi.36.2019.07.01.09.23.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 09:23:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block: Document the bio splitting functions
Date:   Mon,  1 Jul 2019 09:23:28 -0700
Message-Id: <20190701162328.216266-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
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
 block/blk-merge.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1ea00da12ca3..038eaee4438a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -192,6 +192,23 @@ static bool bvec_split_segs(const struct request_queue *q,
 	return !!len;
 }
 
+/**
+ * blk_bio_segment_split - split a bio in two bios
+ * @q:    [in] request queue pointer
+ * @bio:  [in] bio to be split
+ * @bs:	  [in] bio set to allocate the clone from
+ * @segs: [out] number of segments in the bio with the first half of the sectors
+ *
+ * Clones @bio, updates the bi_iter of the clone to represent the first sectors
+ * of @bio and updates @bio->bi_iter to represent the remaining sectors. The
+ * following is guaranteed for the cloned bio:
+ * - That it has at most get_max_io_size(@q, @bio) sectors.
+ * - That it has at most queue_max_segments(@q) segments.
+ *
+ * Except for discard requests the cloned bio will point at the bi_io_vec of
+ * the original bio. It is the responsibility of the caller to ensure that the
+ * original bio is not freed before the cloned bio.
+ */
 static struct bio *blk_bio_segment_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
@@ -248,6 +265,16 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
 
+/**
+ * __blk_queue_split - split a bio and submit the second half
+ * @q:       [in] request queue pointer
+ * @bio:     [in, out] bio to be split
+ * @nr_segs: [out] number of segments in the first bio
+ *
+ * Splits a bio into two bios, chains the two bios, submits the second half
+ * and stores a pointer to the first half in *@bio. If the second bio is still
+ * too big it will be split by a recursive call to this function.
+ */
 void __blk_queue_split(struct request_queue *q, struct bio **bio,
 		unsigned int *nr_segs)
 {
@@ -292,6 +319,14 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 	}
 }
 
+/**
+ * blk_queue_split - split a bio and submit the second half
+ * @q:   [in] request queue pointer
+ * @bio: [in, out] bio to be split
+ *
+ * Splits a bio into two bios, chains the two bios, submits the second half
+ * and stores a pointer to the first half in *@bio.
+ */
 void blk_queue_split(struct request_queue *q, struct bio **bio)
 {
 	unsigned int nr_segs;
-- 
2.22.0.410.gd8fdbe21b5-goog

