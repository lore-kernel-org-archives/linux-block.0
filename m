Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C781C01
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEa6VWzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E159C433C8;
	Wed, 13 Dec 2023 16:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702485694;
	bh=TVZscO3yrWHFw6leu/w3g7rUCknKBK2nu27KiMba8gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEa6VWzvAFn3iXIviR4r7/OThb868y+nWex0hisssdiFsge2CAaMGDcACftCkYfj1
	 Dt3QraiRreferVDvxKWh5PcWufDvSF4qxZVIlYc3ZZUtWdIUTmS3qRWKzmorV/hw/m
	 9vJWOkhVBWRWnbcKpAXH2Qj27Q9x+jl2dZjHnH8rWx39QogKtp/ib+lDWqj1reZ6QJ
	 r3AmIJVdlLpccduyqcQb/KmY7nHQNnP3XqbZc1J2e50kPhnXg6YcAGYEmG6HvlCsGe
	 UYmgLUx42hzTy+vHlDTkoD+fsBYQCk4sSwgaV2Q9B0YvY2N+Iq/OWqGCSTAqWgTGT+
	 tlOtSZW2gzaVw==
Date: Wed, 13 Dec 2023 08:41:32 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <ZXnevBo4eIZEXbhK@google.com>
References: <42054848-2e8d-4856-b404-c042a4365097@acm.org>
 <20231212171846.GA28682@lst.de>
 <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org>
 <20231212174802.GA30659@lst.de>
 <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org>
 <20231212181304.GA32666@lst.de>
 <19cd459e-d79e-4ecd-8ec8-778be0066e84@acm.org>
 <20231212182613.GA1216@lst.de>
 <ZXiual-UkUY4OWY2@google.com>
 <20231213155606.GA8748@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213155606.GA8748@lst.de>

On 12/13, Christoph Hellwig wrote:
> On Tue, Dec 12, 2023 at 11:03:06AM -0800, Jaegeuk Kim wrote:
> > As one of users of zoned devices, I disagree this is a broken model,
> 
> So you think that chasing potential for reordering all over the I/O
> stack in perpetualality, including obscure error handling paths and
> disabling features intentended to throttle and delay I/O (like
> ioprio and cgroups) is not a broken model?

As of now, we don't see any reordering issue except this. I don't have any
concern to keep the same ioprio on writes, since handheld devices are mostly
sensitive to reads. So, if you have other use-cases using zoned writes which
require different ioprio on writes, I think you can suggest a knob to control
it by users.

> 
> > it is essential to place the data per file to get better bandwidth. And for
> > NAND-based storage, filesystem is the right place to deal with the more efficient
> > garbage collecion based on the known data locations.
> 
> And that works perfectly fine match for zone append.

How that works, if the device gives random LBAs back to the adjacent data in
a file? And, how to make the LBAs into the sequential ones back?

> 
> > That's why all the flash
> > storage vendors adopted it in the JEDEC.
> 
> Everyone sucking up to Google to place their product in Android, yes..

Sorry, I needed to stop reading here, as you're totally biased. This is not
the case in JEDEC, as Bart spent multiple years to synchronize the technical
benefitcs that we've seen across UFS vendors as well as OEMs.

> 
> 
> > Agreed that zone append is nice, but
> > IMO, it's not practical for production.
> 
> You've delivered exactly zero arguments for that.
