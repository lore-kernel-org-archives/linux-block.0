Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E1CC83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 15:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D8B206D7
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 15:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j9Vo4tHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgD1P6v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728337AbgD1P6u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 11:58:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631C9C03C1AB
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2020 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s13NL+gqYZoXB69aP0Kxcqu19UWcTJmJUqmL44bmWsk=; b=j9Vo4tHU5rW/sfqXbbqP5PVhoX
        2wV2X9mx5qAMiw1Wcv1v2e+NysDjgq5wzIA+B3IKK+n7aq/hww5G7ZSCBKwxJ4dr4DqSIWTaVXqs4
        OuryQb+9rZxegfS5/AwlGmK5BAC7mFIOKxIwPXbhs7hGMJasSGWM4ApwAC/vVFg6nvukOio+4Z0PS
        U0rPJDXj+lOHfVww0Pfjv2Nc6Lr3mOlWiNdm95RN7Fp6py5+YAqWptFX9ZBmZqgEptAJdOS6hzgJx
        xpUafi1D0LVu20cu+hFwG23rvqfDOlkJLC1dcVHSRIWL9JxfjjZTJpobxaCj1fq4F+R27cjAJ4pQ/
        ul7mDBqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTSd6-0004Lc-3m; Tue, 28 Apr 2020 15:58:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C01CE304121;
        Tue, 28 Apr 2020 17:58:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7D0E201F9F0D; Tue, 28 Apr 2020 17:58:37 +0200 (CEST)
Date:   Tue, 28 Apr 2020 17:58:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200428155837.GA16910@hirez.programming.kicks-ass.net>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-8-ming.lei@redhat.com>
 <20200424103851.GD28156@lst.de>
 <20200425031723.GC477579@T590>
 <20200425083224.GA5634@lst.de>
 <20200425093437.GA495669@T590>
 <20200425095351.GC495669@T590>
 <20200425154832.GA16004@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425154832.GA16004@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 25, 2020 at 05:48:32PM +0200, Christoph Hellwig wrote:
>  		atomic_inc(&data.hctx->nr_active);
>  	}
>  	data.hctx->tags->rqs[rq->tag] = rq;
>  
>  	/*
> +	 * Ensure updates to rq->tag and tags->rqs[] are seen by
> +	 * blk_mq_tags_inflight_rqs.  This pairs with the smp_mb__after_atomic
> +	 * in blk_mq_hctx_notify_offline.  This only matters in case a process
> +	 * gets migrated to another CPU that is not mapped to this hctx.
>  	 */
> +	if (rq->mq_ctx->cpu != get_cpu())
>  		smp_mb();
> +	put_cpu();

This looks exceedingly weird; how do you think you can get to another
CPU and not have an smp_mb() implied in the migration itself? Also, what
stops the migration from happening right after the put_cpu() ?


>  	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state))) {
>  		blk_mq_put_driver_tag(rq);


> +static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
> +		struct blk_mq_hw_ctx *hctx)
>  {
> +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> +		return false;
> +	if (cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu)
> +		return false;
> +	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
> +		return false;
> +	return true;
>  }

Does this want something like:

	lockdep_assert_held(*set->tag_list_lock);

to make sure hctx->cpumask is stable? Those mask ops are not stable vs
concurrenct set/clear at all.

