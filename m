Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B4837FF76;
	Wed, 27 May 2026 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897253; cv=none; b=dj48/75M2cCtif1y0//bLMI0N2O4B4nhuNOgJTyiyTyY31RfGkW9kFlsWV4i8DK0oghNR3y/FXIEe6EJ4LFTKTuJ4tVl7IFChPg9zSMZSeLkgtiiacfvjsQRhZH+ZNyReVgeH+t96+l/zb+zW4L6vMRbkCFuRVhwpBgj2FqUF9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897253; c=relaxed/simple;
	bh=mJSO9kqJwmefLIxtJiE7S3g75xzYcCRkbAVvq/3EaWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0QFEtphmxuc1aqS9azOSkOGFc/LEUVDySW8ODaPbhLzxoP8EJXVyEj7U6vF8RdiCU2kJfT6ERhP8IMYLINF2Ul+RbQcFflGvoRHIOzVEH65FQ+xLw+50DpaUbIH0Tte/NfHSjQJLKVPEe1eRLvFG5/f9vgCbwNBky455LDsfbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mvzMjij3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mvzMjij3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r3kGopIcRkfvszZsA1EUPYixmwDaQOtICWsDPOe8I0o=; b=mvzMjij3hvAena8FUDu7i/An8i
	Hu1eU+qPGpk+KN69un2RqCY6ynnqD/2F6M9QVhjezGyAMrJx/wdlz8wt54HdgxPSSAkfBwB14FY3s
	qTZHOtLeakW785KrN4qJn6cvwr03hSqJvOkbHTML6+WLBbBNx5dZ3gH3lNF4aSz2qSwBp0Qg/nPFL
	Bu4tx9SBGf17DPG2SToycs773UlYDBv2wbjjUo4dX30QS8y/nawiK+iqloWG8nB+Ia/SdGHPjg+M3
	7+iHzYuRReuZ1peI4KDzTOMOmRXwWNkL5zGBmX1Nndy06qsRfeRrL1f5eOsKifn6NSQIn5a/0DR70
	njE9hAcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSGa5-00000002unM-1n4L;
	Wed, 27 May 2026 15:54:05 +0000
Date: Wed, 27 May 2026 16:54:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-mm@kvack.org, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] block: Add bvec_folio()
Message-ID: <ahcTnfk_SjbN7J9e@casper.infradead.org>
References: <20260522182122.2489391-1-willy@infradead.org>
 <ahPm4h2gKgyEEuvV@infradead.org>
 <ahROtyLcr567wM8l@casper.infradead.org>
 <ahVBCtsodsM2FHis@infradead.org>
 <ahXcsrxUFfzoVCOr@casper.infradead.org>
 <ahaNpbG15d6StT9d@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahaNpbG15d6StT9d@infradead.org>

On Tue, May 26, 2026 at 11:22:29PM -0700, Christoph Hellwig wrote:
> On Tue, May 26, 2026 at 06:47:30PM +0100, Matthew Wilcox wrote:
> > How about:
> > 
> > /**
> >  * bvec_folio - Return the first folio referenced by this bvec
> >  * @bv: bvec to access
> >  *
> >  * bvecs can contain non-folio memory, so this should only be called by
> >  * the creator of the bvec; drivers have no business looking at the owner
> >  * of the memory.  It may not even be the right interface for the caller
> >  * to use as bvecs can span multiple folios.  You may be better off using
> >  * something like bio_for_each_folio_all() which iterates over all folios.
> >  */
> 
> Sounds good, although I'd captialize the first word in the sentence.
> (Not that anyone should follow my spelling advice in general)

I don't know how to capitalise bvec.  Is it Bvec?  BVec?

Fortunately my wife is an expert, and many years ago taught me that if
you have a difficult grammar problem, don't fix it, avoid it.

 * A bvec can contain non-folio memory, so this should only be called by
