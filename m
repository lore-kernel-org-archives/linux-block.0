Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40254C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197492073D
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfBOC2V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:28:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbfBOC2U (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 21:28:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8616C0AC921;
        Fri, 15 Feb 2019 02:28:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD73A5C54B;
        Fri, 15 Feb 2019 02:28:12 +0000 (UTC)
Date:   Fri, 15 Feb 2019 10:28:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        NeilBrown <neilb@suse.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.20 49/77] block: cover another queue enter
 recursion via BIO_QUEUE_ENTERED
Message-ID: <20190215022807.GC21045@ming.t460p>
References: <20190215020855.176727-1-sashal@kernel.org>
 <20190215020855.176727-49-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215020855.176727-49-sashal@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 15 Feb 2019 02:28:20 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 14, 2019 at 09:08:27PM -0500, Sasha Levin wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> [ Upstream commit 698cef173983b086977e633e46476e0f925ca01e ]
> 
> Except for blk_queue_split(), bio_split() is used for splitting bio too,
> then the remained bio is often resubmit to queue via generic_make_request().
> So the same queue enter recursion exits in this case too. Unfortunatley
> commit cd4a4ae4683dc2 doesn't help this case.
> 
> This patch covers the above case by setting BIO_QUEUE_ENTERED before calling
> q->make_request_fn.
> 
> In theory the per-bio flag is used to simulate one stack variable, it is
> just fine to clear it after q->make_request_fn is returned. Especially
> the same bio can't be submitted from another context.
> 
> Fixes: cd4a4ae4683dc2 ("block: don't use blocking queue entered for recursive bio submits")
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: NeilBrown <neilb@suse.com>
> Reviewed-by:  Mike Snitzer <snitzer@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  block/blk-core.c  | 11 +++++++++++
>  block/blk-merge.c | 10 ----------
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index deb56932f8c4..22260339f66f 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2449,7 +2449,18 @@ blk_qc_t generic_make_request(struct bio *bio)
>  			/* Create a fresh bio_list for all subordinate requests */
>  			bio_list_on_stack[1] = bio_list_on_stack[0];
>  			bio_list_init(&bio_list_on_stack[0]);
> +
> +			/*
> +			 * Since we're recursing into make_request here, ensure
> +			 * that we mark this bio as already having entered the queue.
> +			 * If not, and the queue is going away, we can get stuck
> +			 * forever on waiting for the queue reference to drop. But
> +			 * that will never happen, as we're already holding a
> +			 * reference to it.
> +			 */
> +			bio_set_flag(bio, BIO_QUEUE_ENTERED);
>  			ret = q->make_request_fn(q, bio);
> +			bio_clear_flag(bio, BIO_QUEUE_ENTERED);
>  
>  			/* sort new bios into those for a lower level
>  			 * and those for the same level
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 7695034f4b87..adfe835ab258 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -272,16 +272,6 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
>  		/* there isn't chance to merge the splitted bio */
>  		split->bi_opf |= REQ_NOMERGE;
>  
> -		/*
> -		 * Since we're recursing into make_request here, ensure
> -		 * that we mark this bio as already having entered the queue.
> -		 * If not, and the queue is going away, we can get stuck
> -		 * forever on waiting for the queue reference to drop. But
> -		 * that will never happen, as we're already holding a
> -		 * reference to it.
> -		 */
> -		bio_set_flag(*bio, BIO_QUEUE_ENTERED);
> -
>  		bio_chain(split, *bio);
>  		trace_block_split(q, split, (*bio)->bi_iter.bi_sector);
>  		generic_make_request(*bio);
> -- 
> 2.19.1
> 

This one should be dropped, given it has been reverted.

-- 
Ming
