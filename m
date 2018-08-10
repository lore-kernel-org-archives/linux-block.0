Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:60560 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeHJF1Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 01:27:25 -0400
Subject: Re: [RFC PATCH 1/5] block: move call of scheduler's
 ->completed_request() hook
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
References: <cover.1533846185.git.osandov@fb.com>
 <dc018874d79575db91e3ec44c09511720e2b0ab0.1533846185.git.osandov@fb.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <97b406d3-ae02-9f27-6855-59e5b13d665b@oracle.com>
Date: Fri, 10 Aug 2018 10:59:37 +0800
MIME-Version: 1.0
In-Reply-To: <dc018874d79575db91e3ec44c09511720e2b0ab0.1533846185.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Omar

On 08/10/2018 04:26 AM, Omar Sandoval wrote:
> @@ -524,6 +524,9 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
>  		blk_stat_add(rq, now);
>  	}
>  
> +	if (rq->internal_tag != -1)
> +		blk_mq_sched_completed_request(rq, now);
> +

Is it OK to move the io scheduler completed callback into __blk_mq_end_request ?

There is a relatively long distance between the __blk_mq_complete_request and __blk_mq_end_request,
especially the driver's mq_ops.complete and the bio_endio.

Thanks
Jianchao
