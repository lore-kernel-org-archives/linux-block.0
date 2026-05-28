Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944ED37996B
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956967; cv=none; b=c0UtQlSf8IsqQDCznkxwxObmt+zP3OUxU8esNFY56paibRjUHeMrLFcmnnr8F+0/LcilI3rVX/35vUpUfQWFjHwIZkA43QjJFsZUQWZBCD7N+tC8zkxWMwW/5vu2dHOpwYqH5eaUDnD4PSOVAbwVilSB4DsiAAzf+T5eu5sAGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956967; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ixs5PdKE0HzZspCj+2E/7AEOoEi/+oK5WKR8hNtasJIDfx9BJD85lu+Wa2bXJmm/gubCWqSekF9b6UsFGLQ/bRMoLkEssHHYuSwklOigPvF1if5e0yaN2ktNFaGtxYN4EFO2Ktb5J4qIlQBcya+tTN2oQoIX4Af3plEhqMEwgmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 918E168BEB; Thu, 28 May 2026 10:29:23 +0200 (CEST)
Date: Thu, 28 May 2026 10:29:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCHv3 2/2] nvme: add support multipath passthrough iostats
Message-ID: <20260528082923.GC6893@lst.de>
References: <20260528010041.1533124-1-kbusch@meta.com> <20260528010041.1533124-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528010041.1533124-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

