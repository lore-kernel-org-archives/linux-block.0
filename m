Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0AC3328FA;
	Mon, 15 Dec 2025 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765813398; cv=none; b=ej9HvkwVaOMKRTpeKdtSg6knTiMdEiWh6xejD8FfpXRAcxSwLDuKUFZubiwJ3994SOsyOwuCVojkGAzaJJRt3IqhFHRoXvt9Ur5mbY0fe/3vUIyokMp6vUl0sCHmquO2U/oCIQz9DpzCRGdE+IzmvG7p10EakQSEkIm092AyKLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765813398; c=relaxed/simple;
	bh=JvbatoQUBtJcTnBqtpzr8mf8zwmJJ8Ov1yuQ+MrMFC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKxEGM+OCjA+FleiFOGhdyOl8eCEANjTglg24aJcjOQY/S9noP57UXO8KzWSMY8UwqEqlUd2tYBoKV98Zbp0C2VhMaVlWOqDHcR493UzOgb7jLXbRcdhR+pmIUTCHaQm9I5cyN8ViRt+vBlg6oHOm9e5WTFH27fqKA4feJsjVlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NWiy+rQ/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NWiy+rQ/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OcTvdwQfx6qYBtSHRI6fL2bQMSfRDHV5QuxA7QFMLjM=; b=NWiy+rQ/OjmtFhyFbnqKbcVNCI
	Ts8H8GD35Gbhv+6TrLbD8JOCKzRHpjNjnGcTIWxphf3dSh3qP55nyKv38xRXkAeptOAppeoPHNbTj
	nGVSIAKHnfdnuHU8v+/w5+3Ksm9lLOb/N++3ryUKNc7/+PuLgItsHZhFq0BkOmyrUlwLlki9QaCBk
	IrsOuFhjFfILtcy51eGUbbLwGzvvZ7s2yUNNqEHIPFK4qBV9NrPW1oUx/UDJhAg50ptoQ2+YkPD5J
	Qa4/iPavQmfAF8BKX5y4zWGiReBMefRsPzUjm7Po0jzolZnV5vLYBS/uD2hZgTodFeCNCyo7VMd1t
	4LU3Kbrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVAjA-00000003uZZ-0hcP;
	Mon, 15 Dec 2025 15:43:12 +0000
Date: Mon, 15 Dec 2025 07:43:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: ziniu.wang_1@nxp.com
Cc: axboe@kernel.dk, ulf.hansson@linaro.org, linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/2] block: decouple secure erase size limit from
 discard size limit
Message-ID: <aUAskIkCHiVmKs87@infradead.org>
References: <20251215102010.608421-1-ziniu.wang_1@nxp.com>
 <20251215102010.608421-2-ziniu.wang_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215102010.608421-2-ziniu.wang_1@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -169,8 +169,13 @@ struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
>  
>  	granularity = max(lim->discard_granularity >> 9, 1U);
>  
> -	max_discard_sectors =
> -		min(lim->max_discard_sectors, bio_allowed_max_sectors(lim));
> +	if (bio_op(bio) == REQ_OP_SECURE_ERASE)
> +		max_discard_sectors = min(lim->max_secure_erase_sectors,
> +					  bio_allowed_max_sectors(lim));
> +	else
> +		max_discard_sectors = min(lim->max_discard_sectors,
> +					  bio_allowed_max_sectors(lim));

Please factor our a low-level helper and pass the max_sectors
as argument.

