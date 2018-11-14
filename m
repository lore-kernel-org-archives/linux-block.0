Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9375AC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 09:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DE722419
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 09:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DE722419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbeKNTO3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:14:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730548AbeKNTO3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 14:14:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72D7780467;
        Wed, 14 Nov 2018 09:12:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DEA360BF7;
        Wed, 14 Nov 2018 09:11:59 +0000 (UTC)
Date:   Wed, 14 Nov 2018 17:11:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 1/4] blk-mq: refactor the code of issue request
 directly
Message-ID: <20181114091153.GB20550@ming.t460p>
References: <1542185131-15029-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542185131-15029-2-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542185131-15029-2-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 14 Nov 2018 09:12:07 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 04:45:28PM +0800, Jianchao Wang wrote:
> Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
> into one interface to unify the interfaces to issue requests
> directly. The merged interface takes over the requests totally,
> it could insert, end or do nothing based on the return value of
> .queue_rq and 'bypass' parameter. Then caller needn't any other
> handling any more.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c | 93 ++++++++++++++++++++++++++++------------------------------
>  1 file changed, 45 insertions(+), 48 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 411be60..14b4d06 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1766,78 +1766,75 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	return ret;
>  }
>  
> -static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> +static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  						struct request *rq,
>  						blk_qc_t *cookie,
> -						bool bypass_insert)
> +						bool bypass)
>  {
>  	struct request_queue *q = rq->q;
>  	bool run_queue = true;
> +	blk_status_t ret = BLK_STS_RESOURCE;
> +	int srcu_idx;
>  
> +	hctx_lock(hctx, &srcu_idx);
>  	/*
> -	 * RCU or SRCU read lock is needed before checking quiesced flag.
> +	 * hctx_lock is needed before checking quiesced flag.
>  	 *
> -	 * When queue is stopped or quiesced, ignore 'bypass_insert' from
> -	 * blk_mq_request_issue_directly(), and return BLK_STS_OK to caller,
> -	 * and avoid driver to try to dispatch again.
> +	 * When queue is stopped or quiesced, ignore 'bypass', insert
> +	 * and return BLK_STS_OK to caller, and avoid driver to try to
> +	 * dispatch again.
>  	 */
> -	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
> +	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q))) {
>  		run_queue = false;
> -		bypass_insert = false;
> -		goto insert;
> +		bypass = false;
> +		goto out_unlock;
>  	}
>  
> -	if (q->elevator && !bypass_insert)
> -		goto insert;
> +	/*
> +	 * Bypass the potential scheduler on the bottom device.
> +	 */
> +	if (unlikely(q->elevator && !bypass))
> +		goto out_unlock;
>  
> -	if (!blk_mq_get_dispatch_budget(hctx))
> -		goto insert;
> +	if (unlikely(!blk_mq_get_dispatch_budget(hctx)))
> +		goto out_unlock;

The unlikely annotation is a bit misleading, since out-of-budget can
happen frequently in case of low queue depth, and there are lots of
such examples.

>  
> -	if (!blk_mq_get_driver_tag(rq)) {
> +	if (unlikely(!blk_mq_get_driver_tag(rq))) {

Same with above.

Thanks,
Ming
