Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A725D548
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536124; cv=none; b=eoIGoOlWsObYyFXuWO9KF7gON1Sj5UzPVpSdj2u04HqReMHJyC27c9Sztntv3TffxnO4LsP8pgHgfDaOamuN9AYRsaJfByhCyFVmbl4lVImhSM0qB3k+Kkw1PxrAe8YcrquIy8glKW/H5it2Uf4Bz09uL3lYvT1SYOUAHnY6mTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536124; c=relaxed/simple;
	bh=9QLT49yl3HSc3weY9bgOQddavT3krd0OUd7XFWa32f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezQ7T6XHnHVwxYCHaVPMPr2NKq9xjN8fLjKrlAg1AXrtKMOueOMFgizBDkWETEXTkNw/MQOY15/N2zDvRz1xCsAYFEQ+NNBVSpYHZ3IxvYZQnk6UhedIf7ecvtvD+Unz9khU96O/24dOCx7M+mpmkVASm8P6/zL1DEyV0s8KSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN/GrDGe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN/GrDGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B66C4CED1;
	Fri, 14 Feb 2025 12:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739536124;
	bh=9QLT49yl3HSc3weY9bgOQddavT3krd0OUd7XFWa32f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BN/GrDGehOyyFZO9PhXrxkYLISLP8A/0wDDFvNLAhnqW267ChzqHbObFyECMCMeQt
	 IWQjbFOkqu3giVaD1KZROX4CXAwx8MgaFDKsUCdbYkJ8LIShJhvhMlM45/gJxN9gIX
	 Cdvxxo/okezZIG2zuM+VEoOvw3w6eqm1LULj0pTfHccInLDmH/BMEMhjz3rKDRJ0Yq
	 ZIf88yglat0YMH4tOGYxO5UNRRyLUOcvjkWNW2mGezm7IIz6z3R2UyotHEDAogsDrH
	 pK4Yg163rh/JHfW/2GsjPmts1LhUsKw5tnQWu+6iVe2XYB2bzxIvBPQHT2UyxLPrqC
	 vVI/J3CM6/qng==
Date: Fri, 14 Feb 2025 13:28:41 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Yi Zhang <yi.zhang@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Bart Van Assche <bvanassche@acm.org>, 
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <xjuuc5qqgy6ujywimm2poxibbhsh5zbsefqeiqjru7q2llmjoj@spht3a4bx555>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <ifgg2za26r6frfco4cky6wxywgdj3l7r6hx6sbqarizqltshfx@kccnmlr3x7nq>
 <Z68m0X9o3Mw_oPsU@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z68m0X9o3Mw_oPsU@fedora>

On Fri, Feb 14, 2025 at 07:19:45PM +0100, Ming Lei wrote:
> On Fri, Feb 14, 2025 at 10:38:36AM +0100, Daniel Gomez wrote:
> > On Mon, Feb 10, 2025 at 05:03:19PM +0100, Ming Lei wrote:
> > >  /**
> > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > index 248416ecd01c..32188af4051e 100644
> > > --- a/include/linux/blkdev.h
> > > +++ b/include/linux/blkdev.h
> > > @@ -1163,6 +1163,7 @@ static inline bool bdev_is_partition(struct block_device *bdev)
> > >  enum blk_default_limits {
> > >  	BLK_MAX_SEGMENTS	= 128,
> > >  	BLK_SAFE_MAX_SECTORS	= 255,
> > > +	BLK_MIN_SEGMENT_SIZE	= 4096, /* min(PAGE_SIZE) */
> > 
> > I think it would be useful to expose this value to the queue_limits and
> 
> Can you share it is useful for what?

I meant for your use case.

> 
> > sysfs (and remove it from here). We can default it to PAGE_SIZE (as it has
> > always been) and allow to overwrite it when the block driver initializes the
> 
> Which device driver needs to initialize it?

I mean, it would be yours. Keeping the default minimum segment size to PAGE_SIZE
rather than changing it to 4k, would keep the current behaviour. Then, adding
the minimum segment limit would allow your driver to overwrite it for your use
case.
