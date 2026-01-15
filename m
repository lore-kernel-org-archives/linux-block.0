Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC922A4D8
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768458392; cv=none; b=hs/Iy4kLLwP3ySyY6IN6DxcHrvpZI52RbGIhZPiZ9Ohtk2JfIm339uzoAs67rRXUC644uGS9ES09v+ClmYNEGUDgOFtIUVfn2tP4PIP2Jtpibuub2W4K46Uf+QnqR2KYpqVHUJ6CFA0WSszXbPINsFmrPOlKyMRD1xQfjfLCLRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768458392; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNVPFmTlFpECxFS4IaMU5HgTLqSMptJZ2qcyZTlw8JQ0iVN6+KhhYiiZ1x2tGvc3Qws1piy4KLR9m6dnRUQH0eO6c+tT2q0PdavcdWXx4C0MSzoK3hIxZPkXaVElGxia7cIvw2I/KCaE3qX9QFxgBnYCB9B9GMdYmIfIF0cgY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB606227AA8; Thu, 15 Jan 2026 07:26:27 +0100 (CET)
Date: Thu, 15 Jan 2026 07:26:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] block: Fix an error path in
 disk_update_zone_resources()
Message-ID: <20260115062627.GB9542@lst.de>
References: <20260114192803.4171847-1-bvanassche@acm.org> <20260114192803.4171847-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114192803.4171847-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

