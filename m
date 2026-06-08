Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FB7351C3B;
	Mon,  8 Jun 2026 05:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895363; cv=none; b=uerk/MaMuvi0WOdeKoMRMohKwkj2TPEQ2W3Qi5Gd643jreGYK/BNStdeqn5rN3Pyow3aFcRsd5ToYFbVTUt2rXtu7BL+t4qoNMU0OLNW/EqnyriABnhc4G3CYyIlgv8ERL8Z+0+kb3X/2L837q14rJMlVV4l/llfZdiyS1Q4Pq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895363; c=relaxed/simple;
	bh=0nv6nlIkvBiTD1u3V4UCm9ndYB57nlyx4ezw9HhOQwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTeCjDXbx9+wa4QDAdDhjlkwr2g2G9GUuIJ/QLk5HKyNt++/o4YAGHSsXmJtlLBbWKFnZC5fMDOnPA5WLSrJNzz0KlnvNO6uIOxw1lhme3n545AIGMjL0FryBEuuekb9onQFj6eR2fZWAUMdHfMphoG3FQEjOkQX+UXB2fnIS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A67B168B05; Mon,  8 Jun 2026 07:09:11 +0200 (CEST)
Date: Mon, 8 Jun 2026 07:09:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/4] block: add a macro to initialize the status table
Message-ID: <20260608050910.GB21313@lst.de>
References: <20260605184441.590927-1-hch@lst.de> <20260605184441.590927-2-hch@lst.de> <aiMZ-PXXQ-NxOHT4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiMZ-PXXQ-NxOHT4@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 05, 2026 at 07:48:24PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 05, 2026 at 08:44:27PM +0200, Christoph Hellwig wrote:
> > Prepare for adding a new value to the error table by adding a macro
> > to fill it.
> 
> > +#define ENT(_tag, _errno, _desc)	\
> > +[BLK_STS_##_tag] = {				\
> > +	.errno		= _errno,		\
> > +	.name		= _desc,		\
> 
> Bleh.  I hate this.  Before, I can grep for BLK_STS_NOSPC and find it.

You will still find BLK_STS_NOSPC itself in include/linux/blk_types.h

> After, I can't.  Yes, I know we have a lot of such things already, but
> I don't like adding more.

I'm not a huge fan off CPP pasting, and especially thing we should never
use it to define global symbols (hi page/folio flag helpers!), and in
general try to avoid using them as much as possible.  But I think here
the need to keep the names in sync with the tags exposed in debugfs is
more important than the grepability.  Especially as this sits in _the_
core block file, so it can't be easily missed.
