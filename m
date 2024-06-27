Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F25146D74
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503287; cv=none; b=p2eOCpy4Hu73hnrpBHytIghd0i9kLd/W2cK3Jq5xLkKHLIyVTZ7CwE8jkParzopha6i2dPxH0X8R4PVNRIIw5gu9j0VLL5rnVaoMdoOhjEDZW1gJ0dXItaIj+oJ4hjBH+BlKxygQ7yfsUMQyHfQk1LJsqaamYY7I5Lkb3AIPgts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503287; c=relaxed/simple;
	bh=f0y2sxfLuaL8nzdphWc8DsQ1Xnh540FVCPdz0FsSdTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGuxOchejb2ABx+fT7LWMWvUiKCr0q73Q/I5pLGJsAE9MzpSvHuuRyt6A4IwyzJcQtX4EJ6O0BvzueXC5gTo/aJHpS+NTEU82Ibs+8PqHKcQoqLB2GVmteuhrp4nMf+esvA2ai7imvW6jEJbqydYkoFwV/e04acLvGWP6DTKUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C0A6E68BFE; Thu, 27 Jun 2024 17:47:59 +0200 (CEST)
Date: Thu, 27 Jun 2024 17:47:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 5/5] block: remove bio_integrity_process
Message-ID: <20240627154759.GA25261@lst.de>
References: <20240626045950.189758-1-hch@lst.de> <CGME20240626050052epcas5p29fc1cf1ef40fdec63860f6d6df9ffad1@epcas5p2.samsung.com> <20240626045950.189758-6-hch@lst.de> <a7fd0e31-63bd-8fff-d7d4-6ba990098e7a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7fd0e31-63bd-8fff-d7d4-6ba990098e7a@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 27, 2024 at 09:06:56PM +0530, Kanchan Joshi wrote:
> The bi->csum_type is constant as far as this bio_for_each_segment loop 
> is concerned.
> Seems wasteful processing, and can rather be moved out where we set a 
> function pointer to point to either ext_pi_crc64_generate or 
> t10_pi_generate once.

A function pointer is way more expensive than a few branches, especially
easily predictable ones.
