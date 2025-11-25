Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E58218596
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089173; cv=none; b=mISRiR+zFuZIdylCbzBwh34Lw9cCN5TopSMl9Vd/H9XXdrbUfJzuG0cUE6KpVTmmHuBIcnq/3+iORjt+V0gkmuKN4kKXqs7xbLZ86a8eUyGBQT0ar0sv3QJglZqMdLg1BS1qbqn+CBp6FjARRTUflcKutp+nandyjd794AuH0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089173; c=relaxed/simple;
	bh=G+l7dVGJyTTD/wxHThESNdCvc2GTGRpiI5OMErK45oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fpmiy3PqSvR0LT7eQApSBa00fdpE7jHwSHCiNXtAKBgFygeRFS9goo84yqvHH/9B0roJBj2eKwfHY4BQOTqs9xTcf+Gl2vS4RrCK3+bq0tWSjvBwz+pwEsZw7n1EaWVtJB0weWQT2Cod2C6tPeVT+v5TgYDnnLTkxGg1bonBlq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 620E467373; Tue, 25 Nov 2025 17:46:05 +0100 (CET)
Date: Tue, 25 Nov 2025 17:46:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, ebiggers@kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv6] blk-integrity: support arbitrary buffer alignment
Message-ID: <20251125164604.GA29226@lst.de>
References: <20251124161707.3491456-1-kbusch@meta.com> <CADUfDZqrpJXLLU9V3eFJvRgth45-ht-yi4cSpmrBdnbfQGtWYw@mail.gmail.com> <aSTii9KbN6wQCvOt@kbusch-mbp> <CADUfDZogsF53MENLLyd0iCGKUoSqap3bEfSbt72KPifO4tvzfA@mail.gmail.com> <20251125113144.GA22938@lst.de> <aSW8G5C--oIzmfJa@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSW8G5C--oIzmfJa@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 25, 2025 at 07:24:27AM -0700, Keith Busch wrote:
> So the solution is to replace mp_bvec_iter_bvec() with bvec_iter_bvec()
> to ensure we don't cross pages? It's a little less efficient, but that's
> not a big deal.

Yes.  At least for CONFIG_HIGHMEM.  Note that in many places I actually
found that open coding these macros leads to nicer code, and with that
CONFIG_HIGHMEM ifdef that would probably also be the case.

> I assumed mapping physically congiguous memory was contiguous in kernel
> address space too,

It is.

> and that seems to work out in testing, but I don't
> have CONFIG_HIGHMEM enable where that might matter.

I keep an x86_32 VM around for that, but I usually only fire it up when
it's too late..
