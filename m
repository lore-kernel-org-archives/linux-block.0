Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25938889D
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 05:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017849; cv=none; b=TEJCOliRq3qknIObCo3SOtyLe3p8ZfqJ5mDUhwyFRk3Alm9mLWk/KBWos23BL6o33yqbbCdO1CgVrtiMVntZFJUN1IROsHqwcfiaEssNF9bhjR8qB+uUCZxXzMnPceV17dES1Zt8CDEs4qes/s+F1J0KPNiigNripUjFpJoFzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017849; c=relaxed/simple;
	bh=YqxU0aPjkTAFd40jiBxkT9l9zUSeUxaI2V6iVSutgX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcQ2ieQcCEXUwv5uUbsBPlk8VL+Kma2sQzTS/zYlkZT8I9wl/v/P3EYCfrefJ960KvvK823DHAQvwUorUbXsjoijf5XgxSTip2Nw06jRd1/C4ri2BEc188nBwYM1kvp9btOJJ21yZj0XWGdb+oTApew9cQe0Pzl9/cTBlSS5G7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B20568BFE; Thu, 10 Sep 2026 07:24:04 +0200 (CEST)
Date: Thu, 10 Sep 2026 07:24:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 11/16] block: retry zone revalidation on capacity
 change
Message-ID: <20260910052403.GA27133@lst.de>
References: <20260908085745.1082697-1-dlemoal@kernel.org> <20260908085745.1082697-12-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908085745.1082697-12-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 08, 2026 at 05:57:40PM +0900, Damien Le Moal wrote:
> When disk_revalidate_zone_resources() detects a capacity change, -ENODEV
> is returned, failing the disk revalidation. However, since a capacity
> change may happen due to a storage element removal being executed
> concurrently to blk_revalidate_disk_zones(), we can simply retry the
> revalidation to capture the new zone state with the new capacity without
> failing the revalidation.
> 
> Retrying the revalidation is driven by disk_revalidate_zone_resources()
> returning -EAGAIN when a new valid capacity is detected. And to avoid
> getting stuck in an infinite loop revalidating zones, retries are limited
> to 2.

I thought our random pulled out the air retyr numbers was 3 :)

Either way, this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

