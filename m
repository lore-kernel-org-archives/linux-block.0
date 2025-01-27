Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1C2AD21
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737993767; cv=none; b=sQwrSgWUsOQAZn0t/eN4eB9MWzT2tEoy8WHJ80iRncMCEnfraRILHoO1QHHLYSkINHgO/BzcvPJSLmwGhKX9230x0skfG+R8krVicFysAVZABLn6HNqEg9G2nV71fYYDbiuf/PKxfM5v24dYa7GF1yAOAYQcOhxfcLwFn8JkODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737993767; c=relaxed/simple;
	bh=OyHgj3UTv8yH/X1kktHy69aOaqacSy1Vr5vrG/aLKWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+npWzi/vcyBeulXj6Ku7/U1my+JIfDdwhJl9+jhWNab+aIHmhzlg1R1BfQtpeieKauWq89dPyPYNJxEhlVipbexHjjcrwQ16s+/32TWqAl8CxbxCG0/Jmvq8icsZpa+1kXgZeH7PKxqDWMPAARXtfZwQmU2s6t+vVeijKCpJPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UZLpSog+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UZLpSog+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=28LMBxDMd1K+Lfe4Mecb7NBAlb5zAN2Qnc1EAyl4s3g=; b=UZLpSog+4jqsQvTtbD5DQhK/Ba
	6sKjwyDUJ1w3HFoKe4RSIVo39MHzvdP29gL/WjK9zjfBDnnSaAvuIPi9HUkGU1it3xCV2FKQi79z7
	9gkR6vQfLS4nsdQEhHSD9LB/fV1BXDMwbvs6ptmVWDqqRqyIr5zJtZXS8nqFvEdpmTIppmxPcGxRC
	2qErTZgSm8wuGoVjUs80nPQB1e3OPMBGgT8IJOsxeHf4Bm40gyRjQptc3pqHBQa1EGcTphIWdOWSO
	zX4BpQiBnpI8TaUgCwi3rFh0NhdV+ugIvgOn2oB8tSzRiuFSpdcFTiObm9+AF+rZPgTMVxhazPZr/
	HN705aUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcRZR-00000009c6H-1KNG;
	Mon, 27 Jan 2025 16:02:41 +0000
Date: Mon, 27 Jan 2025 16:02:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>, Jane Chu <jane.chu@oracle.com>,
	Andres Freund <andres@anarazel.de>
Subject: Re: Direct I/O performance problems with 1GB pages
Message-ID: <Z5euIf-OvrE1suWH@casper.infradead.org>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>

[Adding Andres to the cc.  Sorry for leaving you off in the initial mail]

On Mon, Jan 27, 2025 at 03:09:23PM +0100, David Hildenbrand wrote:
> On 26.01.25 01:46, Matthew Wilcox wrote:
> > Postgres are experimenting with doing direct I/O to 1GB hugetlb pages.
> > Andres has gathered some performance data showing significantly worse
> > performance with 1GB pages compared to 2MB pages.  I sent a patch
> > recently which improves matters [1], but problems remain.
> > 
> > The primary problem we've identified is contention of folio->_refcount
> > with a strong secondary contention on folio->_pincount.  This is coming
> > from the call chain:
> > 
> > iov_iter_extract_pages ->
> > gup_fast_fallback ->
> > try_grab_folio_fast
> > 
> > Obviously we can fix this by sharding the counts.  We could do that by
> > address, since there's no observed performance problem with 2MB pages.
> > But I think we'd do better to shard by CPU.  We have percpu-refcount.h
> > already, and I think it'll work.
> > 
> > The key to percpu refcounts is knowing at what point you need to start
> > caring about whether the refcount has hit zero (we don't care if the
> > refcount oscillates between 1 and 2, but we very much care about when
> > we hit 0).
> > 
> > I think the point at which we call percpu_ref_kill() is when we remove a
> > folio from the page cache.  Before that point, the refcount is guaranteed
> > to always be positive.  After that point, once the refcount hits zero,
> > we must free the folio.
> > 
> > It's pretty rare to remove a hugetlb page from the page cache while it's
> > still mapped.  So we don't need to worry about scalability at that point.
> > 
> > Any volunteers to prototype this?  Andres is a delight to work with,
> > but I just don't have time to take on this project right now.
> 
> Hmmm ... do we really want to make refcounting more complicated, and more
> importantly, hugetlb-refcounting more special ?! :)

No, I really don't.  But I've always been mildly concerned about extra
contention on folio locks, folio refcounts, etc.  I don't know if 2MB
page performance might be improved by a scheme like this, and we might
even want to cut over for sizes larger than, say, 64kB.  That would be
something interesting to investigate.

> If the workload doing a lot of single-page try_grab_folio_fast(), could it
> do so on a larger area (multiple pages at once -> single refcount update)?

Not really.  This is memory that's being used as the buffer cache, so
every thread in your database is hammering on it and pulling in exactly
the data that it needs for the SQL query that it's processing.

> Maybe there is a link to the report you could share, thanks.

Andres shared some gists, but I don't want to send those to a
mailing list without permission.  Here's the kernel part of the
perf report:

    14.04%  postgres         [kernel.kallsyms]          [k] try_grab_folio_fast
            |
             --14.04%--try_grab_folio_fast
                       gup_fast_fallback
                       |
                        --13.85%--iov_iter_extract_pages
                                  bio_iov_iter_get_pages
                                  iomap_dio_bio_iter
                                  __iomap_dio_rw
                                  iomap_dio_rw
                                  xfs_file_dio_read
                                  xfs_file_read_iter
                                  __io_read
                                  io_read
                                  io_issue_sqe
                                  io_submit_sqes
                                  __do_sys_io_uring_enter
                                  do_syscall_64

Now, since postgres is using io_uring, perhaps there could be a path
which registers the memory with the iouring (doing the refcount/pincount
dance once), and then use that pinned memory for each I/O.  Maybe that
already exists; I'm not keeping up with io_uring development and I can't
seem to find any documentation on what things like io_provide_buffers()
actually do.
