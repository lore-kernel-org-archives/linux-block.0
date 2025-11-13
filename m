Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C22877F2
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064719; cv=none; b=RRRHzQBE6jReSc2Cl320NKA79AFzlzMPpncCjbCUFt0H33AfO2YNcOPW2zHM8nK8xDY6EVvlPlgcOtb9eerwhusIA0Ht0edvZLcWq2mxoejlSCZHkZoG2shGQ+cZh3csgnK8g1XGSX/QeKu+nqK1B8weXsf768SFZmWFu0B3c08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064719; c=relaxed/simple;
	bh=/6DiuuNcXBrnQcasTuL9igczjfwcVu+CLYS0dFw0qjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jneoqIrX/G6xpztba4T0tXZ5C1y+T1+z/rwgKVXIaIGaEBq5st7mJQ+MHw8WjnSJNi4KnV/63/ZZMsg4Xyr/Pc2AtNA3F+z0IooGpsucVcDENrAzqLzVyQE7hkyaJl+4BIrIdkWjtwA2hyf3AeWXZFyPMZtrDIpihRH2hz474ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGfmAaPx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGfmAaPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61429C4CEF7;
	Thu, 13 Nov 2025 20:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763064719;
	bh=/6DiuuNcXBrnQcasTuL9igczjfwcVu+CLYS0dFw0qjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGfmAaPxzGwSX5PwuPqpPppw+dIPZugi1SzohE40l79FJKZ3SWd6ZwpSMzUw5Mpnc
	 osijFyVCF/LX3AyKZOm2aG+SFZqXpMyAouyXoxs5mYJS8/dfF3sMoM3pBtWEuHBM3A
	 JXosa59KXQl1D1Kt5Jxd3/rwApBUdt1p1+Vc1US1eCWugVwyqxzLmg9c+wt1p52aTp
	 qnD+3xKt5Z2LrRtdS+xCrThkW1cKT2JTT05Xtm+HLEm+aSLZ4dASj+T3rABLY9CcGV
	 wZuhex2aYCI/aJCqUZNPwJdgSwB0lioFVZuti4//ix7aR7Uoh+MkLf8G033lRV72Os
	 qYRdUC4HOtxBQ==
Date: Thu, 13 Nov 2025 15:11:56 -0500
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4] blk-integrity: support arbitrary buffer alignment
Message-ID: <aRY7jDVt2jpLCWoO@kbusch-mbp>
References: <20251113152621.2183637-1-kbusch@meta.com>
 <20251113173135.GD1792@sol>
 <aRYf9S-UuJqa37fi@kbusch-mbp>
 <20251113192022.GA3971299@google.com>
 <aRY2G6xEgEVqLBgb@kbusch-mbp>
 <20251113200237.GB3971299@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113200237.GB3971299@google.com>

On Thu, Nov 13, 2025 at 08:02:37PM +0000, Eric Biggers wrote:
> On Thu, Nov 13, 2025 at 02:48:43PM -0500, Keith Busch wrote:
> > Like on real hardware? I'm a bit at a loss as to how, I've never seen
> > anything subscribe to this format, not even in emulation. The only thing
> > I can readily do to test this is run random data through the old code,
> > print the result, then run the same data through the new code and see if
> > they're the same. That test is successful. Not good enough?
> 
> ip_compute_csum() returns a folded 16-bit checksum, whereas
> csum_partial() returns an unfolded 32-bit checksum.

Sorry, I must be missing something. do_csum() returns an unfolded 32-bit
result, and it is just getting down cast to a 16-bit result. Where does
the folding happen?

__sum16 ip_compute_csum(const void *buff, int len)
{
        return (__force __sum16)~do_csum(buff, len);
}

In any case, I find that running any random data through it at block
interval lengths (4k or 512b) is always producing results that fit in 16
bits anyway, so maybe that's why it appears to be working?

> I don't see how the
> checksums can be the same as before.  Hence my concern about whether
> this was tested.  It could be with hardware, an emulator, or a unit
> test.

Martin pointed to a good in-kernel debug module that can do it.  I'll
set a test up with that.
