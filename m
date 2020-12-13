Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED68C4361B
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 18:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E766123123
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 18:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgLMSUK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Dec 2020 13:20:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgLMSUK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Dec 2020 13:20:10 -0500
Date:   Sun, 13 Dec 2020 10:19:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607883569;
        bh=2Ay8iwxkhb7pWruC+8K4CRD5cAg4o6Zb2YUnRMyL4OA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=awGh4xeTpxSVTS1o2D5YfUfSIzT58U2okQqY+2g58HryAWMtBA1FAJukpDVdFQgeD
         vSU9zky0P30yDCSWQSLfNJlYYVXUgmjIMPXZ/EdDeaqNdpRfat894GNDTVBigO/QdM
         qZHgXZNZJwQWu82pcLKckUm2ZDR8tBQg6ZExxBYgWxfe5OOGHnCK8GTWMbma1gF0Xd
         GSMukYyPJ+hi4Sd2BFebKsFZQXusanIaAu8Kc7aFMykSwYCKXhsnjoe8VVPWqpVvuB
         /wAm1dicBeT5RSVS8oVjN/2hiKEowa9lSj4dAt6EXev+t8ZkCRUAIHtzVbuTKH8egT
         2QKYp309KIhrA==
From:   Keith Busch <kbusch@kernel.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Andres Freund <andres@anarazel.de>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: hybrid polling on an nvme doesn't seem to work with iodepth > 1
 on 5.10.0-rc5
Message-ID: <20201213181927.GA3909519@dhcp-10-100-145-180.wdc.com>
References: <20201210205141.px7suygfrl2lhdkr@alap3.anarazel.de>
 <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
 <aa735173-fad1-b7d4-1c90-4fccc90c562d@gmail.com>
 <20201211011940.ouc4k3am5gg2ithp@alap3.anarazel.de>
 <de0b46d2-d053-a7a8-23e7-fc954807c70d@gmail.com>
 <20201211033719.GA6414@redsun51.ssa.fujisawa.hgst.com>
 <2b26eaca-d143-6951-3bed-ce29df4dd07d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b26eaca-d143-6951-3bed-ce29df4dd07d@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 11, 2020 at 12:38:43PM +0000, Pavel Begunkov wrote:
> On 11/12/2020 03:37, Keith Busch wrote:
> > It sounds like the statistic is using the wrong criteria. It ought to
> > use the average time for the next available completion for any request
> > rather than the average latency of a specific IO. It might work at high
> > depth if the hybrid poll knew the hctx's depth when calculating the
> > sleep time, but that information doesn't appear to be readily available.
> 
> It polls (and so sleeps) from submission of a request to its completion,
> not from request to request. 

Right, but the polling thread is responsible for completing all
requests, not just the most recent cookie. If the sleep timer uses the
round trip of a single request when you have a high queue depth, there
are likely to be many completions in the pipeline that aren't getting
polled on time. This feeds back to the mean latency, pushing the sleep
timer further out.

> Looks like the other scheme doesn't suit well
> when you don't have a constant-ish flow of requests, e.g. QD=1 and with
> different latency in the userspace.

The idea I'm trying to convey shouldn't affect QD1. The following patch
seems to test "ok", but I know of at least a few scenarios where it
falls apart...

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e9799fed98c7..cab2dafcd3a9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3727,6 +3727,7 @@ static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb)
 static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 				       struct request *rq)
 {
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 	unsigned long ret = 0;
 	int bucket;
 
@@ -3753,6 +3754,15 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 	if (q->poll_stat[bucket].nr_samples)
 		ret = (q->poll_stat[bucket].mean + 1) / 2;
 
+	/*
+	 * Finding completions on the first poll indicates we're sleeping too
+	 * long and pushing the latency statistic in the wrong direction for
+	 * future sleep consideration. Poll immediately until the average time
+	 * becomes more useful.
+	 */
+	if (hctx->poll_invoked < 3 * hctx->poll_considered)
+		return 0;
+
 	return ret;
 }
 
---
