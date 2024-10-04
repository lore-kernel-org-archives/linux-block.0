Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE515749A;
	Fri,  4 Oct 2024 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052812; cv=none; b=i7k15noLBse274zVYiMegENIIc32SndiNZnsq96u+E4q2NUmXIu66dbRlzLwPOVM+zWfkezqGyDGLotncGTpm81jUzY+4O2i0vAzJxI3nnpkRXAv0c/uOwoRaGfl8cZ7oM7cU4P+uKkx4aBZE6p+m/Ppx2PIjE+oJyjnkJq0MSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052812; c=relaxed/simple;
	bh=LUVtOALipsNU2DgtVgDq+QV/+d3Tpj/6mOgOJ1y9ubo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyswn64/4F9FOK+pEnU3YoUJxoDJKIa+t1oPRL0374mQB+DATQYtZivscsP31exT3YxwZk4hbqYXgLapPTFC+HjEWr4LnB8b/5aHiii/vgOEgunhcxYgZaPGar/ICVXWbxxUZd1RQToAlrzMz39vqwuTHxoodavTi8b9FTTv5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+HWRNxQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+HWRNxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98BAC4CEC6;
	Fri,  4 Oct 2024 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728052812;
	bh=LUVtOALipsNU2DgtVgDq+QV/+d3Tpj/6mOgOJ1y9ubo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u+HWRNxQpfoFASzsAy3uCk+u0yfUkNv+1sEPYHGIKIkBvpLVh6Ext8hEUUlTPKLY9
	 1aMGDOPiEKVU25m1eZFbautxXyXx+58EQg6LhTmK7hpk2MrD5w09gbusnfH+yrKp8W
	 IREwUPXq7Xo/fDNqZ4qcAeDOSm9oNh42QRNKXOReyudop+XIlzFxe1hO1C/iguoFCs
	 8Uq53ZraIS1ngTf+EJAgS6DX3P+JoKYoe4D92n3STDTTKpyFB2vmRjv/0VJFEOvvqC
	 8q6VFAiCUldMDUyUAsTKB1jwk9YAqTifX7u8sOJ0k/upT2Bbhx+/zwRDv2F5clknbo
	 eR4AL9ZCNEaMw==
Date: Fri, 4 Oct 2024 08:40:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: SurajSonawane2415 <surajsonawane0215@gmail.com>, hch@infradead.org,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Explanation on Uninitialized Variable bio in blk_rq_prep_clone
Message-ID: <Zv_-SRguWC4sxWBJ@kbusch-mbp>
References: <Zv_eFIjstVns-ebG@infradead.org>
 <20241004141037.43277-1-surajsonawane0215@gmail.com>
 <6a0ec577-fba1-44b3-87d8-3a202df19d8c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a0ec577-fba1-44b3-87d8-3a202df19d8c@oracle.com>

On Fri, Oct 04, 2024 at 03:33:00PM +0100, John Garry wrote:
> On 04/10/2024 15:10, SurajSonawane2415 wrote:
> > Explaination of how bio could be used uninitialized in this function:
> > 
> > In the function blk_rq_prep_clone, the variable bio is declared but can remain uninitialized
> > if the allocation with bio_alloc_clone fails. This can lead to undefined behavior when the
> > function attempts to free bio in the error handling section using bio_put(bio).
> > By initializing bio to NULL at declaration, we ensure that the cleanup code will only
> > interact with bio if it has been successfully allocated.
> > 
> > 
> 
> What about if rq_src->bio is NULL for blk_rq_prep_clone() ->
> __rq_for_each_bio(,rq_src):
> 
> #define __rq_for_each_bio(_bio, rq)	\
> 	if ((rq->bio))			\
> 		for (_bio = (rq)->bio; _bio; _bio = _bio->bi_next)
> 
> Then I don't think bio it get init'ed. Whether this is possible (rq_src->bio
> is NULL) is another question.

If the source request doesn't have a bio, then the onstack 'bio' is
never referenced, so should be okay if it's not initialized in that
case.
