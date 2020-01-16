Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2558C33CB6
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 18:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E35208C3
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 18:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199553;
	bh=9KQUfNd3Nvl/2tc+oWzrExL4KL6ShVPizW8ADsB0Frw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MwVnc7psK6IE6i94hmJihf+RTN3q0hve5TkoX/nOp+j5+KVFENrAAKkGLXxeRzrhe
	 JnluJRNXwMQi20ujc0CSwNzSvwe/ng/ASAqRSjdAuvRLA3jRMS/W9LZF1STK991BRv
	 4lP4sMkJLEvweS+XuJecR/NAkv3k5LOOem///GJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391636AbgAPRY7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:24:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391372AbgAPRY7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 12:24:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6A6D246A3;
        Thu, 16 Jan 2020 17:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195498;
        bh=9KQUfNd3Nvl/2tc+oWzrExL4KL6ShVPizW8ADsB0Frw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNNrfU0NOj7fMPkTLM6+VHhYUeSrJv+xwjurT/M3mwe0QC0wWu66NZkcdXtYx1Do+
         DQbL3eXEFHJkLoHbT3COj/l2JbVE9xfjt9+ZdZIdu82HKKqMkwElxJe+hrFRphnKla
         umDbfN11bA9+4+2w9CeOLouWmVQZipmf5l+drbDo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 099/371] block: don't use bio->bi_vcnt to figure out segment number
Date:   Thu, 16 Jan 2020 12:19:31 -0500
Message-Id: <20200116172403.18149-42-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 1a67356e9a4829da2935dd338630a550c59c8489 ]

It is wrong to use bio->bi_vcnt to figure out how many segments
there are in the bio even though CLONED flag isn't set on this bio,
because this bio may be splitted or advanced.

So always use bio_segments() in blk_recount_segments(), and it shouldn't
cause any performance loss now because the physical segment number is figured
out in blk_queue_split() and BIO_SEG_VALID is set meantime since
bdced438acd83ad83a6c ("block: setup bi_phys_segments after splitting").

Reviewed-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Fixes: 76d8137a3113 ("blk-merge: recaculate segment if it isn't less than max segments")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-merge.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index f61b50a01bc7..415b5dafd9e6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -299,13 +299,7 @@ void blk_recalc_rq_segments(struct request *rq)
 
 void blk_recount_segments(struct request_queue *q, struct bio *bio)
 {
-	unsigned short seg_cnt;
-
-	/* estimate segment number by bi_vcnt for non-cloned bio */
-	if (bio_flagged(bio, BIO_CLONED))
-		seg_cnt = bio_segments(bio);
-	else
-		seg_cnt = bio->bi_vcnt;
+	unsigned short seg_cnt = bio_segments(bio);
 
 	if (test_bit(QUEUE_FLAG_NO_SG_MERGE, &q->queue_flags) &&
 			(seg_cnt < queue_max_segments(q)))
-- 
2.20.1

