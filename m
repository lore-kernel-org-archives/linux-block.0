Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2EC2D3EFC;
	Tue, 18 Nov 2025 05:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763443111; cv=none; b=n2kywN2aGI7N6x7S8WJBxa8n8KAXe+pc3bX2gmiojYRBBt/KbhTqrZvnUrUq81oPlAWoNgy+XpNIepATGS/RIu8bAg8KwKa0N7bffHWR2EwEHa+dY036DZsADJ0H/QOU2ajq4P78HKg6KJUSAADIbCWMwm79MGIqxzA+lS+xMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763443111; c=relaxed/simple;
	bh=kTWW7uFhN7v1xGLsN05JUtJhQtK3pjAf1f5BzgYNWZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1l305pWMEDJD1U/Qt96fwo5Y+l8BMJ18JjLhGiwkH2URl++Fxorx+FJlkklodm4xV6xorFAwsfbMF50tExMAJ7BkzSDhpYmAwq4sKGXROANWqGX8oGh2Q0ppBd8BFdc3rnQn3X33q4qMqc+naCDpP3/7LJbcHKcVQPooXzLck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 40E486732A; Tue, 18 Nov 2025 06:18:24 +0100 (CET)
Date: Tue, 18 Nov 2025 06:18:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to
 handle larger sizes
Message-ID: <20251118051823.GA21858@lst.de>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com> <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com> <aRt5DPnMwzDw8_dF@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRt5DPnMwzDw8_dF@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 17, 2025 at 12:35:40PM -0700, Keith Busch wrote:
> > +	size_t total_len;
> 
> Changing the generic phys_vec sounds fine, but the nvme driver has a 8MB
> limitation on how large an IO can be, so I don't think the driver's
> length needs to match the phys_vec type.

With the new dma mapping interface we could lift that limits for
SGL-based controllers as we basically only have a nr_segments limit now.
Not that I'm trying to argue for multi-GB I/O..
