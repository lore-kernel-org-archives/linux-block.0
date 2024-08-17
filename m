Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA159256E
	for <linux-block@vger.kernel.org>; Sat, 17 Aug 2024 04:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723869366; cv=none; b=ShrgeUcGTw0vDWDlonndZ49kF/CQkbl/Av9xTLkksav5WgSfbZY5UA5z86e1CgpYAKASZFInAlHollutgsby1sonmaADYldpLAiahbbRDqukJZnuPM9qYJVTp7KKsXGU5iq3HJ7tdWHMJ0FLcp+/RneustGAdg2KdgjrmnhIWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723869366; c=relaxed/simple;
	bh=sHlvrveK9fiQ+kK1lv6NsqXF0ujwSDu1LjjaqD9aUrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjdWp2F3rWKtnQoNR4vo7Mmt2v9zNpjH1ruFeD8VRswBiR2MV/IKvasf9HhQgWGnZKnjmrqe2i03rK5eDQRYo7JBlnMCf3GKvaHPIxTFNYs/2MQn5qo7THJ14xusjYi9ZIif32tHuqhjoGI+3V4sLdegrI1Dol67oDOBXIN21Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QKsrTksG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QKsrTksG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GeYPCOVsoeJ/BIR1aFSrsrFziI7YRTnx3KR7n087BBc=; b=QKsrTksGEFABthPH/m0/xr/1b2
	toROpKMPHVVgr6AyA6vxdH5JUVedxbBLHRrzpT8WCRwoqY4K+jYqcGk2IPeudeSc6jfn/jUdPQ05K
	Fpd3p2EWMQwy/rosodumzU8gyg4ObnC9XRYoI3RwXpMOzFGSuXpFh0uLthPqOY0EIvE+ok6gU80UP
	WeWdPk6KwlDNW0EQeQ6RC56zwHVjKjmTz3KKqkuaBFnSGNu7tpd8jlAxh+cdlGoocc7EiLt/KPxRH
	psJtIbY1vaU7bBD03IHOhWBf87IpBNLDPOch4YesvujRn7sxbIKgsDhGVeATdJK0M5nLwwYoupI/k
	87s7YHEg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sfBAX-00000004R31-0Pdn;
	Sat, 17 Aug 2024 04:36:01 +0000
Date: Sat, 17 Aug 2024 05:36:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v8 5/5] block: unpin user pages belonging to a folio at
 once
Message-ID: <ZsAosHAJNWAM811a@casper.infradead.org>
References: <20240711050750.17792-1-kundan.kumar@samsung.com>
 <CGME20240711051543epcas5p364f770974e2367d27c685a626cc9dbb5@epcas5p3.samsung.com>
 <20240711050750.17792-6-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711050750.17792-6-kundan.kumar@samsung.com>

On Thu, Jul 11, 2024 at 10:37:50AM +0530, Kundan Kumar wrote:
> +static inline void bio_release_folio(struct bio *bio, struct folio *folio,
> +				     unsigned long npages)
> +{
> +	unpin_user_folio(folio, npages);
> +}

Why doesn't this need to check BIO_PAGE_PINNED like bio_release_page()
does?  That should be explained, certainly in the commit message or
maybe in a comment.
