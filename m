Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5421B28D
	for <linux-block@vger.kernel.org>; Fri,  7 Jun 2024 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717738839; cv=none; b=cErzCzo5cTl/sC2J2bw20QaYr37xqZQNnL6TbXc5/sh/d8CKN8zHQZVRbivrVW9Om4EZGEALLMyNd5MTZbWGiE0jg5Z4tRVvG6F8go70LrRklxDwnxksXqD0QB08JbpBiFR92MxNxDkU4uqjlXL/nJhCol7Lqwr6eckqNRpNyUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717738839; c=relaxed/simple;
	bh=kkEqM0uKMD5znji1pe3cNCTUUmlSgo+IZRtJ2wJBNKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7POQ/wdbxT6Cy7WqGaV+ELo01cxhK1VFTrLOxHffrqT8i+4+Cke5uh372UdOaOxYLfmA92iZ6yWyVk3UKZSMqzyB98/H7A33stXsMK460d2C9Dzln84keQaovRdVmUPfrzdy9VUXzm7TKZJS/7CA0OK44V+yv+F5dV+m4Sq4qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 30A6468B05; Fri,  7 Jun 2024 07:40:34 +0200 (CEST)
Date: Fri, 7 Jun 2024 07:40:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: initialize integrity buffer to zero before
 writing it to media
Message-ID: <20240607054033.GA3631@lst.de>
References: <20240606052754.3462514-1-hch@lst.de> <yq1msny6ucc.fsf@ca-mkp.ca.oracle.com> <20240606141017.GA10730@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606141017.GA10730@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 06, 2024 at 04:10:17PM +0200, Christoph Hellwig wrote:
> > We do explicitly set the app_tag to 0 for PI so it's only non-PI
> > metadata that's affected.
> 
> Ah, true.  I could switch to then just zeroing the buffer in
> ->generate_fn for non-PI metadata only.  That's actually the
> first version I prototyped.

So that would cause a fair amout of conflicts with moving the integrity
information to the limits.  So unless someone objets I'd like to go
with this simple version, and with that series we can then easily
relax the zeroing check to only cover the non-PI case.

