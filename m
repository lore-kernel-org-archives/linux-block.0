Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B6C8460
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887823; cv=none; b=N7W0+zZpfjEVhhNq9+ybCHVJtmOxrcD6xweeG9g2vou80FrW7R9bJ7pNULYKuFVrPdKH2jHGyyAo1LZqqNZxDUd4N9BmgrtxJtkf//tVzYKdJMQoQMEXckyfcGTpoxzevzZaKil+c465vWzOzIOB3/vb+k7MwEmWd0pscfrFUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887823; c=relaxed/simple;
	bh=ptZlg4cSY4YwqZmgcW3tF9ufEpuzcg6zND5p5xCFfQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRUdBDZ5iB4hELFZewWrNO2C5C2qkgHIb5tnBzNrQntPW19/dK8hVbUv/sKVvz0HOQ4m53xYz0lBoBBf7SWnSwssXm0x0gh3Cdd3uL5KhpbJZaA1sxuIQbFgMXO00U3aooiH2CTQ25+n5dp320ROKJbf2GQJaenxiGt45w1ICXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 87F3F68B05; Wed, 27 May 2026 15:16:57 +0200 (CEST)
Date: Wed, 27 May 2026 15:16:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, nilay@linux.ibm.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] nvme: add support multipath passthrough iostats
Message-ID: <20260527131657.GB10351@lst.de>
References: <20260526153921.2402015-1-kbusch@meta.com> <20260526153921.2402015-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526153921.2402015-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 26, 2026 at 08:39:21AM -0700, Keith Busch wrote:
> +	struct nvme_ns *ns = q->queuedata;
>  	struct request *req;
>  
> +	if (ns && nvme_ns_head_multipath(ns->head))
> +		rq_flags |= REQ_NVME_MPATH;

I just wanted to come with reasons why it this is wrong, but it actually
seems already - we only have a ns for multipath nodes if multipathing
is enabled.  Maybe throw a little comment in on that?

Otherwise looks good.
