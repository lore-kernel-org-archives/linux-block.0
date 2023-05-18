Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9C6C77B7D
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 05:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjERFbL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 01:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjERFbK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 01:31:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BCACE
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 22:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xTfXsXh3bvbS2NAY7L17wcmVVEUhUrIlvx29OIQV2KI=; b=vLNAxvo+V7knjLMUxvPCyq8ylY
        NrXwHhWs9M828ErBhkedGp5PfzKJ2giVUXibfvf2BwQl7jL90wXY5ot5i7vwDWahbhZq3GMunpLUh
        51vcdka8PS6g2EnijeD6LQQkB1fY+mCmpetk/8UwPLrl0ZlLVhmpocmprNHB7yLVG7lIfSaIRau6j
        avjOUs2/GXupCcZyWrqJF1HLjr+Uc3cawdlzZN0CNeownOqzdRj+08fXbX1hIuifrQZ5OeFUJD0KU
        2faVNstdY+kJZiCsSchNtFa0Q3SntKD629GS1pfMY+NyuCUZ5Tfk1J7xDZOMbHvzdzyntTOUDWS1O
        gUOZW5OQ==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzWEE-00BwdB-2p;
        Thu, 18 May 2023 05:31:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Subject: [PATCH 1/3] blk-mq: don't queue plugged passthrough requests into scheduler
Date:   Thu, 18 May 2023 07:30:59 +0200
Message-Id: <20230518053101.760632-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518053101.760632-1-hch@lst.de>
References: <20230518053101.760632-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Passthrough) request should never be queued to the I/O scheduler,
as scheduling these opaque requests doens't make sense, and I/O
schedulers might required req->bio to be always valid.

We never let passthrough request cross scheduler before commit
1c2d2fff6dc0 ("block: wire-up support for passthrough plugging"),
restored this behavior even for passthrough requests issued under
a plug.

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Closes: https://lore.kernel.org/linux-block/CAGS2=YosaYaUTEMU3uaf+y=8MqSrhL7sYsJn8EwbaM=76p_4Qg@mail.gmail.com/
Investigated-by: Yu Kuai <yukuai1@huaweicloud.com>
Fixes: 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
[hch: use blk_mq_insert_requests for passthrough requests,
      fix up the commit message and comments]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6dad0886a2fa1..8b7e4daaa5b70d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2711,6 +2711,7 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 	struct request *requeue_list = NULL;
 	struct request **requeue_lastp = &requeue_list;
 	unsigned int depth = 0;
+	bool is_passthrough = false;
 	LIST_HEAD(list);
 
 	do {
@@ -2719,7 +2720,9 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 		if (!this_hctx) {
 			this_hctx = rq->mq_hctx;
 			this_ctx = rq->mq_ctx;
-		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx) {
+			is_passthrough = blk_rq_is_passthrough(rq);
+		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
+			   is_passthrough != blk_rq_is_passthrough(rq)) {
 			rq_list_add_tail(&requeue_lastp, rq);
 			continue;
 		}
@@ -2731,7 +2734,8 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 	trace_block_unplug(this_hctx->queue, depth, !from_sched);
 
 	percpu_ref_get(&this_hctx->queue->q_usage_counter);
-	if (this_hctx->queue->elevator) {
+	/* passthrough requests should never be issued to the I/O scheduler */
+	if (this_hctx->queue->elevator && !is_passthrough) {
 		this_hctx->queue->elevator->type->ops.insert_requests(this_hctx,
 				&list, 0);
 		blk_mq_run_hw_queue(this_hctx, from_sched);
-- 
2.39.2

