Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985FE19AA4E
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683023; cv=none; b=jmIMSRtXtjZmmcRHhgrOxRlBSHsEFj1kZRUXeUyrL4PgJRFDnLQRhP1lCNuGGJyxXdDkv40mU4F3nJ3Xg4/JATGMVbEpxNgMILJR/l3rznu1BG4n//RdtdG2HQugJ+dCHsX2CG4vlgStMHN0GIrs94HqPWwqLI7wCYOFnoEa/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683023; c=relaxed/simple;
	bh=XTN9AX0O0MMDKcNkQrlQAGXMVHqfeMUsYtl3Pl+N/B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ0MmFi31Je0ClqAUS6DK0/hwRvvkjZy+JfxsPKaC3e0+ZEcSpGPCtP2FUp3SX3Ue5siD2seQGO5LCp0z8sQS2GF70zT4Zsgyg8tAvtAnU50l3fMNCnMxWGPwaqZKLL2xxHW8gB1GiiiOKkHwEohXiWXoJdGwYJic9zPGvCugis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 940F468D07; Thu,  6 Jun 2024 16:10:17 +0200 (CEST)
Date: Thu, 6 Jun 2024 16:10:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: initialize integrity buffer to zero before
 writing it to media
Message-ID: <20240606141017.GA10730@lst.de>
References: <20240606052754.3462514-1-hch@lst.de> <yq1msny6ucc.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1msny6ucc.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 06, 2024 at 10:08:20AM -0400, Martin K. Petersen wrote:
> 
> Christoph,
> 
> > Metadata added by bio_integrity_prep is using plain kmalloc, which
> > leads to random kernel memory being written media. For PI metadata
> > this is limited to the app tag that isn't used by kernel generated
> > metadata, but for non-PI metadata the entire buffer leaks kernel
> > memory.
> 
> We do explicitly set the app_tag to 0 for PI so it's only non-PI
> metadata that's affected.

Ah, true.  I could switch to then just zeroing the buffer in
->generate_fn for non-PI metadata only.  That's actually the
first version I prototyped.

