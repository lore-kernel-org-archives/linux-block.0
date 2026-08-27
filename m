Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50436440A2B;
	Thu, 27 Aug 2026 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832152; cv=none; b=feOcC3/TRH5PSKUfIzUVhPExA2aFGo08VstlA03Ffzb35UZqo8iQAUjernwwPg93/lddmFhjogllnQnQgrtd1RqpB2fDI9XGJT7dG/MbZCrDl5I+1FByKjzzaun7aXZ7c2Ngr4OGaaUlvFDkjSzkSZCLgNHO3gku5NO6z0Rcm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832152; c=relaxed/simple;
	bh=xy7XKD/bymlK+Ksss8En9NkgtwUVdpivc5xveG7VynQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0T8WNNA4m2yTcoTNnLFIdJMW1K066byYPdEk+XIP2aR0Mw0ApGHCDRVqmpwn5qUqkY15ubDcIwJIyqlfV5p5ApRsLj8TN9vXQUpThAtgFMXkD4xQo3+abeBftyyLp+IuO+4SYB9cIIyzOrJCRx0WvhGa3mDtGR6PPVAayDUjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oU5Fu3nr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oU5Fu3nr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315A71F00A3D;
	Thu, 27 Aug 2026 12:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832151;
	bh=2XsxeEPR3/Rk7rjBdJvlKvo98WGdtvIZTN2N8+2tZQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oU5Fu3nrwgSonksrVWuyCM/FVaiZU5Gi+zkbUcCV+6xESzPhMe5dL8xTf3tQk3VY+
	 KHxvgVpnPTpHQGazRIpUt456oMO2kIvsKleE8vsOPV2T4YgKvwEd06gg0t20onsmg4
	 H2YePWYvzJZOsp0Lyl0CCfkgtJzhD9vwHCiUw8wWzH4t6BMrkqQtFE1n+e2Ddr0VlZ
	 rrzVJQGRaQV2vgIZFBDEYR4vydHidItacPkK11kWlV6/mhaFZr9CcRezKp8IFUbdGW
	 TqvuZqOUe7EWRULhJeLATyRbHiG1SNjvWO9h8mzvwzauSERiBs1ht+u5i/UUIc2Ws9
	 1LlK1PhBcmoCA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 04F11198006A;
	Thu, 27 Aug 2026 08:02:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 27 Aug 2026 08:02:27 -0400
X-ME-Sender: <xms:SyeQaoKo4tb8bnlH35Szx0wbWy1NZzrTNp7vZHlBAy7-Fq4uFp-eiA>
    <xme:SyeQarFtcvavQQbVlnXTqwtmjArg-w4o6Ar6lS5E8jAZUR7yVzO1kMBJNzgQYLg2F
    dVhC-lD7rF7m35p74_UP39j9dC5zeKcCs-ESRSXIPDxDgRCgZMm4KQ>
X-ME-Received: <xmr:SyeQasEhQH8TtHVEGB_dbkCL2SlmpH8VDjVoQNmre6hRRmzmxEEpLkqdwsU>
X-ME-Proxy-Cause: dmFkZTEirA8p/Fg2Vt0IQ3sbf8tygsd6g4HGOD50ZYQXuEOzvK3DDnN+iPIFENoOnOzS8y
    jl4cteOEz9eDzItp1psFvzkCM8nSgtIDdtXPBJUOsZUni9pif7kyC1W52Cbg5Y5o4uXe65
    VqjwEt9ummVrtTdk+rpysdpOiyf5vZ9yetWZQoeBBoc+hPU4GIoq6romIJ6qEM6rH+0v7t
    OBnCBYkMaKf1tYtVOe0M2Ct7auJ71LhpDbgT1P/lz9P3MFwvlMkwlj2+xrVs8UmZMr74kE
    RP/8923JcU3qWpmArRahVMHSYtCWOWanNLthEMna1K6MswnvpxEy649NmN9nHdrRrGzBbW
    W/k1jezLaTAJc73o/EXawFGSUYoJR4c+TXIzR7h20OG7HDRGWp0bK9L+wkAlAJYhtry1YW
    sJ6WIBHNqylTjDtXfscT6bsb+fxgd+t/Ew3ALSICZinX2t+XlOJp4HolZ4C7IdMTv4hHWH
    +t8SZPqTgfyzBoelXA+4SfIjRWtn9U2ZpWT4mGQvrNivXc7daUyWHp3sDOkyxYDXoQcmbq
    yV4DrKa+59naxi6Pj7cBVsnTFEGxK7FsGKZcsuXdDqAdLJIuVE6szwyIGDdiPnskEaEVih
    QWuXHPSyTDwaLSAQhXmFzfXcK8Uhx2Pk992kJhYYzXVdDq7ovWBWIfhGRHxg
X-ME-Proxy: <xmx:SyeQas6x_CJAKC10gEebMtWvee83j2n4rr6KZqH9u-QrgV25nhpENA>
    <xmx:SyeQaobfSR2oXdZfYfuMbYFgWhmZIlwMBfH9GtmIZCEj6lSEoQBxbQ>
    <xmx:SyeQaoswysIcl7AWGL07Q0fQFEhknHXPx5s0slrJlXtovuG8C79AOg>
    <xmx:SyeQai2eUUcBLktxZoPLt_q8cP0i2UUXT3PadRIqdG8xhqrvOK51Fw>
    <xmx:SyeQaioTmw4oBvOWObMpNP3HJglgHG0vOGhDDJbax1PZhaE0uqr0wCVD>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 08:02:17 -0400 (EDT)
Date: Thu, 27 Aug 2026 13:02:16 +0100
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
Subject: Re: [PATCH 07/25] mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize
 folio_activate()
Message-ID: <apAllneItXmyjRPo@thinkstation>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
 <16b39f43-d91e-7b23-900e-90cec13837ff@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b39f43-d91e-7b23-900e-90cec13837ff@google.com>

On Mon, Aug 24, 2026 at 07:09:34AM -0700, Hugh Dickins wrote:
> @@ -355,6 +356,8 @@ bool lru_add_del_folio(struct folio *folio)
>  	/* BUG_ON(folio_test_lru(folio)); */
>  	if (!(folio->lru_next & BIT(LRU_NEXT_BATCHED)))
>  		return false;
> +	if (folio->lru_next & BIT(LRU_NEXT_ACTIVATE))
> +		folio_set_active(folio);
>  	folio->lru.next = LIST_POISON1;
>  	/* BUG_ON(folio->lru_next & BIT(LRU_NEXT_BATCHED)); */
>  	return true;

folio_activate()'s try_cmpxchg() can land in between two lru_next reads.
Logically, it is safe but I suspect KCSAN would not be happy about it.

Maybe READ_ONCE() here?

Other note, page_pool (pp_magic) seems to be using bit 2, but I don't
think there's a real conflict.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
