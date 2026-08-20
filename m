Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662438E8A0;
	Thu, 20 Aug 2026 05:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787203910; cv=none; b=sLajAweYLgG9H6Mmg4SyfaNZI+8wWz1I1s5+b86HeEDN/YsN4yDy3cIIsb3HuLlji1rzLQ8OjEOHK2p6PomXZgVbEFVi6gCmJvcmsTtldlaY9+DDO8X1vzB11J+zavyzvxoTLLvgCMKqw1DmPkrbyGKb8UCECQuhCQaFbXJa+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787203910; c=relaxed/simple;
	bh=q3aNxyRr6Ri14JFN9THu0zOHdoHranMyWSSdCWhgkEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFHhRnfWknQW2IuDFgDTemq6WSY0lAaE0c9MkYF0ygX7nt0/bnHywtv4GaUxLNJUNsi8dyVGTm52vQqYodg19SejTtI8mN1WnzQtj14aQJ9bcsDqfY7AfKdAT89yo8fwRLPRJnB7ZW6j50UzvCQjVU3Uza+27EX32GOMoUVoegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xkIELz48; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xkIELz48"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OgYFTiiY4rg4rcoQOWMTWgztGpAnVDYpxPdBZR27ytg=; b=xkIELz48gaXVR4aX68jE/mPXIq
	kL+PGuhbL9NdNy3khToqBB7+4DfsfWfauutMUpkEBe5bIeAL1gxh6XG/44KiyBcDBiKkFHzySQe/V
	CWvzkOjyjtEkvRY4I7FZkJm3aD90xTqJsamjxBDF/GVvra+Hvvh3mO5KhzqD9L34pJNyUGifK8aYD
	IVLwo8ms7cli+AzylskSzVsB0f7C7Tijb2rLvNkwS3buRSWUMjoHnSsoBquGwqt9DxbGzXgbYLKQb
	Xyc1XPnRB6s0G2xxcnz1GpmRbAfeY/n0kCiKLzGm9vcXfU1BZA6uI7A0Usai5LG8TyIy1LhPkclHN
	2gtMCk6A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwvNO-0000000AqrU-46Bn;
	Thu, 20 Aug 2026 05:31:43 +0000
Message-ID: <62073844-1d50-4c73-9fca-79821d5817a4@infradead.org>
Date: Wed, 19 Aug 2026 22:31:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: block: fix dead http link in blk-mq.rst
To: Jenson Johnathon Reggentin <mail@jregg.de>, corbet@lwn.net
Cc: axboe@kernel.dk, linux-doc@vger.kernel.org, linux-block@vger.kernel.org
References: <20260819174635.37505-1-mail@jregg.de>
 <20260819192422.42189-1-mail@jregg.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260819192422.42189-1-mail@jregg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/19/26 12:23 PM, Jenson Johnathon Reggentin wrote:
> The current link http://kernel.dk/blk-mq.pdf leads to a 404 error page.
> https://www.kernel.dk/blk-mq.pdf leads to the correct document.
> 
> v2 to add the missing www. prefix in the actual file change.

Version changes should be added after the "---" line below.

> 
> Signed-off-by: Jenson Johnathon Reggentin <mail@jregg.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/block/blk-mq.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
> index fc06761b6ea9..2798761efe0d 100644
> --- a/Documentation/block/blk-mq.rst
> +++ b/Documentation/block/blk-mq.rst
> @@ -139,7 +139,7 @@ completed.
>  Further reading
>  ---------------
>  
> -- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <http://kernel.dk/blk-mq.pdf>`_
> +- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <https://www.kernel.dk/blk-mq.pdf>`_
>  
>  - `NOOP scheduler <https://en.wikipedia.org/wiki/Noop_scheduler>`_
>  

-- 
~Randy
