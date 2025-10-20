Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF0246768;
	Mon, 20 Oct 2025 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966502; cv=none; b=BtMEVLyF7cnWnfOieRbNOfxJb1ZrGF5OqtCSOhlzLw6zIgXXFy9jsgG4CaY9qy0C3D/Jt13ytiZVAOHAP1Jn6LcWJqj/Z81AecwZflY31IPeJsJ6TdPZSeorLqmgy87/bBAZU5pRkfNx3nzYFLZzt0qK03u9a96JGy4Uw++8/RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966502; c=relaxed/simple;
	bh=IbxW4iy/ORdzRWjGHRfMUARzsy1VBtY+cCnLFG8KxE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i96nQzFVmkwPDS202HnUdw/QxGUkx8A4AdBFqhfv7qDvV2qDJ/3ZFA/EO6IDOxxZ/hLjc3VCXoK6fPuVxeyfJ7iig2163hEGgkyLIk1ufUIWdMG4+oMsPpEeNWrhdpD4UbRtgNmrtifjoTbJLcNBrNryfo/FcKhKDFvzMgLzVTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L16aJg2W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L16aJg2W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=39sFsgq/tZnDvvZj4BvMobyTdX/qSf9wpLI9lFYHekA=; b=L16aJg2WmNI2rAcPbopnWoaUep
	VhSLOWGUy8ZJEYMCXNnoO8iOkAjxG3mBNLO0bTO8H+mEM5nsRj1IiBRFmlq9uU22ZromG8gsrehmD
	3l9thEreW0aslhW2F0t+NmsW/4yNEyVs3DQikUQxxg+69RoDp8nGfbTf8KUJMztsVf2aCbHFAECjw
	VX9QtGNj1KyEYpCdoEgUk+n2QgnXuppiLau2pQVn1P9V+dZ8aA19lrTd4HGbf4s//aACZpWI+sMhq
	LsQxXmL4R8cW8vfgubXeGzQpLevbca0WEYH4fHE6LzdUWbe930b1RFuoyvW4F4RD8Xs3rlbMHSj8X
	3R8o0VAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAppQ-0000000Dldh-2QIh;
	Mon, 20 Oct 2025 13:21:36 +0000
Date: Mon, 20 Oct 2025 06:21:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-block@vger.kernel.org
Subject: Re: [GIT PULL] block-bio_iov_iter_export
Message-ID: <aPY3YKzGbIKxFbl-@infradead.org>
References: <ov54jszhism7mbeu74vtyoysxnx3y3tsjbj5esszlrx3edq77s@j2vtyy45gsna>
 <aPHemg-xpVLkiEt9@infradead.org>
 <6strysb6whhovk4rlaujravntyt2umocsjfsaxtl4jnuvjjbsp@sqf6ncn3yrlm>
 <aPYCbIrvAkOf5L3g@infradead.org>
 <lyqal3mcvjwmzoxltydw2aoyhjllwcvv5ix2axpw24kh2iotkx@lygocjo66enh>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lyqal3mcvjwmzoxltydw2aoyhjllwcvv5ix2axpw24kh2iotkx@lygocjo66enh>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 20, 2025 at 08:56:59AM -0400, Kent Overstreet wrote:
> The implementation has morphed given multipage bvecs and iov_iters, but
> otherwise it looks structurally much the same as the version I
> originally introduced.

Not a pissing context, but I introduced it.  I attributed the git
authorship you because it fundamentally it based on your idea but with a
lot of tweaks.  I and many others do this to give proper credit.

> Please attribute correctly, and that would've included CCing me on the
> patch that dropped the EXPORT_SYMBOL().

No, we don't Cc the author of each line of code or even function.  The
relevant maintainer here is Jens.

> The way you're doing it with bdev_logical_block_size() is just wrong -
> even for single device filesystems! - because it's the filesystem
> blocksize that's relevant here and that isn't necessarily going to match
> (even if it matched when the filesystem was formatted, filesystems can
> be moved to different block devices).

I'm not sure what you are talking about, but the changes you seem to
be complaining about are making the alignment boundary a caller provided
argument.  Which seems to be what you're arguing for here?  Either way
this is the wrong venue.  If you want to change something sent patches
following the usual guidelines to the maintainer.

