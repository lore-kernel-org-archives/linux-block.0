Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D602459D7
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591687; cv=none; b=SXEQsQuq52A/cZ8b1g9ySP8fmodOa9IvCxHsVY1kr+zVXegtDReXSF04OEkg2Vhhe7AmLTenSz8VIacUSCLGrcdOEcJUUMhriXFxWH718rG7RK9vPNbJnth3HxgqGemj1K+HLFhQtS0fsaI0Ak84TvTy8n4lhE8VZtImgC5Wnpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591687; c=relaxed/simple;
	bh=iq+cGeMSMzeq0AYcGnN3tuZ9Fcm8544MakrRblM6JDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBUvEohEDZWyiteFeAHAfiIHku2BNeSktNptKz7/duavBQOHHTHfo4FZ8XKYi3v+FZwoJh2vlKnWkFsv2DFo7OWG1SW2MfinEGgbTzmx9UjfJgp0k6H1zqBbmnpveR9ujdX7l38ShzUeppmrd3FEAcK2e/i69Z+Idpx6YujnJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 77A3568BEB; Fri, 25 Apr 2025 16:34:41 +0200 (CEST)
Date: Fri, 25 Apr 2025 16:34:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 10/20] block: move blk_unregister_queue() &
 device_del() after freeze wait
Message-ID: <20250425143441.GE11082@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com> <20250424152148.1066220-11-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424152148.1066220-11-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 24, 2025 at 11:21:33PM +0800, Ming Lei wrote:
> Move blk_unregister_queue() & device_del() after freeze wait, and prepare
> for unifying elevator switch.
> 
> This way is just fine, since bdev has been unhashed at the beginning of
> del_gendisk(), both blk_unregister_queue() & device_del() are dealing
> with kobject & debugfs thing only.

Can you please add a reference to the previous attempt here and that
it was backed out again and why we think it's fine this time around?

