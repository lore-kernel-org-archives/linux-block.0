Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97FC15539A;
	Wed, 12 Mar 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793108; cv=none; b=L2hCr8TXphviLrtcpzPC0bwm9y5FZLPNVMeTBJvUsIoP+jN+tXYZGV8KEAt4uWLjDeQwJGV4yM+g1eH4Osczyiy3U0ajtPNHn0vqvZW2roMGFj9GMtBDTse37F1XVSYmG+pqPdC3JI4tx1VcRvKX+xP48h0SLVdfGC1NFEXaD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793108; c=relaxed/simple;
	bh=qCy31R7dww0j1i0US9AlZoqTPW70teVl4tpDVXWN810=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT0eXATK4DatTS272LRNzIolZi4/DT3gOkHGCBFSMSqJS9MSIad7ZXKAo3r4gLGmdPlsYJFf6dHA7bYBD9zKJDJO5wxLhGspWi+8lqeZ/7XbOUaWjUc208LjBdsy+P1gPfCEdfDNtDvICD88KXPlwbEdVAR/WtxsvHfnVyN/s/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hzlgqTqV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hzlgqTqV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j+Uxy4UgqZ01TMYocbtqbznCHYwDjKEPy1F0RAtlmZA=; b=hzlgqTqV1c7iAagiTWiaVa6U2l
	0iHfK9bc6oWAIxUTiaaVHTJT2qSGyN9k7icitCFpm5owgGRNv8sLo3vhGgpvSvbrfiCYJ46DfB6MZ
	2W/k/eQbp1z0FKgeTtLOLOJYb0VWQpuZJbdpZ5ENuzc7EaFaFdcHz9/TZ6OxWWPS5h0hzeqsZmVsE
	mNUivblro2QSUYCpCJPnMdUvM9JXjp44b8hybJlJBWv7IW8gLn7i++jQe+oAihGk4pCwarJikD+wf
	FT3/Os+f/IqXlI3a9jmtSo1iaRo+P86f9CaM0amimyOjJ3kSka14ADw1v01rmHlOoQd4NoPRHwqYv
	2ycBJh1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNxB-00000008r6s-0921;
	Wed, 12 Mar 2025 15:25:05 +0000
Date: Wed, 12 Mar 2025 08:25:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Sooyong Suk <s.suk@samsung.com>,
	Jaewon Kim <jaewon31.kim@gmail.com>, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, spssyr@gmail.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, dhavale@google.com
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct
 IO
Message-ID: <Z9GnUaUD-iaFre_i@infradead.org>
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com>
 <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com>
 <848301db8f05$a1d79430$e586bc90$@samsung.com>
 <CAJuCfpHjV=nRmkAGrf-tyCxEEygZ0CuW-PRp+F_vHwFbfYS8dA@mail.gmail.com>
 <Z9Gld_s3XYic8-dG@infradead.org>
 <CAJuCfpGa43OQHG9BmnvxROX1AneCvkuLxFwM+TdxAdR1v9kWSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGa43OQHG9BmnvxROX1AneCvkuLxFwM+TdxAdR1v9kWSg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 12, 2025 at 08:20:36AM -0700, Suren Baghdasaryan wrote:
> > Direct I/O pages are not unmovable.  They are temporarily pinned for
> > the duration of the direct I/O.
> 
> Yes but even temporarily pinned pages can cause CMA allocation
> failure. My point is that if we know beforehand that the pages will be
> pinned we could avoid using CMA and these failures would go away.

Direct I/O (and other users of pin_user_pages) are designed to work
on all anonymous and file backed pages, which is kinda the point.
If you CMA user can't wait for the time of an I/O something is wrong
with that caller and it really should not use CMA.

