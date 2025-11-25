Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4254A21
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070308; cv=none; b=qUyi5603xwQSSKbmG5JCdO8FWtU6x/JQBfJp5+wSQaY0pFOpmUbKpPFV8ggOaIzAOy+YxJwWh/VpGul5bq5/zLjs5Sj0QqCQ5fSBRjaGM8Qd7aOQrsUrU3/RgJOvx2wrmIQYRpuIPo+QRu046CfJsEiBvDJVfaMycdCP+408Vow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070308; c=relaxed/simple;
	bh=YLCa0KGEOXMfFb8UjNiMVXlPlvjXuBIpYEPA70WntSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqHD/naxQeZ3GIFZI6iB7ssO6/sFu9HJx7SeSIMzLtt39dLdu0Y9ivhOYh49ZGjBpCknLylhFpfIpAdVL6aCDeM1Q8fRBXpHBJPH6tSuISQ964DjmuHv+VUM+6iNWJv3QyHMIdtftOCDQJANtEFIf7z5iQ6Um3l4rI65e4T8W6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 617E068B05; Tue, 25 Nov 2025 12:31:44 +0100 (CET)
Date: Tue, 25 Nov 2025 12:31:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	ebiggers@kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv6] blk-integrity: support arbitrary buffer alignment
Message-ID: <20251125113144.GA22938@lst.de>
References: <20251124161707.3491456-1-kbusch@meta.com> <CADUfDZqrpJXLLU9V3eFJvRgth45-ht-yi4cSpmrBdnbfQGtWYw@mail.gmail.com> <aSTii9KbN6wQCvOt@kbusch-mbp> <CADUfDZogsF53MENLLyd0iCGKUoSqap3bEfSbt72KPifO4tvzfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZogsF53MENLLyd0iCGKUoSqap3bEfSbt72KPifO4tvzfA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 24, 2025 at 07:41:16PM -0800, Caleb Sander Mateos wrote:
> > Compare kmap_local_page() with kmap_local_folio(). They both resolve to
> > the same lower level mapping function, and folios have no problem
> > spanning pages.
> 
> Documentation/mm/highmem.rst seems to suggest that kmap_local_folio()
> only maps the page that contains the specified offset, not the whole
> folio:

Yes.  Additionally multi-page bvecs aren't folios, they just are
physically contiguous ranges.  So I don't think we could even use any
folio helpers if they worked, as a single range might consist of multiple
folios.

(Sorry for not spotting this earlier)

