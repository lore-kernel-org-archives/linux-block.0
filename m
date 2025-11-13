Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EE23148CE
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763065266; cv=none; b=hxESCO6wgI2A4fTAwpwoU37q5cwTREHWbmWo87DOg+LKTeXhwH6mbTDYnW1W/IndITeKCyLCa1k3fPVCYDauvLZHlMOsod0tVu42fz/kCnWXFq/KthylJ4KMgGUh16R7IR5Vib6fNTgaBX+L5fmMYmCfecQogLUg1wp4VSHJU/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763065266; c=relaxed/simple;
	bh=02V4JfOnzdMAA0dJ16sclnatpneh3FN3MXFY2aEDE4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtXRVQUGVUKdBIIEETQiVRFsG9Wo6XsBp4IRRJToyJWq779uu/XEeXeCT7lWZnkjKlqY2SYodhgRolIDhdoTvZItmdd9GOirSCFwY/vzVtl97IspR94UzvGhWLrhcFzzq+xYNenaZQY7Yn1MTWoIYEaojd+Bwg1olejue8Onmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUanHa0R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUanHa0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E2FC4CEF7;
	Thu, 13 Nov 2025 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763065265;
	bh=02V4JfOnzdMAA0dJ16sclnatpneh3FN3MXFY2aEDE4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUanHa0RdNCojm4/C2G8QIUZsOKED9qU8tBSF3pdrsX6QF6iA3xpaFOD/MAtqStvb
	 GUOi5kKB6RJTWDKiV+E074KYUEevjaXJr9Ul/hvwWq2eIZP9S48nBwCEEsaOnsVY2v
	 zo4IP7YJIOXaKOnIcZ//aVUf5cFOeb3r/FGHXaEXjtJcIWhonpvlIKqtNykvx+7OsA
	 GTAYt4bqinwTG/Wutpyi74QtzOj24GapOERFzk2Y4H+AjOtzFqCjJ7yXxQkqATgwxE
	 6Z4lUz9zUtmdpDB+nsHPZuYNahtPOAUAXtsVdgheUYcwsMs8o76RjVqu03QluDtHqu
	 eTkN3CY2nKXew==
Date: Thu, 13 Nov 2025 20:21:03 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4] blk-integrity: support arbitrary buffer alignment
Message-ID: <20251113202103.GC3971299@google.com>
References: <20251113152621.2183637-1-kbusch@meta.com>
 <20251113173135.GD1792@sol>
 <aRYf9S-UuJqa37fi@kbusch-mbp>
 <20251113192022.GA3971299@google.com>
 <aRY2G6xEgEVqLBgb@kbusch-mbp>
 <20251113200237.GB3971299@google.com>
 <aRY7jDVt2jpLCWoO@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRY7jDVt2jpLCWoO@kbusch-mbp>

On Thu, Nov 13, 2025 at 03:11:56PM -0500, Keith Busch wrote:
> On Thu, Nov 13, 2025 at 08:02:37PM +0000, Eric Biggers wrote:
> > On Thu, Nov 13, 2025 at 02:48:43PM -0500, Keith Busch wrote:
> > > Like on real hardware? I'm a bit at a loss as to how, I've never seen
> > > anything subscribe to this format, not even in emulation. The only thing
> > > I can readily do to test this is run random data through the old code,
> > > print the result, then run the same data through the new code and see if
> > > they're the same. That test is successful. Not good enough?
> > 
> > ip_compute_csum() returns a folded 16-bit checksum, whereas
> > csum_partial() returns an unfolded 32-bit checksum.
> 
> Sorry, I must be missing something. do_csum() returns an unfolded 32-bit
> result

Nope.  It returns a folded 16-bit result.

> In any case, I find that running any random data through it at block
> interval lengths (4k or 512b) is always producing results that fit in 16
> bits anyway, so maybe that's why it appears to be working?

Your kernel build may be using the generic csum_partial(), which folds
the checksum more frequently than the x86 one (and maybe some of the
other arch-optimized implementations too).  Try the x86 one.

- Eric
