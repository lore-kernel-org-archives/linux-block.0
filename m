Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2532CCC1
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 05:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745386419; cv=none; b=hMFF2ddoC7WGg8Xcs9dqvRYrEuBFVjJUJhSSt2zoXdqY/9rucIoxIDaECm3dMa4XohRJnbGRnEkEsGgme/EB6rdGCLdQtagWUm4m+6EJSIwRx7sq0ExsJAe5HPd1Y6UgwtG1xUuqF1Aot9q+qzdoutKWntrWme533xnCgsuw0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745386419; c=relaxed/simple;
	bh=HGhiS7hvt9IIyLP+Ar4BAZXMZ4DSA8d3OaBys9JkNSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDwJYwipTYksSWXD/DO7uQyU+/0bOZINKKtvTgQ/hE8DVYCRJaxfyx2XQfrZwteBFaimju8hmAOehEKOyrzr9jSGsCO98m+auzUlAIGhRB/iUpnS8AJcW2IAnj52ZWhzLqB50fab/vrIlZOfvbWJvBu/Qi6bs3xUujMCbBns1FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0yqBgHFj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0yqBgHFj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2R2Uwm2W/xsx1uDfl+ypjxS38Szxio+2XCM3jzDr198=; b=0yqBgHFjvlvKFZc0e/LNrdjmuB
	pGSbGkrjyXUPe6mtQ7yOyLnZC2AN2SdKOqQiVR+cCtxVTCvfH+X276VZeC3kDU1ingDpdfKtoZq2N
	m94u7WpJmrDcdqSCDkXmI4ok5RhrvU/LbANYySkeyJwfK3QNDAYYzV5DQP1wmH3Du0aCMOWvoMzGZ
	zmERvnlfpGOAxT8sCWztRtDQ8PXPawws71MY5GmJUaK2mlOdJbYMvHsIP8tvfrm1rmSVRSVRjvAWt
	iLAlPuN/9Q3XxL+OEkww3N/B/3KM3Jp9ek8DpJateQu0gy7BqnGC1e8uZ6XfHd4v2oj1zoC52EVZ9
	l5YPt+jQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Sjn-00000009FIt-4AS1;
	Wed, 23 Apr 2025 05:33:35 +0000
Date: Tue, 22 Apr 2025 22:33:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, "arnd@arndb.de" <arnd@arndb.de>,
	"ojeda@kernel.org" <ojeda@kernel.org>,
	"nathan@kernel.org" <nathan@kernel.org>,
	Martin Petersen <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/1] block: prevent calls to should_fail_bio() optimized
 by gcc
Message-ID: <aAh7rymjazruoMTM@infradead.org>
References: <20250417163432.1336124-1-prasad.singamsetty@oracle.com>
 <aAYxSOxeM-mQgNyF@infradead.org>
 <91C42F53-51CB-4529-9139-3CF4AA2DD935@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91C42F53-51CB-4529-9139-3CF4AA2DD935@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 22, 2025 at 09:58:34PM +0000, Prasad Singamsetty wrote:
> We are also aware of the block filter project that was active and not sure about
> the current status of it. We will look into that. 

Please help with upstreaming it and your code depending on it.

