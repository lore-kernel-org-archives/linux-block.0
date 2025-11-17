Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5534D34B677
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763416434; cv=none; b=d/xS48thSVLT7gdrAdqay4i6qy8yQWCTefC8f/4qTo9jahiVVVGi1OAHAOz3drJTFr7jJHKT/SfiwX0CMoQFBIEQhYKq8/2r/4g44lcnOB4I15SCWLSmiTvbSlzmWBOoGPN4SlcSKGLJD4ixDAUoLiRug8nRQSNkdlQh2W/XUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763416434; c=relaxed/simple;
	bh=OOioz2QC0qKKWQUl7T4wEoM1SacEhPbVhdPhgwWmV/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SanZFyixizJbFe5ZmLAr1DiN+OK+opEVnN4Kh3f4aJPgm6Cx3pKXvYBjTBlz7ejzzN0qkv67g9L93GqkC/sWJMBI5ZBM+LboikfbZoJzvWW3GIftUajJWsdFdxzDQ49omux23/Udev5JMqZaOJcOUTdGCVpKYjVQVctqp/j3oSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKmv6J/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKmv6J/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57752C19425;
	Mon, 17 Nov 2025 21:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763416432;
	bh=OOioz2QC0qKKWQUl7T4wEoM1SacEhPbVhdPhgwWmV/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKmv6J/teRXp8Emc1uoQqfFcDCO+QvxqQkiYOwJrthnebl1W8YYTbdjM0kR+w+v8v
	 mXkAsli8IU9RNkjGPL5HILdTAEtPxlEbIIvM1OjQqvv5PYcrUlgS3KImhEOXv+xnyQ
	 17lyHtDv0lFrX/kxMAhhnK/g0T2vAcw9cRiDeIWAWRDluYdFvTWg1RqRZZFe6PEL4H
	 bxlSUNDGArF1t4m1MV066Ztawjey3c0CuAlhj0ax25iguuP/kER3V1ayJBXh0A4Eat
	 tFY33YxpN370ZHu7muYDJqW39EJqSwf0Eob284xm11ag48yRohimnx9VLPqgFajcQJ
	 56V8HP2FmgJww==
Date: Mon, 17 Nov 2025 14:53:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH blktests] create a test for direct io offsets
Message-ID: <aRuZbTBUNu8oTbty@kbusch-mbp>
References: <20251014205420.941424-1-kbusch@meta.com>
 <aPIk3Ng8JXs-3Pye@infradead.org>
 <aPZhWIokZf0K-Ma9@kbusch-mbp>
 <aPcZ6ZnAGVwgK1DO@infradead.org>
 <aPf5gAOlnJtVUV6E@kbusch-mbp>
 <aPhhpohu8mc95oLp@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPhhpohu8mc95oLp@infradead.org>

On Tue, Oct 21, 2025 at 09:46:30PM -0700, Christoph Hellwig wrote:
> On Tue, Oct 21, 2025 at 03:22:08PM -0600, Keith Busch wrote:
> > On Mon, Oct 20, 2025 at 10:28:09PM -0700, Christoph Hellwig wrote:
> > > seems like a huge win.  Any chance you could try to get this done ASAP
> > > so that we could make the interface fully discoverable before 6.18 is
> > > released?
> > 
> > I just want to make sure I am aligned to what you have in mind. Is this
> > something like this what you're looking for? This reports the kernel's
> > ability to handle a dio with memory that is discontiguous for a single
> > device "sector", and reports the virtual gap requirements.
> 
> So, I think Christian really did not want more random stuff in statx,
> which would lead to using fsxattr instead.

I haven't forgotten about this. I was hoping I would make sense of the
request. It looks like only xfs makes use of fsxattr (it's the only one
that calls copy_fsxattr_to_user()). Is the intention that every
filesystem needs to implement support for fsxattr then?
