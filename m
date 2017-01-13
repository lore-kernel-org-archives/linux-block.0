Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52520 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750701AbdAMVwM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 16:52:12 -0500
Subject: Re: [PATCH 1/4] block: add blk_rq_payload_bytes
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
References: <1484306953-3194-1-git-send-email-hch@lst.de>
 <1484306953-3194-2-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1abf5fd7-d666-c2eb-44f0-6e7444f66d5c@grimberg.me>
Date: Fri, 13 Jan 2017 23:52:06 +0200
MIME-Version: 1.0
In-Reply-To: <1484306953-3194-2-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Add a helper to calculate the actual data transfer size for special
> payload requests.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/blkdev.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ff3d774..1ca8e8f 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1000,6 +1000,19 @@ static inline unsigned int blk_rq_cur_sectors(const struct request *rq)
>  	return blk_rq_cur_bytes(rq) >> 9;
>  }
>
> +/*
> + * Some commands like WRITE SAME have a payload or data transfer size which

Don't you mean here DISCARD?

> + * is different from the size of the request.  Any driver that supports such
> + * commands using the RQF_SPECIAL_PAYLOAD flag needs to use this helper to
> + * calculate the data transfer size.
> + */
> +static inline unsigned int blk_rq_payload_bytes(struct request *rq)
> +{
> +	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
> +		return rq->special_vec.bv_len;
> +	return blk_rq_bytes(rq);
> +}
> +
>  static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
>  						     int op)
>  {
>
