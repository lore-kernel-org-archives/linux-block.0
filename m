Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F8168BD;
	Fri, 10 May 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715360897; cv=none; b=uj3zB9LCtPuQdS2l4Vi/0oqNEiWmXn/+l62cWSloeEDIiQB3HdCRFM9uTdQszqlFu78RHDYciBfLLcIRAoOXI/J/ZtoS/61bxAFgsWBDYbtd1UfYnZFznzhpFXrOgdH9Rt2VDAZZVgnJA5X+2mbqZORcaxGpY75YJb8QoefE0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715360897; c=relaxed/simple;
	bh=FeldaRg6tINYOeoeFmz/DOcrzlUptv3ygea75vJ6kSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKnHpv9PoC5yVorbAS+T/ILOmJRokB08no39ce2e7QqpD1OcGjR2caDYkSldJKWtGyEXpf2k/7Oq/LCcuraKR28Bv8jL5yHzzwYuWyDvVSaGIdhwU7emXmDbm8Oc97HyjQEB9v63oeM53AFn+kpeulhosBNUetSkkY0RzDOn5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEM0zyJe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEM0zyJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99BFC113CC;
	Fri, 10 May 2024 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715360897;
	bh=FeldaRg6tINYOeoeFmz/DOcrzlUptv3ygea75vJ6kSY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DEM0zyJe/j8AUmcUc1mKG2HoRzTBnZ3MRLZhztcGakB5xxz+/iYXoVzymrn8tmTHi
	 Jnclldj4TFmUqzNZoZdouLKBq92Ul5hz5sXIQI5pNRzVtnHLjA+5vmGape1e6EFaOe
	 B7Xh8/aV3u9kkkjLD6RdOsjAM0EHOMO1G/RGblzTV6QcfW7KBFasH0/rc0dxDTkvYl
	 Fy3zgzYZOh7Td5qrP85zptpVf+aFPH4cj9xQuubw5pfpQV3efIeXdaxnviJFhqqkcf
	 Fm4G78nkjQY1T2db0ffZO+59EXsY1q0aJCLBzywR57Ed8AO23x4wF5wKJd86y109h2
	 w8uPMiIqN7lAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8DC36CE094C; Fri, 10 May 2024 10:08:16 -0700 (PDT)
Date: Fri, 10 May 2024 10:08:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
Message-ID: <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240510141921.883231-1-leitao@debian.org>
 <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>
 <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop>
 <d037f37a-4722-4a1d-a282-63355a97a1a1@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d037f37a-4722-4a1d-a282-63355a97a1a1@acm.org>

On Fri, May 10, 2024 at 09:20:58AM -0700, Bart Van Assche wrote:
> On 5/10/24 8:41 AM, Paul E. McKenney wrote:
> > On Fri, May 10, 2024 at 07:28:41AM -0700, Bart Van Assche wrote:
> > > On 5/10/24 07:19, Breno Leitao wrote:
> > > > diff --git a/block/blk.h b/block/blk.h
> > > > index d9f584984bc4..57a1d73a0718 100644
> > > > --- a/block/blk.h
> > > > +++ b/block/blk.h
> > > > @@ -353,7 +353,8 @@ int blk_dev_init(void);
> > > >     */
> > > >    static inline bool blk_do_io_stat(struct request *rq)
> > > >    {
> > > > -	return (rq->rq_flags & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
> > > > +	/* Disk stats reading isn’t critical, let it race */
> > > > +	return (data_race(rq->rq_flags) & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
> > > >    }
> > > >    void update_io_ticks(struct block_device *part, unsigned long now, bool end);
> > > 
> > > Why to annotate this race with data_race() instead of READ_ONCE()? Are
> > > there any cases in which it is better to use data_race() than
> > > READ_ONCE()?
> > 
> > We use this pattern quite a bit in RCU.  For example, suppose that we
> > have a variable that is accessed only under a given lock, except that it
> > is also locklessly accessed for diagnostics or statistics.  Then having
> > unmarked (normal C language) accesses under the lock and data_race()
> > for that statistics enables KCSAN to flag other (buggy) lockless accesses.
> 
> Can using data_race() instead of READ_ONCE() result in incorrect code
> generation, e.g. the compiler emitting a read twice and reading two
> different values?

It could.

And if that was a big enough problem, you might want READ_ONCE() there.
The cases in Linux-kernel RCU involve quantities that rarely change,
so even if the compiler does something counterproductive, the odds of
output being affected are low.

So why not just always use READ_ONCE() for debugging/statistical accesses?

To see that, consider a variable that is supposed to be accessed only
under a lock (aside from the debugging/statistical access).  Under RCU's
KCSAN rules, marking those debugging/statistical accesses with READ_ONCE()
would require all the updates to be marked with WRITE_ONCE().  Which would
prevent KCSAN from noticing a buggy lockless WRITE_ONCE() update of
that variable.

In contrast, if we use data_race() for the debugging/statistical accesses
and leave the normal lock-protected accesses unmarked (as normal
C-language accesses), then KCSAN will complain about buggy lockless
accesses, even if they are marked with READ_ONCE() or WRITE_ONCE().

Does that help, or am I missing your point?

							Thanx, Paul
