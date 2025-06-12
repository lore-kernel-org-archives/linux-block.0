Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD303C1F
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749704465; cv=none; b=KUHvwxO4A0O0maIDiQeb5g0hRnghbmFUeUwZl4gS31hn8ekhdIkk3Ir1QL7YbN/9Spm88DCqOSD/TGLav8BM0ZoDPZjTJDXnvjVkdOk3jVlJj2DCbnZ4VkD2iW/qqNQd/cC/WFXsO8g1oL0xFQYEsSvnEhS/Iqyq5DSiW2ISPBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749704465; c=relaxed/simple;
	bh=nuST9IokJBMrH15BjGCzrQL0vRt9ET1MOKLccCGg/D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JE+eQeTrz5WHgNJEfU6XtTXSNOS88yL3/HJxelryewYJ6Nka1p/+/pHlvh96G/ZMgSjLN5/AQO2WoIfhytt0t9Zj2pV5fmMFidWp57EohCtaUYzkIUyASttFb/sQT0SA7r8wIi/cztwyVn4ZPv1ilnAXk7xUcLLP3acu9foYQkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A18FC68D09; Thu, 12 Jun 2025 07:01:00 +0200 (CEST)
Date: Thu, 12 Jun 2025 07:01:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] nvme-pci: merge the simple PRP and SGL setup into
 a common helper
Message-ID: <20250612050100.GF12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-6-hch@lst.de> <6f0a019c-f9c7-4ccf-837c-c6d15492ba45@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f0a019c-f9c7-4ccf-837c-c6d15492ba45@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 11, 2025 at 03:44:45PM +0200, Daniel Gomez wrote:
> > -static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
> > -		struct request *req, struct nvme_rw_command *cmnd,
> > -		struct bio_vec *bv)
> > -{
> > -	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> > +	if (use_sgl == SGL_FORCED || !prp_possible) {
> 
> I couldn't find any place other than this where the new FORCED tristate actually
> matters. So instead of passing the use_sgl tristate around, why not just check
> here whether SGL is forced?

See the check in nvme_map_data.
