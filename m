Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D21DE2AD
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492029; cv=none; b=u5MSEQ9MzzJ7ymKaVAn5tePEuYlAoOckNdqe9Kajp2KxhQ38AFPJZJYv6jN0K+TNTjoQPkjn5jQE90vzTs+STHyFbehUz+1D/bG3tt5e6j5VucY+vpya5xXCco2F49owIV96XRUgOUywIB3uw+iuOWpkxL7deW5DxkvH4Wyqh5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492029; c=relaxed/simple;
	bh=b47UGLwt56TeDovbyOpUXv+AsExc2S3/fsI3YI09x2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyYTcXHOb50BJEo/XBrR3L6Ytn2jAT9hyw/hVEoyJqqy7D+jA7tlUeYZJtkyOOaSgulow0g8544Smh7kF4koK0P7fnFNoMAF98aHCFNez10iXZmTI5xZIVceauyVTtMln/shvBc1WpBhxOib8DKpUIktRqhkRwbTnfJ1P2y2TM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9FCEF68B05; Wed,  6 Aug 2025 16:53:34 +0200 (CEST)
Date: Wed, 6 Aug 2025 16:53:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250806145333.GA20102@lst.de>
References: <20250805195608.2379107-1-kbusch@meta.com> <aJKLGy9UkVjJTIIQ@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJKLGy9UkVjJTIIQ@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 05, 2025 at 04:52:11PM -0600, Keith Busch wrote:
> On Tue, Aug 05, 2025 at 12:56:07PM -0700, Keith Busch wrote:
> > +	bv = next->bio->bi_io_vec[0];
> > +	bvprv = req->biotail->bi_io_vec[req->biotail->bi_vcnt - 1];
> 
> Hm, commit 7bcd79ac50d9d8 suggests I missed something obvious about not
> being allowed to use 'bi_vcnt - 1' for the tail bvec of the previous
> bio. I guess it's some stacking thing.

It is bio cloning and splitting.  bi_io_vec is the original payload added
to a bio, and directly accessing it is only allowed for the submitter,
i.e. usually the file system.  The I/O stack always need to go through
the bio_iter to deal with split/cloned/truncated/partially completed and
resubmitted bios.
