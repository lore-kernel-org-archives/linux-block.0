Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF23655CC
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260206; cv=none; b=eS11ivzCOZWTbmGKpzZQn9ier51JikNyo4FML/GmFlvFSceoyOv+Vs3nBSAOFd9ba435gq/WhDvzKvRWjpkHlYLkgcSNRgnIwHFaWJJpeywQQaDFjAzg4+x/3PZnwhvNs+pYBxD1/MnTbfgDW/bHfFsCGSaVeeWPMjtYgSI17ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260206; c=relaxed/simple;
	bh=9trSHzqhAbUFJgEBLCpBukjDW0+MO20AwASSbV+UI/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+SDiS1b8xKpI70f6tL0xhzkCchQu2aLM6cR5hKoV/BEMatsHUjjJygbjOZBwSP3xd+QyDJqs4t3Ni8k5061UzdXtVrTABkSmCsX+RdvvxHony+rsi1dj4G87/d1Db0aVMFm75zD1omFc0GmAO2X9A+PgkgQdBz3rQQKmCSMNp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoIPtbsd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoIPtbsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945361F000E9;
	Wed, 20 May 2026 06:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779260203;
	bh=PQyE2sjonzdzHK3b0QvSKBdcBtvd/iEDjOKguePEnKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JoIPtbsd0F8vSjYNkhi/4yI0YDiqEe3rIRrtAcaLYw1SxJq9MKEhB2tqsOyoykvKO
	 RboRy6tG7VU7/xGIowXy6BOfeOCoN3+wjXdcXFHDZc95sAlN2wBIwCakZsIxCihKDV
	 AT2l8/wKWIY/9PljhZ/vpQHB4BFCOUo2dCi16afHvQi9Cn495ogqT/uBd5CVIfr9sQ
	 LmeMMrp82HoujmJgf1eweDrYiaXrKxX3tSM9JMlr+N+6BUJzavTDW17mQ4JvnuWJVO
	 mHku3ob61qnKa6XuXt0Z91jwYBsgft2zCxucTHWKxW54OhwzGeMO5crSKTyJGIxXsb
	 ft6omnEu/yViA==
Message-ID: <b791c4de-ff5c-4f68-af26-7b6d37013fef@kernel.org>
Date: Wed, 20 May 2026 08:56:39 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/5] blk-mq: fix status for unaligned bio
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com, coshi036@gmail.com,
 Igor.Achkinazi@dell.com, Keith Busch <kbusch@kernel.org>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-2-kbusch@meta.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260519172326.3462354-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/19 19:23, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A bio requesting sectors unaligned to the logical format is invalid
> rather than an IO error. Fix up the return code because there are some
> device mappers that care about distinguishing these kinds of errors.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

It seems that this one could go in regardless of this series (so I do not think
it needs to be RFC).

-- 
Damien Le Moal
Western Digital Research
