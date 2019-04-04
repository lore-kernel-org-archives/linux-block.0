Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F21CC10F0C
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 07:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFA921734
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 07:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDDHJJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:09:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfDDHJI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Apr 2019 03:09:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 871B3307D9D0;
        Thu,  4 Apr 2019 07:09:08 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 046DE848CC;
        Thu,  4 Apr 2019 07:08:56 +0000 (UTC)
Date:   Thu, 4 Apr 2019 15:08:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] block: Fix blk_mq_try_issue_directly()
Message-ID: <20190404070849.GD5004@ming.t460p>
References: <20190403201126.22819-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403201126.22819-1-bvanassche@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 04 Apr 2019 07:09:08 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 03, 2019 at 01:11:26PM -0700, Bart Van Assche wrote:
> If blk_mq_try_issue_directly() returns BLK_STS*_RESOURCE that means that
> the request has not been queued and that the caller should retry to submit
> the request. Both blk_mq_request_bypass_insert() and
> blk_mq_sched_insert_request() guarantee that a request will be processed.
> Hence return BLK_STS_OK if one of these functions is called. This patch
> avoids that blk_mq_dispatch_rq_list() crashes when using dm-mpath.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Tested-by: Laurence Oberman <loberman@redhat.com>
> Reviewed-by: Laurence Oberman <loberman@redhat.com>
> Reported-by: Laurence Oberman <loberman@redhat.com>
> Fixes: 7f556a44e61d ("blk-mq: refactor the code of issue request directly") # v5.0.
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 652d0c6d5945..b2c20dce8a30 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1859,16 +1859,11 @@ blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	case BLK_STS_RESOURCE:
>  		if (force) {
>  			blk_mq_request_bypass_insert(rq, run_queue);
> -			/*
> -			 * We have to return BLK_STS_OK for the DM
> -			 * to avoid livelock. Otherwise, we return
> -			 * the real result to indicate whether the
> -			 * request is direct-issued successfully.
> -			 */
> -			ret = bypass ? BLK_STS_OK : ret;
> +			ret = BLK_STS_OK;
>  		} else if (!bypass) {
>  			blk_mq_sched_insert_request(rq, false,
>  						    run_queue, false);
> +			ret = BLK_STS_OK;
>  		}

This change itself is correct.

However, there is other issue introduced by 7f556a44e61d.

We need blk_insert_cloned_request() to pass back BLK_STS_RESOURCE/BLK_STS_RESOURCE
to caller, so that dm-rq driver may see the underlying queue is busy, then tell
blk-mq to deal with the busy condition from dm-rq queue, so that IO
merge can get improved.

That is exactly what 396eaf21ee17c476e8f6 ("blk-mq: improve DM's blk-mq IO merging
via blk_insert_cloned_request feedback") did.

There must be performance regression with 7f556a44e61d by cut the feedback.

So could you fix them all in one patch?


Thanks,
Ming
