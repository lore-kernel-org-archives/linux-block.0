Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761792BE63F;
	Mon, 23 Mar 2026 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774248263; cv=none; b=VESU4/Gu5yqNhAxsG0e0/py/B/4AFHbcNOwWNjzIKRmTAgUB7E54KK6yF4L7fm1LaKoIWVmnLiVrhg6tI9D+PwR1VEN7DV1hTcRQOhFUCopHEnC5MDVZJ2OapGsfM06hETMVgcUTMnDVSiLC5oYuYqyvV8WJziqillP5ekFt1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774248263; c=relaxed/simple;
	bh=FZ3Pis2uRLgT04RfGMxx78Df96VS14JIQP0mkVvBkLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Id8TT6jo4mKFm3KAUSV/y6XEl8scu5u4lkgObfmGiCw935iFCbrLvuJkeU0tMv7Pvl/0hJ7wx8xO0vtlcvLCNJdPI6flBmsqBvBeo6DzgtwewX0pNf+gvcxxjCVChh6FkcUZdPWJcRtMj18zRMozH5CoP8munqa579V1A6ZKBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D7AA368BEB; Mon, 23 Mar 2026 07:44:17 +0100 (CET)
Date: Mon, 23 Mar 2026 07:44:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+09ddb593eea76a158f42@syzkaller.appspotmail.com>
Subject: Re: [PATCH] block: fix bio_alloc_bioset slowpath GFP handling
Message-ID: <20260323064417.GA24833@lst.de>
References: <69bdcdcd.050a0220.3bf4de.002f.GAE@google.com> <p01.gc6e9ad5845ad.ttca29g@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p01.gc6e9ad5845ad.ttca29g@ub.hpns>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Mar 22, 2026 at 03:35:10AM +0100, Vasily Gorbik wrote:
> bio_alloc_bioset() first strips __GFP_DIRECT_RECLAIM from the optimistic
> fast allocation attempt with try_alloc_gfp(). If that fast path fails,
> the slowpath checks saved_gfp to decide whether blocking allocation is
> allowed, but then still calls mempool_alloc() with the stripped gfp mask.
> That can lead to a NULL bio pointer being passed into bio_init().
> 
> Fix the slowpath by using saved_gfp for the bio and bvec mempool
> allocations.

Looks good, thanks:

Reviewed-by: Christoph Hellwig <hch@lst.de>

