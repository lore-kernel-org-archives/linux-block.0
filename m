Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644DA12AAF0;
	Thu, 23 May 2024 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451956; cv=none; b=EpSAFIMv7IWlq1V447J9yJ8OyzOaoER4fI9ANWyUrNgge8yIkaDwLUTbpTaBkgzVdvMkzbE4kjarFZbJhYjgaD1WDTxZ6sax5C4RBHaXfbmhrwiOXWgoVSYPyK5k6ZGbUJ4HrSZJS3ACaJC2NhB0QpnsL8NouJsBgui0noSAyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451956; c=relaxed/simple;
	bh=GiS0l/t/EMbiG3Fc4pwBgmlqOQwWN26xi729dZ1J9bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O11YB2qbhoDDH6G5E7iiAxCAmpph0hI2CiOFs9NjxGbwJodnPO5h/CdRWchDWypdv/IHKHDxfxOTlYPpFg4S16Jj82Z5bla1yIVKs6SePFpO9ajT8a7fXvwGPg2n05wB6ymLAUr5WUxBQQ36rg0cvaV4D1ebBgC8uvt4ptYxmP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 278DC68BFE; Thu, 23 May 2024 10:12:31 +0200 (CEST)
Date: Thu, 23 May 2024 10:12:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@kernel.dk, shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com,
	hch@lst.de
Subject: Re: [PATCH 2/2] loop: Test to detect a race condition between loop
 detach and open
Message-ID: <20240523081229.GC1086@lst.de>
References: <20240521224249.7389-1-gulam.mohamed@oracle.com> <20240521224249.7389-2-gulam.mohamed@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521224249.7389-2-gulam.mohamed@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 21, 2024 at 10:42:49PM +0000, Gulam Mohamed wrote:
> When one process opens a loop device partition and another process detaches
> it, there will be a race condition due to which stale loop partitions are
> created causing IO errors. This test will detect the race

This isn't really a 2/2, but a single patch for a separate repository.

