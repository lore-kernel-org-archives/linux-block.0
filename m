Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B8198A17;
	Tue,  7 Apr 2026 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775541178; cv=none; b=DZFFB0OnWHbQCuJ5q1hdUuHGRr6/XMJEZfDpkyvhWorTJh4hyrWxolxorSJeVtV0bxZaj4m3VYJlEXgB6/CYVnSk1/6z8jwDYffeQBY6S5TDwXQ1A6Sat+JS0emrKieEfKmpYEfUcPVSH2jiMBEXsB5Hz2OcXWCI2D9WHaTJURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775541178; c=relaxed/simple;
	bh=lRXkdSqKL6I2vyoLgfSia3nnmSOzcseIUyxj+jXwjmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXfKwrdWCilycZmJ8d0ajX+PtzCSUvrYRPmNjqect41sPmqerZa3+BlSsM84m7PqlmFPRM94x9gLVsJYTUjdppN1R/27vXSFS23RTf68CmA9GCTwqVtGAoO1yDqt6vYtLs080p225y/SDhfonGgP9Xk7UfONZ9cOWk1pYBu8uvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 62AC768C4E; Tue,  7 Apr 2026 07:52:47 +0200 (CEST)
Date: Tue, 7 Apr 2026 07:52:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 2/2] block: allow different-pgmap pages as separate
 bvecs in bio_add_page
Message-ID: <20260407055247.GA6405@lst.de>
References: <20260401082329.1602328-1-namjain@linux.microsoft.com> <20260401082329.1602328-3-namjain@linux.microsoft.com> <20260401140850.GC21703@lst.de> <70c82c3a-d135-4877-ab46-c15d329815f5@linux.microsoft.com> <20260402053057.GA11783@lst.de> <d48427c2-9aa3-42a2-a8d7-43a7a3b3b685@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d48427c2-9aa3-42a2-a8d7-43a7a3b3b685@linux.microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> -               if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
> +               if (!zone_device_pages_compatible(bv->bv_page, page))
>                         return 0;
> -
> -               if (bvec_try_merge_hw_page(q, bv, page, len, offset)) {
> +               if (zone_device_pages_have_same_pgmap(bv->bv_page, page) &&
> +                   bvec_try_merge_hw_page(q, bv, page, len, offset)) {

We still can't merge merge pages with different P2P pgmaps into the
same request.

So the zone_device_pages_have_same_pgmap check should go into
zone_device_pages_compatible and we need to stop building the bio
as well in that case.

