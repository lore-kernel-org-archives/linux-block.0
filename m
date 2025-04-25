Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD412185AC
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605428; cv=none; b=Rn/mP4/2InriL3A6+KYImJPy4Hmo2k7gXcu6OG5WE6rHwdWkMLi74XvgkOVpZE7TjYSaeSEvyj9CHSqPVtxwaz9Hm/uOOH5MHh6yvi2SFh+czyQrU9hfpxck4kjyfMSZJo6haptmtVLc8mu0h2FWd/B3he/Sk8YhtB0lGIiE2Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605428; c=relaxed/simple;
	bh=5tdlpwcz6JTqQTkjcTo4LkhOQHuzxeLgYWAyZQRm4Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o01C6z0hGbjHFAQqUxfIZllzbJ/6cnS3enmPtKdMVGtHRg4l2GgxBu2MQgMqjLBGFSWBeH4ZG7+v8CROu4oFexNaU512HI5X9J9uKR7gJD2boKoL4WLEhLoo+a0Qli5gpyjm/zOBBU7363FIMxqQiqwPmxfwzem8f3GukfHdrt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7456068BEB; Fri, 25 Apr 2025 20:23:41 +0200 (CEST)
Date: Fri, 25 Apr 2025 20:23:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 12/20] block: add `struct elv_change_ctx` for
 unifying elevator change
Message-ID: <20250425182341.GA26154@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com> <20250424152148.1066220-13-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424152148.1066220-13-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 24, 2025 at 11:21:35PM +0800, Ming Lei wrote:
> +struct elv_change_ctx {
> +	const char *name;
> +	bool uevent;

There's only one caller that wants to supress the uevents.  So maybe
invert the polarity so that it only has to be set in one place,
which also documents how setting the initial scheduler is special a
bit better.

> -	ret = elv_register_queue(q, true);
> +	ret = elv_register_queue(q, ctx->uevent);

.. and pass the ctx on to elv_register_queue instead of converting
paramter types.  Although that might be woeth doing later when
another argument derived from ctx gets passed as well.

