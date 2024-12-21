Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18919DF61
	for <linux-block@vger.kernel.org>; Sat, 21 Dec 2024 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734768799; cv=none; b=EZJyx5YWrhbTnomsF9+FpAuqIsORyhvXUpjWnp88PvjDs+lI91emzHN75+AL2PWcApYnILbSjDZziB1vCCqN+623GYl4qOO7NybgUHuGr8xs448d9SHEnbiK1/ap1UIbfCSkxXdMtcmZtkOYictTdLB4XaNIeuO0Hy2e7WUPp60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734768799; c=relaxed/simple;
	bh=lXu3Prl3gwvcHwDJ5rvXpiJpEJJ+ZCBav7vxbtqZoIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tb+Lf9lBpaRH85VeEZEF6QlkcROQibCIdQKtg2NGefXH3q8ZAxzzedMprZXpS6Q5eiHBlx4Jjf0RPqq0IcLkGpfThgtUBb9Jkgf5jAj1RgpVEFdGihm0Vd3MSf9XEADseAegqHHe5pLpVasXNs8GWL52xloBDl3+iId4/36qRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E52E768BEB; Sat, 21 Dec 2024 09:13:12 +0100 (CET)
Date: Sat, 21 Dec 2024 09:13:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Zoned storage and BLK_STS_RESOURCE
Message-ID: <20241221081312.GB13103@lst.de>
References: <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org> <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk> <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org> <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org> <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org> <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk> <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org> <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk> <20241219060029.GB19133@lst.de> <b6a65de9-626b-42e2-a55f-28470ddee416@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a65de9-626b-42e2-a55f-28470ddee416@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 19, 2024 at 09:12:48AM -0800, Bart Van Assche wrote:
> Using zone append operations defeats two of the advantages of zoned
> storage. One of the advantages of zoned storage is that filesystems have
> control over the layout of files on flash memory with regular writes.

I'm not sure what you mean, but not they absolutely do not.  The FTL
will reorder in any way it fits.  With zones it will genrally do less
so (at least for sensible implementations), but that does not depend
on using write or zone append.

> That advantage is lost when using zone append operations because it is 
> allowed to reorder these operations.

It is allowed but doesn't do in practice.  It will reorder in exactly
the case where your scheme doesn't work at all.

> Another advantage that is lost is
> the reduction in size of the FTL translation table. When using zone
> append operations, the filesystem has to store the offsets returned by
> zone append operations somewhere. With regular writes this is not
> necessary.

The file system always has to track the extents.  Bart, I'm not sure
where you get the lines your spewing here from, but they are completely
decouple from technical reality.  Please spend some time actually
understanding the technologies you make claims about.

