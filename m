Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB6EC4360F
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5CB20840
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197909;
	bh=J67Vt12geolshGvCQ5737yLG1eJWIMHZWnqYpI5sOBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rr2B85XlQl2SHMDw1iNz8LwDi0ZOGG/0vORCYfPWr+RXYTz3dj5hKJEBSIfTycQaq
	 fuEW1JAPgvFAESKvAH6CvIkCoWpK5MzeNk7z9Sw1GwbpO3M8ecfMwvhc3ey1+g1yW5
	 P3AuyAEXchMIg74ipzBkyfL1yX7AD5LZWPq7TZNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391107AbfBOCMa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:12:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391078AbfBOCM2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F3B5206BA;
        Fri, 15 Feb 2019 02:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196747;
        bh=J67Vt12geolshGvCQ5737yLG1eJWIMHZWnqYpI5sOBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPB5REvF9ee3lwtIujZSHJOtJEh1fhcpoHb8bE5JBAPnimWFGl1y5MiLbpGZVKZZn
         oZ0kf1uniogmEplJe+AGO9BbzxApva4kTV2E3f2VdTt2zPsUOkwgyKTEyvFBZS6Rp7
         I6mS/dcm2wyzpxgHmvB/UqwwfGB6YYKzJdWHXFWc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        NeilBrown <neilb@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 41/65] block: cover another queue enter recursion via BIO_QUEUE_ENTERED
Date:   Thu, 14 Feb 2019 21:10:57 -0500
Message-Id: <20190215021121.177674-41-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 698cef173983b086977e633e46476e0f925ca01e ]

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
Cc: NeilBrown <neilb@suse.com>
Reviewed-by:  Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c  | 11 +++++++++++
 block/blk-merge.c | 10 ----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index eb8b52241453..a9fde80606d7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2454,7 +2454,18 @@ blk_qc_t generic_make_request(struct bio *bio)
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
index 2e042190a4f1..ba7f732c519e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -211,16 +211,6 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
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
2.19.1

