Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5691F9408
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734588037; cv=none; b=tJN1E2OpEoy9R5bbn3ZfK3L2hB8lQYvBjb8/kVYeyIgqsAdmEyAemc/d/NW1+hWllov1dA8l+gjx6XkyPDDUACq6g5nv4sAH0zoydn7mxiK2UNvMLIvyZE5uu3n2oh9wwF5fKpuXnSaZEF1Hsgm+oFzreA2HM7kE8TKOZNUJFTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734588037; c=relaxed/simple;
	bh=hmYO4K6CsWXM9vVjgfAGVLY2Ms/MIwV8YMUVheinAfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS2rD9nB1ZldIa1tNuKSUrSWvQIwbGI71h80rI4JqRdw8b2jXFktcxeUawangfKyGnpOoShAfgrCHQ+9ezhEjKPGlIqFd27LeYvX+qfJaT6pOxE+IPr0wmmCgm3N3zBJ4ImlWmunYApVFRXTiEPGUPYinz1+X5MysI5YCGi+hm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A059E68AFE; Thu, 19 Dec 2024 07:00:30 +0100 (CET)
Date: Thu, 19 Dec 2024 07:00:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Zoned storage and BLK_STS_RESOURCE
Message-ID: <20241219060029.GB19133@lst.de>
References: <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org> <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk> <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org> <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk> <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org> <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org> <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org> <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk> <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org> <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 17, 2024 at 12:41:50PM -0700, Jens Axboe wrote:
> As per earlier replies, it's either -EAGAIN being mishandled, OR it's
> driving more IOs than the device supports. For the latter case, io_uring
> will NOT block, but libaio will.

And that's exactly the case here as zoned devices only support a single
I/O to a zone and will have to block for the next one.

> Like Christoph alluded to in his first reply, driving more than 1
> request inflight is going to be trouble, potentially.

If you rely on order.  If you are doing O_APPEND-style I/O on  zonefs or
using a real file systems it's perfectly fine.  
