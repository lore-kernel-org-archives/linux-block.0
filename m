Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E94C433E7
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 20:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D44C20773
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 20:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIBUTe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:19:34 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44418 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBUTe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 16:19:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 1239429A1D3
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>, kernel@collabora.com
Subject: [PATCH v2] block: Consider only dispatched requests for inflight statistic
Organization: Collabora
References: <20200831153127.3561733-1-krisman@collabora.com>
        <CACVXFVM21GWTrWs=6w3OXm7vQ-gmR_3PGss+9TE=swVN-Uzn7Q@mail.gmail.com>
        <87wo1dpclt.fsf@collabora.com>
        <d3dd1d80-ea30-f9df-9812-05b846a76f21@kernel.dk>
Date:   Wed, 02 Sep 2020 16:19:28 -0400
In-Reply-To: <d3dd1d80-ea30-f9df-9812-05b846a76f21@kernel.dk> (Jens Axboe's
        message of "Tue, 1 Sep 2020 16:39:09 -0600")
Message-ID: <87r1rkorsf.fsf_-_@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> We just need to decide if this makes sense or not. I think we should
> apply this for 5.10, with Ming's suggestion of using
> blk_mq_request_started(). Then I guess we'll see what happens...

Hello,

Here is the second version, then.  But, instead of
blk_mq_request_started as suggested on the review, this uses
blk_mq_rq_state to access the state attribute, since we don't want to
include MQ_RQ_COMPLETE.

Also, improved the commit message a bit.

Thanks,

>8

According to Documentation/block/stat.rst, inflight should not include
I/O requests that are in the queue but not yet dispatched to the device,
but blk-mq identifies as inflight any request that has a tag allocated,
which, for queues without elevator, happens at request allocation time
and before it is queued in the ctx (default case in blk_mq_submit_bio).

In addition, current behavior is different for queues with elevator from
queues without it, since for the former the driver tag is allocated at
dispatch time.  A more precise approach would be to only consider
requests with state MQ_RQ_IN_FLIGHT.

This effectively reverts commit 6131837b1de6 ("blk-mq: count allocated
but not started requests in iostats inflight") to consolidate blk-mq
behavior with itself (elevator case) and with original documentation,
but it differs from the behavior used by the legacy path.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
Changes Since v1:
  - Use blk_mq_rq_state to fetch req->state
  - Improve commit message

 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0015a1892153..bee55f80fb69 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -105,7 +105,7 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 {
 	struct mq_inflight *mi = priv;
 
-	if (rq->part == mi->part)
+	if (rq->part == mi->part && blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
 		mi->inflight[rq_data_dir(rq)]++;
 
 	return true;
-- 
2.28.0


