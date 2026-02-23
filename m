Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821BD24397A;
	Mon, 23 Feb 2026 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854384; cv=none; b=bjzAmNXVPbJWDjaY7qNL9ZBE/ekLK3xwgqBei8p0J50PsSam0X8BmsI3BZt0AjmFIYWCin++rLZ7UUnax5Wwgs70D/e4aoGQa4yymFce9gtF+6HEsQqnAFp2CRP0yc0dVJm+HFgDubqPNAJSzYP9TjE0zQ/JoqVlOYZzcLHTAs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854384; c=relaxed/simple;
	bh=AslV2qA63gUWoHS9QZYmMq0vrpv1g+5PpOK6LBBpAsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nm7jvZS65XPLGqMHF5XjV3h84xgJddVUYm5D7o+cpeyI9HDmPypQ0PVi2rC82yLaAS3usKcAyn6gs3/kyFF49Ukt4ygQFjGZCQJFfMR2p5h5pt+wWcNSXFHOm0ylbar9sIhNdini3mXD6ke20t9oN8c8V2csvtW1L575m/dRUVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cszANuHk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cszANuHk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JJ4KtBZ4k7mPQNvSdOKma/KrL8oFM/9ZCZpnL0vUUmQ=; b=cszANuHklU70b08hJly+nRjFHg
	WEQcf911XV0uvJ2N74cAit4X9NPl4xV/giOETJPgb0YHIS521/q+bYzLZEUzd6pXStd06OMni3Eu5
	mdT5LXABrkMHMDrT2Ju6QHSPhM6Ej1zfaMmrR+ZCGYYsKMgB3p0yVh1HY6u6aL8J6m1BuS9pUgrjA
	81cuqWcc4U43+rrQruzTuAbrV9QaHXpKpD4f/2gAXhfdWy+OCrDVjEsMtAwibGd00Gsz4PnbtLBkn
	KXNs6D6p62k6+uYouKOuuxvOV3ttPQzzsK/RwvUZJi+Ia19k8oBEa9AQFTF9aY1xZ5hgD4P62KR3R
	0xozqhkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuWGG-00000000PAF-25JZ;
	Mon, 23 Feb 2026 13:46:08 +0000
Date: Mon, 23 Feb 2026 05:46:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
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
Message-ID: <aZxaIEFZr2NvO2eQ@infradead.org>
References: <20260223032641.1859381-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223032641.1859381-1-ziy@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Feb 22, 2026 at 10:26:30PM -0500, Zi Yan wrote:
> Hi all,
> 
> Based on a recent discussion with David Hildenbrand on page->private
> is not zero when a page is freed[1], this patchset is trying to fix all
> users do not zero ->private when freeing a page and add checks to make
> sure all freed pages have ->private set to zero. For compound pages,
> both head page and tail pages need to have ->private set to zero.

Requiring the user to clear a field before freeing is just a way to
awkward interface.  Don't do that.

