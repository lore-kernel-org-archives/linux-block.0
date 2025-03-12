Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7822E402;
	Wed, 12 Mar 2025 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792636; cv=none; b=qFcLbNOt2tY+Ag8CdczO8HSD0cvZmPoWQA+T3byG6tHcRtVmPjJlMs9UrFToDpy17+oY+ExHVcagXpSqHWciLeToz6gqIl2OS81fCzYAAhcFqVRzBgcVIiVjRyC+KoZZXOpn81W3toFMFR0wCypQq3tQcvfIlmn0sYRYVeT1vCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792636; c=relaxed/simple;
	bh=tSkMFGu47t+CvWuXVdH/hsK0ULncBiLZuf0VSvKKQXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3KVoo/lJiBgsu6YXnpMzX/i45B4SgedlTfpPTY5cQa3ffDfS+b5cqT9SuSc0LjfgpW351iUPjYqk0/0Lnm8hKpxIVmoVO6GVrEmyyO5xOblXy/pzNRSYqG/bIxaW+XGtd+QgMSAFD7zNuQW1vGw06kNtWlTHjtcVKl5UTZkzg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZLeRwH6o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZLeRwH6o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cc1IRF4EhJKY8LXoN7q2qpy3BjmvcLDyzu1HWXRb5PQ=; b=ZLeRwH6oaWpY7zx8CJowpM1xLa
	bWukiSc5jXW/4wAXeX5MqQuwIq8csAasq8cuYqDfJ/VfugB5z9rqd7L7g9II+Eg1PJUoPsK8spSwb
	lECxCEMsj7Hav08+Q8E4zFOGsUt5TeZCy4RYGGTYeYwkRNz+SACX8TK4N/LjYb6LrC6MrvtrpVVan
	FYB5Xsrd7DE5GXbhegcuTDsAOQTeOfB3Wd1BH+YD0k3PZXkF9dTF05EtMr82gEAYFr+E9o8AMKpXg
	qW8FK3uKsgk1cN8PoyyyNLQOkwzkXdHtduVto6BRK1ARMtF/fOyrF5H3jwLI+AjuNHIk3PX+7Ln0+
	r0W7EC6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNpY-00000008oxP-05M4;
	Wed, 12 Mar 2025 15:17:12 +0000
Date: Wed, 12 Mar 2025 08:17:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Sooyong Suk <s.suk@samsung.com>, Jaewon Kim <jaewon31.kim@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, spssyr@gmail.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, dhavale@google.com
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct
 IO
Message-ID: <Z9Gld_s3XYic8-dG@infradead.org>
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com>
 <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com>
 <848301db8f05$a1d79430$e586bc90$@samsung.com>
 <CAJuCfpHjV=nRmkAGrf-tyCxEEygZ0CuW-PRp+F_vHwFbfYS8dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHjV=nRmkAGrf-tyCxEEygZ0CuW-PRp+F_vHwFbfYS8dA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 06, 2025 at 06:28:40PM -0800, Suren Baghdasaryan wrote:
> I think this will help you only when the pages are faulted in but if
> __get_user_pages() finds an already mapped page which happens to be
> allocated from CMA, it will not migrate it. So, you might still end up
> with unmovable pages inside CMA.

Direct I/O pages are not unmovable.  They are temporarily pinned for
the duration of the direct I/O.

I really don't understand what problem you're trying to fix here.

