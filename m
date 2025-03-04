Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408125DCEC;
	Tue,  4 Mar 2025 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107198; cv=none; b=H2/WnEMq1pDaVspn/PTQrqahBSZURtYfwUAJffOI7Jxx+Zm3+y/Lh7ty0Qz9LwKEo4YFJV5cgj3+CJv3nAMKfWfvWCtuz1Lc95jB7M2jWaVi5V7zgsoId1I0PK3s/qmnj8MNlp4IZDMMI0I65zz+OLMWMTfZ5j1jzuhnknWHjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107198; c=relaxed/simple;
	bh=Fl/v7qLy82ZL3HpIHCv0KzmgjAvnTeFEYEQJIM5ngmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pd3bV3NH8wHYHLpzFQPGT93C2SWQ1omiIM8kHoIJAS1toW4zb/arNSy8/3POLmVsUTexmHB8wXe2gPUfg3+4WWEvudAAP0Fn2DMgU6Er1Fqn7xz//7vDZCLRgTF+JTBUsdWWPXKaIlqZMEBtDcTEXK61k6KfSnEn3ZhH4Zwexq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wRFv1js6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wRFv1js6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cRHPazYps1wq7KJ5C8fXLniBimphIu0da+uuMFbtb3s=; b=wRFv1js6bmgBAOVXTa8oSiVAP+
	4BZzmc0J9YF/co2jTAPij/WtgiOPXAF+05gWyH9g3EOeFWOooEAigwevLkNAbGCwJTcQYKi7OooWG
	MHkv9erbQPJxNPA6bKkBDyPT0HNl6Lj+YwIT7PFP0I5NZ+t7wGjPJ6IgVGjYSrIvLGUp0Lh9gTRu9
	Im4d9aIIE+DtMjKu+ll2pYnm9Rik1RGD7oAhEXe3nr4HZbbOtwxNMrTDn1gVyxXjT6C40tcckihZb
	MhTLCdITMBU+yOqheRkwVs9T+H2yjWs7/abkwVF3kE5GI8w8AlGi4zwK18cWM7M0xSNmF4rVrdH0G
	1RHwCWkg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpVW2-000000029No-3nl4;
	Tue, 04 Mar 2025 16:53:10 +0000
Date: Tue, 4 Mar 2025 16:53:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Kernel oops with 6.14 when enabling TLS
Message-ID: <Z8cv9VKka2KBnBKV@casper.infradead.org>
References: <15be2446-f096-45b9-aaf3-b371a694049d@suse.com>
 <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
 <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
 <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
 <Z8cm5bVJsbskj4kC@casper.infradead.org>
 <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>

On Tue, Mar 04, 2025 at 05:32:32PM +0100, Hannes Reinecke wrote:
> On 3/4/25 17:14, Matthew Wilcox wrote:
> > I thought we'd done all the work needed to get rid of these pointless
> > refcount bumps.  Turns out that's only on the block side (eg commit
> > e4cc64657bec).  So what does networking need in order to understand
> > that some iovecs do not need to mess with the refcount?
> 
> The network stack needs to get hold of the page while transmission is
> ongoing, as there is potentially rather deep queueing involved,
> requiring several calls to sendmsg() and friends before the page is finally
> transmitted. And maybe some post-processing (checksums,
> digests, you name it), too, all of which require the page to be there.
> 
> It's all so jumbled up ... personally, I would _love_ to do away with
> __iov_iter_get_pages_alloc(). Allocating a page array? Seriously?
> 
> And the problem with that is that it's always takes a page(!) reference,
> completely oblivious to the fact whether you even _can_ take a page
> reference (eg for tail pages); we've hit this problem several times now
> (check for sendpage_ok() ...).

Calling get_page() / put_page() on a tail page is fine -- that just
redirects to the head page.  But calling it on a slab never made any
sense; at best it gets you the equivalent of TYPESAFE_BY_RCU -- that is,
the object can be freed and reallocated, but the underlying slab will
not be reallocated to some other purpose.

> But that's not the real issue; real issue is that the page reference is
> taken down in the very bowels of __iov_iter_get_pages_alloc(), but needs
> to be undone by the _caller_. Who might (or might not) have an idea
> that he needs to drop the reference here.
> That's why there is no straightforward conversion; you need to audit
> each and every caller and try to find out where the page reference (if any)
> is dropped.
> Bah.
> 
> Can't we (at the very least) leave it to the caller of
> __iov_iter_get_pages() to get a page reference (he has access to the page
> array, after all ...)? That would make the interface slightly
> better, and it'll be far more obvious to the caller what needs
> to be done.

Right, that's what happened in the block layer.  We mark the bio with
BIO_PAGE_PINNED if the pincount needs to be dropped.  As a transitional
period, we had BIO_PAGE_REFFED which indicated that the page refcount
needed to be dropped.  Perhaps there's something similar that network
could be doing.
