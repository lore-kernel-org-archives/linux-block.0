Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7B2A1CF;
	Mon, 20 Oct 2025 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952946; cv=none; b=hepvYelpjPu7By11zmBq74K9Ua9OdGqTEsnH4J86H06MD1JalrmYuuMTcILdIY6jA0kVSe7GK+AiiaTQqDHgtiUCZ56FWjNMGntVVm3dgKxYjizsrwvG4AO8eeLUAbXVwLrkDlA9bYYbSJzHN368FDMmxaac0d3kS5/i9yzQ6/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952946; c=relaxed/simple;
	bh=2IAIt2SUCUhxcb807Lyj3JXjSDC9/iTXJyvqnAzZGRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJfK9DTViKgGnnyMvd1T2HYQttRldiWaI6JxLzN0NFGhltHER4ZjJ1OM1nHC5hPCMiwLaTqRdQ0YQX6MPpPVYa6riMg/rLNo3hLPIPTveWHw9OJIorth6WmomlyVV87iX/bwY2U0Is4TUj0fy57K9X3idb1PO3RFqICk4vdc04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kvWulCzv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kvWulCzv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ln38FfARN4Gj/ksc4kfm6PLlv2NAm9fTW6k7Agq3IS0=; b=kvWulCzvyx0Ps/sMfHZZj+byCC
	cu0YRjydzqAiw6m00rt624KHTY1G8Lf/3giE3ms7WHwf8cUKA3qpGjPX6LEKAtq5JqQXaA42Sxtae
	QcyHUkg/2+hlM9a+bpai/Irs4UPGHnpP+hwIwKdD2Qds+IR4bgQXNdB4GV5DrDT0kMHnMCMtzT9VK
	wSDpUUuYFB6ZGerWWRvGu9rioEi05/ZAeK7IhEKVu1Gvwai2qySksbq3Y5sGLmi58mFg1H29x3tvQ
	Qu7Yp6laPe/AFlBhh8qJQCpRHiVziqXEnh3ykjKUSCMwrWb1ewV/v61Tcd9VL5KURr6K8XI2v0MFQ
	SfuQRsoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAmIm-0000000Cbrq-2iTO;
	Mon, 20 Oct 2025 09:35:40 +0000
Date: Mon, 20 Oct 2025 02:35:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-block@vger.kernel.org
Subject: Re: [GIT PULL] block-bio_iov_iter_export
Message-ID: <aPYCbIrvAkOf5L3g@infradead.org>
References: <ov54jszhism7mbeu74vtyoysxnx3y3tsjbj5esszlrx3edq77s@j2vtyy45gsna>
 <aPHemg-xpVLkiEt9@infradead.org>
 <6strysb6whhovk4rlaujravntyt2umocsjfsaxtl4jnuvjjbsp@sqf6ncn3yrlm>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6strysb6whhovk4rlaujravntyt2umocsjfsaxtl4jnuvjjbsp@sqf6ncn3yrlm>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 17, 2025 at 09:31:59AM -0400, Kent Overstreet wrote:
> On Thu, Oct 16, 2025 at 11:13:46PM -0700, Christoph Hellwig wrote:
> > Umm,
> > 
> > besides adding exports without in-tree users, this is a patch that's
> > never seen any relevant mailing list, in a pull request that the
> > maintainer hasn't seen.  That's now exactly how Linux development works,
> > does it?
> 
> Christoph, I wrote that code /for bcachefs/; the rest of you decided it
> was nice and started using it too.

In fact this version was written by me, giving you the attribution
because I stole a cool idea from you.  But none of this actually
matters, there's not magic exception just because someone wrote the
code.

> Then you removed the export talking about the "abuse" of bcachefs using
> it. WTF?

The random NULL bdev check that breaks the proper splitting.  We told
told you that's not the way to go, but you just sent it directly to Linus
instead of reworking it.  And this then got into the way of the rework
Keith did to support arbitrarily small memory alignments.  Fortunately
we could clean this up properly now.
