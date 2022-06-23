Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74194C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiFWTBA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiFWTAe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:34 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EB4A1E23
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:57 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so3412525pjr.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFxKlh69vpKK2GSD0HsDe+6kxHHjfwgM5wsVikqV7XE=;
        b=NimUElmQjDC1rnTZcbvkpKONNaB8dL9GVCXwGgPmDyZn4gjzFWCnUX4NcYweggFeD9
         G4spg4V8o/luGowSNvoCJ7VD4ApJ3VaBsQrahXAHMui3zKrfUD9iN6UZuvtoefXnEa0y
         nYb0ErSmcsileFhHv6/aFAV3B3CNpZjsbCHegf6NFBl15118Ou6HF1ewwvexiG2HjV7K
         /M3/iS/FfM1oB924EVRzRii7SOW6LPlyeGvOjBgrEIbF7sBs/Ohifh8s+NK/6paP6Fvp
         LOFZfo6JxhSpAesN8+kgqPnXvmyP9dkqrpo2ygbqL+lcyBzi9GJpd0KkKxQkCBVx3mM/
         95hQ==
X-Gm-Message-State: AJIora/nq+mIlf1z2qWqNkocfO6IQmjnAnQFVPwoBJl6+qlNrsr01soa
        ADp/rmcoIBVmHZpGQl88YEw=
X-Google-Smtp-Source: AGRyM1tbgpua8djrkFV8wAzRSqi58W+WA8yHRMA+GmP7xQ7gY3TvPr7fwak0m1MSlOXAYAOmLu1MPQ==
X-Received: by 2002:a17:902:b090:b0:167:7ae5:e13b with SMTP id p16-20020a170902b09000b001677ae5e13bmr40194835plr.170.1656007557398;
        Thu, 23 Jun 2022 11:05:57 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:56 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 15/51] dm/bufio: Change 'int rw' into 'enum req_op op'
Date:   Thu, 23 Jun 2022 11:04:52 -0700
Message-Id: <20220623180528.3595304-16-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using type 'enum req_op' instead of 'int'.
Make the role of the 'rw' arguments more clear by renaming these into 'op'
(operation). This patch does not change any functionality.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-bufio.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 5ffa1dcf84cf..666b36d043d4 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -577,12 +577,12 @@ static void dmio_complete(unsigned long error, void *context)
 	b->end_io(b, unlikely(error != 0) ? BLK_STS_IOERR : 0);
 }
 
-static void use_dmio(struct dm_buffer *b, int rw, sector_t sector,
+static void use_dmio(struct dm_buffer *b, enum req_op op, sector_t sector,
 		     unsigned n_sectors, unsigned offset)
 {
 	int r;
 	struct dm_io_request io_req = {
-		.bi_op = rw,
+		.bi_op = op,
 		.bi_op_flags = 0,
 		.notify.fn = dmio_complete,
 		.notify.context = b,
@@ -616,7 +616,7 @@ static void bio_complete(struct bio *bio)
 	b->end_io(b, status);
 }
 
-static void use_bio(struct dm_buffer *b, int rw, sector_t sector,
+static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
 		    unsigned n_sectors, unsigned offset)
 {
 	struct bio *bio;
@@ -630,10 +630,10 @@ static void use_bio(struct dm_buffer *b, int rw, sector_t sector,
 	bio = bio_kmalloc(vec_size, GFP_NOWAIT | __GFP_NORETRY | __GFP_NOWARN);
 	if (!bio) {
 dmio:
-		use_dmio(b, rw, sector, n_sectors, offset);
+		use_dmio(b, op, sector, n_sectors, offset);
 		return;
 	}
-	bio_init(bio, b->c->bdev, bio->bi_inline_vecs, vec_size, rw);
+	bio_init(bio, b->c->bdev, bio->bi_inline_vecs, vec_size, op);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = bio_complete;
 	bio->bi_private = b;
@@ -669,7 +669,8 @@ static inline sector_t block_to_sector(struct dm_bufio_client *c, sector_t block
 	return sector;
 }
 
-static void submit_io(struct dm_buffer *b, int rw, void (*end_io)(struct dm_buffer *, blk_status_t))
+static void submit_io(struct dm_buffer *b, enum req_op op,
+		      void (*end_io)(struct dm_buffer *, blk_status_t))
 {
 	unsigned n_sectors;
 	sector_t sector;
@@ -679,7 +680,7 @@ static void submit_io(struct dm_buffer *b, int rw, void (*end_io)(struct dm_buff
 
 	sector = block_to_sector(b->c, b->block);
 
-	if (rw != REQ_OP_WRITE) {
+	if (op != REQ_OP_WRITE) {
 		n_sectors = b->c->block_size >> SECTOR_SHIFT;
 		offset = 0;
 	} else {
@@ -698,9 +699,9 @@ static void submit_io(struct dm_buffer *b, int rw, void (*end_io)(struct dm_buff
 	}
 
 	if (b->data_mode != DATA_MODE_VMALLOC)
-		use_bio(b, rw, sector, n_sectors, offset);
+		use_bio(b, op, sector, n_sectors, offset);
 	else
-		use_dmio(b, rw, sector, n_sectors, offset);
+		use_dmio(b, op, sector, n_sectors, offset);
 }
 
 /*----------------------------------------------------------------
