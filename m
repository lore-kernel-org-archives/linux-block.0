Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E3DC282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 08:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982E920861
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 08:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfAVIUa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:20:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfAVIU3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 03:20:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C30CD8764B;
        Tue, 22 Jan 2019 08:20:29 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BE345D9CB;
        Tue, 22 Jan 2019 08:20:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Snitzer <snitzer@redhat.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH] block: cover another queue enter recursion via BIO_QUEUE_ENTERED
Date:   Tue, 22 Jan 2019 16:20:17 +0800
Message-Id: <20190122082017.9020-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 22 Jan 2019 08:20:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Except for blk_queue_split(), bio_split() is used for splitting bio too,
then the remained bio is often resubmit to queue via generic_make_request().
So the same queue enter recursion exits in this case too. Unfortunatley
commit cd4a4ae4683dc2 doesn't help this case.

This patch covers the above case by setting BIO_QUEUE_ENTERED before calling
q->make_request_fn.

In theory the per-bio flag is used to simulate one stack variable, it is
just fine to clear it after q->make_request_fn is returned. Especially
the same bio can't be submitted from another context.

Fixes: cd4a4ae4683dc2 ("block: don't use blocking queue entered for recursive bio submits")
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c  | 11 +++++++++++
 block/blk-merge.c | 10 ----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3c5f61ceeb67..1ccec27d20c3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1083,7 +1083,18 @@ blk_qc_t generic_make_request(struct bio *bio)
 			/* Create a fresh bio_list for all subordinate requests */
 			bio_list_on_stack[1] = bio_list_on_stack[0];
 			bio_list_init(&bio_list_on_stack[0]);
+
+			/*
+			 * Since we're recursing into make_request here, ensure
+			 * that we mark this bio as already having entered the queue.
+			 * If not, and the queue is going away, we can get stuck
+			 * forever on waiting for the queue reference to drop. But
+			 * that will never happen, as we're already holding a
+			 * reference to it.
+			 */
+			bio_set_flag(bio, BIO_QUEUE_ENTERED);
 			ret = q->make_request_fn(q, bio);
+			bio_clear_flag(bio, BIO_QUEUE_ENTERED);
 
 			/* sort new bios into those for a lower level
 			 * and those for the same level
diff --git a/block/blk-merge.c b/block/blk-merge.c
index b990853f6de7..8777e286bd3f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -339,16 +339,6 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
 		/* there isn't chance to merge the splitted bio */
 		split->bi_opf |= REQ_NOMERGE;
 
-		/*
-		 * Since we're recursing into make_request here, ensure
-		 * that we mark this bio as already having entered the queue.
-		 * If not, and the queue is going away, we can get stuck
-		 * forever on waiting for the queue reference to drop. But
-		 * that will never happen, as we're already holding a
-		 * reference to it.
-		 */
-		bio_set_flag(*bio, BIO_QUEUE_ENTERED);
-
 		bio_chain(split, *bio);
 		trace_block_split(q, split, (*bio)->bi_iter.bi_sector);
 		generic_make_request(*bio);
-- 
2.9.5

