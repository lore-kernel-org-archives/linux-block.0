Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC80718A926
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961831; cv=none; b=Nse4raQH6O+WG1RvbNe7NCCDPDlpQkHfl4t4PKbAnvobBYVKN6/W8Y5MOyLiY8F8tGeyIXN+Y9d9dgQJGa6v7nGddblfXJj7HhX+VxaNtz49QBZPRrjFR2/BUucVVUnCgmJ5yYuWXcOxxG/z0uDSC7ZQ4FSceNh0JDL0xrhT6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961831; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUUOPFUuhiM1bv2wU0go7xgEyX0yNEfTq5n3bMSrhPEHgbdk0vO1vVpC0YL7m2uAm5MBvW3OQPohSDkU53BpwuSen6jHUatTQ4A9JWTJiAMBHy0g/ljn6I1NihaM4QRz8IPjPSAbF9HXKI8XFiexaCr2JHcPqNN7X32+aeL6UfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BE6D4227A87; Thu,  7 Nov 2024 07:43:46 +0100 (CET)
Date: Thu, 7 Nov 2024 07:43:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/2] block: Add a public bdev_zone_is_seq() helper
Message-ID: <20241107064346.GB3458@lst.de>
References: <20241107064300.227731-1-dlemoal@kernel.org> <20241107064300.227731-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107064300.227731-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

