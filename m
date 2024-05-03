Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A0155342
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753380; cv=none; b=gbrBpmDQWHJS/uIpDDgoZQSYlfictNKCSl1y7tQhB3jbVHqV4Q+Xxa/mndqGWFOXGSqT0freOGD/lRsef6NvcfWq7hCIkYBsWTOyCDDUIoeWi1G5cQaGT4RPxkvBY3P0wjXSQs6FxZb4M/+EjBzVx9V1dQDvtBxFN8/f80y9Qiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753380; c=relaxed/simple;
	bh=SRtJ8KBHw8d4CKKy8rTTzwTvgnBLctc9QV0NRPlj8qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W61U3MYY0WoXT6QZxoIWclT0Ua2tByVsdhZVlJ7wbWNyaV7gZotohG6YVjO4WjEmQ3KtmP63rYnpJHZL2Uf7Ei11r8knfZQeXQuqHJwrZTa7jbS7T4HsvY54oC5KwD6fPbTJ9ZS231Ym7PG2prqfRCHMj2jnvIl4I96PlWPR8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4605768AFE; Fri,  3 May 2024 18:22:52 +0200 (CEST)
Date: Fri, 3 May 2024 18:22:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Kundan Kumar <kundan.kumar@samsung.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v2] block : add larger order folio size instead of pages
Message-ID: <20240503162252.GA25087@lst.de>
References: <CGME20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff@epcas5p1.samsung.com> <20240430175014.8276-1-kundan.kumar@samsung.com> <317ce09b-5fec-4ed2-b32c-d098767956d0@suse.de> <20240502125340.GB20610@lst.de> <ZjUCP08UyIGTzpW_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjUCP08UyIGTzpW_@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 03, 2024 at 04:26:55PM +0100, Matthew Wilcox wrote:
> I think this is wandering into a minefield.  I'm pretty sure
> it's considered valid to split the bio, and complete the two halves
> independently.  Each one will put the refcounts for the pages it touches,
> and if we do this early putting of references, that's going to fail.

That's now how bios work.  The submitter always operates on the entire
bio using the _all iterators.  bios do get split and advances, but that
only affects the bi_iter state.

In a perfect world we'd split the memory containers aspect of the bio
from the iterator, but that would be a lot of churn and we've got
bigger fish to fry.
