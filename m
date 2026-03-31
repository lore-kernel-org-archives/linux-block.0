Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DAA26A1B5;
	Tue, 31 Mar 2026 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941381; cv=none; b=prsEuLiM4CJzH1oX6D4Tf/ixqXu7TrIkryreXkZxRH8jNWPPflARbOEfvUly3E95MBbmALy4VmDwE/iK1CZ9lDu+1Kmrd2wGZVSTFsAIyHxrqH4AEK+KMYfMVC7zaCTZRkbFapOSEgOL9bijqmqwHTIvOnBdSn7rspMr4WFZHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941381; c=relaxed/simple;
	bh=sgPebN8LAxTscPZNbI7LSfjm9u99fuk+TlEywW+T3V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG0+P1b7atQhoQQEGPTySXp8J/dtG3SlVZaYQME3IehHN1oWnfX0uhSNzQmq4VBSFDidHK01LL4TpouZoBXmonX70QxmVqAaHzxyxqIr1812mxtjOgZ3LcuFCIUwOVq5YndafyW+U6rV0sFVUKilQnO9Os4hNLDvM3blDVYqi/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mJRyacST; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mJRyacST"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0ttq0UrYAQ2lg3jmVM+5pPYGqrXfSL0rw9xPytSPqPo=; b=mJRyacSTFm939GZfeysPc/tF6C
	1ahqJ7PyddWBIkVUdK9t8hf4e4DZikdLVBI1fHb3oTMZ+/aDHZbSHirmfcNFsgoxnrKjSZvVddwzb
	fv7g4BwGqCLig29awqcpS0dscbvGKfca8Th6CuIZMnHVIvd9L6F/DasokEE5HuTMf9f16Ti3ekyYi
	WTcr2kY/FNxJTh42DswOMRzzAEfxmkITWL7Odg/WjGIDX96rrxRpuAa5IUhVEYGic+VJAMqfn5CbS
	5iRFR2VIey6vutHYAXb7Sbp4CuOxB1er5/DlNkJ671vvZNHwOlEJ682PINqD1PB70BEESXPGJGERf
	ZdVmr+SQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7TKi-0000000CSSm-07Hr;
	Tue, 31 Mar 2026 07:16:16 +0000
Date: Tue, 31 Mar 2026 00:16:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>,
	Dave Tian <daveti@purdue.edu>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: Fix general protection fault in
 bio_integrity_map_user()
Message-ID: <act0wKGUHCcQvAN8@infradead.org>
References: <20260330230256.4160820-2-iam@sung-woo.kim>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330230256.4160820-2-iam@sung-woo.kim>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 30, 2026 at 07:02:56PM -0400, Sungwoo Kim wrote:
> pin_user_pages_fast() can partially succeed and return the number of
> pages that were actually pinned. However, the bio_integrity_map_user()
> does not handle this partial pinning. This leads to a general protection
> fault since bvec_from_pages() dereferences an unpinned page address,
> which is 0.

Can you share the reproducer, or even better wire it up to blktests?

> 
> To fix this, add a check to verify that all requested memory is pinned.
> 
> KASAN splat:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> RIP: 0010:_compound_head home/wukong/fuzznvme/linux/./include/linux/page-flags.h:240 [inline]
> RIP: 0010:bvec_from_pages home/wukong/fuzznvme/linux/block/bio-integrity.c:290 [inline]
> 
> Fixes: 492c5d455969 ("block: bio-integrity: directly map user buffers")
> Acked-by: Chao Shi <cshi008@fiu.edu>
> Acked-by: Weidong Zhu <weizhu@fiu.edu>
> Acked-by: Dave Tian <daveti@purdue.edu>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
> V1: https://lore.kernel.org/linux-block/20260308001358.1675543-2-iam@sung-woo.kim/T/#u
> V1->V2:
> - v1 incorrectly assumed pin_user_pages_fast() returns bytes. Fixed.
> 
>  block/bio-integrity.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 20f5d301d32d..992ce39e8ab9 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -338,6 +338,15 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
>  					extraction_flags, &offset);
>  	if (unlikely(ret < 0))
>  		goto free_bvec;
> +	if (unlikely(ret != nr_vecs)) {
> +		for (int i = 0; i < ret; i++)
> +			unpin_user_page(pages[i]);

I guess this works fine even for a negative ret, but it looks really
odd.

> +		if (pages != stack_pages)
> +			kvfree(pages);
> +		ret = -EFAULT;
> +		goto free_bvec;

This now loses the original return value if it alredy was
negative.

I think the better fix here would be to switch to
iov_iter_extract_bvecs, but that might be a bit too big for
a backportable bugfix, so I guess we should merge your patch
first once it is fixed up.

