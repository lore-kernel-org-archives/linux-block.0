Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.10.14.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037806;
	b=M0miUsmLFnBSJnXY1suvz4UnAd8qj/fs4cbj2P1jJBu5wndhvxJZLHl+Ow2eDDolTArs
	 SElCq1sog28LRHic8+AM3I3HBt7nDXXXbE/MVzTLJlvJr7sQ/Z3znHXwvZsL51zuaWtj5
	 Yb6Ygfj0YPKbMAWCQo8bHPKZldbFaQ8VCvTA61CMbVO1ulhuKWFTpoRgnFMSoMAFVRnRe
	 GwyGNMq1t7C4kCM7JcQM4tWJLAZ7a/WsAUQ2Te9LMnirMv9yi0asGHEAwx0OTYGM3awph
	 CD01urQAVE2fF9bm8lfzowOjUYGG9fINbyck2G8unXKU9ig21Vn0oR1GQMVRRaITi/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037806;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Zy6L9v+u2/66VXEmMx/FCU+X4+fd2Rd5Xvu5cyI5u0Y=;
	b=5Hn9dxtV+4x87U1kWav1qou0RVYPgf8x4QJrNNJkmyiakWpOFq90oHVuG4gAuIsJVe6h
	 BqyueBotchEaSpwV1kHI98A1zuaqAJWLgADvqHFtmXBjHUqcMcLWXeUpKR/mohDqwxI24
	 XSzXtFqblbn1Hb/GYuMArVBBmokaCQIvlkvHPNqgCdAt/5ztNG5kcaFWRv1wgesr77bFm
	 DVxjD4DmmZbvSyGHNjyL3E4heXUpYYPm+LvUjpNnH2LGF4a7zgwITUk2jEcPfgWkT2QId
	 w84fQsjLa/lKf6MYGfL8jHlbDxCb4p8Ao9Cll+1MzvbMXAtDJ//OzDEwCHCyogq+WMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=c--e.de;
	spf=pass smtp.mailfrom=c--e.de;
	arc=none smtp.remote-ip=217.10.14.231
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB3606A31A;
	Mon, 26 Oct 2026 18:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18FB3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id ABB4C140191; Mon, 26 Oct 2026 19:03:16 +0100 (CET)
Date: Mon, 26 Oct 2026 19:03:16 +0100
From: "Christian A . Ehrhardt" <lk@c--e.de>
To: TJ Adams <tadamsjr@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: advance iterator after copy-in for
 SG_DXFER_TO_FROM_DEV
Message-ID: <at-V5NK237TLh8rE@cae.in-ulm.de>
References: <20260929160813.1599129-1-tadamsjr@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929160813.1599129-1-tadamsjr@google.com>


Hi,

On Tue, Sep 29, 2026 at 09:08:13AM -0700, TJ Adams wrote:
> When a passthrough request uses transfer direction SG_DXFER_TO_FROM_DEV,
> bio_copy_user_iov() sets up a temporary iterator iter2 with
> data_source = ITER_SOURCE to copy user data into the bio pages before
> execution.
> 
> bio_copy_from_iter(bio, &iter2) copies the data and advances iter2, but
> the original iter is never advanced. Consequently, iov_iter_count(&i)
> remains non-zero in the caller loop in blk_rq_map_user_iov():
> 
> 	i = *iter;
> 	do {
> 		if (copy)
> 			ret = bio_copy_user_iov(rq, map_data, &i, gfp_mask);
> ...
> 	} while (iov_iter_count(&i));
> 
> Because i is never advanced, blk_rq_map_user_iov() loops indefinitely,
> continually allocating bios and consuming map_data pages until it
> exhausts pages and fails with -EINVAL.
> 
> Fix this by calling iov_iter_advance(iter, bio->bi_iter.bi_size) in the
> map_data && map_data->from_user branch after bio_copy_from_iter().

Sorry for being lazy on this (and for messing it up).

Acked-by: Christian A. Ehrhardt <lk@c--e.de>

Thanks,
Christian

> 
> Fixes: 13f3956eb568 ("block: Fix WARNING in _copy_from_iter")
> Signed-off-by: Terrence Adams <tadamsjr@google.com>
> Assisted-by: LLM
> ---
>  block/blk-map.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 9cb9605d1f62..2685f6177ceb 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -236,6 +236,7 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
>  		ret = bio_copy_from_iter(bio, &iter2);
>  		if (ret)
>  			goto cleanup;
> +		iov_iter_advance(iter, bio->bi_iter.bi_size);
>  	} else {
>  		if (bmd->is_our_pages)
>  			zero_fill_bio(bio);
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
> 
