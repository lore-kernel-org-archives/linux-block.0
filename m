Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD222C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EB82147A
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554737694;
	bh=X4rj1VB5WCbiqSKBnHqifSa6H5KH0+nZD6OF3aT1jJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wrv7st9nuQEzke5C6tWg02POYM5eVr+l2Q4kxFrTrwC88BtN0x0OCcEg42Cjb09YW
	 XTV69+6F2xPKVTs2sGHKylhOnJfAJvILBn/8uCb7mcv8h5U6O8PoHyLpWtdToKPFZR
	 kbjf561/dcVEsEBUqkTutgJ1J8fD3LLmR06FKVYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfDHPex (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:34:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:1363 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfDHPew (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 11:34:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 08:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="289744903"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2019 08:34:50 -0700
Date:   Mon, 8 Apr 2019 09:36:27 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Keith Busch <keith.busch@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Busch, Keith" <keith.busch@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
Message-ID: <20190408153627.GF32498@localhost.localdomain>
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
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 07, 2019 at 06:55:20AM -0700, Dongli Zhang wrote:
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

Ha, I think you're right. 

It would be a bit more work, but it might be best if we could avoid
calling the notify for each hctx that doesn't apply to the CPU. We might
get that by registering a single callback for the request_queue and loop
only the affected hctx's.

But this patch looks good to me too.

Reviewed-by: Keith Busch <keith.busch@intel.com>
 
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
> 
> -- 
> 2.7.4
