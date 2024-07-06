Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90B41A94
	for <linux-block@vger.kernel.org>; Sat,  6 Jul 2024 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720253580; cv=none; b=nzOJdwXpZj3Hagbzh1w8ktqOCa6e5aOBuFajS8ZPRZ3F1QoUdoOdDa2jUrs8FumASAaamKpaWjvO+Xki7H/lW9L6YP0l+TvkUHyCxmESixl5c3zmiqL8MWZnTbiQzA9C/FE2rVQ7TsmoF4Fb9Rta79wJFs9E1zhlZYSOHBqtFK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720253580; c=relaxed/simple;
	bh=bng1tZo/TMZ99fGxt7AI25QHg9rf6iWHzLgarnO8GPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYpeXMVjnY3oD02qsCqOhFZueGTI8DCjwA4cuJATFf/geXlzxWbsXMlq6BCg1f7QVASH7HzDn4r29hcdUVvgZMx2l/K+t4TQ/ItNBkGr7UVgiZSwJ1jq0Qu9ByrLRd9zympiKaIf6/6Uihg1F3kwFAW8zbbbBkG1kNDzKJ7nAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6630668AA6; Sat,  6 Jul 2024 10:12:55 +0200 (CEST)
Date: Sat, 6 Jul 2024 10:12:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v7 4/4] block: unpin user pages belonging to a folio at
 once
Message-ID: <20240706081255.GC15556@lst.de>
References: <20240704070357.1993-1-kundan.kumar@samsung.com> <CGME20240704071134epcas5p2ec6160369e9092de98a051e05750bd4f@epcas5p2.samsung.com> <20240704070357.1993-5-kundan.kumar@samsung.com> <20240706081021.GB15556@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706081021.GB15556@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jul 06, 2024 at 10:10:21AM +0200, Christoph Hellwig wrote:
> Also this means we know the loop doesn't do anything if mark_dirty is
> false, which is another trivial check that can move into
> bio_release_pages.  As this optimization already applies as-is I'll
> send a prep patch for it.
> 
> so that we can avoid the npages calculation for the !BIO_PAGE_PINNED
> case.  Morover having the BIO_PAGE_PINNED knowledge there means we
> can skip the entire loop for !BIO_PAGE_PINNED && 

Braino - we're obviously already skipping it for all !BIO_PAGE_PINNED
case.  So discard most of this except for that fact that we should
skip the wrapper doing the extra BIO_PAGE_PINNED checks.

