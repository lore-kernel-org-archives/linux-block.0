Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DD285CA3
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100401; cv=none; b=a3qi5VwOraNaYu5zyftogv2nU15bkkEWKt5+qOoK4hVDcm/ie5raJvrSV/58FMQqkeWFnqRBTM9H1cer33Dt5MowOfFbd80a378dbKWqIs0Haagax/9hHNHbo7CyQdzHsTat1lD2DJH+4nMmCh84aGkX2rVuRvKx6HgM+h2M7Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100401; c=relaxed/simple;
	bh=yw1/IwB9lfKluaa+2obSZF9PPdzrnZ2BIsCA1pQcYGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zhgb+54sO9y+9CbA5KO/WNBgS2TglsQdmxnuK2AYOGuy8+7Kf/A7g2kUyWe0jFnSvmNr7HdzHSXDP/EbEYoFx+5I7POsb64o7qIq8sjRIT7hKX+KC5XB8weCAGQE1QHi3ROrdRVNDf7hQjdzZUQNO+aTFrldEC7IhvoOau3+5kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC234227AAA; Wed, 13 Aug 2025 17:53:12 +0200 (CEST)
Date: Wed, 13 Aug 2025 17:53:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv7 3/9] blk-mq-dma: require unmap caller provide p2p map
 type
Message-ID: <20250813155312.GA14188@lst.de>
References: <20250813153153.3260897-1-kbusch@meta.com> <20250813153153.3260897-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813153153.3260897-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 13, 2025 at 08:31:47AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> In preparing for integrity dma mappings, we can't rely on the request
> flag because data and metadata may have different mapping types.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Didn't I review this already?  Either way:

Reviewed-by: Christoph Hellwig <hch@lst.de>

