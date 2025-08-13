Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C9727C17E
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100567; cv=none; b=fT5uwOru4aWnMZOAVgP/s1P6n1DsXhucECp1FJ2wbuT93XjcWsKy6JpJI3tuyl3RM0X5HCkqH2WSwNCwFZI0OdspjVhEuz4Olg4mhXSCMomzdtMyyfj9CVCT3yO6NlVDJn94FZ2aD8OwULveJC9dmfcqC0lX8mwjh7yRyunP9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100567; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrhjrUJVb40TZ2rtleu6Gg6IYj/pIu79VQwH/oY5MbQa0NCbkAiP7mKelv6MwAi7APxs9QSykoxWBuIXgErDG1BJ115SHioV0h6ayQ1Ib28PmqxrGB19yC/Prbnnv/iaoNivmrBM1X1dp/5JBNaA0WvF5eKDNiiBMSU1PoJ5f98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 640F6227AAA; Wed, 13 Aug 2025 17:56:01 +0200 (CEST)
Date: Wed, 13 Aug 2025 17:56:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv7 8/9] nvme-pci: create common sgl unmapping helper
Message-ID: <20250813155601.GB14275@lst.de>
References: <20250813153153.3260897-1-kbusch@meta.com> <20250813153153.3260897-9-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813153153.3260897-9-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

