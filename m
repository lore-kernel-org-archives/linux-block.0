Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4B5C433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 16:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAABF22B49
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596039153;
	bh=6odGQAlsGAjIO5C9+jDPao0Eqc3yHtptq7MwPG24FzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gSPjrdajb+JB9f/i3IucY4qBEwKxebRWyOOCI6016g8DF4VtOAh+oFS/YCk/seKtd
	 9h7XCxiRJIONMq33zK8pfa6SmFAQ9ZmyQpLrjoO3ZcVMlDhlEj1RZBxYmwVyI5me8g
	 I7id9tVsxpWZk/+RlS1DKfbiVCCgpkDWtOx/1Af0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgG2QMc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:12:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2QMc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 12:12:32 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B14720FC3;
        Wed, 29 Jul 2020 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596039151;
        bh=6odGQAlsGAjIO5C9+jDPao0Eqc3yHtptq7MwPG24FzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hChLhcLMiiOcVU+evfdPvcp2cuRuzqrFjiiPVAcLtNXsG/pKULCEz7pTD3QGlaUtG
         B5p4A2Y8W/a2gQBdo3njYpkXjyskUPNEQ5J0kIxvQEW+1q7yIIT9R+UDimW52z3tmd
         mNS+OE7TIZJAIHV3KdZC1rO4oJPXcYyyC2U6ZBu0=
Date:   Wed, 29 Jul 2020 09:12:29 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Message-ID: <20200729161229.GA3136267@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200728134938.1505467-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728134938.1505467-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 28, 2020 at 09:49:38PM +0800, Ming Lei wrote:
>  void blk_mq_quiesce_queue(struct request_queue *q)
>  {
> -	struct blk_mq_hw_ctx *hctx;
> -	unsigned int i;
> -	bool rcu = false;
> -
>  	blk_mq_quiesce_queue_nowait(q);
>  
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (hctx->flags & BLK_MQ_F_BLOCKING)
> -			synchronize_srcu(hctx->srcu);
> -		else
> -			rcu = true;
> -	}
> -	if (rcu)
> +	if (q->tag_set->flags & BLK_MQ_F_BLOCKING) {
> +		percpu_ref_kill(&q->dispatch_counter);
> +		wait_event(q->mq_quiesce_wq,
> +				percpu_ref_is_zero(&q->dispatch_counter));
> +	} else
>  		synchronize_rcu();
>  }



> +static void hctx_lock(struct blk_mq_hw_ctx *hctx)
>  {
> -	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> -		/* shut up gcc false positive */
> -		*srcu_idx = 0;
> +	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
>  		rcu_read_lock();
> -	} else
> -		*srcu_idx = srcu_read_lock(hctx->srcu);
> +	else
> +		percpu_ref_get(&hctx->queue->dispatch_counter);
>  }

percpu_ref_get() will always succeed, even after quiesce kills it.
Isn't it possible that 'percpu_ref_is_zero(&q->dispatch_counter))' may
never reach 0? We only need to ensure that dispatchers will observe
blk_queue_quiesced(). That doesn't require that there are no current
dispatchers.
