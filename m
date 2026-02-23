Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E0273D8F;
	Mon, 23 Feb 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855428; cv=none; b=EjXKK7nV0DdXDtcei041NLJQzgbUcFGMVELqKloVjglQ5jQmgZN94C+5OoqI4gMDD+/s7GLNhW/xjVxCq8OSm7lP24FPOI2IF9vYiXLrj8gR7ZOyKlD+EavIMf4G/pNxdUWXRyTBibS3t/ClIJIeSv7utvgLW3mrQMmqQMyJ7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855428; c=relaxed/simple;
	bh=UaUU6yK0+AlttiQgxI7jXG8hfigUCmX6sJ5W+ZtX9Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuYJ9XPK/BH5Nhsr2SoS8uOPgLEVQQ1EbkTlMrZUD/D+OgCHWqoQfbSsVx/OBQfZFTlKvNkbfwGkJqjyBx68Ir7bwiW7fyzUUQtHucUkxF6lgOHVjpj1QqvJtP22Oe1weBNO7yjq4SJX0qetOE2p8KinEA2aMbNtYJCkuS2TKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UamWqCMb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UamWqCMb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x0bCF0gSNivwN6OED4BvckqGL7j34q4jTf0yj2ndCis=; b=UamWqCMbl6P3nbszGSl40uzFdI
	l6ZjTjAvQZpcrAqLBgvEpn1PTBhaHyLcLM8nELM9k9jjB6cjpWItZhBWSB5yo2Ld35EG+LfWoKPTg
	wVZxxM82kFhZnjlwTKTAN6hU7JgDj5V5zS6fWPIUujS71WuSauUKRLhQZ3h884V5YXbE5yeA/3o1z
	g40QtAPXSLaE45U3JPId+LK77m7RrY4TycmWevnGT6EuY2nKm5Xn0QxVi5dZXjgXlrt2BhEC48Zyw
	uGKob5+htZDIPIv7s4zX/dbitIPZd//Uy8Ip1NfgtuTMWU87fVwdAZnqjL6MVezLjACgLXbPrh2rA
	Z8z5r+DA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuWX0-00000000RIL-2hdP;
	Mon, 23 Feb 2026 14:03:26 +0000
Date: Mon, 23 Feb 2026 06:03:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, linux-block@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Xing <kernelxing@tencent.com>,
	Yushan Zhou <katrinzhou@tencent.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Eric Sandeen <sandeen@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Carlos Llamas <cmllamas@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH v1 00/11] Zero page->private when freeing pages
Message-ID: <aZxeLmNyKKTrkSzn@infradead.org>
References: <20260223032641.1859381-1-ziy@nvidia.com>
 <aZxaIEFZr2NvO2eQ@infradead.org>
 <F1307EF8-7054-4135-B61A-62141A113394@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F1307EF8-7054-4135-B61A-62141A113394@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Feb 23, 2026 at 09:00:57AM -0500, Zi Yan wrote:
> > awkward interface.  Don't do that.
> 
> Page allocator hands the user a zero ->private. I think it is reasonable
> to require the user to return a zero ->private. Restoring things back
> to their original states is a common standard, isn't it? And most of
> users do that.

No other relevant interface requires private data pointers, as that would
be silly and cause tons of bugs.

