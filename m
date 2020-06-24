Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD41C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 06:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB8DB20706
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 06:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbgFXGsY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:48:24 -0400
Received: from verein.lst.de ([213.95.11.211]:43007 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388972AbgFXGsX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 02:48:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4BA7568AEF; Wed, 24 Jun 2020 08:48:20 +0200 (CEST)
Date:   Wed, 24 Jun 2020 08:48:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk, agk@redhat.com,
        snitzer@redhat.com, kbusch@kernel.org, hch@lst.de,
        rostedt@goodmis.org, mingo@redhat.com, rdunlap@infradead.org
Subject: Re: [PATCH RFC] block: blktrace framework cleanup
Message-ID: <20200624064820.GA17964@lst.de>
References: <20200624032752.4177-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624032752.4177-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Tue, Jun 23, 2020 at 08:27:52PM -0700, Chaitanya Kulkarni wrote:
> There are many places where trace API accepts the struct request_queue*
> parameter which can be derived from other function parameters.
> 
> This patch removes the struct request queue parameter from the
> blktrace framework and adjusts the tracepoints definition and usage
> along with the tracing API itself.

Good idea, and I had a half-ready patch for this already as well.

One issue, and two extra requests below:


>  	if (bio->bi_disk && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
> -		trace_block_bio_complete(bio->bi_disk->queue, bio);
> +		trace_block_bio_complete(bio);

This one can also be called for a different queue than
bio->bi_disk->queue, so for this one particular tracepoint we'll need
to keep the request_queue argument.

> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index fdcc2c1dd178..a3cade16ef80 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -409,7 +409,7 @@ EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
>  
>  void blk_mq_sched_request_inserted(struct request *rq)
>  {
> -	trace_block_rq_insert(rq->q, rq);
> +	trace_block_rq_insert(rq);
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_sched_request_inserted);

As a follow on patch we should also remove this function.

>  	}
>  
>  	spin_lock(&ctx->lock);
> @@ -2111,7 +2111,7 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  		goto queue_exit;
>  	}
>  
> -	trace_block_getrq(q, bio, bio->bi_opf);
> +	trace_block_getrq(bio, bio->bi_opf);

The second argument can be removed as well.  Maybe as another patch.
