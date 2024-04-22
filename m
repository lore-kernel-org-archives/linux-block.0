Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF6A14388E
	for <linux-block@vger.kernel.org>; Mon, 22 Apr 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784454; cv=none; b=QY5p25WH4mnZKcLKMA2rQa+pEN5F6ntVO1WCqEo//Ux0UgwvLRSzwQTC9q+tfbUpWOp50KItc2qmKd9ZZn9N3NZ75pRglvXN5BOiN5r8d0WCCgA6X6bgQXQ73ySIo2jtQe1CnDDgSKzu8vKJ9O9A0osZNy5CmHAamsyYhR81UzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784454; c=relaxed/simple;
	bh=piz8YvU8KU7fc1OEYqwNDoEUYRYpvY6xEv/Xws7iVDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj30/nn8midnzjIrlK6cjMH4XSs8p1nr4cZQJGPNh30WB5nAudYKX5YVcox8T4TzXmKj4m9VjC+El2jVpV69y6shYcQMGTroMwAv+cukRj0Smqk+YfcNK4tW0W+GuhVTsFmKcjQBpPzjftvdTzgh9aJL+zJNQ82eOyXggEcSVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B4E3368BEB; Mon, 22 Apr 2024 13:14:07 +0200 (CEST)
Date: Mon, 22 Apr 2024 13:14:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH] block : add larger order folio size instead of pages
Message-ID: <20240422111407.GA10989@lst.de>
References: <CGME20240419092428epcas5p4f63759b0efa1f12dfbcf13c67fa8d0f0@epcas5p4.samsung.com> <20240419091721.1790-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419091721.1790-1-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +		folio = page_folio(page);
> +
> +		if (!folio_test_large(folio) ||
> +		   (bio_op(bio) == REQ_OP_ZONE_APPEND)) {

I don't understand why you need this branch.  All the arithmetics
below should also work just fine for non-large folios, and there
while the same_page logic in bio_iov_add_zone_append_page probably
needs to be folio-ized first, it should be handled the same way here
as well.  bio_iov_add_page should also be moved to take a folio
before the (otherwise nice) changes here.

and of course in the long run we really need a folio version of
pin_user_pages and iov_iter_extract_pages.

