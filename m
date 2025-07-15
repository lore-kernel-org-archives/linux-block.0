Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589FE161302
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 05:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557630; cv=none; b=J254AdEtuXPzvJmMS0elbrTVoM0Lj+vHvKqkUOuvkjQsGng47t/Yat8BOLl4ZGY6OYHJIghcvt5waIHsfVGE07VHjKqse8qCJZczQRQZzQH++DuORPda++UEbMo4mIBf4HF+KTez3lKnpIB6avT+DwxYpNHEMpr272gOq2+6wOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557630; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8PYm862Mkm72uTAf7Qx87bd5Qk8R75Y/IjuwJp+w7zqqZMQptZGbqLc/MByLA3wpIl9ouTc4Hlqv/KBukVHfg5/eM/nvu2XM9tXVPOq/h2r/3OT2x8zDfr3lU8913bEEwxPaOV0OhFNoBXnyunjh1YLXRz3Q2nBp2llFRccoKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AFF0568AA6; Tue, 15 Jul 2025 07:33:45 +0200 (CEST)
Date: Tue, 15 Jul 2025 07:33:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 4/5] block: add tracepoint for blkdev_zone_mgmt
Message-ID: <20250715053345.GC18074@lst.de>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com> <20250714143825.3575-5-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714143825.3575-5-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

