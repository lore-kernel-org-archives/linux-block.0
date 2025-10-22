Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150419F13F;
	Wed, 22 Oct 2025 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113664; cv=none; b=BYA9LadwKQpVDZ6Ugu28ahTRiYFmnkB2zkax4CSCNIyczmydgYdCQINdMZ20VwoCqdbU2za+7yH0BZ3X3NCw9lVoFGVo0rMYMfmdvMjUgvJSRDkASQetDe1B+Pxr4SM0TprukwsLS6MZh+ATgzgvox9veyGTmp0obPxRU9BpXn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113664; c=relaxed/simple;
	bh=Rmp34rm5ML8Jw0hFm+LUlt2ux1fy0TaZ6PGH0gb/SrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpoBgsW8cMs3yAXgBNubs4hSp7gbexNBq2cH17sdpKHsaq4onFyTi5WdAUmSOY1MsWeoSS/cu7bOpDGkFIHt+5AGOnOqHaDtdg4ZQgs429WI1o5/Vtl7CoLRu8AQ49hSh0HCo3mf3vCkF13WzPtgJJ3e1ZktmdNrQ+6Lbx1oKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 90CF9227A88; Wed, 22 Oct 2025 08:14:18 +0200 (CEST)
Date: Wed, 22 Oct 2025 08:14:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] nvme-pci: migrate to dma_map_phys instead of
 map_page
Message-ID: <20251022061418.GC4317@lst.de>
References: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com> <20251020-block-with-mmio-v2-1-147e9f93d8d4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-block-with-mmio-v2-1-147e9f93d8d4@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

This actually has block and nvme bits, so the subject line should
say that.

> +	unsigned int attrs = 0;

attrs is always zero here, no need to start passing it for the
map_phys conversion alone.

> +	unsigned int attrs = 0;

Same here.

> +	unsigned int			attrs;

And this is also entirely unused as far as I can tell.

