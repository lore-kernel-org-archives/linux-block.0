Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67270440632;
	Wed, 19 Aug 2026 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163921; cv=none; b=hb+gRET91ptbaOhTdlrEXKAAIuKRS0F4WBoYH3nePfA7lZ1/wkwqlwp0HFw2c1ibcWifdCJPj39pF5JLT36aln7C2BpBZHMDb8DGK+y5l1t2ZMEwt91DbY6hWphQeeQJlJKE/cApdWDCMcbVGeMfdi+7N1FwiLDNciGjFcgVwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163921; c=relaxed/simple;
	bh=HXOVMbTVGjMgxgLMH6/hnx/BmLZdqWm8fOYIy23SdT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gf+I1Qmt/Dp93zXjaYS6xvdKg4AhGfpvOVuMWQquhhlSL75gYJXiBUJI8FwJ4wz18yAxXHsKfJsYALedJtBsVkTuny+yerINW8YrxII2qsVhNRYGmgKog7FBYn5a4Ox9G1M30sjDteNyG4Zq5+4MiGInGeVji6a7sLXeaO0oswg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HJyL9cPe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HJyL9cPe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IvOuJWWeAiM/t8Xt9bvr8XSZx+mlGJ/NrgblX5k0MjY=; b=HJyL9cPefjAoMk7+rzIyE1J8EU
	89eyQ/qabnUr13iV344W/ag51lm3xnD26Tv+SKcK4nxCLnLNyENUwXs/NCgSdbhR4OfynQyEINAcz
	8+n6uQcZHR8LddVt+u9wFi1eAnxAVffg+wyyvylFK2YETXPICiwMXZDVH0zc7d33H4KZ82d/eSVR9
	xQUZ+NL6fPEJITVKh4mf2WjQDDL7+MM01D0ZdscTUZf7FigVFUBtL+vqVF68fyQc7/zWdEs/haPvC
	6cNJX7zGMtz8Ws5bQD67pc2MwpRyyOTjp9xGwTRCj9WESIs06XXzdKIE/cY1RgWbxP2lqZS7T56il
	zpoMCrGQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwkyR-0000000AMm9-1q1W;
	Wed, 19 Aug 2026 18:25:15 +0000
Message-ID: <b49648fd-33a2-4469-95aa-1946ed8a4bb4@infradead.org>
Date: Wed, 19 Aug 2026 11:25:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: block: fix dead http link in blk-mq.rst
To: Jenson Johnathon Reggentin <mail@jregg.de>, corbet@lwn.net
Cc: axboe@kernel.dk, linux-doc@vger.kernel.org, linux-block@vger.kernel.org
References: <20260819174635.37505-1-mail@jregg.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260819174635.37505-1-mail@jregg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/19/26 10:46 AM, Jenson Johnathon Reggentin wrote:
> The current link http://kernel.dk/blk-mq.pdf leads to a 404 error page.
> https://www.kernel.dk/blk-mq.pdf leads to the correct document.
> 
> Signed-off-by: Jenson Johnathon Reggentin <mail@jregg.de>
> ---
>  Documentation/block/blk-mq.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
> index fc06761b6ea9..c2af39f14d6d 100644
> --- a/Documentation/block/blk-mq.rst
> +++ b/Documentation/block/blk-mq.rst
> @@ -139,7 +139,7 @@ completed.
>  Further reading
>  ---------------
>  
> -- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <http://kernel.dk/blk-mq.pdf>`_
> +- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <https://kernel.dk/blk-mq.pdf>`_
>  
>  - `NOOP scheduler <https://en.wikipedia.org/wiki/Noop_scheduler>`_
>  

I still get a 404 error message for the new link also.
As well, my browser and wget both report bad/invalid SSL certificate.


-- 
~Randy

