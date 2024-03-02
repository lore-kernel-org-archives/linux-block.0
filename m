Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2995E17BA2
	for <linux-block@vger.kernel.org>; Sat,  2 Mar 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709388509; cv=none; b=DSVWYV12FjIgP6W+ButCkbS1oaR2Y4hDdqPEH7vuYWsyrKPSpgFM5ta5klckAHcnVHRx9rL09NuUy69tx1nz69CMVCBj9iFmojFwOg06dWUYNTfImwpyFW7qCFPK6CjT+yUHVPrr0tYMr6+Byj/efEcqYDm8hBG51FIVFSU19jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709388509; c=relaxed/simple;
	bh=L5YIbJIiM75EjHSPy8MT+H8pI+qiS0LEdnQCrO7kfUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaTnM+tFlzKKS3h4HdBOspZtjHs0cS3GsGP1frjDU/XMc54vC0XMoV/GxhftSyl+hNNjRQpLG2mPhtl41n+BAigVFtCvf33ok8K/2i3H1dmjlynY56FC58TMx92hO0MzkvrDTszMWT3R4o5RQcKVhOEkG0HAUrXAYvMlEWtcfAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 281F668BFE; Sat,  2 Mar 2024 15:08:25 +0100 (CET)
Date: Sat, 2 Mar 2024 15:08:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] block: Rename disk_set_max_open/active_zones()
Message-ID: <20240302140824.GC1319@lst.de>
References: <20240301192639.410183-1-dlemoal@kernel.org> <20240301192639.410183-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301192639.410183-4-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Mar 02, 2024 at 04:26:39AM +0900, Damien Le Moal wrote:
> Given that the max_open_zones and max_active_zones attributes of a zoned
> block device have been moved to the device request queue limit, rename
> the functions disk_set_max_open_zones() and disk_set_max_active_zones()
> to blk_queue_max_open_zones() and blk_queue_max_active_zones() to be
> consistent with other request queue limit setting functions.

Same comment as for the last one - this one will go away early next
merge window too.
