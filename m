Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA0C1FC3
	for <linux-block@vger.kernel.org>; Sun, 26 Jan 2025 00:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737852412; cv=none; b=Rsv/wxg2LC6Jz03/yttgO1QdjpmRlZQij1TQdlX0egtm+/6enApnMh2OUJ+YfufvEgKXjNU7BS0mFHdGC7CiXN2gnX+ucnXsIpAWo9LkmPAwhU/13gbvgQJnpBkakoRcvz70Pa7msmUS9vNv3pcUz1tPXdJ3jxKKpDOtS2qct8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737852412; c=relaxed/simple;
	bh=qYBU8ZacjmZ9dVgRBk103Q0ECkVclVeb3k/1tqubss0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mNtXcbh0CYEgy8YSOt7FMYa65HxgBrS383hGC7Nvb6UPJmsdZEudLl/OeRtWAah0eeGhpcOJbrxLNE4QCUeBUU6zcMEN9r8thh8DVuMDAVHLAgGk8ldol0kssIhF0qv1Mos7nJNxut+z5Y+36pj7KnDeukGD7+dGkVucl9J5/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OGW9zcRj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OGW9zcRj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=jGn+vlufNxbazpI40lKb7tO/eBSKtukFfR6vbxhXKSU=; b=OGW9zcRjBkOPtShCBAfXaoKQJb
	yKM3ys4iU7xtm2iq7o+/Um/fszo5dLCrAe8VK3XBvv55ymDXI6hKddQhd9iGavHYODFHefmgyeLUr
	/9PjLrExvIERBm2UfUf6nR2MET72KIx4R/Eho9+BikUlTj8o57Jizim76uMjxuJjhZse1VvwX1dKX
	RfEGnMYUXJdBR6Qb9Xi+TOS7dGdAJzyPLU59M6IJKekHeloxeBm4LF2X5a6vlpSDw3I9/B4f3EWq0
	J/ycSrWbUOtxsXtHXW7WM7ZzBrJx3e7EaWzRibbWwbIhj6VcEjpfh2DM2n0x0hhw9+WrMQLElYu44
	W7GygjmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tbqnV-00000007ETB-224K;
	Sun, 26 Jan 2025 00:46:45 +0000
Date: Sun, 26 Jan 2025 00:46:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: linux-block@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
	Jane Chu <jane.chu@oracle.com>
Subject: Direct I/O performance problems with 1GB pages
Message-ID: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Postgres are experimenting with doing direct I/O to 1GB hugetlb pages.
Andres has gathered some performance data showing significantly worse
performance with 1GB pages compared to 2MB pages.  I sent a patch
recently which improves matters [1], but problems remain.

The primary problem we've identified is contention of folio->_refcount
with a strong secondary contention on folio->_pincount.  This is coming
from the call chain:

iov_iter_extract_pages ->
gup_fast_fallback ->
try_grab_folio_fast

Obviously we can fix this by sharding the counts.  We could do that by
address, since there's no observed performance problem with 2MB pages.
But I think we'd do better to shard by CPU.  We have percpu-refcount.h
already, and I think it'll work.

The key to percpu refcounts is knowing at what point you need to start
caring about whether the refcount has hit zero (we don't care if the
refcount oscillates between 1 and 2, but we very much care about when
we hit 0).

I think the point at which we call percpu_ref_kill() is when we remove a
folio from the page cache.  Before that point, the refcount is guaranteed
to always be positive.  After that point, once the refcount hits zero,
we must free the folio.

It's pretty rare to remove a hugetlb page from the page cache while it's
still mapped.  So we don't need to worry about scalability at that point.

Any volunteers to prototype this?  Andres is a delight to work with,
but I just don't have time to take on this project right now.

[1] https://lore.kernel.org/linux-block/20250124225104.326613-1-willy@infradead.org/
