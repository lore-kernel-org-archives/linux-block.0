Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F113C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4B520883
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554736824;
	bh=/phdwhnjT0kwwsjSnq2lGtRBBrDys1nMccYrqHSQ0P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fHzm3ooI/Z8DoZDsp2M0PegWIxR1N8/qVqjJ2SrfABWh/YkHR/ceHpp4M3aU/pUYH
	 A921G1QDTlHEM2YsEKNk0qW9Rqrd11uvY860Tq2FPsicjkhb3Taexf9ZSrbw03yvTk
	 9yWIygdaiPPqh8rZBz/047kxDeZ4YqNcidXyAAWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfDHPUX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:20:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:3205 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfDHPUX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 11:20:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 08:20:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="221592237"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2019 08:20:21 -0700
Date:   Mon, 8 Apr 2019 09:21:58 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Keith Busch <keith.busch@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
Message-ID: <20190408152158.GD32498@localhost.localdomain>
References: <20190405215920.27085-1-keith.busch@intel.com>
 <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
 <20190405223719.GC25081@localhost.localdomain>
 <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
 <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
 <20190406212709.GA29871@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190406212709.GA29871@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 06, 2019 at 02:27:10PM -0700, Ming Lei wrote:
> On Fri, Apr 05, 2019 at 05:36:32PM -0600, Keith Busch wrote:
> > On Fri, Apr 5, 2019 at 5:04 PM Jens Axboe <axboe@kernel.dk> wrote:
> > > Looking at current peak testing, I've got around 1.2% in queue enter
> > > and exit. It's definitely not free, hence my question. Probably safe
> > > to assume that we'll double that cycle counter, per IO.
> > 
> > Okay, that's not negligible at all. I don't know of a faster reference
> > than the percpu_ref, but that much overhead would have to rule out
> > having a per hctx counter.
> 
> Or not using any refcount in fast path, how about the following one?

Sure, I don't think we need a high precision completion wait in this path,
so a delay-spin seems okay to me.

 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ff3d7b49969..6fe334e12236 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2199,6 +2199,23 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>  	return -ENOMEM;
>  }
>  
> +static void blk_mq_wait_hctx_become_idle(struct blk_mq_hw_ctx *hctx,
> +		int dead_cpu)
> +{
> +	unsigned long msecs_left = 1000 * 10;
> +
> +	while (msecs_left > 0) {
> +		if (blk_mq_hctx_idle(hctx))
> +			break;
> +		msleep(5);
> +		msecs_left -= 5;
> +	}
> +
> +	if (msecs_left > 0)
> +		printk(KERN_WARNING "requests not completed from "
> +			"CPU %d\n", dead_cpu);
> +}
> +
>  /*
>   * 'cpu' is going away. splice any existing rq_list entries from this
>   * software queue to the hw queue dispatch list, and ensure that it
> @@ -2230,6 +2247,14 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>  	spin_unlock(&hctx->lock);
>  
>  	blk_mq_run_hw_queue(hctx, true);
> +
> +	/*
> +	 * Interrupt for this queue will be shutdown, so wait until all
> +	 * requests from this hctx is done or timeout.
> +	 */
> +	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) >= nr_cpu_ids)
> +		blk_mq_wait_hctx_become_idle(hctx, cpu);
> +
>  	return 0;
>  }
>  
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index d704fc7766f4..935cf8519bf2 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -240,4 +240,15 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
>  		qmap->mq_map[cpu] = 0;
>  }
>  
> +static inline bool blk_mq_hctx_idle(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct blk_mq_tags *tags = hctx->sched_tags ?: hctx->tags;
> +
> +	if (!tags)
> +		return true;
> +
> +	return !sbitmap_any_bit_set(&tags->bitmap_tags.sb) &&
> +                       !sbitmap_any_bit_set(&tags->bitmap_tags.sb);
> +}
> +
>  #endif
> 
> Thanks,
> Ming
