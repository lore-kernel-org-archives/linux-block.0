Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3824C9D
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430938; cv=none; b=rHVC+gheMoHf4fBAv6nKupIPCp/odUMKf75mFqAuWI3kPO3DlTQIpnJJeXkaSXYJWTSnYbMMFL1f82XBieTG6Auiop9hlvWAoSPFpdu8YePu88M7czKGRVTYLou/QefWBAWL2pT0eXH0R49Wb+hAtiXuiAsPgfyMefuS6iOnflM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430938; c=relaxed/simple;
	bh=fR0mRgX/KKIEA3HzpV5QWIxO7SBOU0WNSsmZfOdUW9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5DZ/+X9HKRdSMmlGZazvKlnWt9VdB6hLOzUIKvafqJlt0zyijIMi5JDvbELsHIRh24nnRrYCze09x2EgrO3/WueZD+u2v1Z5ndPPlTKKrhEaNN71ZjSu1N0dDvxdfwyDoUb6VtsJNtiiK3O+G1wLL4nQRBakelHjut43fjQfV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B9D4227A87; Thu,  6 Nov 2025 13:08:50 +0100 (CET)
Date: Thu, 6 Nov 2025 13:08:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: Unexport blkdev_get_zone_info()
Message-ID: <20251106120849.GA3115@lst.de>
References: <20251105193554.3169623-1-bvanassche@acm.org> <20251105194703.GC5780@lst.de> <f7bbb2a2-8342-4fd0-b906-7be5f5e59721@kernel.dk> <20251105195146.GA5998@lst.de> <72910b6c-6871-4f5a-b40b-0bd58329e264@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72910b6c-6871-4f5a-b40b-0bd58329e264@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 05, 2025 at 12:56:49PM -0700, Jens Axboe wrote:
> Let's just defer if there are planned users for 6.19. Once we're in
> the middle of that release and if no users have been added, then we
> can kill it.

Yes, if the users don't materialize in the next merge window this should
absolutely go away.

