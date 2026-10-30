Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793322704;
	b=AfGD4uY14Cd7ipDOOe4lqes+YbZ1a3Hh0AW0mvzR3vZowsI14+pf4t4GKNjZFYZQ/Gtx
	 pP+EMdk8/cDjSNwu7fWmdAL1wGuxKKfvxZRBUlJmSl2yggW/Tujtse5K4yJ0p/WiH80vu
	 8pZgu2nL0t10aSdZ0EZ94T3tnUAQSZO1zYaAe6mDkGRNUpQTfwnvkoJlVQVbm0u6tOFTB
	 oDfkJkM5ORsKuvXug4gZm15o61zc6W/FZo7xECeemV8FrDW8/6D75UhdrMDTW7Ar8PqiR
	 SMe9Wb90NxdiVSChhSRB//0eQTgtX/ZSWZM0UNjmF5/4bG5s084bVUVgzPeLQw2SwnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793322704;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=tgtuNNBFFB7xe0qBe8dGzhZDn8Gpip/Q2jXZbv9lnAc=;
	b=zqNvyrzM6erRHiJM8CKIfCg8C+IRcooqm47e85Dhp2VsGelHK1uXeo/GFbqys2v+pmE2
	 RvyEh+n7+x74qULYLBvfcG5DsG1RQjq01S7cJo3Eon7qCRHmZGJfr+UVUaQOuQh9ZHymK
	 98w80tJEvHL0jq67Xw2C9slFO0YxeVzo0RNe1t005OUksqrS6X/IbT2TTUbBo0VM2N7M1
	 rpISezBTUIl6f6c2IIT65IU5xu00/lGfY5w+XqFDHuQup7TZesLsxkPPevWIA0+ikNY7P
	 fp7+qonnjCHwAj6UWS8aaE5g1aukHuDK9Gr4EVvgQyp/U6C3q3Y9ADzlEEHoDL79FPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BvpWeHou;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F2606A31A
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BvpWeHou
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865E71F000C1;
	Fri, 30 Oct 2026 01:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793322703;
	bh=tgtuNNBFFB7xe0qBe8dGzhZDn8Gpip/Q2jXZbv9lnAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BvpWeHouZBTziTgepMF3fKGePe6r84OdV5sAWUi2Cm9J8y0ImhdFmasW0WeQk0Luw
	 dmgpLlYCKJBvp8a90BuVHIn/hQt8flDAmTZliTw0rzmRgVSy1f7Kt3mMv+fuQPa3aw
	 PFtZ5dMFyy4tXgrlPELxF0AbKZ1GEfu3VQL1x0+DsTyRJqNoDodDRkOVR2E5oheFwq
	 FDvIvNdsEcKi//fiYoS9tVjlHaqfyTxFf5SgaNEbJjThtbErDnCzmr+ImgOhU4zeaQ
	 VtmaxUqC4zr/6O6uu4QAF8QW+1VuXX7PDyUivuAigq8wT4s6fX3m7MjoddPUnM/B+a
	 FlDYW8UW3/e3w==
Message-ID: <2b8611f5-91d1-4059-9f9f-7918fc8f3ab3@kernel.org>
Date: Fri, 30 Oct 2026 08:11:39 +0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] zloop: check that the zone backing file support
 ->{read,write}_iter
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
References: <20261029150353.2503201-1-hch@lst.de>
 <20261029150353.2503201-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261029150353.2503201-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/29 22:03, Christoph Hellwig wrote:
> I/O to backing files requires support for iter based read/write, so check
> for that upfront instead of dereferencing a NULL pointer later.
> 
> Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
