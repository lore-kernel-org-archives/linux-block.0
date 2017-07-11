Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44127 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932754AbdGKSk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 14:40:26 -0400
Subject: Re: [PATCH 4/6] blk-mq: use EWMA to estimate congestion threshold
To: Ming Lei <ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
CC: Bart Van Assche <bart.vanassche@sandisk.com>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20170711182103.11461-1-ming.lei@redhat.com>
 <20170711182103.11461-5-ming.lei@redhat.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <786dc75e-18f0-eb13-0bef-f526e7896510@fb.com>
Date: Tue, 11 Jul 2017 12:39:35 -0600
MIME-Version: 1.0
In-Reply-To: <20170711182103.11461-5-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/11/2017 12:21 PM, Ming Lei wrote:
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 60b01c0309bc..c4516d2a2d2c 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -133,4 +133,13 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
>  	return hctx->nr_ctx && hctx->tags;
>  }
>  
> +/* borrowed from bcache */
> +#define ewma_add(ewma, val, weight, factor)                             \
> +({                                                                      \
> +        (ewma) *= (weight) - 1;                                         \
> +        (ewma) += (val) << factor;                                      \
> +        (ewma) /= (weight);                                             \
> +        (ewma) >> factor;                                               \
> +})

Just put that in blk_mq_update_req_dispatch_busy(), or at least make it
a static function in blk-mq.c above that function. You don't use factor
at all.

-- 
Jens Axboe
