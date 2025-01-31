Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F67169397
	for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738319792; cv=none; b=pwH2sKtZu/to35/Y7rKwoAImJ29MIc0Y9vgp54wjf9Vk5U0CkSpDIyNF8E06i92Lr3R2bUp0Sm7slkCXO+rq0c6PmBB68IpJL97D1xFmCEE1RC/dHkFrfLPTjVetMwdSycEoU0ALTRC8tGhnhd+MrMNGhSOkY6OYwo33Dm4pAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738319792; c=relaxed/simple;
	bh=BZVBALT3kaSUC/x7zpfoR0bXbKDTlW4CdZ5GQ+mUAsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGWVtU7UoRTpPoSa0mvXy9LBcAwKzVJauGCBQ7EbfGKFYNERlw978J8O33WmtZGHx1mb15xxTfQKzH3yMWmfRo5yVZFmH1ZxUc3jSIVffU+KBHhsbkm53LiUQB9Rz2DSvmrHkSE2A8TPRKzLEqmZRVrG0dyJd5BvZDOiahNIVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 654B168B05; Fri, 31 Jan 2025 11:36:25 +0100 (CET)
Date: Fri, 31 Jan 2025 11:36:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: in-kernel verification of user PI?
Message-ID: <20250131103625.GA20115@lst.de>
References: <CGME20250129124655epcas5p39750f07e5015f1dd5e198c72cca0aa4e@epcas5p3.samsung.com> <20250129124648.GA24891@lst.de> <3e7a79d7-b5ed-4ad2-a2d2-84c2c6cda757@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e7a79d7-b5ed-4ad2-a2d2-84c2c6cda757@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 31, 2025 at 04:04:53PM +0530, Kanchan Joshi wrote:
> On 1/29/2025 6:16 PM, Christoph Hellwig wrote:
> > Also another thing is that right now the holder of a path or fd has no
> > idea what metadata it is supposed to pass.  For block device special
> > files find the right sysfs directory is relatively straight forward
> > (but still annoying), but one a file is on a file systems that becomes
> > impossible.  I think we'll need an ioctl that exposes the equivalent
> > of the integrity sysfs directory to make this usable by applications.
> 
> Are you thinking this ioctl to be on a regular file?

On anything that supports passing PI through io_uring.  So block devices
and (some) regular files.
