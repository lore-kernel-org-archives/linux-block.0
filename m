Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD9317143;
	Mon,  2 Mar 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473053; cv=none; b=Qs2H2Fv4NH/Y9/v5SDkd37StWwobsSAbcQ3KOIjA+TmJPLjVGY690uXOBDwXBgTGL3h7Y8BO1gzleTRG8qwF/npYs3Sf96Nd9lAXlkJlaW4VFkK5XBmhCr/gCdKbHaF9MDyaI5QvjmN19s1y18KMD1n3oGDJxyN196rXBQhWKL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473053; c=relaxed/simple;
	bh=HBZU7lDrqfiSFQCOqZP8QIuscOzDLO1xfpjrl0wUxfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1OvITxG9UIA7TOQWN7cM1FYMgR1Ks3KiotPvAyPBjoyNq5itecnz5ukuy0uJ5UBwOgbH9BN70sfapc2NkBmAxBhSCoCG8JxUhZRlADWsUEOnXOi6DXGcdyhoWoJawPeptKvFo/z00rSpIiD3gbeb8zXjDWAZAQJrv1hYGlxHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ehTo4NjD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ehTo4NjD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HBZU7lDrqfiSFQCOqZP8QIuscOzDLO1xfpjrl0wUxfI=; b=ehTo4NjDnDbSNIxrlRcltHgLiK
	ZFXRHXew8As8wOR37BRxXGVN6MNhYqSj036P4OQs0tY6JLOKITQJ88+z8sdEsQcWgwNIbN0fZVtwv
	7Ms57LIVncTKXYIGWSVZpxXDRqx//BZsbVounzAl9KGiWVD8c+3+GNEhHQR4jpQ2OJewH48yL2PDS
	581FS0SqPSNntr8+8yPPW8Jnk5q0RX852O3bKuvptQu2PuqyInVMRO8pGBOUx//Rjas5xux+u67UY
	pLqcqTYZlbLIbxuG2Fe5wcgnm/zioxUglEBT+zfUPnQ93XE5/4Vql0lOjI2Rq12DOwfx7kcG60GEe
	v+klc6kg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx7Cu-00000009qOO-0PEU;
	Mon, 02 Mar 2026 17:37:24 +0000
Date: Mon, 2 Mar 2026 17:37:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Tal Zussman <tz2294@columbia.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC v3 1/2] filemap: defer dropbehind invalidation from
 IRQ context
Message-ID: <aaXK0_HqEnU5SK61@casper.infradead.org>
References: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
 <20260227-blk-dontcache-v3-1-cd309ccd5868@columbia.edu>
 <wen63cjbk3k54mjzgw7zftsuze6bzxmdk5u5wdjabzdiqg645k@67666k5lrevh>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wen63cjbk3k54mjzgw7zftsuze6bzxmdk5u5wdjabzdiqg645k@67666k5lrevh>

On Mon, Mar 02, 2026 at 10:11:19AM +0100, Jan Kara wrote:
> Folio batches are relatively small (31 folios). With 4k folios it is very
> easy to overflow the batch with a single IO completion. Large folios will
> obviously make this less likely but I'm not sure reasonable working of
> dropbehind should be dependent on large folios... Not sure how to best
> address this though. We could use larger batches but that would mean using
> our own array of folios instead of folio_batch.

That's why I think we should allow the bio to be tagged as
"finish the bio in workqueue context",
https://lore.kernel.org/linux-fsdevel/aaC3LUFa1Jz2ahk3@casper.infradead.org/

Why remove the folios from one data structure, to put them into a
different data structure that they don't necessarily fit in, rather than
just postpone processing to workqueue context?
