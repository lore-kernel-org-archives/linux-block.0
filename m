Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6789FC282CE
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 09:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365A520870
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 09:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfDHJtm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:49:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfDHJtm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 05:49:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DEDB308A953;
        Mon,  8 Apr 2019 09:49:41 +0000 (UTC)
Received: from ming.t460p (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F9A25D9C9;
        Mon,  8 Apr 2019 09:49:33 +0000 (UTC)
Date:   Mon, 8 Apr 2019 17:49:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Keith Busch <keith.busch@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
Message-ID: <20190408094927.GB19589@ming.t460p>
References: <20190405215920.27085-1-keith.busch@intel.com>
 <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
 <20190405223719.GC25081@localhost.localdomain>
 <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
 <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
 <20190406212709.GA29871@ming.t460p>
 <4a57f581-954d-b314-fd1d-6dd30640e0f5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a57f581-954d-b314-fd1d-6dd30640e0f5@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 08 Apr 2019 09:49:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 07, 2019 at 09:55:20PM +0800, Dongli Zhang wrote:
> Hi Keith and Ming,
> 
> On 04/07/2019 05:27 AM, Ming Lei wrote:
> > On Fri, Apr 05, 2019 at 05:36:32PM -0600, Keith Busch wrote:
> >> On Fri, Apr 5, 2019 at 5:04 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>> Looking at current peak testing, I've got around 1.2% in queue enter
> >>> and exit. It's definitely not free, hence my question. Probably safe
> >>> to assume that we'll double that cycle counter, per IO.
> >>
> >> Okay, that's not negligible at all. I don't know of a faster reference
> >> than the percpu_ref, but that much overhead would have to rule out
> >> having a per hctx counter.
> > 
> > Or not using any refcount in fast path, how about the following one?
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 3ff3d7b49969..6fe334e12236 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2199,6 +2199,23 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
> >  	return -ENOMEM;
> >  }
> >  
> > +static void blk_mq_wait_hctx_become_idle(struct blk_mq_hw_ctx *hctx,
> > +		int dead_cpu)
> > +{
> > +	unsigned long msecs_left = 1000 * 10;
> > +
> > +	while (msecs_left > 0) {
> > +		if (blk_mq_hctx_idle(hctx))
> > +			break;
> > +		msleep(5);
> > +		msecs_left -= 5;
> > +	}
> > +
> > +	if (msecs_left > 0)
> > +		printk(KERN_WARNING "requests not completed from "
> > +			"CPU %d\n", dead_cpu);
> > +}
> > +
> >  /*
> >   * 'cpu' is going away. splice any existing rq_list entries from this
> >   * software queue to the hw queue dispatch list, and ensure that it
> > @@ -2230,6 +2247,14 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
> >  	spin_unlock(&hctx->lock);
> >  
> 
> While debugging the blk_mq_hctx_notify_dead(), I found that
> blk_mq_hctx_notify_dead() is called once for each hctx for the cpu to offline.
> 
> As shown below between linux 2216 and line 2217, ctx might not be mapped to
> hctx. Why would we flush ctx->rq_lists[type] to hctx->dispatch?
> 
> 2207 static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
> 2208 {
> 2209         struct blk_mq_hw_ctx *hctx;
> 2210         struct blk_mq_ctx *ctx;
> 2211         LIST_HEAD(tmp);
> 2212         enum hctx_type type;
> 2213
> 2214         hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
> 2215         ctx = __blk_mq_get_ctx(hctx->queue, cpu);
> 2216         type = hctx->type;
> 
> ===>>>>> ctx might not be mappped to hctx, that is,
> cpumask_test_cpu(cpu, hctx->cpumask) = false
> 
> 2217
> 2218         spin_lock(&ctx->lock);
> 2219         if (!list_empty(&ctx->rq_lists[type])) {
> 2220                 list_splice_init(&ctx->rq_lists[type], &tmp);
> 2221                 blk_mq_hctx_clear_pending(hctx, ctx);
> 2222         }
> 2223         spin_unlock(&ctx->lock);
> 2224
> 2225         if (list_empty(&tmp))
> 2226                 return 0;
> 2227
> 2228         spin_lock(&hctx->lock);
> 2229         list_splice_tail_init(&tmp, &hctx->dispatch);
> 2230         spin_unlock(&hctx->lock);
> 2231
> 2232         blk_mq_run_hw_queue(hctx, true);
> 2233         return 0;
> 2234 }
> 
> 
> For example, on a VM (with nvme) of 4 cpu, to offline cpu 2 out of the
> 4 cpu (0-3), blk_mq_hctx_notify_dead() is called once for each io queue
> hctx:
> 
> 1st: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 3
> 2nd: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 2
> 3rd: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 1
> 4th: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 0
> 
> Although blk_mq_ctx->cpu = 2 is only mapped to blk_mq_hw_ctx->queue_num = 2
> in this case, its ctx->rq_lists[type] will however be moved to
> blk_mq_hw_ctx->queue_num = 3 during the 1st call of
> blk_mq_hctx_notify_dead().
> 
> 
> Is this expected or a bug?
> 
> If it is a bug, would the below help?
> 
> [PATCH 1/1] blk-mq: do not splice ctx->rq_lists[type] to hctx->dispatch if ctx
> is not mapped to hctx
> 
> When a cpu is offline, blk_mq_hctx_notify_dead() is called once for each
> hctx for the offline cpu.
> 
> While blk_mq_hctx_notify_dead() is used to splice all ctx->rq_lists[type]
> to hctx->dispatch, it never checks whether the ctx is already mapped to the
> hctx.
> 
> For example, on a VM (with nvme) of 4 cpu, to offline cpu 2 out of the
> 4 cpu (0-3), blk_mq_hctx_notify_dead() is called once for each io queue
> hctx:
> 
> 1st: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 3
> 2nd: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 2
> 3rd: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 1
> 4th: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 0
> 
> Although blk_mq_ctx->cpu = 2 is only mapped to blk_mq_hw_ctx->queue_num = 2
> in this case, its ctx->rq_lists[type] will however be moved to
> blk_mq_hw_ctx->queue_num = 3 during the 1st call of
> blk_mq_hctx_notify_dead().
> 
> This patch would return and go ahead to next call of
> blk_mq_hctx_notify_dead() if ctx is not mapped to hctx.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  block/blk-mq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ff3d7b..b8ef489 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2212,6 +2212,10 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu,
> struct hlist_node *node)
>  	enum hctx_type type;
> 
>  	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
> +
> +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> +		return 0;
> +
>  	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
>  	type = hctx->type;

Looks correct:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
