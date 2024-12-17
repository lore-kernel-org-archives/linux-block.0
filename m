Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A555150994
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469141; cv=none; b=OqjnnpJPyEvbHOwY44pdAsSGz7L26rENmUxKcB6sCyw+lStNuIcAuLxH/VOkhmAnLQPDVep+ThGJ+79XqrJWzpE2Dn6LpxetzeMF57P/UF5mxgcDvsq2Uk/FobsRFpU6ZdaL8KfSUgXVrkA+ImoB35CzHFL+vruXrqKEuIXUV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469141; c=relaxed/simple;
	bh=iz/aHwsVP+p2eoJcXgPpPR95H1xcXMbLEFnsNbZJHxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hi7OZU/1lbDqGsq8ye4SPnSc1+cXrr0w3L9FuVCe7G+B9HwrB7Szx9zawSiANqFVgnI9gHFx8wDPiMXCQiO+XjxTmuuT4tGzlMg5TzBrnAf0SMwr0GQyiS+gyCE9Gegbgspfw4LlPMW+VzxwUuMqekrHaEpDQUk1F9DQVEDMD4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvpS5WAU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvpS5WAU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC61C4CED3;
	Tue, 17 Dec 2024 20:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734469141;
	bh=iz/aHwsVP+p2eoJcXgPpPR95H1xcXMbLEFnsNbZJHxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dvpS5WAUa+sHcTIXzEntgMnRIFNlZ0IjaK7SgAioTaNhmf3ZJ7+8PlNmAexY4az3Z
	 X84De1Zw3HFIDflQc8xx9WRsVUjGInQx89JdxX36DdeEB71mWXM1dg8Wj9mr5avKOJ
	 qJJbLefG5Sm3FWYM+rB2Iealrn1mZ6eQTri0p4CNrgWulbJ7xbQdqc7Uoap5sNj91s
	 /091KHSQ4w1zN6nj774Nh+atTV/O3TtrMOm+ZBjZuBmjJ80CbCGnaCcJkBc2WwmkhO
	 2EzRB1W+2TLXlvaGVNzM1xfuJbQ/ePC//NeHJ0wGr12tNpGK8nOaVGrzwngQexaYkK
	 8+2maLlS0ZSFg==
Message-ID: <9e8e2410-53b5-4dad-8b54-b7e72647703b@kernel.org>
Date: Tue, 17 Dec 2024 12:59:00 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 Christoph Hellwig <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <20241217041515.GA15100@lst.de>
 <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
 <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
 <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
 <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org>
 <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
 <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
 <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org>
 <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
 <f41ffec1-9d05-47ed-bb0e-2c66136298b6@kernel.org>
 <e299e652-2904-417c-9f76-b7aec5fd066b@kernel.dk>
 <fb292dc8-7092-45c1-ae8a-fca1d61c6c9a@kernel.dk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <fb292dc8-7092-45c1-ae8a-fca1d61c6c9a@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/17 11:58, Jens Axboe wrote:
> On 12/17/24 12:54 PM, Jens Axboe wrote:
>> io_uring does support ordering writes - not because of zoning, but to
>> avoid buffered writes being spread over a bunch of threads and hence
>> just hammering the inode mutex rather than doing actual useful work. You
>> could potentially use that. Then all pending writes for that inode would
>> be ordered, even if punted to io-wq.
> 
> See io_uring/io_uring.c:io_prep_async_work(), which is called when an IO
> is added for io-wq execution, io_wq_hash_work() makes sure it'll be
> ordered. However, this will still not work if you're driving beyond the
> limit of the device queue depth, or if you're doing IOs that may trigger
> -EAGAIN spuriously for -EAGAIN as you can still have two issuers - the
> task itself submitting IO, and the one io-wq worker tasked with doing
> blocking writes on this zoned device.

Thanks for the pointer. Will have a look. It may be as simple as always using
the io-wq worker for zone writes and have these ordered (__WQ_ORDERED). Maybe.


-- 
Damien Le Moal
Western Digital Research
