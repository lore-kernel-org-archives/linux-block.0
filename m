Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9EE433CB
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737996973; cv=none; b=tumUj89p6ws1t2hXKAIgvbvDGYBnalNAehJDAlxR8kaffZUK848lEcXhNtKwefFiTINS8+USHjrDe5/F5TJS1l1AbMQzZWtpY38eF1gyIe7mg2bblvbyE7JfjG6NPYn6B8D6P7ds5iWXTFq0PAmAEjhzWogxY4myL4dV4oDB8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737996973; c=relaxed/simple;
	bh=Uea695+hgXefabi04BAaIGX/jFULstr2RuV81+JXuEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASUf60Ss/l5lMRlJWx27Jny1nEntBORY+JuxMM+zeMIKIPaVUjP0lIicXVh9O3jN5It7m/LR8ceUBIPreslIzd1BzIYauwM4FeytAoEZmriDQ99+RW+6PCqHGAmxBmmCIZFH9RVv6KIuH2Z3lHDOkGcHFn4IDyY5NrIFmhh/+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=trEJLPBQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="trEJLPBQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XY1ZfVc8WmomcNIooSDhWek/rzvPOimXm1nFYmDzRBQ=; b=trEJLPBQ9BS8VeeidK2KU4Rb0O
	IImqYNuNIJRIcpu1g8ntmGDT9C9YJ85XCGSrqNPXjbu0hnmlrrCdPxPKMQ2uQ25xk9InUPy7gsdez
	M1Gz4Wn/Dwr60mUo0YRTdY4OJ8+VIQTk60ZAcTOTMPZByRjlHfETkz3AzPTy6lbqyuFXtbXl2Xuzs
	i/9J3ATg6Q3KzJBeYAvKySA+MpuLa9lYrC2pEIQJjt3urnJ13OC0ogl84iMQODU20dohZzB6vj+w4
	HzsW4RWkI9keKF236bsRe8OG07zautcoTeytNaY9I1BebdLYcH6snTE7IqNWAqE97S26NOJJa3NZo
	tkIoZF1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcSP9-00000009fxz-44xx;
	Mon, 27 Jan 2025 16:56:08 +0000
Date: Mon, 27 Jan 2025 16:56:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>, Jane Chu <jane.chu@oracle.com>,
	Andres Freund <andres@anarazel.de>
Subject: Re: Direct I/O performance problems with 1GB pages
Message-ID: <Z5e6p4itt-g5Ys97@casper.infradead.org>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>
 <Z5euIf-OvrE1suWH@casper.infradead.org>
 <f3710cc4-cbbf-4f1e-93a0-9eb6697df2d3@redhat.com>
 <503c29c8-bcc7-4a6c-ab2e-ebf238a9a1db@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <503c29c8-bcc7-4a6c-ab2e-ebf238a9a1db@redhat.com>

On Mon, Jan 27, 2025 at 05:20:25PM +0100, David Hildenbrand wrote:
> > >       14.04%  postgres         [kernel.kallsyms]          [k] try_grab_folio_fast
> > >               |
> > >                --14.04%--try_grab_folio_fast
> > >                          gup_fast_fallback
> > >                          |
> > >                           --13.85%--iov_iter_extract_pages
> > >                                     bio_iov_iter_get_pages
> > >                                     iomap_dio_bio_iter
> > >                                     __iomap_dio_rw
> > >                                     iomap_dio_rw
> > >                                     xfs_file_dio_read
> > >                                     xfs_file_read_iter
> > >                                     __io_read
> > >                                     io_read
> > >                                     io_issue_sqe
> > >                                     io_submit_sqes
> > >                                     __do_sys_io_uring_enter
> > >                                     do_syscall_64
> 
> BTW, two things that come to mind:
> 
> 
> (1) We always fallback to GUP-slow, I wonder why. GUP-fast would go via
> try_grab_folio_fast().

I don't think we do?

iov_iter_extract_pages() calls
iov_iter_extract_user_pages() calls
pin_user_pages_fast() calls
gup_fast_fallback() calls
gup_fast() calls
gup_fast_pgd_range() calls
gup_fast_p4d_range() calls
gup_fast_pud_range() calls
gup_fast_pud_leaf() calls
try_grab_folio_fast() which is where we see the contention.

If that were to fail, we'd see contention in __get_user_pages_locked(),
right?

