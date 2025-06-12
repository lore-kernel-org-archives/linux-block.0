Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420A8F40
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 05:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749704612; cv=none; b=s79crpWtltFQwezwn3l4aVKFg7AIKi57FQtij6Dh2D9Z8taCKwD0kbg7MXfozPEF8xn+XEfIeB78hwobo6I809Nacp4z7FVP6sL6QVGtPxDZetwzEHoI1TxYCHJKw6J2C8zFjDgIAPkFQWiEYGtIvxfVoelBd4WfohwPCTcEj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749704612; c=relaxed/simple;
	bh=1TEYQie9dab0oLznfm+uJ1OeGYfXJA5zPIhyeEU2zX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7K5lTZgwxfCoN+QRjuIl3062wF/pFXsW+cdu4LVE8UKonJGqu8c6QotW+nRztBm0oKgkoskDA0R+Y1XlfPoTNmxufMl54P2StF0z0Jpz1VVnBF59ZJc3zzBaiZP6zmWmXux1u/8V3yHYiUp71z6oIGceooHvaOclWGXacucCFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E66068D09; Thu, 12 Jun 2025 07:03:27 +0200 (CEST)
Date: Thu, 12 Jun 2025 07:03:26 +0200
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
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
Message-ID: <20250612050326.GI12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-8-hch@lst.de> <4bdeb522-42d4-460c-8812-7e0d8602cf8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bdeb522-42d4-460c-8812-7e0d8602cf8f@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 11, 2025 at 04:13:22PM +0200, Daniel Gomez wrote:
> > @@ -2908,26 +3018,14 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
> >  static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
> 
> Since this pool is now used exclusively for metadata, it makes sense to update
> the function name accordingly:

Nah.  It should go away entirely pretty soon, so let's keep the churn
down.

