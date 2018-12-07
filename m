Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98F3C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 10:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998E620892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 10:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998E620892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLGKun (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:50:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeLGKum (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Dec 2018 05:50:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CF503078ABB;
        Fri,  7 Dec 2018 10:50:42 +0000 (UTC)
Received: from ming.t460p (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3ABF7FB91;
        Fri,  7 Dec 2018 10:50:33 +0000 (UTC)
Date:   Fri, 7 Dec 2018 18:50:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v3] blk-mq: punt failed direct issue to dispatch list
Message-ID: <20181207105027.GG29027@ming.t460p>
References: <aa6abfa7-30c3-57d7-7369-754d514584f5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6abfa7-30c3-57d7-7369-754d514584f5@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 07 Dec 2018 10:50:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06, 2018 at 10:17:44PM -0700, Jens Axboe wrote:
> After the direct dispatch corruption fix, we permanently disallow direct
> dispatch of non read/write requests. This works fine off the normal IO
> path, as they will be retried like any other failed direct dispatch
> request. But for the blk_insert_cloned_request() that only DM uses to
> bypass the bottom level scheduler, we always first attempt direct
> dispatch. For some types of requests, that's now a permanent failure,
> and no amount of retrying will make that succeed. This results in a
> livelock.
> 
> Instead of making special cases for what we can direct issue, and now
> having to deal with DM solving the livelock while still retaining a BUSY
> condition feedback loop, always just add a request that has been through
> ->queue_rq() to the hardware queue dispatch list. These are safe to use
> as no merging can take place there. Additionally, if requests do have
> prepped data from drivers, we aren't dependent on them not sharing space
> in the request structure to safely add them to the IO scheduler lists.
> 
> This basically reverts ffe81d45322c and is based on a patch from Ming,
> but with the list insert case covered as well.
> 
> Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
> Cc: stable@vger.kernel.org
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> I've thrown the initial hang test reported by Bart at it, works fine.
> My reproducer for the corruption case is also happy, as expected.
> 
> I'm running blktests and xfstests on it overnight. If that passes as
> expected, this qualms my initial worries on using ->dispatch as a
> holding place for these types of requests.
> 
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3262d83b9e07..6a7566244de3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1715,15 +1715,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>  		break;
>  	case BLK_STS_RESOURCE:
>  	case BLK_STS_DEV_RESOURCE:
> -		/*
> -		 * If direct dispatch fails, we cannot allow any merging on
> -		 * this IO. Drivers (like SCSI) may have set up permanent state
> -		 * for this request, like SG tables and mappings, and if we
> -		 * merge to it later on then we'll still only do IO to the
> -		 * original part.
> -		 */
> -		rq->cmd_flags |= REQ_NOMERGE;
> -
>  		blk_mq_update_dispatch_busy(hctx, true);
>  		__blk_mq_requeue_request(rq);
>  		break;
> @@ -1736,18 +1727,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	return ret;
>  }
>  
> -/*
> - * Don't allow direct dispatch of anything but regular reads/writes,
> - * as some of the other commands can potentially share request space
> - * with data we need for the IO scheduler. If we attempt a direct dispatch
> - * on those and fail, we can't safely add it to the scheduler afterwards
> - * without potentially overwriting data that the driver has already written.
> - */
> -static bool blk_rq_can_direct_dispatch(struct request *rq)
> -{
> -	return req_op(rq) == REQ_OP_READ || req_op(rq) == REQ_OP_WRITE;
> -}
> -
>  static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  						struct request *rq,
>  						blk_qc_t *cookie,
> @@ -1769,7 +1748,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  		goto insert;
>  	}
>  
> -	if (!blk_rq_can_direct_dispatch(rq) || (q->elevator && !bypass_insert))
> +	if (q->elevator && !bypass_insert)
>  		goto insert;
>  
>  	if (!blk_mq_get_dispatch_budget(hctx))
> @@ -1785,7 +1764,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	if (bypass_insert)
>  		return BLK_STS_RESOURCE;
>  
> -	blk_mq_sched_insert_request(rq, false, run_queue, false);
> +	blk_mq_request_bypass_insert(rq, run_queue);
>  	return BLK_STS_OK;
>  }
>  
> @@ -1801,7 +1780,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  
>  	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false);
>  	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
> -		blk_mq_sched_insert_request(rq, false, true, false);
> +		blk_mq_request_bypass_insert(rq, true);
>  	else if (ret != BLK_STS_OK)
>  		blk_mq_end_request(rq, ret);
>  
> @@ -1831,15 +1810,13 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  		struct request *rq = list_first_entry(list, struct request,
>  				queuelist);
>  
> -		if (!blk_rq_can_direct_dispatch(rq))
> -			break;
> -
>  		list_del_init(&rq->queuelist);
>  		ret = blk_mq_request_issue_directly(rq);
>  		if (ret != BLK_STS_OK) {
>  			if (ret == BLK_STS_RESOURCE ||
>  					ret == BLK_STS_DEV_RESOURCE) {
> -				list_add(&rq->queuelist, list);
> +				blk_mq_request_bypass_insert(rq,
> +							list_empty(list));
>  				break;
>  			}
>  			blk_mq_end_request(rq, ret);
> 

Tested-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
