Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B7C33A9F1
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972203; cv=none; b=YiT/TtSYNuw0p1PlFPGj8CN+8ryjwvPFUTzi7Npwp5I6FrCP+x6eEGJ9Re7phxhA1HUAbMr+TLC6ZQjx7kn0SrAu8xN07TPYKwHajtDPbJ3fv9+1yfKCbyrW/u6hrDIlJympcxXfzLqbBm6wu0DwHDCAqI+6cs8mnR5YOrqXufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972203; c=relaxed/simple;
	bh=zJNryP4bEGuKrGwuglAgl/BjJtTribhjLlZDPJX13/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lzlk3CzyrGStV1f2BANqCfg63m9ijLkrFA5zwxs5K+mu78Qg5xOagzH4vYS56prVuWEXVY88DLVn5CmOzqY5vLO4AaBumwpvJTPuIVYoTaBK9RTjjdm1AxbS6LRehmkFoHteVAGoMphKwCDMRQlCSKmpJNNCLaVFlGu7r0TchPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NakVBmfi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NakVBmfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AFEC116D0;
	Tue, 24 Feb 2026 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771972203;
	bh=zJNryP4bEGuKrGwuglAgl/BjJtTribhjLlZDPJX13/M=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=NakVBmfiQvjwxjjtWbDMGAXLCvRtOOey51zHuXbGE17rLZUEZOdGTzvNu0URknx0Z
	 6uJl2ZTiy+/4xY7e/ARWzHhG4mDO9wPxysHAUzP9RHdYdiMDHrGNpkQMO8vegC7OTr
	 BrP7xxwiENLDB5UmkOmAHbPvI7u0zyVDScv85UBDUVDUbvtqgyehPGen+GL+bdurro
	 L+OaUiLMqKVv22qmOK+00Pm+6L/3FjigdGrwCdfRCEdYMvawKhNB5O1KZc7vm5+DaM
	 qs6uIGvO+akg8tcZERMw7p9oKslRrqP7DFzmDANgHECV3CBM3qt0lnNZs71m6YXxHi
	 a1jEsshYIsqaQ==
Message-ID: <ecc9f524-be64-48c1-8107-a3f8a6b4599f@kernel.org>
Date: Wed, 25 Feb 2026 07:30:01 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: simplify blk_mq_finish_request()
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20260224215855.1709335-1-dlemoal@kernel.org>
 <745ef6a2-758c-484e-ab12-9aa2d64ae5d7@kernel.dk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <745ef6a2-758c-484e-ab12-9aa2d64ae5d7@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/26 07:16, Jens Axboe wrote:
> On 2/24/26 2:58 PM, Damien Le Moal wrote:
>> Remove the local q variable as it is not necessary. This also removes a
>> useless pointer dereference when RQF_USE_SCHED is not set for a request.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  block/blk-mq.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 9af8c3dec3f6..55a255750ad1 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -781,12 +781,10 @@ EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
>>  
>>  static void blk_mq_finish_request(struct request *rq)
>>  {
>> -	struct request_queue *q = rq->q;
>> -
>>  	blk_zone_finish_request(rq);
>>  
>>  	if (rq->rq_flags & RQF_USE_SCHED) {
>> -		q->elevator->type->ops.finish_request(rq);
>> +		rq->q->elevator->type->ops.finish_request(rq);
>>  		/*
>>  		 * For postflush request that may need to be
>>  		 * completed twice, we should clear this flag
> 
> This will compile to the same code...

OK. I had not check the compiled code. Sorry for the noise.


-- 
Damien Le Moal
Western Digital Research
