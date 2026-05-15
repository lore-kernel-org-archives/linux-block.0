Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF5E3019A6
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850830; cv=none; b=WdtrblrbOLI5gtK9zY/JKSwY+020Vk+Zewbj4J3CilLNIycqCVGGHpCiILMWMiV2TxegS+KXne0d5diPdmyr070DMycoQgFyji4G7fCuWzEHNhTqJz279rxkuknXvpVpwkBuU7pwb3RvB/+OKoDIMthVCoIlEyuEtHa8UgaX8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850830; c=relaxed/simple;
	bh=9CPFr29xBZxbYYx/+rvAXoVHsm1AYBTjDvdccTZRxRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahpjgAtRZA9kHesKlrlGtKcs/1KY9S0L+kxaoo4ENpYvsfUyq+GGQ7VYd2QkY3hG2u/Gx13wZZXgisVFkV28hR+mJMfw3fwz1AP7AyIFBMUigpZT1yJwZrkp95i5ihX/PrpkavAMzhWkWEdLYH/PGTDx6qwgEY9Y2DeWA7U0UbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 74A7268CFE; Fri, 15 May 2026 15:13:41 +0200 (CEST)
Date: Fri, 15 May 2026 15:13:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jens Axboe <axboe@kernel.dk>, Weidong Zhu <weizhu@fiu.edu>,
	Chao Shi <cshi008@fiu.edu>, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	lvc-project@linuxtesting.org, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] block: bio-integrity: fix memory leak in
 bio_integrity_map_user()
Message-ID: <20260515131340.GA32283@lst.de>
References: <20260513070515.528861-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513070515.528861-1-dmantipov@yandex.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 13, 2026 at 10:05:15AM +0300, Dmitry Antipov wrote:
> Since 'iov_iter_extract_pages()' may allocate new array of pages
> even when it returns non-zero error value, matching cleanup with
> 'vfree()' should be performed on all return paths afterwards. So
> adjust 'bio_integrity_map_user()' to ensure that both 'pages' and
> 'bvec' arrays are always freed on return.
> 
> Fixes: 8582792cf23b ("block: bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()")
> Fixes: 492c5d455969 ("block: bio-integrity: directly map user buffers")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

The change looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

We'd still be much better off converting it to iov_iter_extract_bvecs
to share common code, and make it more efficient by no needing the
separate pages allocation.

> ---
>  block/bio-integrity.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index e796de1a749e..53fb04adb09b 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -400,7 +400,7 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
>  	ret = iov_iter_extract_pages(iter, &pages, bytes, nr_vecs,
>  					extraction_flags, &offset);
>  	if (unlikely(ret < 0))
> -		goto free_bvec;
> +		goto out_free;
>  
>  	/*
>  	 * Handle partial pinning. This can happen when pin_user_pages_fast()
> @@ -414,16 +414,12 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
>  			for (i = 0; i < npinned; i++)
>  				unpin_user_page(pages[i]);
>  		}
> -		if (pages != stack_pages)
> -			kvfree(pages);
>  		ret = -EFAULT;
> -		goto free_bvec;
> +		goto out_free;
>  	}
>  
>  	nr_bvecs = bvec_from_pages(bvec, pages, nr_vecs, bytes, offset,
>  				   &is_p2p);
> -	if (pages != stack_pages)
> -		kvfree(pages);
>  	if (nr_bvecs > queue_max_integrity_segments(q))
>  		copy = true;
>  	if (is_p2p)
> @@ -434,15 +430,10 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
>  	else
>  		ret = bio_integrity_init_user(bio, bvec, nr_bvecs, bytes);
>  	if (ret)
> -		goto release_pages;
> -	if (bvec != stack_vec)
> -		kfree(bvec);
> -
> -	return 0;
> -
> -release_pages:
> -	bio_integrity_unpin_bvec(bvec, nr_bvecs);
> -free_bvec:
> +		bio_integrity_unpin_bvec(bvec, nr_bvecs);
> +out_free:
> +	if (pages != stack_pages)
> +		kvfree(pages);
>  	if (bvec != stack_vec)
>  		kfree(bvec);
>  	return ret;
> -- 
> 2.54.0
---end quoted text---
