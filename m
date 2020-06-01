Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC51C433DF
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 12:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0743F206C3
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 12:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="diASRVyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFAMhP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:37:15 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:34160 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbgFAMhO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jun 2020 08:37:14 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 63A412E146A;
        Mon,  1 Jun 2020 15:37:11 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 2BvFuUgSOx-b9fuaNjU;
        Mon, 01 Jun 2020 15:37:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1591015031; bh=TQETKRhtCiB37qEhqMf6OVjO3wUc34huMloLIRNEzig=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=diASRVyfaLvmacOpxcs2ovMQxQZUkZLgWuhkDOxnAR8SThK5rf4OLsGKSyggA/4Vf
         nSPGDwHLrZMXlH8HF67BO+B26G2Cs66akUZAEpTRsA7YbQfcneJDl5IAIYdPP2KZ9n
         iRtrHGY87HhZEtbgBwx7Xzcr8UpADkmvQoPQJFMY=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:6420::1:8])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 1wSpJbGMQA-b9Wux0gM;
        Mon, 01 Jun 2020 15:37:09 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 1/3] block: add flag 'nowait_requests' into queue limits
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>
Date:   Mon, 01 Jun 2020 15:37:09 +0300
Message-ID: <159101502963.180989.6228080995222059011.stgit@buzz>
In-Reply-To: <159101473169.180989.12175693728191972447.stgit@buzz>
References: <159101473169.180989.12175693728191972447.stgit@buzz>
User-Agent: StGit/0.22-39-gd257
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add flag for marking bio-based queues which support REQ_NOWAIT.
Set for all request based (mq) devices.

Stacking device should set it after blk_set_stacking_limits() if method
make_request() itself doesn't delay requests or handles REQ_NOWAIT.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/blk-core.c       |    4 ++--
 block/blk-mq.c         |    3 +++
 block/blk-settings.c   |    3 +++
 include/linux/blkdev.h |    1 +
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c4b015004796..9139a316e6d4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -892,9 +892,9 @@ generic_make_request_checks(struct bio *bio)
 
 	/*
 	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
-	 * if queue is not a request based queue.
+	 * if queue does not support this flag.
 	 */
-	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q))
+	if ((bio->bi_opf & REQ_NOWAIT) && !q->limits.nowait_requests)
 		goto not_supported;
 
 	if (should_fail_bio(bio))
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a7785df2c944..0c3daa0cda87 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2952,6 +2952,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	 */
 	q->poll_nsec = BLK_MQ_POLL_CLASSIC;
 
+	/* Request based queue always supports REQ_NOWAIT */
+	q->limits.nowait_requests = 1;
+
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q);
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 14397b4c4b53..8f96c7324497 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -59,6 +59,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->io_opt = 0;
 	lim->misaligned = 0;
 	lim->zoned = BLK_ZONED_NONE;
+	lim->nowait_requests = 0;
 }
 EXPORT_SYMBOL(blk_set_default_limits);
 
@@ -486,6 +487,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_segment_size = min_not_zero(t->max_segment_size,
 					   b->max_segment_size);
 
+	t->nowait_requests &= b->nowait_requests;
+
 	t->misaligned |= b->misaligned;
 
 	alignment = queue_limit_alignment_offset(b, start);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..5f612dda34c2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -346,6 +346,7 @@ struct queue_limits {
 	unsigned char		misaligned;
 	unsigned char		discard_misaligned;
 	unsigned char		raid_partial_stripes_expensive;
+	unsigned char		nowait_requests;
 	enum blk_zoned_model	zoned;
 };
 

