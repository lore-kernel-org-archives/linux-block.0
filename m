Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD42DEA8E
	for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857430; cv=none; b=bLSv7oBoX9OZmHa/B0J7g9xUb6Wz4wNjaSAtYluuDdm0eIAGfNXhag9sK5UOiFHIHRmRwM1tq6kvNKo36ZWqM1yxzYLpOlfOMmzoL2DzkZ9rftvw9FiIHDKXgJIeHPb8m2DQRZplSdekN8zgGIDqIJqN8wjyh0CfjpeF2BwCE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857430; c=relaxed/simple;
	bh=p0IkI9BFFQwf7PGF4dnHd4MoNDGbIFKcjpiSnXIjxJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuVN4gnT51Uiy0c2emQSRbAVw/pKFawZ5+wHvfAw07ef0GPcmChysElcQ2GWzvc9ztt1Jk8z2GwsABQlbUgUUNnlDL32A49vK3+9r6r2r8WzGyuVpVjrMTu/TwRwiAzCVTe5gNAx4qK069n8BlQztelRyG9yjGwTVYup2AlVD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJPnID9+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJPnID9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3CBC4CEF1;
	Fri, 18 Jul 2025 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752857429;
	bh=p0IkI9BFFQwf7PGF4dnHd4MoNDGbIFKcjpiSnXIjxJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJPnID9+uBXkLrhFOpaBjXUh4XRE1A2rkbJRc26n3cZs4unWHjKlNIpWUP/2dQ2Co
	 UjN3zHHTFk1i4AJh3CIcybn8ZB/0WV4+6E7yXA8UqPUPaKiJc4i9DrdUmwS16bvYLc
	 z+0c1oQu3y6nPVF+OG2GoWz64wUpawb6PlLISiWZsIg8rlbxve5i0fuJv/FS3UEQMa
	 kskjbx0P5vxIh17AVXVEQUROdql0YdQ8HZalLbZhruFfSmCc1xWURynvUalsX8XinL
	 wbkzc3ygDWEvoxr4pYTiiU9pMN+dVc/1Bmq9o1sww4iWlSXXDNVCkyLeCeDAQuv/qA
	 iplMzPk9Q4ePg==
Date: Fri, 18 Jul 2025 09:50:24 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Fix bio splitting by the crypto fallback code
Message-ID: <20250718165024.GD1574@quark>
References: <20250715201057.1176740-1-bvanassche@acm.org>
 <20250715214456.GA765749@google.com>
 <20250717044342.GA26995@lst.de>
 <3d6e8317-7697-4bb4-8462-c67b5e6683b4@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d6e8317-7697-4bb4-8462-c67b5e6683b4@acm.org>

On Fri, Jul 18, 2025 at 08:37:04AM -0700, Bart Van Assche wrote:
> On 7/16/25 9:43 PM, Christoph Hellwig wrote:
> > Getting back to this.  While the ton is a bit snarky, it brings up a good
> > point.  Relying on the block layer to ensure that data is always
> > encrypted seems like a bad idea, given that is really not what the block
> > layer is about, and definitively not high on the mind of anyone touching
> > the code.  So I would not want to rely on the block layer developers to
> > ensure that data is encrypted properly through APIs not one believes part
> > that mission.
> > 
> > So I think you'd indeed be much better off not handling the (non-inline)
> > incryption in the block layer.
> > 
> > Doing that in fact sounds pretty easy - instead of calling the
> > blk-crypto-fallback code from inside the block layer, call it from the
> > callers instead of submit_bio when inline encryption is not actually
> > supported, e.g.
> > 
> > 	if (!blk_crypto_config_supported(bdev, &crypto_cfg))
> > 		blk_crypto_fallback_submit_bio(bio);
> > 	else
> > 		submit_bio(bio);
> > 
> > combined with checks in the low-level block code that we never get a
> > crypto context into the low-level submission into ->submit_bio or
> > ->queue_rq when not supported.
> > 
> > That approach not only is much easier to verify for correct encryption
> > operation, but also makes things like bio splitting and the required
> > memory allocation for it less fragile.
> 
> Has it ever been considered to merge the inline encryption code into
> dm-crypt or convert the inline encryption fallback code into a new dm
> driver? If user space code would insert a dm device between filesystems
> and block devices if hardware encryption is not supported that would
> have the following advantages:
> * No filesystem implementations would have to be modified.
> * It would make it easier to deal with bio splitting since dm drivers
>   can set stacking limits in their .io_hints() callback.

Yes, this was considered back when blk-crypto-fallback was being added.
But it is useful to support blk-crypto unconditionally without userspace
having to set up a dm device:

- It allows testing the inline encryption code paths in ext4 and f2fs
  with xfstests on any system, just by adding the inlinecrypt mount
  option.  See e.g.
  https://lore.kernel.org/linux-block/20191031205045.GG16197@mit.edu/
  and 
  https://lore.kernel.org/linux-block/20200515170059.GA1009@sol.localdomain/

- It allows upper layers to just use blk-crypto instead of having both
  blk-crypto and non-blk-crypto code paths.  While I've been late on
  converting fscrypt to actually rely on this, it still might be a good
  idea, especially as we now need to revisit the code for reasons like
  large folio support.  (And Christoph seems to support this too -- see
  https://lore.kernel.org/linux-block/20250715062112.GC18672@lst.de/)

But, as suggested at
https://lore.kernel.org/linux-block/20250717044342.GA26995@lst.de/ it
should also be okay to reorganize things so that the regular
submit_bio() does not support the fallback, and upper layers have to
call a different function blk_crypto_fallback_submit_bio() if they want
the fallback.  I don't think that would help with the splitting issue
directly, but perhaps we could make the filesystems just not submit bios
that would need splitting by blk-crypto-fallback, which would solve the
issue.

- Eric
