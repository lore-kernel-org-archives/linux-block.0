Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CD5377A98
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694886; cv=none; b=OgV3PLIjwJ+XR3Px+z6dxnLGIPaV411HXFxSKz83iMwW8WG0H/IWg9dYvM1GpRQm6lHSuzBTTz8sePh4wgQ/fIc77s7zv6uuDl5SmLOO2EFvwxx9wixY4MVzj5l46W249IFcEXgRONsfGBOqvPVymm2DZ+hMHojW+yvdWVqsYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694886; c=relaxed/simple;
	bh=zZ3uzCaw5ROxwrxVqL2amt7R+VQqZCdu0TB46IIPq9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLbhyHTxnZ+H6/6EUCpZ4x6ZgLsHKvn22BgfVTdrWE1A4vGbIXp+UnKO63p703HlDgVTIzIrM2aSXBxTXBMVMlPiFRn/vFhntrwCaUb0rt7adFsUacBxtRlH0N4W4SjSwnS5nSV8tDNMx2ODl8QITBJiyi32TpkjoZucIsjISX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BD7068B05; Fri, 14 Aug 2026 10:08:01 +0200 (CEST)
Date: Fri, 14 Aug 2026 10:08:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 10/13] block: fail zone management operations to
 read-only and offline zones
Message-ID: <20260814080801.GE12566@lst.de>
References: <20260814063201.1762743-1-dlemoal@kernel.org> <20260814063201.1762743-11-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814063201.1762743-11-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 14, 2026 at 03:31:58PM +0900, Damien Le Moal wrote:
> +		if (!bdev_check_zone_mgmt(bdev, bio->bi_iter.bi_sector))

bdev_check_zone_mgmt fails like a bit of an odd name.  Why not something
like bdev_zone_mgmt_allowed?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
