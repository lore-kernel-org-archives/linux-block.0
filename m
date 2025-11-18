Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16B2D8766
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 05:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763445277; cv=none; b=TzAw+fM5OpCL6AzHGRR7iQ+u61Gi0VPCX0xVXFJRYK0NDR2J75aj6/kPL8Jj8h/WI2r94VH/6iLUtJ7OUsd43GnNlj33wi/LezNOlGBPA1iEbv5xjIPdpTTRXyb3kSHVwQ2DX//wNg2m+emBGpRi8WbM8mAZSUFK9q5qz8V7DYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763445277; c=relaxed/simple;
	bh=ooXzNww8N1xswd7Cimv1CqSVZ7srtW07tLEVp821wM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsEvcJGxnEa8oaTVjZscuVb6dvlWzl6PV7USgwSTnNaOL68u93cAXTSIOOaXNPIdHZ0DGQ+mmMW9OQOt+2I7whu6gtCe25xQooUTy9j7JBsxK+5GIxfBDqphye2TI2yRpGfiNeCN6L5vi2ldG5A1yo4sHD1HK+RFXyks3N9zeCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UFSQJw+t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UFSQJw+t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OawlVXwphR6hIAr5wfhp6tps3i+oxAiVjF6JbfroI7M=; b=UFSQJw+tm3Lf1Pio57wJN7uqrb
	58L1cJuqBAz0VNwDUt08dUfI8EmuOV6mhEmB6ml/Zqf/m5nYo4onZHelroVnL2IeZTrBQSlhdXIE/
	s88dW8E90z+EB/uQj38VZTXwZ8TFoWyaMJIHE8Wx2E90cex7/q5RGu4b3DQZDu8SaTB/P6E4LIEZO
	zC3q8s/mkH9OvSv6nL/Irjaufk/jCx6rtfn5yUrm4ZIUyMemGk8Hy2iUJfmBrVFbVp7L+l7H3H1Rm
	8EowM0d9ULod+DA/UWkKUblr57Y9gsw971xJtl4TomiojqWxY7H0FlOOXowfLyQCkvuRYv/wImr35
	mVN0uAKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLEfi-0000000HS4S-3cFQ;
	Tue, 18 Nov 2025 05:54:34 +0000
Date: Mon, 17 Nov 2025 21:54:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH blktests] create a test for direct io offsets
Message-ID: <aRwKGvo0CDBR86bo@infradead.org>
References: <20251014205420.941424-1-kbusch@meta.com>
 <aPIk3Ng8JXs-3Pye@infradead.org>
 <aPZhWIokZf0K-Ma9@kbusch-mbp>
 <aPcZ6ZnAGVwgK1DO@infradead.org>
 <aPf5gAOlnJtVUV6E@kbusch-mbp>
 <aPhhpohu8mc95oLp@infradead.org>
 <aRuZbTBUNu8oTbty@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRuZbTBUNu8oTbty@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 17, 2025 at 02:53:49PM -0700, Keith Busch wrote:
> On Tue, Oct 21, 2025 at 09:46:30PM -0700, Christoph Hellwig wrote:
> > On Tue, Oct 21, 2025 at 03:22:08PM -0600, Keith Busch wrote:
> > > On Mon, Oct 20, 2025 at 10:28:09PM -0700, Christoph Hellwig wrote:
> > > > seems like a huge win.  Any chance you could try to get this done ASAP
> > > > so that we could make the interface fully discoverable before 6.18 is
> > > > released?
> > > 
> > > I just want to make sure I am aligned to what you have in mind. Is this
> > > something like this what you're looking for? This reports the kernel's
> > > ability to handle a dio with memory that is discontiguous for a single
> > > device "sector", and reports the virtual gap requirements.
> > 
> > So, I think Christian really did not want more random stuff in statx,
> > which would lead to using fsxattr instead.
> 
> I haven't forgotten about this. I was hoping I would make sense of the
> request. It looks like only xfs makes use of fsxattr (it's the only one
> that calls copy_fsxattr_to_user()). Is the intention that every
> filesystem needs to implement support for fsxattr then?

In addition to XFS, the generic ioctl_fsgetxattr, which is directly
weird up to FS_IOC_FSGETXATTR processing uses it, XFS only has it
because it has a special version of that for xattrs.

->fileattr_get is already implemented by most file systems, so
FS_IOC_FSGETXATTR works widely.
