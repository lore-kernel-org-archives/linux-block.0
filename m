Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A97324B1E
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080670; cv=none; b=NuTRbYlNIe7rT3nf63kS/YvkhmsHnO11RryyKPqljSlInritcHo5ljlk7bhBR77vUpqBL6UVcrtihefq/2S4h73prKaJGzwjniCy7sHYBFdO+gsMxQ62gsqoL4sM32UY0+Lt7tePZ4fL4QndLDkGw3+YVyzBHspuQSMevRDqa9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080670; c=relaxed/simple;
	bh=MezJzhASO2e9xrE2sHEwthvBryILQEMub5d/JE7o7Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECUV+CqjvLBDwlGuFptjj7fRSAcvG8m2TsDsqBwqO7OeVhyfQMD0tqi3k/CZexN1kSMRLXnLIA61SenDGQuJg0njW1zWJNWy8XBQpw/928mQAKNqH2vPWopKxf92kn1KI8pFm/BheiweevE1tZz5BdtvzYqrwFtjGCS+LfHk62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMH1SEXh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMH1SEXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34079C4CEF1;
	Tue, 25 Nov 2025 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764080669;
	bh=MezJzhASO2e9xrE2sHEwthvBryILQEMub5d/JE7o7Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMH1SEXho3ff7a0otspPzHA6iPTtTOcK2WObLrll4n618VwhWIHdujuemXOhGyr02
	 IhO938NZpyzAed41JgiLtbWXWr1tAsHOb/YX+KkKFFSfS235IMKj3tYSQ/GaA1eR4J
	 vwac5byKM7WPR+svdVPjEyjoxT4049WKUpwaT1Kbk0Sv3u5IICBK9uJPUmusPDlFo3
	 f1RC1Fk0+uU2SOC6n9hmKt/sg8skQbTkDQGhG9MXxdSaxAjdKsM8uH+mWB7GZDVgeK
	 MJ4n7TqJljrgHt7KYGRj3E4AtjWrjK9SuyaNPW4ugXbvM/yorQVffcS3JefTtPmbCW
	 IIqXk/9F8iWjA==
Date: Tue, 25 Nov 2025 07:24:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, ebiggers@kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv6] blk-integrity: support arbitrary buffer alignment
Message-ID: <aSW8G5C--oIzmfJa@kbusch-mbp>
References: <20251124161707.3491456-1-kbusch@meta.com>
 <CADUfDZqrpJXLLU9V3eFJvRgth45-ht-yi4cSpmrBdnbfQGtWYw@mail.gmail.com>
 <aSTii9KbN6wQCvOt@kbusch-mbp>
 <CADUfDZogsF53MENLLyd0iCGKUoSqap3bEfSbt72KPifO4tvzfA@mail.gmail.com>
 <20251125113144.GA22938@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125113144.GA22938@lst.de>

On Tue, Nov 25, 2025 at 12:31:44PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 24, 2025 at 07:41:16PM -0800, Caleb Sander Mateos wrote:
> > > Compare kmap_local_page() with kmap_local_folio(). They both resolve to
> > > the same lower level mapping function, and folios have no problem
> > > spanning pages.
> > 
> > Documentation/mm/highmem.rst seems to suggest that kmap_local_folio()
> > only maps the page that contains the specified offset, not the whole
> > folio:
> 
> Yes.  Additionally multi-page bvecs aren't folios, they just are
> physically contiguous ranges.  So I don't think we could even use any
> folio helpers if they worked, as a single range might consist of multiple
> folios.
> 
> (Sorry for not spotting this earlier)

So the solution is to replace mp_bvec_iter_bvec() with bvec_iter_bvec()
to ensure we don't cross pages? It's a little less efficient, but that's
not a big deal.

I assumed mapping physically congiguous memory was contiguous in kernel
address space too, and that seems to work out in testing, but I don't
have CONFIG_HIGHMEM enable where that might matter.
