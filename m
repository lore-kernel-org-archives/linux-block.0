Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E952A5661;
	Tue, 26 Aug 2025 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237270; cv=none; b=kcU6p2ArxRvAtnZLDJRKH+jjrF1neXOlD2deR5w0tl+Y1fXUxajihZyz4xTcjyooQdYoqv/sAeDg3q2ikQvVoJZgfRfiQ1dKQfhhyJWIKb+UjoTu1mkkQDorplSHJOIX55DRooI2mcK6JS2SL0QWJs+hZGbzPFRStjIwH5GbHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237270; c=relaxed/simple;
	bh=pB0HN5+AQjHtb2JgkDO+ZgAWnxex9FXJJaeFRpvCmWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grlSm8nbhKEIWcv96tjlykv5YJty0EkXdnxfl9B8w47bUC/ECTkIpv+FcUu4mKXAyLNQI05zOPgoeBaP0pCy79GHbmUIsCSOvDQVvoZzdTWJE073zS5ZyfLYU3c/CeCj1zLrFda0f41DeeV+0Q5HjRswdMt0bGtgblVicM5fg/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tLMhM2UN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tLMhM2UN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CXZHG7FeAOLOdb03rd+3Zpl+8D1DiDY/d4hTHKY6fqE=; b=tLMhM2UN+tFtFq/me9RYX9Ry4N
	ZLFYOPNJDlPOeXHAENuvC6xLP+OdJYI7lc9H8OEOWi9UiN5RLcky/5CUBRBznFnZ6KHGPMYyeTcS6
	vV2+YZVbTe3o+lsHsGETnLvtBva1cNmCaV6pdcntMCvIOwUceGiHBoTTWA59pzOb9fSoh7yayjYQW
	K9wbPXqGA8LG++N7xJ2YyC+SSvQEYwLcO6fa+eBqu6c6BPuZF5i11STRG8+wDnYdzSvu+SKOS2i8K
	y+V17UBijIjB1jEODonYhpqCAedvVkN+vaxSzzditWefHn+TObeP3XWCKO0s/+kEdQDVzJmqx8Gp1
	Sm1t0+PA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqzXT-00000008f9y-2mU8;
	Tue, 26 Aug 2025 19:41:03 +0000
Date: Tue, 26 Aug 2025 20:41:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/7] aoe: Stop calling page_address() in free_page()
Message-ID: <aK4NzxmGZjKvsGz8@casper.infradead.org>
References: <20250826193258.902608-1-vishal.moola@gmail.com>
 <20250826193258.902608-3-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826193258.902608-3-vishal.moola@gmail.com>

On Tue, Aug 26, 2025 at 12:32:53PM -0700, Vishal Moola (Oracle) wrote:
> free_page() should be used when we only have a virtual address. We
> should call __free_page() directly on our page instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Probably should have run ./scripts/get_maintainer.pl drivers/block/aoe/aoecmd.c
Adding ccs.

>  drivers/block/aoe/aoecmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
> index 6298f8e271e3..a9affb7c264d 100644
> --- a/drivers/block/aoe/aoecmd.c
> +++ b/drivers/block/aoe/aoecmd.c
> @@ -1761,6 +1761,6 @@ aoecmd_exit(void)
>  	kfree(kts);
>  	kfree(ktiowq);
>  
> -	free_page((unsigned long) page_address(empty_page));
> +	__free_page(empty_page);
>  	empty_page = NULL;
>  }
> -- 
> 2.51.0
> 
> 
