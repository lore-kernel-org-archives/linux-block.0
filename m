Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7856C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68B221871
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552666523;
	bh=RpaS2pcVdJu5kJQz+kSIhUPYav7ZYzDmpAIosxThCJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=saXvIFwk3d22eOH+3wAOJnDBAWsunQgjyFWe47CE1Pk6QR8fJlAG7U59ffZW2zfHX
	 Lu2e7OTbB7hG+aoL39W/K6z/nUFVhkzzUOR+7z+NwTC/XFAOk1Hr74bs0DJ/591yn5
	 Ej1PzQG7ZIyz9+xVK3tdOtIuJW44O0ShASdv2ffw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfCOQPX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:15:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:51229 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729465AbfCOQPW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 12:15:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 09:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="327645325"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2019 09:15:21 -0700
Date:   Fri, 15 Mar 2019 10:16:08 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "hare@suse.de" <hare@suse.de>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "Busch, Keith" <keith.busch@intel.com>,
        "jsmart2021@gmail.com" <jsmart2021@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] blk-mq: change the method of iterating busy tags of
 a request_queue
Message-ID: <20190315161608.GB15153@localhost.localdomain>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 15, 2019 at 01:57:38AM -0700, Jianchao Wang wrote:
> tags->rqs[] will not been cleaned when free driver tag and there
> is a window between get driver tag and write tags->rqs[], so we
> may see stale rq in tags->rqs[] which may have been freed, as
> following case,
> blk_mq_get_request         blk_mq_queue_tag_busy_iter
>   -> blk_mq_get_tag
>                              -> bt_for_each
>                                -> bt_iter
>                                  -> rq = taags->rqs[]
>                                  -> rq->q
>   -> blk_mq_rq_ctx_init
>     -> data->hctx->tags->rqs[rq->tag] = rq;
> 
> To fix this, the blk_mq_queue_tag_busy_iter is changed in this
> patch to use tags->static_rqs[] instead of tags->rqs[]. We have
> to identify whether there is a io scheduler attached to decide
> to use hctx->tags or hctx->sched_tags. And we will try to get a
> non-zero q_usage_counter before that, so it is safe to access
> them. Add 'inflight' parameter to determine to iterate in-flight
> requests or just busy tags. A correction here is that
> part_in_flight should count the busy tags instead of rqs that
> have got driver tags.
> 
> Moreover, get rid of the 'hctx' parameter in iter function as
> we could get it from rq->mq_hctx and export this interface for
> drivers.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq-tag.c     | 76 +++++++++++++++++++++++++++++++++-----------------
>  block/blk-mq-tag.h     |  2 --
>  block/blk-mq.c         | 31 ++++++++------------
>  include/linux/blk-mq.h |  5 ++--
>  4 files changed, 64 insertions(+), 50 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index b792537..cdec2cd 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -216,26 +216,38 @@ struct bt_iter_data {
>  	busy_iter_fn *fn;
>  	void *data;
>  	bool reserved;
> +	bool inflight;
>  };
>  
>  static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  {
>  	struct bt_iter_data *iter_data = data;
>  	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
> -	struct blk_mq_tags *tags = hctx->tags;
>  	bool reserved = iter_data->reserved;
> +	struct blk_mq_tags *tags;
>  	struct request *rq;
>  
> +	tags =  hctx->sched_tags ? hctx->sched_tags : hctx->tags;
> +
>  	if (!reserved)
>  		bitnr += tags->nr_reserved_tags;
> -	rq = tags->rqs[bitnr];
> +	/*
> +	 * Because tags->rqs[] will not been cleaned when free driver tag
> +	 * and there is a window between get driver tag and write tags->rqs[],
> +	 * so we may see stale rq in tags->rqs[] which may have been freed.
> +	 * Using static_rqs[] is safer.
> +	 */
> +	rq = tags->static_rqs[bitnr];
>  
>  	/*
> -	 * We can hit rq == NULL here, because the tagging functions
> -	 * test and set the bit before assigning ->rqs[].
> +	 * There is a small window between get tag and blk_mq_rq_ctx_init,
> +	 * so rq->q and rq->mq_hctx maybe different.
>  	 */
> -	if (rq && rq->q == hctx->queue)
> -		return iter_data->fn(hctx, rq, iter_data->data, reserved);
> +	if (rq && rq->q == hctx->queue &&
> +	    rq->mq_hctx == hctx &&
> +	    (!iter_data->inflight ||
> +	     blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT))
> +		return iter_data->fn(rq, iter_data->data, reserved);

There is still a window where the check may succeed, but the request is
being assigned to a completely different request_queue. The callback
then operates on a request it doesn't own.

Tag iteration from a driver can be safe only if the driver initiates a
freeze and quiesced all queues sharing the same tagset first. The nvme
driver does that, but I think there may need to be an additional grace
period to wait for the allocation's queue_enter to call queue_exit to
ensure the request is initialized through blk_mq_rq_ctx_init().
