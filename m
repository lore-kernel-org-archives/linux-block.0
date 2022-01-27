Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B01C433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 09:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbiA0J1u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 04:27:50 -0500
Received: from verein.lst.de ([213.95.11.211]:43362 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238542AbiA0J1u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 04:27:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BF03F68AA6; Thu, 27 Jan 2022 10:27:46 +0100 (CET)
Date:   Thu, 27 Jan 2022 10:27:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        joshiiitr@gmail.com
Subject: Re: [PATCH 1/2] block: introduce and export blk_rq_map_user_vec
Message-ID: <20220127092746.GA14431@lst.de>
References: <20220127082536.7243-1-joshi.k@samsung.com> <CGME20220127083034epcas5p4aaafaf1f40c21a383e985d6f6568cbef@epcas5p4.samsung.com> <20220127082536.7243-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127082536.7243-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 27, 2022 at 01:55:35PM +0530, Kanchan Joshi wrote:
> Similiar to blk_rq_map_user except that it operates on iovec.
> This is a prep patch.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  block/blk-map.c        | 19 +++++++++++++++++++
>  include/linux/blk-mq.h |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 4526adde0156..7fe45df3e580 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -577,6 +577,25 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
>  }
>  EXPORT_SYMBOL(blk_rq_map_user);
>  
> +int blk_rq_map_user_vec(struct request_queue *q, struct request *rq,
> +		    struct rq_map_data *map_data, void __user *uvec,
> +		    unsigned long nr_vecs, gfp_t gfp_mask)
> +{
> +	struct iovec fast_iov[UIO_FASTIOV];
> +	struct iovec *iov = fast_iov;
> +	struct iov_iter iter;
> +	int ret;
> +
> +	ret = import_iovec(rq_data_dir(rq), uvec, nr_vecs, UIO_FASTIOV, &iov, &iter);
> +	if (unlikely(ret < 0))
> +		return ret;
> +	ret = blk_rq_map_user_iov(q, rq, NULL, &iter, gfp_mask);
> +	kfree(iov);
> +
> +	return ret;

I see very little point in adding this function vs just open coding it.

Also please don't add overly long lines.
