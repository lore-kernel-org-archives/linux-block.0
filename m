Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2355E1DDA3D
	for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164381; cv=none; b=HSejtUx1LDQZVrutzxIuOl0eWtuU978+gI2yLCIHaR/nQ7TB/sledfgGbi6msQOLATZPlgnLgxSSAsl1awEybMMElBi2w9JWEJf5T+/U+cKJL3FY/8rTz9IFixzCywO4EFurZ2Cl6PEoj1YeNslNS1MaPSG99jahCcwKtVjcc+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164381; c=relaxed/simple;
	bh=1Wd1GdJLKWSV0+fejmK2lTf9IFE2odETOBWy3LpPAJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1lEanH1j2ToZUo3zJdxfiTQtLzo+cfh897pI+tEHCGXBdC5HXGowGF6Nge7UG+GqFk9NhbQkxadM/pDEjziGTzzaXYrA1+Gdsc4OYDgakxZQrF1MfE38yuaQSS9TiEMLBNtCfivV8UI+co2kgDwiGgCtW5CNhRngxA4uATGjTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3271368D07; Wed, 29 Jan 2025 16:26:13 +0100 (CET)
Date: Wed, 29 Jan 2025 16:26:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: in-kernel verification of user PI?
Message-ID: <20250129152612.GA5356@lst.de>
References: <20250129124648.GA24891@lst.de> <yq15xlxsqkg.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq15xlxsqkg.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 29, 2025 at 09:23:37AM -0500, Martin K. Petersen wrote:
> Doing a verification pass in the write hot path had a substantial
> performance impact when I originally did this.

Oh yes, it absolutely will.  While the CRC implementations got a lot
faster in the last years, there's still a cost.  It also touches a lot of
cache lines.

> Even remapping the ref
> tag has an impact on cache. That's why DIX1.1 moved ref tag remapping to
> the HBA so we could avoid touching the PI buffer altogether in the hot
> path.

As in supplying an offset for the ref tag somewhere in the HBA specific
per-command payload?  That's not implemented in Linux as far as I can
tell, or did I miss something?

> > I.e. if userspace passes incorrect information it can trigger a
> > command failure and thus the driver error handler, which is something
> > we don't usually allow for "regular" I/O.
> 
> Do you trigger EH in NVMe? For SCSI we just bubble the PI error up
> without retrying.

We don't have the EH thread from hell, but there is error handling yes.

