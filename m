Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E13EBF3C;
	Mon, 23 Feb 2026 04:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771820960; cv=none; b=OaNDRZ99IRqZtxGsmZJMiTpCP2sBD1fWJ2WIC8QGD41h513DwwzeOBfPLjtzmUEWPr7wQlho2QFE6wVKdfG3R5hl92cbGPilveKMXC1UkYOw9SZI/ynM/yskwX4YC5YcH6n0aUnGEPnHB6Rau5MHaGeLMFPiUHxyexwKh6pLYUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771820960; c=relaxed/simple;
	bh=a1UEaDva94TFrul68B9awcMNyBObL38LI5KUDiExxUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/AZlbqCFcVBB87XItv9YH24Rwjgy8R2rh6QE1aLhkQo18CyvOYLZ/UVTxh9Fx7UPHmwnOJw6NWk87myiO4ZjrY2kDl4gQ+w+9cX0Xa2BfSJqzqUgO6VXH7ZYc27f60iyqMKGQkc50WaiJKCsb5wFOtmhceLu2QyZxGP3uhckVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EGbJhp6R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EGbJhp6R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZHLh3cKXZKjxYpTI2A5f4Usbzkmd+cL0G7dSp1H+f/4=; b=EGbJhp6RfZrjSCE2rvuy7WsEoF
	Vned+yo1lQzDtP/c65f5E63hpbQmW6y7ucwgA36tqcLB4ihf5O1KbaWOvkp2IapQ30+AHXOFJWjXB
	/RWGxNJjNkWwtJ2vl+0DzbR9bVX7lJX6j6a8nOhuWxbaagFLoHIZzmBvLxcDmeGhZ79DT3yuiIuoU
	RNWPH+fe4mULAm0Y7nJRODD7d45hZJKcUrkZcuC7gBNSAFo6dq/qtqDzakWfbPlqe2ane9otf5tBQ
	Ldl35tPIftkoei5Z3t519AT4iV+zg/Awk4rFsN6hLBbWwOB9jXkwPiv7EEbVbPCilvKeUUBH9RNd1
	qxBZyxog==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuNYo-0000000Drlf-3eoa;
	Mon, 23 Feb 2026 04:28:42 +0000
Date: Mon, 23 Feb 2026 04:28:42 +0000
From: Matthew Wilcox <willy@infradead.org>
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
Message-ID: <aZvXevheBMQ6LuUu@casper.infradead.org>
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

On Sun, Feb 22, 2026 at 10:26:30PM -0500, Zi Yan wrote:
> Based on a recent discussion with David Hildenbrand on page->private
> is not zero when a page is freed[1], this patchset is trying to fix all
> users do not zero ->private when freeing a page and add checks to make
> sure all freed pages have ->private set to zero. For compound pages,
> both head page and tail pages need to have ->private set to zero.

Sorry, I didn't notice this conversation.  It seems entirely unnecessary
to me to zero out page->private before freeing.

I'm a bit confused that ac1ea219590c was needed too; I thought we
cleared page->private in the allocation path, and I don't see why
it needs to be cleared in the freeing path.  split_page() should be
clearing page->private.

Can we discuss this at the THP Cabal meeting on Wednesday?  I don't
think that introducing this new rule that page->private must be cleared
by the users is a good idea.
