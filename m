Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC54AEE5
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750023; cv=none; b=GBiTiSHNSQJtRQb0YmPhql57+JINkLi0JICFDPtFxe0r/TDVnJX0lLq9+J0+tFuYWRRIZSdHR7QzezGORzyxLUeULA0sDTFxs11BaBtD/H0l8YLLk97eofhjIPz8m7io7FX8HXkkl8QjaRZPH86JR5jaevPPrmBcG5hTFuUnBQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750023; c=relaxed/simple;
	bh=DDQGwUFWx7g/5DR4jnNW+MysjZ5+7XeJXqWiisgFOjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBpRFFnjANItciPoQtHEqF9Xtjg5IZqMZgyc2cuc4IEtRQ11niePckMg2RRZG5GmvWSk3IEUbiKsuBZQ2uzZaZKEesCjVc+S1u01Hju7haBK9wOO0FoxNp5rdEhQ3PmSRPO9fLUxRjePmi8nEpU+dc+HrgXGuYZPGr9M3Wbjv+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Su0E9BYV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Su0E9BYV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ren387Jif9dZEaFl93O89SgQIrqlvNuSmnFzw7VJmvs=; b=Su0E9BYVyhT80lGUDQauntaSR7
	vS3tDbychtHh/h/mWRNb+HfS8jfRL0RKaOhcykdA0CbWUmank6zlPLj9hEj4ISELo/BB3ERUJXyyO
	J8N/BN7pefNN18OlUnM5EwSMPXI7kSSauJuK5t/dmH3pvqE8tqnzdfvDevjuCtQFjriM0mPZ4ZTwR
	lr61Q6C4ANACol/EcY3KHkFYW61I86KLF5bm+fFJVLOXD51nKeMPzsszJ/6UHsltZzibTa6pVWQBb
	YAFY+IyGrFc/DO/RAxdv954Av1ntQ8dzQY3g3Z8LZdE9fCEwamONp7Z10+gCAFQieEPQ79uA7tvQa
	VILIDKrw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2uoJ-00000004M8X-32fb;
	Fri, 03 May 2024 15:26:55 +0000
Date: Fri, 3 May 2024 16:26:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Kundan Kumar <kundan.kumar@samsung.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org, joshi.k@samsung.com,
	mcgrof@kernel.org, anuj20.g@samsung.com, nj.shetty@samsung.com,
	c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v2] block : add larger order folio size instead of pages
Message-ID: <ZjUCP08UyIGTzpW_@casper.infradead.org>
References: <CGME20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff@epcas5p1.samsung.com>
 <20240430175014.8276-1-kundan.kumar@samsung.com>
 <317ce09b-5fec-4ed2-b32c-d098767956d0@suse.de>
 <20240502125340.GB20610@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502125340.GB20610@lst.de>

On Thu, May 02, 2024 at 02:53:40PM +0200, Christoph Hellwig wrote:
> On Thu, May 02, 2024 at 08:45:33AM +0200, Hannes Reinecke wrote:
> >> -		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
> >> -			   fi.offset / PAGE_SIZE + 1;
> >> -		do {
> >> -			bio_release_page(bio, page++);
> >> -		} while (--nr_pages != 0);
> >> +		bio_release_page(bio, page);
> >
> > Errm. I guess you need to call 'folio_put()' here, otherwise the page 
> > reference counting will be messed up.
> 
> It shouldn't.  See the rfc patch and explanation that Keith sent in reply
> to the previous version.  But as I wrote earlier it should be a separate
> prep patch including a commit log clearly explaining the reason for it
> and how it works.

I think this is wandering into a minefield.  I'm pretty sure
it's considered valid to split the bio, and complete the two halves
independently.  Each one will put the refcounts for the pages it touches,
and if we do this early putting of references, that's going to fail.
