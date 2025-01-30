Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FC1DDC22
	for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738242139; cv=none; b=bzp9yKZOXVM/hXfTC+4q+ZlQVlA+zeDHED+jkgbaFj8iMtkzvHmv3ZlJqm2u+iGuoGdWlI3Qh01jc2eaw/dBbvepBNKi5MzIi8TD3n7kXqZFYcTOkeIJrX+CCKI6Ha46K3lLWocARkr19TNmf1C6F5gi78Z74bb4chLOlw05EKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738242139; c=relaxed/simple;
	bh=8WMQMpHRmsknwX0cP9ZJMZI7KOol8fNFxr8IYbSRZN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqCI5dgJVwv77oYRS5KLN5ftVGrkHrV+R+kSyE1+wB07M9YDvZfZt1CVDxxHfGfNUBCr/Kt63FMfO/yCHfxulkeM6Gy+GQNxo9X/pxUTwVV22Nzbpjp2exVFGDOaKHqtz2gsrmG3snzWfdA/unw+DcqVxAyIdumBA2dxyNYIdeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8ED5668C4E; Thu, 30 Jan 2025 14:02:12 +0100 (CET)
Date: Thu, 30 Jan 2025 14:02:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: in-kernel verification of user PI?
Message-ID: <20250130130212.GA19522@lst.de>
References: <20250129124648.GA24891@lst.de> <yq15xlxsqkg.fsf@ca-mkp.ca.oracle.com> <20250129152612.GA5356@lst.de> <yq1tt9hr62s.fsf@ca-mkp.ca.oracle.com> <20250129154315.GB7369@lst.de> <yq1jzadr5a6.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1jzadr5a6.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 29, 2025 at 11:15:35AM -0500, Martin K. Petersen wrote:
> 
> Christoph,
> 
> >> It fell by the wayside for various reasons. I would love to revive it,
> >> all it did was skip the remapping step if a flag was set in the profile.
> >
> > How much remapping could the hardware do?  Would this also work for
> > remapping a inode-relative ref tag?  Do we need to bring it into NVMe?
> 
> One of the reasons it lost momentum was that NVMe didn't do it for
> ILBRT/EILBRT. Although of course NVMe doesn't really have an
> intermediate HBA entity like SCSI.

Or any kind of coherent architecture for PI..

> With DIX1.1, you tell the HBA what to expect the first received ref tag
> to be. That could be the application's file offset or whatever you want.
> It's just the seed value chosen by the application when the PI was
> generated. That's passed down the stack along with the PI buffer itself.

Yeah.  NVMe actually kinda supports this, but for zone append only as we
need that for PI with zone append.   But it is limited to remapping from
a starting reftag that is the zone start address, so it's not quite as
flexibble.  Search for the PIREMAP bit in the ZNS spec.

> Not sure if we'd have room for both an EILBRT and an ILBRT in the same
> command? Sounds like it would be difficult, especially with the larger
> ref tags in NVMe. But I'm happy to pursue in NVMe if there is interest.
> Because it did make a performance difference not having to touch the PI
> buffer in the I/O path.

I guess you'd do it by treating type1 PI as actual type1 PI, that is
the ILBRT is derived from the LBA.  But I'd need to think more about
it, and without a clear customer use case it's probably not going to
happen in NVMe.

