Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA91A171E72;
	Fri, 10 May 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355668; cv=none; b=RtkkuzSBSlIuMIpI6tchId00mFiNp1ixdEn3DWkp2RDkfJoolQpSdgDMOmycidDTxSVu19/q72LtUgQxOevMbaCsEvQPcgRLYxhmZZr/2gY/nLL+VgbdvQWh+pqsjvUHVWm7mWP7NXIzFsBkeiwlEjL3/PQFg11qU/1rX9UOkdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355668; c=relaxed/simple;
	bh=LTm7mVVSrXVQxGvjvWX4FzLddQuu5y9GagjAYFS7UnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwOKQP0F8a8dhhYYm3KR1xfjTahdhKkvY578dUTJANDkhyqWMddBm2MGlEEH/kXtoHvqx9ZxtaDUrmGynMz93Qwo5yby4lQKdM9oJBnq5lseOKLZWs7xFuqyi5MvzIzBchBrvWcsEoPxshaHEYzXbdTRckFp7ZdFAtVY591qEAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILH92WRG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILH92WRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53594C113CC;
	Fri, 10 May 2024 15:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715355668;
	bh=LTm7mVVSrXVQxGvjvWX4FzLddQuu5y9GagjAYFS7UnE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ILH92WRGpndE4x0yfGD4wnPfYZ4rTISC0GlbkmceAWhVMsME2gQOqcgf/ilW0nt+w
	 v3PgRBbqDB1BUfYWtw4vw13qLuy9/2fLBPsaEzd9sUusQNPTTnNxgc3SOBUpcbvk0w
	 n4Wqru7CY/SKzBi29lMdglgHeGz3ZcGK88QSoEv3w38yOC0VsTEVdYBeGK+YpxRE/H
	 gWeFh8QBdLUUo094YR0v+wlW6y3GKeVYYeYOhcE+e6jKMee4NpEsPyLY2Lfp/85BMB
	 lkCGIXTA+fs89uOlcmGe1j1PkK+CYgLA9DbH7XR1KGdrd80DgfkFce1b7v+8cg1Txx
	 c/ev8CR31bDKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0576BCE08A1; Fri, 10 May 2024 08:41:08 -0700 (PDT)
Date: Fri, 10 May 2024 08:41:07 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
Message-ID: <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240510141921.883231-1-leitao@debian.org>
 <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>

On Fri, May 10, 2024 at 07:28:41AM -0700, Bart Van Assche wrote:
> On 5/10/24 07:19, Breno Leitao wrote:
> > diff --git a/block/blk.h b/block/blk.h
> > index d9f584984bc4..57a1d73a0718 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -353,7 +353,8 @@ int blk_dev_init(void);
> >    */
> >   static inline bool blk_do_io_stat(struct request *rq)
> >   {
> > -	return (rq->rq_flags & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
> > +	/* Disk stats reading isn’t critical, let it race */
> > +	return (data_race(rq->rq_flags) & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
> >   }
> >   void update_io_ticks(struct block_device *part, unsigned long now, bool end);
> 
> Why to annotate this race with data_race() instead of READ_ONCE()? Are
> there any cases in which it is better to use data_race() than
> READ_ONCE()?

We use this pattern quite a bit in RCU.  For example, suppose that we
have a variable that is accessed only under a given lock, except that it
is also locklessly accessed for diagnostics or statistics.  Then having
unmarked (normal C language) accesses under the lock and data_race()
for that statistics enables KCSAN to flag other (buggy) lockless accesses.

							Thanx, Paul
