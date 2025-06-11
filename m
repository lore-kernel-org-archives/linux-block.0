Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB452374C4
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603861; cv=none; b=RTdua5Tg9UmFDuEbd+eUNgaT2luLEU8FC+W6BF7HFoKSM+Y7rK0+hphKqtvEemZV2ND69Jekao4ADk4C752i5rUXmXCZpMC2jDaNF44hay8QxVDrHonEW28ZAikeekME4JhGf/463n4MjOgfEbJWVQjHPH/j40FOgOPxJMbwOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603861; c=relaxed/simple;
	bh=Pth+rY/iV3mC3xKTQhUlSpfS3O17+039ZIcUc5zRvzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSPWd0Cst2fXVT/MC00Ud07Yx3qBIsT7qZh9m/jw5Su8U1XuzE4cpPjVZofPvTIzkdGfR1D3cslbI4VkNanZN+xHaGeSFW+aQbZXNxJnHc77pLI6Gkkur/3F/zoGw3ga8XBQCCrIHxH7GHVKdJPl84kJk0GuL4qDApuSbh5MkQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6KS+kV0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6KS+kV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7E0C4CEED;
	Wed, 11 Jun 2025 01:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749603861;
	bh=Pth+rY/iV3mC3xKTQhUlSpfS3O17+039ZIcUc5zRvzA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a6KS+kV0uNNdule9rAk/jKhlP/rzd7vICEuy8lv3eu90pEw6X5gr72a4TvRIgGOmN
	 RFmlQWh2y64yKWsYzjaX4LjhEr79Gx6tOg0W91a4WhjsnSmSm67xkNPTCeWQ0jn560
	 2XuHBVhMScNiq+jBnBpnLJUP2EoSqFjHAeLR9bS5RwYdEuaCUIOSLlt3ULMxiLnRBh
	 T10Ytfn27aG7neWZG9Lnt4ogpZ5rU2HgnrmkFVNmwCawCUeS8zgr6pI4ZKIdJt0h+j
	 SJu0xWBxXNisdmJz1yZUj+VfFkEdiQrWlT1dZvi9tKIeQrObmaApOMgKAFJKHhqVYg
	 6VSjZRzATvh+Q==
Message-ID: <4c658f15-7a8d-4add-8638-d8cdfe31f670@kernel.org>
Date: Wed, 11 Jun 2025 10:02:34 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Keith Busch <kbusch@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Eric Biggers <ebiggers@google.com>
References: <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
 <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
 <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
 <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
 <20250609035515.GA26025@lst.de>
 <83e74dd7-55bb-4e39-b7c6-e2fb952db90b@acm.org> <aEi9KxqQr-pWNJHs@kbusch-mbp>
 <c98e6252-c0af-4d25-8995-5b808b0c6da5@kernel.org>
 <aEjVPK9Xdo8P5Um0@kbusch-mbp>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aEjVPK9Xdo8P5Um0@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 10:00 AM, Keith Busch wrote:
> On Wed, Jun 11, 2025 at 09:46:31AM +0900, Damien Le Moal wrote:
>> On 6/11/25 8:18 AM, Keith Busch wrote:
>>>
>>> I think you could just prep the encryption at the point the bio is split
>>> to its queue's limits, and then all you need to do after that is ensure
>>> the limits don't exceed what the fallback requires (which appears to
>>> just be a simple segment limitation). It looks like most of the bio
>>> based drivers split to limits already.
>>
>> Nope, at least not DM, and by that, I mean not in the sense of splitting BIOs
>> using bio_split_to_limits(). The only BIOs being split are "abnormal" ones,
>> such as discard.
>>
>> That said, DM does split the BIOs through cloning and also has the "accept
>> partial" thing, which is used in many places and allows DM target drivers to
>> split BIOs as they are received, but not necessarilly based on the device queue
>> limits (e.g. dm-crypt splits reads and writes using an internal
>> max_read|write_size limit).
>>
>> So inline crypto on top of a DM/bio-based device may need some explicit
>> splitting added in dm.c (__max_io_len() maybe ?).
> 
> Ah, thanks for pointing that out! In that case, could we have dm
> consider the bio "abnormal" when bio_has_crypt_ctx(bio) is true? That
> way it does the split-to-limits for these, and dm appears to do that
> action very early before its own split/clone actions on the resulting
> bio.

That sounds reasonable to me.


-- 
Damien Le Moal
Western Digital Research
