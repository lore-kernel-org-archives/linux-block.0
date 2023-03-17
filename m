Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB4CC74A5B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 20:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCQUAI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCQT7x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 15:59:53 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAE6302AC
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 12:59:52 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so6401301pjp.1
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 12:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679083191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJRjXC8OJ9tkNBcDsusOIuRd5HHrk8VJANGN7GkUVw0=;
        b=FywOefKBmUtVjM6MC5aQP3bv5tDU0Ghek+olulExi7JbnNvA9N254UceMpjr65+3Bm
         ZKj0gafQ7RSt8ERwP3KPzSvxYydfhOIb973z7VhukvDRv8xusrjGlKRYZRncjzFCDs+I
         UDFhUUlNNJzXUM9K+rPSwUqnra/5NHAfjTwEzMzIKe2PBFA0qQB6IpBxZlYG898kVROP
         sslACjma5zgS2ZmJzijedTYagHl/Z6tT8Gv3bKLsV23sIiYV50+O3+pbRyjnZVKCtIem
         i4bM9j5shFgsnPJdPuRIlercXRE6m6rAREo9hJevd9XzenlBk4CJZjqLESvLBWIMHXKK
         Pi2Q==
X-Gm-Message-State: AO0yUKWANCzlONZsL9qSpfOM/mQKSTbTHAeVy3M816tbUNvY18H7wFl+
        p/4CwftIWSJpDvfMg0C6TWU=
X-Google-Smtp-Source: AK7set/H3/4yolECkXISguPiWOmAB0D+DEfkC/5QyLevVaJ/vplhBS/ESMinHzGjIeSRmQCR/bgZtQ==
X-Received: by 2002:a17:902:facd:b0:1a0:768a:e648 with SMTP id ld13-20020a170902facd00b001a0768ae648mr7364670plb.9.1679083191412;
        Fri, 17 Mar 2023 12:59:51 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad26:bef0:6406:d659])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902eec600b0019cb131b89csm1051917plb.254.2023.03.17.12.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:59:50 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/2] block: Split and submit bios in LBA order
Date:   Fri, 17 Mar 2023 12:59:38 -0700
Message-Id: <20230317195938.1745318-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230317195938.1745318-1-bvanassche@acm.org>
References: <20230317195938.1745318-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of submitting the bio fragment with the highest LBA first,
submit the bio fragment with the lowest LBA first. If plugging is
active, append requests at the end of the list with plugged requests
instead of at the start. This approach prevents write errors when
submitting large bios to host-managed zoned block devices.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c      | 9 +++++----
 block/blk-mq.c         | 7 +++++--
 include/linux/blk-mq.h | 6 ++++++
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2e07f6bd96be..6031021d7ac0 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -344,8 +344,8 @@ static struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
  * @nr_segs: returns the number of segments in the returned bio
  *
  * Check if @bio needs splitting based on the queue limits, and if so split off
- * a bio fitting the limits from the beginning of @bio and return it.  @bio is
- * shortened to the remainder and re-submitted.
+ * a bio fitting the limits from the beginning of @bio and submit it.  @bio is
+ * shortened to the remainder and returned.
  *
  * The split bio is allocated from @q->bio_split, which is provided by the
  * block layer.
@@ -380,8 +380,9 @@ struct bio *__bio_split_to_limits(struct bio *bio,
 		blkcg_bio_issue_init(split);
 		bio_chain(split, bio);
 		trace_block_split(split, bio->bi_iter.bi_sector);
-		submit_bio_noacct(bio);
-		return split;
+		submit_bio_noacct(split);
+		*nr_segs = bio_nr_segments(lim, bio);
+		return bio;
 	}
 	return bio;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cc32ad0cd548..9b0f9f3fdba0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1300,7 +1300,7 @@ static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
 
 static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 {
-	struct request *last = rq_list_peek(&plug->mq_list);
+	struct request *last = rq_list_peek(&plug->mq_list), **last_p;
 
 	if (!plug->rq_count) {
 		trace_block_plug(rq->q);
@@ -1317,7 +1317,10 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 	if (!plug->has_elevator && (rq->rq_flags & RQF_ELV))
 		plug->has_elevator = true;
 	rq->rq_next = NULL;
-	rq_list_add(&plug->mq_list, rq);
+	last_p = &plug->mq_list;
+	while (*last_p)
+		last_p = &(*last_p)->rq_next;
+	rq_list_add_tail(&last_p, rq);
 	plug->rq_count++;
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index dd5ce1137f04..5e01791967c0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -228,6 +228,12 @@ static inline unsigned short req_get_ioprio(struct request *req)
 	*(listptr) = rq;				\
 } while (0)
 
+#define rq_list_add_tail(lastpptr, rq) do {		\
+	(rq)->rq_next = NULL;				\
+	**(lastpptr) = rq;				\
+	*(lastpptr) = &rq->rq_next;			\
+} while (0)
+
 #define rq_list_pop(listptr)				\
 ({							\
 	struct request *__req = NULL;			\
