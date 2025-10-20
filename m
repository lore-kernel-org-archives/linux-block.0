Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BCF1D6187
	for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971809; cv=none; b=Ew4IHqOAPaaQjBGTrVMvGwPi31Eega+/JR6B5nSxY3q1FIH/pZIMKF2csRu/REnx5odD8ApQ297zBb9uZaTF/vEzgh3HEHjnJWb03LIafT1VZVmopV5hir6Xin8tprZjyKiSUeLT3/r0Q7NKVPQHciHsEEs2dKyU/neQ3C4TgdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971809; c=relaxed/simple;
	bh=RWFKsywEpSud+qRUcHNQb5+B3pin/IiJfu78fXrVZwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ5O26i8XX24W9QfGPBXOZkZK6wcbYx8K73Fy5IFd1ISg74Hf5KhO/SZqLgEkiZW70pALEOmntphkQaXLUEyV5uYy7WE1vJMCJUuggcZ14NULEeBUjBuHhfYHea/tTULUIUwh7BDTyqX12dztxsslA7nkhFTkaeuzkjGMAgtDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gjJsgzcv; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gjJsgzcv"
Date: Mon, 20 Oct 2025 10:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760971801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Zeg/dM55COfEhiKccXsh3omWVQ8ClpYXf2/Teku+Sw=;
	b=gjJsgzcvyQbpg+W903bhkBLVmb6KKGRsxmTzZWA6HLnQmayj3NxMe7AKvx0x/IopgQggx3
	IeRjJ4up/BEly7lD1z3l6y6Kbh75qgQvcq1Rc5nyCZFLL/glKW/TXfUoWjNYxedqh4n9ON
	sjPrNrnyePPeDngbQ9KoFjrCM6/bmeU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org
Subject: Re: [GIT PULL] block-bio_iov_iter_export
Message-ID: <wrcaluw3pxx65tgznv5z3td3xb2tdf6rwucze5sy7bqrutj4jp@srde54eo3iyz>
References: <ov54jszhism7mbeu74vtyoysxnx3y3tsjbj5esszlrx3edq77s@j2vtyy45gsna>
 <aPHemg-xpVLkiEt9@infradead.org>
 <6strysb6whhovk4rlaujravntyt2umocsjfsaxtl4jnuvjjbsp@sqf6ncn3yrlm>
 <aPYCbIrvAkOf5L3g@infradead.org>
 <lyqal3mcvjwmzoxltydw2aoyhjllwcvv5ix2axpw24kh2iotkx@lygocjo66enh>
 <aPY3YKzGbIKxFbl-@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPY3YKzGbIKxFbl-@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 20, 2025 at 06:21:36AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 08:56:59AM -0400, Kent Overstreet wrote:
> > The implementation has morphed given multipage bvecs and iov_iters, but
> > otherwise it looks structurally much the same as the version I
> > originally introduced.
> 
> Not a pissing context, but I introduced it.  I attributed the git
> authorship you because it fundamentally it based on your idea but with a
> lot of tweaks.  I and many others do this to give proper credit.

Christoph, I don't know what you're claiming here. I see no tweaks in
the original patch, that's all code I wrote.

> > Please attribute correctly, and that would've included CCing me on the
> > patch that dropped the EXPORT_SYMBOL().
> 
> No, we don't Cc the author of each line of code or even function.  The
> relevant maintainer here is Jens.

I always try to CC people with relevant expertise, and that _definitely_
includes the person who authored the code being changed.

And considering the multiple times I've had to track down bugs you and
Jens introduced into code I wrote without CCing me...

> > The way you're doing it with bdev_logical_block_size() is just wrong -
> > even for single device filesystems! - because it's the filesystem
> > blocksize that's relevant here and that isn't necessarily going to match
> > (even if it matched when the filesystem was formatted, filesystems can
> > be moved to different block devices).
> 
> I'm not sure what you are talking about, but the changes you seem to
> be complaining about are making the alignment boundary a caller provided
> argument.  Which seems to be what you're arguing for here?

You brought up the bdev NULL check.

> Either way this is the wrong venue.  If you want to change something
> sent patches following the usual guidelines to the maintainer.

There was no need for you to drop the EXPORT_SYMBOL.

What I want to know is, is this going to become a pattern?

I can vendorize this one function, but If you're going to make a habit
of ripping out exports and functionality bcachefs depends on, I can't
expect I'll always be able to. There's open bug on the bcachefs bug
tracker for 6.18 support, and people are just patching the kernel to
deal with this. I'll just pass the bcachefs enablement patches to the
distros if it looks like that's going to be less of a hassle.

With the lib/Kconfig patch to make library code user selectable that you
also nacked, perhaps that's the safer route here.
