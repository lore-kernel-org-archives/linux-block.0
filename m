Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF007E9
	for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165401; cv=none; b=B7k/LwkEcSj8w18NerxGXxAMh0B1lIThrR9bzYmxLXNs5XnLkzG6RgzHwhe35mZicBNP1yDTJ40+93BnvVuFfdIJ7gODN85ozBb3vB2LisFuF/nGX8F+peIBkhBx8RAFOMUjvnRb9ZwQdP6vi2eR3rY8L/zn7GNCBphAuq1z2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165401; c=relaxed/simple;
	bh=zMsUfPQA5HxvCccin6YzjWCKSCrGZNaS0C84mjWki0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPbqXVvGK2GfGDj30psURGd59hzWB/bc5ZIOMp3jKrFu7s/BsZrYpiH9+R0ItliVgyY6ZqQgtINSnBlvy/Dg94CacYJ2yNHa+6m/v6MsIHJYPg++LdtPt7UY7l2P7iqnn2yxbaIgseb46HWOYpOLe80C69IyU9UuHB3g//RiTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B40C368D0D; Wed, 29 Jan 2025 16:43:15 +0100 (CET)
Date: Wed, 29 Jan 2025 16:43:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: in-kernel verification of user PI?
Message-ID: <20250129154315.GB7369@lst.de>
References: <20250129124648.GA24891@lst.de> <yq15xlxsqkg.fsf@ca-mkp.ca.oracle.com> <20250129152612.GA5356@lst.de> <yq1tt9hr62s.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1tt9hr62s.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 29, 2025 at 10:42:04AM -0500, Martin K. Petersen wrote:
> 
> Christoph,
> 
> > As in supplying an offset for the ref tag somewhere in the HBA specific
> > per-command payload?  That's not implemented in Linux as far as I can
> > tell, or did I miss something?
> 
> It fell by the wayside for various reasons. I would love to revive it,
> all it did was skip the remapping step if a flag was set in the profile.

How much remapping could the hardware do?  Would this also work for
remapping a inode-relative ref tag?  Do we need to bring it into NVMe?

