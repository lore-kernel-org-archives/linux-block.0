Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE12516130A
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975403; cv=none; b=S9LESzqzdkxsma5WuC7HgFP70s4Zpx+gqwC89/jO75/o0dJDk0he9bJ10KwtKuD0nfjqPhpi5irizxmpuBk4Dlo66LVF/lv4shk+dJQYpHBFUm9lPeEtQJjGoYYglgoo5YE6PfA2oZ1KSgc009Pfxh/8FeP5ECfygSAfZnnJORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975403; c=relaxed/simple;
	bh=1ND+0DqPrxmLp4etmadRhSq/T0iT58deFx+LPhQPlUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3xjiK+McbLrXAHA6Crn7YQ9iJcYU6/Ea4RnZY/LzdrlDi/0Kv7ep71o0qATCKCWStE3qcNh6vndBh/2mdCqqQ8snJ7J8GoEFqUPiUSizD42X0zmzsnrnB+bssPapt2O1Yl5hR6li6+J7b3MnnhVFGYJr00iYQ9Yk2KgMi7QWpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjYUjioO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjYUjioO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD3AC113CD;
	Wed, 24 Apr 2024 16:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713975403;
	bh=1ND+0DqPrxmLp4etmadRhSq/T0iT58deFx+LPhQPlUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZjYUjioO/F3iu0Ki6s/WI2XpNu3jJxOrlVOPbzlenMee1LmAnQPEvDIYLWsEDJF7b
	 o3DYbv/3bfxtMhBENpGebvilf0cewHs6eurmgF9utIsayEI5V6IzrbFQ0icqFbRLq/
	 J5KNwoVyYG7yVx1kHPjonxhEWkw2+9n6w3PMmvVqkzUlVWFngi8Ppx82KsM2HN8fvT
	 4n7+qI0B/e2GFLHLDKgNTCmCL/K7XZAQL05FSVtwI9lgU6hk55yDxEKVPWhT5ZdVR5
	 pm8TbO1fAXNLRLU+iqcESrahsOF4vICxEom8nuGJl6bJp4Y9hIYE0RL3gH8IQo5NUV
	 ZQ7AHHSRhZL1A==
Date: Wed, 24 Apr 2024 10:16:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH] block : add larger order folio size instead of pages
Message-ID: <ZikwaBHfP0pTu_AK@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240419092428epcas5p4f63759b0efa1f12dfbcf13c67fa8d0f0@epcas5p4.samsung.com>
 <20240419091721.1790-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419091721.1790-1-kundan.kumar@samsung.com>

On Fri, Apr 19, 2024 at 02:47:21PM +0530, Kundan Kumar wrote:
> @@ -1289,16 +1291,33 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  
>  	for (left = size, i = 0; left > 0; left -= len, i++) {
>  		struct page *page = pages[i];
> +		folio = page_folio(page);
> +
> +		if (!folio_test_large(folio) ||
> +		   (bio_op(bio) == REQ_OP_ZONE_APPEND)) {
> +			len = min_t(size_t, PAGE_SIZE - offset, left);
> +			if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> +				ret = bio_iov_add_zone_append_page(bio, page,
> +						len, offset);
> +				if (ret)
> +					break;
> +			} else
> +				bio_iov_add_page(bio, page, len, offset);
> +		} else {
> +			/* See the offset of folio and the size */
> +			folio_offset = (folio_page_idx(folio, page)
> +					<< PAGE_SHIFT) + offset;
> +			size_folio = folio_size(folio);
>  
> -		len = min_t(size_t, PAGE_SIZE - offset, left);
> -		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> -			ret = bio_iov_add_zone_append_page(bio, page, len,
> -					offset);
> -			if (ret)
> -				break;
> -		} else
> -			bio_iov_add_page(bio, page, len, offset);
> +			/* Calculate the length of folio to be added */
> +			len = min_t(size_t, (size_folio - folio_offset), left);
> +
> +			num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
>  
> +			bio_iov_add_page(bio, page, len, offset);

I think there's another optimization to be had here. You only need one
reference on the folio for all its pages, so I believe you can safely
drop (num_pages - 1) references right here. Then __bio_release_pages()
can be further simplified by removing the 'do{...}while()" loop
releasing individual pages.

I tested this atop your patch, and it looks okay so far. This could be
more efficient if we had access to gup_put_folio() since we already know
all the pages are part of the same folio (unpin_user_pages()
recalculates that)

---
diff --git a/block/bio.c b/block/bio.c
index 469606494f8f7..9829c79494108 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1155,7 +1155,6 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 
 	bio_for_each_folio_all(fi, bio) {
 		struct page *page;
-		size_t nr_pages;
 
 		if (mark_dirty) {
 			folio_lock(fi.folio);
@@ -1163,11 +1162,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 			folio_unlock(fi.folio);
 		}
 		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
-		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
-			   fi.offset / PAGE_SIZE + 1;
-		do {
-			bio_release_page(bio, page++);
-		} while (--nr_pages != 0);
+		bio_release_page(bio, page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1315,6 +1310,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
 
 			bio_iov_add_page(bio, page, len, offset);
+			if (bio_flagged(bio, BIO_PAGE_PINNED) && num_pages > 1)
+				unpin_user_pages(pages + i, num_pages - 1);
 			/* Skip the pages which got added */
 			i = i + (num_pages - 1);
 		}
--
