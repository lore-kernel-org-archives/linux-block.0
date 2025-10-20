Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD7225397;
	Mon, 20 Oct 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972047; cv=none; b=JqYyNhQBNHrXN3z1fjDaTZSmoAT77zTWUQzVRay9vBXW0qswXB7OQ+f12wPuJEmPadqGgXLOIj7MC2/nshPqqw5Dx8WJAVt9GUBzQJC6vhGYFPmDdT43GquBNR36/2QT2JTo2tHQq1JiZFVyekeCzpLvwzjniqKJ63CyCYWVDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972047; c=relaxed/simple;
	bh=FUJglCsEiJPmSTmX6lbsxypqHcM2t510unTNEvRevy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNF9H4V0VGck2XdRYYcGHSwyMbhvzdEaGbRkhZZM97qtK77H6wfcptmMVZ9NhX605nj5Ps2n0ZoYoKWNw2ToCNHd6f9ZtLx+ILMQS+CIbp/ecdzlxU+zSukjceyiKb3JkKl7REt2Qs940mGFozi5QBIuRTn1yvY3JBRw8hsA8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w09nRaEK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w09nRaEK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ykQNRL19NsE0PMhAZcAcgnbmKxbkt0YndoWKR1pRfc0=; b=w09nRaEKQYFPG4v18TOVgFBD7W
	e/mKrodgh0LQLe3oTJSZ6pkLe1prWOrj4VSjCbsBh6bJK+5ucT1B5FJUKQVoOjgu5uhmAnRGl6Tld
	XvoUEalGr+Wt8JIJjypGWlk0m7MQj05jPXYXYS0gNyAT0iQqDUfXixr5T5rkbw8pqWbKfvq3wbpZD
	ujWKffJgf3STcG2AY0rG8lw8sUvCCbh9ONRYr7bhbUYL1ce3kmKZYv5LXZfgVsU+zIP36ilB87eOU
	dx6faZl3GCWVU3ajm7dCmB3m5Y+8CTiopAKC2Hzb1tcFrhJjHamQBEoEBE9ucKx+fuHvp3taLhbnn
	DVbYK6/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vArGt-0000000E1PY-3LYw;
	Mon, 20 Oct 2025 14:54:03 +0000
Date: Mon, 20 Oct 2025 07:54:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-block@vger.kernel.org
Subject: Re: [GIT PULL] block-bio_iov_iter_export
Message-ID: <aPZNC8bKIzRmFJ21@infradead.org>
References: <ov54jszhism7mbeu74vtyoysxnx3y3tsjbj5esszlrx3edq77s@j2vtyy45gsna>
 <aPHemg-xpVLkiEt9@infradead.org>
 <6strysb6whhovk4rlaujravntyt2umocsjfsaxtl4jnuvjjbsp@sqf6ncn3yrlm>
 <aPYCbIrvAkOf5L3g@infradead.org>
 <lyqal3mcvjwmzoxltydw2aoyhjllwcvv5ix2axpw24kh2iotkx@lygocjo66enh>
 <aPY3YKzGbIKxFbl-@infradead.org>
 <wrcaluw3pxx65tgznv5z3td3xb2tdf6rwucze5sy7bqrutj4jp@srde54eo3iyz>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrcaluw3pxx65tgznv5z3td3xb2tdf6rwucze5sy7bqrutj4jp@srde54eo3iyz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 20, 2025 at 10:49:57AM -0400, Kent Overstreet wrote:
> Christoph, I don't know what you're claiming here. I see no tweaks in
> the original patch, that's all code I wrote.

Then look closer.

> There was no need for you to drop the EXPORT_SYMBOL.
> What I want to know is, is this going to become a pattern?

Of course there was.  The kernel doesn't keep unused code around,
including symbols.  So anything that is unused will eventually be
garbage collected.  There's even folks around that run scripts and
automate it (David Alan Gilbert is the most active one currently).

> I can vendorize this one function, but If you're going to make a habit
> of ripping out exports and functionality bcachefs depends on, I can't
> expect I'll always be able to.

I'm not sure why you're turning this personal and singling me out.
Yes, unused exports and code are removed all the time, and that's a
feature and not a bug.

