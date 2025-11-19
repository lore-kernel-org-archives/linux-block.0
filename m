Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEC0143C61
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763530835; cv=none; b=Kkz1szNMitwE5yFtHcSXSc77xNvQFxc/bbxiA4yx4UZ/82BHtD4cBurFbGxF5QEd2QQfttQGIR//MM098ttviI9b2atQXnK9hqr6WRMuvX/DzQ+3MedT1nbNfFsmNcf+7ax5XA6P21DFEQf8X1SRnXp5Jl3+5pbWb2uE6Ki0puM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763530835; c=relaxed/simple;
	bh=zW4qVDeAoSkF0pttWdUp8rpXpXFd1iXzZWSsotUzJIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXHAHulD/v8705IWGYuRVqzS8CW73PVbIjeVgZ8E/tgu6JrXqMtCiDkebGHOPazmzr8a8/yTqu5aNy53RQEn2HBxcXD6MzAeW0+fOwNPWQHsU/xCg4N8/yclfXt84FwqPNf4yFZOdfHMEVQAiWFn+GZo2uf+GjTIrQ69l3Tv45w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8369E68AFE; Wed, 19 Nov 2025 06:40:22 +0100 (CET)
Date: Wed, 19 Nov 2025 06:40:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH] zloop: fix zone append check in zloop_rw()
Message-ID: <20251119054022.GA19866@lst.de>
References: <20251119043423.1668972-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119043423.1668972-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 19, 2025 at 01:34:23PM +0900, Damien Le Moal wrote:
> While commit cf28f6f923cb ("zloop: fail zone append operations that are
> targeting full zones") added a check in zloop_rw() that a zone append is
> not issued to a full zone, commit e3a96ca90462 ("zloop: simplify checks
> for writes to sequential zones") inadvertently removed the check to
> verify that there is enough unwritten space in a zone for an incoming
> zone append opration.
> 
> Re-add this check in zloop_rw() to make sure we do not write beyond the
> end of a zone. Of note is that this same check is already present in the
> function zloop_set_zone_append_sector() when ordered zone append is in
> use.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

