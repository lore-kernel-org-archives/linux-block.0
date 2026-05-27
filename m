Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC4D43637F
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896365; cv=none; b=YR//jmFjsSfQb9+tqI5OUcLOuhc45RK8EmWqm/nVpbkctUPq2Uatjj1epAgiB+QRlBDNn1Dr1gAK1EICWKzPEJ0wWdP/Ajo353shh3fqSfw4MwGTTznXOMbxrko1G6G30ezUrFGb5Q71VRm2f1fkYNXifo8aAQqu25Sjas/WY0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896365; c=relaxed/simple;
	bh=b6VpXjdtg9lV33PB6Hi3Z0X90y/K0/kHxUht1PQYYJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxcSNnnraphq2ZPsZOJAgnH5Kn09RYT6EuVAGFHoqqyiWRPSKcBhOBmH7b6m8YqvmXe6HcDQYDWKxXadH0WZdl/FfsQQW2UYWL0x/2DRV+/cw0s68b9obj9obBscYcQQFjxUJk7KdYN0oK3SpRbc5vPwlL0TZsvIRRnomz9n9FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C65E068B05; Wed, 27 May 2026 17:39:20 +0200 (CEST)
Date: Wed, 27 May 2026 17:39:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Haris Iqbal <haris.iqbal@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: add a bio_endio_status helper
Message-ID: <20260527153920.GB15670@lst.de>
References: <20260527151247.2352145-1-hch@lst.de> <c09acca3-d674-4671-8e8a-28c80e948266@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c09acca3-d674-4671-8e8a-28c80e948266@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 27, 2026 at 05:33:18PM +0200, Haris Iqbal wrote:
> Do you plan to convert similar call patterns in other drivers like drbd, 
> zram, dm, etc, too?

Yes, as-needed.  But I'm happy to leave others to do that as well.
