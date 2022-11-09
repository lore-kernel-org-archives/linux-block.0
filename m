Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B95C4332F
	for <linux-block@archiver.kernel.org>; Wed,  9 Nov 2022 10:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiKIKId (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Nov 2022 05:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiKIKIb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 05:08:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A7B5FE2
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 02:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xk841BuvR0epzPDzgT1Vm4hLiQe4Xs0h426bTakmp/w=; b=1E1hJt1EvRPqzFsunRwm2cLgQV
        JzuWaVVv3t6JYK6IX5gBf0O63EipnvlL+f+j1Jfo7ptGkefqS+R9lQgKAzXZnUJfb6EWhhB29uOzT
        zh7tw7vA3EQUcXZ7z0dfnJkf1j2JJnQIKGQ6b1CIQT/VzRiz/Yf2yOw0tt7Y9iFojUfrVLrFXUF3p
        BotvQKEajmev0vWK0S4Lo2XiN4EhENrTfffarAUoyst3caCjKEWQTdsyT0Youte4poeyBeewUAWFt
        Fiut7PHTeBOe+IQsOTU5gN1CrMNRwnUSPi6wigBzApYe9qUE2r1cV118iV8hpUTevEnoO2dzwG+On
        nsOveClw==;
Received: from [46.183.103.17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osi0N-00CZrl-Mp; Wed, 09 Nov 2022 10:08:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] blk-mq: simplify blk_mq_realloc_tag_set_tags
Date:   Wed,  9 Nov 2022 11:08:11 +0100
Message-Id: <20221109100811.2413423-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109100811.2413423-1-hch@lst.de>
References: <20221109100811.2413423-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use set->nr_hw_queues for the current number of tags, and remove the
duplicate set->nr_hw_queues update in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8c630dbdf107e..9fa0b9a1435f2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4381,11 +4381,11 @@ static void blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 }
 
 static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
-				  int cur_nr_hw_queues, int new_nr_hw_queues)
+				       int new_nr_hw_queues)
 {
 	struct blk_mq_tags **new_tags;
 
-	if (cur_nr_hw_queues >= new_nr_hw_queues)
+	if (set->nr_hw_queues >= new_nr_hw_queues)
 		return 0;
 
 	new_tags = kcalloc_node(new_nr_hw_queues, sizeof(struct blk_mq_tags *),
@@ -4394,7 +4394,7 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 		return -ENOMEM;
 
 	if (set->tags)
-		memcpy(new_tags, set->tags, cur_nr_hw_queues *
+		memcpy(new_tags, set->tags, set->nr_hw_queues *
 		       sizeof(*set->tags));
 	kfree(set->tags);
 	set->tags = new_tags;
@@ -4710,11 +4710,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	}
 
 	prev_nr_hw_queues = set->nr_hw_queues;
-	if (blk_mq_realloc_tag_set_tags(set, set->nr_hw_queues, nr_hw_queues) <
-	    0)
+	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
 		goto reregister;
 
-	set->nr_hw_queues = nr_hw_queues;
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-- 
2.30.2

