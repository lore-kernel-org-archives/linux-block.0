Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0046E192D9E
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215026; cv=none; b=SuUVZeo9gSRIusB6PFc66Zy/ob3OMZ5nD09lkuZYnQw3763hlo/KKxy/HHC1hnpoiS3DPi3UHKSZuSXwW8dLktCIe9gkqOL0UHLk3ZXgRZBOtXkig+KiNoQ/DP/vNTijBfSXwIR2pFXRUSGZGNz9upnkJMwtowo2esw59xQ61/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215026; c=relaxed/simple;
	bh=/gWzMUnZsR3O3NKmth6ezd1td4Cs94Ri/Z29vp/+G84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUUrOdrb48OM9XZkzfho4OghAN3Roi+vZisCPaAW6SB/P8An5WE4I2ZG1yLg7w2r48pOzUBIfA5MtMi3+1LvA/5K+uVz90GGaJ57kYGFi65qyBnnxMMAyhXIMja2Drk0TPsI+SSGMXdytUSTh5l8l2JpNKAbaDEJcfikMnOotCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 31F1B227A88; Tue, 29 Oct 2024 16:16:54 +0100 (CET)
Date: Tue, 29 Oct 2024 16:16:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: add a bdev_limits helper
Message-ID: <20241029151654.GA25946@lst.de>
References: <20241029141937.249920-1-hch@lst.de> <70d23933-a9ee-45a5-8805-75f477abccec@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70d23933-a9ee-45a5-8805-75f477abccec@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 29, 2024 at 03:13:10PM +0000, John Garry wrote:
> I do note that there still seems to be patterns of calling bdev_get_queue() 
> and then examining the queue limits directly outside block/, like 
> do_region() in dm-io.c or lots of other drivers/md/ stuff or 
> loop_config_discard
>
> I can try to help clean some up when I get a chance

I'm slowly going through them.  Have been a bit busy lately, but as
I have some pending code that can make use of bdev_limits() I expedited
them.  If you want to take some on go for it, I have no immediate plans
as I'm pretty busy at the moment.
