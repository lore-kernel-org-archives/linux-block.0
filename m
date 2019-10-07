Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43736C47404
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 15:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D532070B
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 15:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfJGPE3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:04:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGPE3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Oct 2019 11:04:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A5EA10CC1F2;
        Mon,  7 Oct 2019 15:04:29 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81FF31001E75;
        Mon,  7 Oct 2019 15:04:22 +0000 (UTC)
Date:   Mon, 7 Oct 2019 23:04:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V2 RESEND 3/5] blk-mq: stop to handle IO before hctx's
 all CPUs become offline
Message-ID: <20191007150416.GB1668@ming.t460p>
References: <20191006024516.19996-1-ming.lei@redhat.com>
 <20191006024516.19996-4-ming.lei@redhat.com>
 <047ecdf1-bd4b-6702-1add-83b902a6902f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <047ecdf1-bd4b-6702-1add-83b902a6902f@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Mon, 07 Oct 2019 15:04:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 07, 2019 at 11:23:22AM +0100, John Garry wrote:
> On 06/10/2019 03:45, Ming Lei wrote:
> > +	}
> > +}
> > +
> > +static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
> > +{
> > +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> > +			struct blk_mq_hw_ctx, cpuhp_online);
> > +	unsigned prev_cpu = -1;
> > +
> > +	while (true) {
> > +		unsigned next_cpu = cpumask_next_and(prev_cpu, hctx->cpumask,
> > +				cpu_online_mask);
> > +
> > +		if (next_cpu >= nr_cpu_ids)
> > +			break;
> > +
> > +		/* return if there is other online CPU on this hctx */
> > +		if (next_cpu != cpu)
> > +			return 0;
> > +
> > +		prev_cpu = next_cpu;
> > +	}
> > +
> > +	set_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
> > +	blk_mq_drain_inflight_rqs(hctx);
> > +
> 
> Does this do the same:
> 
> {
> 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> 			struct blk_mq_hw_ctx, cpuhp_online);
> 	cpumask_var_t tmp;
> 
> 	cpumask_and(tmp, hctx->cpumask, cpu_online_mask);
> 
> 	/* test if there is any other cpu online in the hctx cpu mask */
> 	if (cpumask_any_but(tmp, cpu) < nr_cpu_ids)
> 		return 0;
> 
> 	set_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
> 	blk_mq_drain_inflight_rqs(hctx);
> 
> 	return 0;
> }
> 
> If so, it's more readable and concise.

Yes, but we have to allocate space for 'tmp', that is what this patch
tries to avoid, given the logic isn't too complicated.

> 
> 
> BTW, You could have added my Tested-by tags...

OK, I will add it in V3.


Thanks,
Ming
