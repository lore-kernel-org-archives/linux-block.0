Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C4298CAF
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534471; cv=none; b=gNwJBEfgRAU6Rls/Yq5izozH/ctNglLmvRzFYKCfqclulVJ19nT6/fXHXEcC5fmpsRyNk66hGA4APOR57RhscBo3iKyrTzdwoGHS4louHuJCjA+JozKs2A3rxNbaQezOnQnBNCtdDpgKr7PddkJDjwXJH/gil7dw6JNVkAG2vxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534471; c=relaxed/simple;
	bh=vNt/c8mICi1IZTG/LMNveBhy4k7ofsd6e9rzCbo0P+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzqeY6AriGfHqfFT1ChEQHeM2AxRIbX9Wp9CbzcLDwi5vflTMn0FFDKkoQ8iAZ04MajOcWxNNuqX3VZTkQ0bVG8oRy4OG7DGX5kGtTUinlP469r3cRvs+r0gm34MxBOq9bj1fNbjDt83eZbVxz5TIPAhF9eSMkeOI7f3gNjn8O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B90E568CFE; Thu, 26 Mar 2026 15:14:24 +0100 (CET)
Date: Thu, 26 Mar 2026 15:14:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 15/26] drbd: Balance RCU calls in
 drbd_adm_dump_devices()
Message-ID: <20260326141424.GB16166@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-16-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-16-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 25, 2026 at 02:44:56PM -0700, Bart Van Assche wrote:
> Make drbd_adm_dump_devices() call rcu_read_lock() before
> rcu_read_unlock() is called. This has been detected by the Clang
> thread-safety analyzer.

Please split out fixes so they:

  a) stand out
  b) can be queued up in the current merge window

The patch itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

