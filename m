Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E23B4EBD
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506527; cv=none; b=HpOCw1SeoYYp4kipxphgySNosHUx5fh3CY6Xu47TMR8O0p1xIVKGVLLKq9ihTuKEh41zNEBhkk2g3DPkogC6bcFGCFXg90SnThI6Jp4kqPlKK/jFDk56PT31d0/v9Kmg68/S5nhWfRN4SBoWTr+G+pVsQuXh+OFCfkMoDpvpMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506527; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPnvbvhtlO86x+wBZrl36ok8fw7TkBdS+fouZmJnJiQ4cNELcy7KDwuTsTpTHgMHSTGxcNZX0aBiSGdtd7x3ZmPIUDZ2FioRUc56uYg71Pu8TD6F/RhtfJD+vfB8BEduMYhIuylGdgsLBeg23GrUlTbDzNd3MYhf2Oq0YsdllHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F62068C7B; Thu, 26 Mar 2026 07:28:44 +0100 (CET)
Date: Thu, 26 Mar 2026 07:28:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 06/26] block/crypto: Annotate the crypto functions
Message-ID: <20260326062843.GG24071@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-7-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-7-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

