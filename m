Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9421CC44
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547661; cv=none; b=REq7u+RV5ri9yRChmqyEnjwbXL/FsiLxyKVRufeW0ju++OOsLWCP9052cCf7xLblD8UXsXPlU2d2kMRrlMVj+yM0dwPJm921Y8//8K59U9GpCljHf9A2Hq6+yVpBo35G5943GZ3OOy5ZLX6MoRfkwDo+1jHR9ZoWIjhYppvT+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547661; c=relaxed/simple;
	bh=VBDswt4wkAGgimr1R7qePK+gVWWJ8RRygxn0ojpbSGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPIs9QBPcSkql+Ayy87SfVref6q/CNc3GwWV4b7NVpfDbCXnr2wpJoYrDEExkzlTusv6oXrlyhoCVpeMPVFYY3YWyExkKgnl9kpfssYKqxINc4c4djkA3wakRtMGwoTAihaAmjSumiL8vxETUYxMN5dpKnimaRuN6V+Zx9v37+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 42A3B227A87; Mon, 27 Oct 2025 07:47:28 +0100 (CET)
Date: Mon, 27 Oct 2025 07:47:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] slab, block: generalize bvec_alloc_gfp
Message-ID: <20251027064728.GA13145@lst.de>
References: <20251023080919.9209-1-hch@lst.de> <20251023080919.9209-2-hch@lst.de> <aP6QX_gNpY9UDtub@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP6QX_gNpY9UDtub@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Oct 26, 2025 at 09:19:27PM +0000, Matthew Wilcox wrote:
> it's quite different.  I am by no stretch of the imagination a GFP
> flags expert, but it seems to me that we should make the two the same
> since they're both "try to allocate and we have a fallback if
> necessary".  I suspect kvmalloc() is called with a wider range of
> GFP flags than bvec allocation is, so it's probably better tested.
> 
> Is there a reason _not_ to use the kvmalloc code for bvec allocations?

It's using a dedicated slab cache, which makes sense for such a frequent
and usually short-lived allocation.  We also don't use vmalloc backing
ever at the moment.
