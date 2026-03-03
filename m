Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A6C383C7A;
	Tue,  3 Mar 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547026; cv=none; b=TI0XRU5yX4NSZRsPMfC5l4XoocqIOlvf3GeLpquyaMTjx/5CJF5TsiRyVB84eOGmeIj4H1wIHNhVD1k8LpDfE6ubhMH+oebBT+m1NJZi5Zs+mwjc0rEZVOlYh1R/BnWs3ADRLvO/Ksmzuo2gwSuq/KWRF6eNcdQqj8I7BmU4N30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547026; c=relaxed/simple;
	bh=6QjPYj8PUmZMpbtQONXPFJKXrsZshrPIELsTsDvK0P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFHYa3CsZVZmtQ+EWIzKTz1ualoEcm/XVFExHGttuGgJSe0bheMaCUMOtw0rHiS/pnplwU8/wv53yhPLSj3uNTXDsuDy6vKm8UdHdkhlbUFnoTPIi/psyZ3JJY8YUmhnApvFykXmwQpOC5taYaXHqQDL84j2BFSxcOt94RupgAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mzf8zM8b; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mzf8zM8b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a9u56EZ3PSfIb2btDXq4/JS3z6i9/jf+AUwQRPvsces=; b=Mzf8zM8b6LFOygmPYqODqdSM9e
	Tp9BXCcIo947iDR4+2TmKKK3BbGix8IyIB277AjxFH1u8jUvwxi2SDp3iEjHXK2/0u2GNXRQrfXmV
	lzkQ/lqP2x7DEcw4eigUo7yL6pyux0Bzy5ibhpKNxLVwtdUFuQk6bKwLAtfTAsLBw96AQ9iQuifl3
	nTFmpV4yMywEPCs+BB4fbsm+1UM0zbdp4vCanMWq+Xx7QL2e9/b/CtdZjXxMqsOaA8Dj/v53MkgYD
	U5dES+gMZeAXhWT7BcpfbVvpAmTOK/925okF+7ySgncqEqszHZbCKcU1GfMrwASKH+ljRvFlu5ffU
	dyaoXHPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxQRr-0000000FI4y-0fQd;
	Tue, 03 Mar 2026 14:10:07 +0000
Date: Tue, 3 Mar 2026 06:10:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [RFC PATCH 1/1] mm: Reduce direct reclaim stalls with RAM-backed
 swap
Message-ID: <aabrv_xrsKPx9jZf@infradead.org>
References: <20260303115358.1323188-1-matt@readmodwrite.com>
 <20260303115358.1323188-2-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303115358.1323188-2-matt@readmodwrite.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

No way.  Stop adding hacks to the block layer just because you're
abusing a block driver for compressed swap.  Please everyone direct
their enegery to pluggable zwap backends and backing store less zswap
now instead of making the zram mess even worse.

