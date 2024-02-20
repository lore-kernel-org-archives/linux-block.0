Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60207762D7
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444249; cv=none; b=MVnSFcO7XvSlzb/P/q/tnHtXYrvndc4SgwpbnBPOc+1kgEr8DvVpk/Cbxl16WzrHYd9JCMd906z9KtjZj0FHo9dRsCE55QTif2BMp+sJsvpxa3aWMc883IkIeeIlmXzpqMA01NmGa11SoG6UAw+LUAUc4cnmmebpq9tdxs7BCfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444249; c=relaxed/simple;
	bh=kSTK6+H1xUigvmtAn+fxBTk9I9qPMfgW8SX5KszkZFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lV7auKKpYZJBFpAOlItQVHMFXJ38bBMt9YK0a6n0RCxgjiLKRsirEYkM1Tr8N9Nlx6TMw8eeIzI5RR8IUyaa750MHIZWivtmkTz5al2ely9VYIVsJtj2Mg+wdVDNimboMRzSxhnQ1ukk6C42CWpQuTG5mWxpOQplh7c1cAjfA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C66C968D07; Tue, 20 Feb 2024 16:50:41 +0100 (CET)
Date: Tue, 20 Feb 2024 16:50:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Christoph Hellwig <hch@lst.de>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] xen-blkfront: set max_discard/secure erase limits
 to UINT_MAX
Message-ID: <20240220155041.GA17393@lst.de>
References: <20240220084935.3282351-1-hch@lst.de> <20240220084935.3282351-2-hch@lst.de> <ZdSPj32Ww80nKQhM@macbook>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdSPj32Ww80nKQhM@macbook>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 20, 2024 at 12:39:59PM +0100, Roger Pau Monné wrote:
> On Tue, Feb 20, 2024 at 09:49:32AM +0100, Christoph Hellwig wrote:
> > Currently xen-blkfront set the max discard limit to the capacity of
> > the device, which is suboptimal when the capacity changes.  Just set
> > it to UINT_MAX, which has the same effect except and is simpler.
> 
> Extra 'except' in the line above?

Yes, thanks.
