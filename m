Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F412F1FDF
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787831182; cv=none; b=u1SsbEpYBL9Ulh683dfTYlSyRlbDqw7O7JizaHZQYZ2owQz0mQkj7pMGrikSYmfngj9Ycj0fBTRPvUNPMY83ggLx/eT8X/fv7jxc/llcnwQJiTvfdk4Hzox/N8IIIFTPxoHGbdzaN+OcQ4DuddjTUFwQ5VUbcMX91urpG+kQZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787831182; c=relaxed/simple;
	bh=I93NvcT5kkpWYtiRck26P3d7syS0PgNWXwsEmndyHm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMsYbGwKw387L4ysw7Bfh6YkUsRg4UslQZ6ZN3HHFXBYGYA028xVpxx0Q9ElDoPTG5YiDRN8sD5OZqKaZyPhUMDXi++nw+fWLbEBGvF/TDoBxFRHC9s1OWX3buXxje8exwaXLK5QvDtHir/aJjmUGz+9rP1l84gf81EIK+/tkvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rt4sOSCR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rt4sOSCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376771F00A3E;
	Thu, 27 Aug 2026 11:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787831180;
	bh=1/7HEinzHyrUIuuAvpR8eRudqoAYvO5vyA5jKxjS7tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rt4sOSCRNDXuFPLuoJaGzxCPmi1+DLpY927TMXzpzdfWtFouhdayMbPf6X405oVpy
	 0q0qtAzraVDJrstHEPH87k4Y070O0WLN5ftXpWOU/6IjRPIGu6jz+h06Evik4Lrjna
	 RSRIU2oX2OIn5WFxhRyl3H9CUTVKwIPbarZbV9fJbipOxDQfA41ZjCJtLCOKIfD7wT
	 3mIuDwlMo/2tISjSaaSwB2e84o3sBNdDX7D+kHnRjkK8bpcdTjoZwEp1JMUhz9HYK4
	 MkHCPE4LILNBkbhMIdabjnMOrbBQaLPLkiZOWvt+Z0YQM+E6t9x9L38dq4qfNCGve+
	 ZknbhUhYMOkxQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 0D84C1980047;
	Thu, 27 Aug 2026 07:46:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 27 Aug 2026 07:46:17 -0400
X-ME-Sender: <xms:giOQajxrB74n8M4jds9AgIgRcXpZU72wEnOkHc67ccNPTLLr8QeOrQ>
    <xme:giOQavD3npuGe4nFyz4WZJ-qUfIAY-EgCq22IPkgUII8ZyzGBtOwUV9G0iQGDgzOG
    RehAd8N5LIKhvMjiVwxkNL-m2X-UTvHQKMnBSxB4NzfddAx7cqQmY0K>
X-ME-Received: <xmr:giOQatEdIKGZu4wUeRJvPxwf9xdQrGV7tpsNpfxfdTl_3NKnq4cP7GW7iEs>
X-ME-Proxy-Cause: dmFkZTFEkFs1SlQDQdGfvtSAc9WTtr25v16L9+AoTBfiYB5jwPukem/FqOc9aBgzJGVE8s
    XWYu6XtTF1TiqpkLYgBAEZedvE5yRMka2V0KyqpQK759rDery0ZQGWPcpvUce4YOjJdxaU
    mkTf/h8DzsCePJPfrcIYp7xj1rVZw3sfyseBqC2/BQ8R8iSKLxuJs+tBOg/r6anSmnpAGj
    suewUpL2Xs5LkLCTflIiNIekfKUet6doHLg1kVgwEnuEEpGtXoDy4Uu5Xw+aUuWpdhdYH1
    6O/Lvfm5/orsfos/smODRowOFflASWqZjIPkmpZbyHf+P2lnRwkJw4sifLopkuetjJjFkr
    X2dMrF2eJyqCwxQIzQ5IGiUwcFQge78u2cyfBqZkCWT5CcNVB2b34WWwQ0URExW4hkV1aQ
    VMa18lLChoRZqk8ZtIAQiEsxhoTbabQnXk5nEsISNP8YF0fHGnI+tuvYx2zGzPDTq2YWfF
    QBTdbxsbws8PYjblh48P7bR4oI+zvDgBhC8d6yjVSSg3TjuYD8biX1DTIPSj2w6fItuZ4/
    iyaktA3Yvce6MXL9T9alUvd3Vj+A5RoIHjbfYs/vMt1U0WVNM6EK1igwNxqOvJ1t2DoL3n
    87zY9T+sIyKV1SZpj/n2fUbPx49BE0ULFZXet8EkBdfquu52KsyYYAZPxiXA
X-ME-Proxy: <xmx:giOQas2OLdJ4vCHLOR8jMhfVr2tyw-CQpxDt2Q7fGMGmRKCgA0zTYA>
    <xmx:giOQasabqX5COZwurOKIaF9PlBhW-FRP14X3Lw1NmJ_AQ9xRNM6qew>
    <xmx:giOQakxILQStI4fYkHh5khjicZk8rS5SP1n_fgq3iqBHDEhyTFtZJg>
    <xmx:giOQal1cjolE8KhzFiTwWpP7I85s2j-ZZ-zVksXlMlSqFxI_yZZhKg>
    <xmx:giOQav3y6duKlH4MJy6mMMXvnUw52ihIcPMaYjTGDnlxNYNKGufQVsIk>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 07:46:09 -0400 (EDT)
Date: Thu, 27 Aug 2026 12:46:08 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 	Ackerley Tng <ackerleytng@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 	Baolin Wang <baolin.wang@linux.alibaba.com>,
 Barry Song <baohua@kernel.org>, 	Binbin Wu <binbin.wu@linux.intel.com>,
 Christian Brauner <brauner@kernel.org>, 	Christoph Hellwig <hch@lst.de>,
 Christoph Lameter <cl@gentwo.org>,
 	Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, 	JP Kobryn <jp.kobryn@linux.dev>,
 Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
 	Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>,
 	Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>,
 	Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>,
 	Matthew Wilcox <willy@infradead.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
 Minchan Kim <minchan@kernel.org>, 	Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 	Peter Zijlstra <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>,
 Rik van Riel <riel@surriel.com>,
 	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 	Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 	Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>,
 Zach O'Keefe <zokeefe@google.com>, 	Zi Yan <ziy@nvidia.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 04/25] mm/fbatch: lru bit set, no extra ref, while folio
 on per-cpu fbatch
Message-ID: <apAaWsWPV9QEeVwn@thinkstation>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
 <e0887417-85a7-453e-e733-561dc11db08f@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0887417-85a7-453e-e733-561dc11db08f@google.com>

On Mon, Aug 24, 2026 at 07:01:20AM -0700, Hugh Dickins wrote:
> Treat folios on a per-cpu fbatch as if they were already on the lruvec:
> with PG_lru set, without holding an extra reference. This will enable
> the removal of most lru_add_drain() and lru_add_drain_all() calls soon.
> 
> Recognize such a folio by 0x02 set in the folio->lru.next pointer by
> folio_add_lru().

Hm. pfmemalloc (__GFP_MEMALLOC) thingy already claims the bit. Is it
safe because such memory is never on LRU?

Are pfmemalloc and PG_lru mutually exclusive?

Do we want to be explicit about this? Like, folio/page_is_pfmemalloc()
shouldn't return true for PG_lru folios/pages or something.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
