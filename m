Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793322692;
	b=1ebPgSg4YB8vst7dfGymknFKZJLA223Irh2uTiOtI+ybx2wDTMZEhjcuGhJ7KJmktJ51
	 A1PytS0ZCeYj6kWYLDOxtk2ewBwtLzLKbve+fVXstt6Xyw6yu7DDJIwn15hpf09k4p4Ck
	 33/Nk9iFG7fCOrmGSTc1jwJUvEso+bjp1pLEyUxKjWCHRbqAy8fISjx+Q7dPUFA+XVPfn
	 Yku8PRgrL5dqX/1bfop+u3+a2kBlP1KQmCHLdLXB8VCqsY/2aAdeA58N/AiOJ4bh9rrfF
	 rDF9oiwtL0RJ0ruG4g/cpauBLP2/vwZgYcP5waVLjJoh1iApFNgH7pPvC59qbzQYUpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793322692;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0AFEeeesocWWC1LI/Q8q5tYpYCLtd1ZN5bSFuDImd7Q=;
	b=Q+l5N5R+pC8/FykjXot8aNDV59av4Ppj6/H9HiXi/fGsKuD9wkbM4v25nmxfVXOhT9x3
	 YGIvIljAzrV2vvfE0EWmjL6elotRJ77C0LRJhNrutKxOGuwwXGU3LM7XLD1Vg/or5sYsr
	 8osruIPN118KcwpxuwBEzelj2nF03US1y9zJKp8QS2jty3G4yMuEl+FZBbbAlAOKxpyKv
	 Pa7Hq4N5PwnhG2CscqPA/DlAgsrvjbls1RyUxzfoT0f6AF6EWYWZrVqwp7XAlO5qu/Abp
	 KPq7RSLuOxZ3ey1ni3q86sDTrlW4pGwUq1XfYX12fazgTNvSJ1zXeNpvqbFy0tFIF4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fy3cruaZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51FA606A31A
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fy3cruaZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B898D1F00919;
	Fri, 30 Oct 2026 01:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793322691;
	bh=0AFEeeesocWWC1LI/Q8q5tYpYCLtd1ZN5bSFuDImd7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fy3cruaZb5D+U8wvXIncQJr7III2StYXM6S/GdyBS30shiAwXV/U2znHyFvES2e/s
	 fX+07eL1jrkRFPQrO/m0fZukfTZavRKhQXZY1tOydqxrfdOaaJY/+3y5WSihkTitkL
	 lwWxnHsPON4FH2nkYOOc/Ajrh2oBX8mLvpZoI7y6TuJ0VyePr+54KRhHm/fj3+LVuO
	 vi31omlyry5/iYmAkeOSswM/UlBhLpuW3aiG//Fv7OIdvxnBX9nHewLEyBJvdX5l6A
	 k4UqUKaWRSF34XboabkA/x/T3UfulC1Cw7+9uTm0NhZKfsGY74F+Db3WK/B94WTDIu
	 SWIdTv74IDR2Q==
Message-ID: <a74fd6da-4753-424f-8aad-ccd190f5c3e5@kernel.org>
Date: Fri, 30 Oct 2026 08:11:27 +0700
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
Subject: Re: [PATCH 3/4] zloop: fput file after failed zone init
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
References: <20261029150353.2503201-1-hch@lst.de>
 <20261029150353.2503201-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261029150353.2503201-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/29 22:03, Christoph Hellwig wrote:
> Clean up after failure in zloop_init_zone, as the caller only cleans up
> the zones before the current one.
> 
> Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
