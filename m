Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7C6BB4B;
	Wed,  7 Aug 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051223; cv=none; b=al9GFLyhvYBgdnsDn7s3ZE9loj+6mIpeQJSxKXyhxp2T7b6KZ6mXABaQ+AYlPXrKvPqvM0neBm7QIy3owwQ+ptKZjhuuDLzDWrn7ThtqIhsA1itvuu9wizc44Lj8QoHMn/McILorZn3gO/2M1qmFUqaPsa3nVEsvry8Xc6fEPDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051223; c=relaxed/simple;
	bh=t/xnzJIShAShSeheceeLkwe+qhphG8/7tsBvktmb1r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FiHHejV8KK52xEV8gjZWeiBVRe5R1PqavDIhO91MLkE5KRbiJkJrH6dw3Gla+b3GH7i+Eir7wM8Kl08UhdGQ+Nd8rPHebJEVg/1d4KmJLhMbADf0GLfZI3kpH1V3hTx4EtKZTJHz342qe+patjlmARjB89/uAChKdaCO8NV4oNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh4TkjoY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh4TkjoY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DCEC32781;
	Wed,  7 Aug 2024 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723051223;
	bh=t/xnzJIShAShSeheceeLkwe+qhphG8/7tsBvktmb1r0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kh4TkjoYLS9AA3aue+UMQFwV4x2jWY07SOuzLZfTDPGteH3nzQ6qeHRPe7HPGctXK
	 RNySl1ddcP33JRqjDWmWeEjjnQ+6PUu5uw4o1HdgL8pCE4i2Kh3dqyqahRMcFgIUU3
	 2N/TNsGe0bzTYmJMwrytavlaaozMVgwltFlKoPMGg0o+f+oZQ3DGX7fhyh0/IAEKKc
	 4IpJlBQ2qK4mWUH0b0BxXxZedNzzWdp5H6rq97j6uGJbr4Aj6s4im4qfZkrRTwTw/Z
	 AmmayJMj1ZtZ996ShxTEKwpVV2AEsHzSheNaTV31pkWxq7DDy+44IpXyFzxlPhZv/X
	 jIlbbLWNdt0gA==
Message-ID: <effc195f-9f0e-4e0d-95ab-5bae22702f95@kernel.org>
Date: Wed, 7 Aug 2024 10:20:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nbd: correct the maximum value for discard sectors
To: Josef Bacik <josef@toxicpanda.com>, Wouter Verhelst <w@uter.be>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 nbd@other.debian.org, linux-kernel@vger.kernel.org
References: <20240803130432.5952-1-w@uter.be>
 <20240806133058.268058-1-w@uter.be> <20240806133058.268058-3-w@uter.be>
 <20240807135625.GA242945@perftesting>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240807135625.GA242945@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/08/07 6:56, Josef Bacik wrote:
> On Tue, Aug 06, 2024 at 03:30:56PM +0200, Wouter Verhelst wrote:
>> The version of the NBD protocol implemented by the kernel driver
>> currently has a 32 bit field for length values. As the NBD protocol uses
>> bytes as a unit of length, length values larger than 2^32 bytes cannot
>> be expressed.
>>
>> Update the max_hw_discard_sectors field to match that.
>>
>> Signed-off-by: Wouter Verhelst <w@uter.be>
>> Fixes: 268283244c0f018dec8bf4a9c69ce50684561f46
>> ---
>>  drivers/block/nbd.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 20e9f9fdeaae..1457f0c8a4a4 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -339,7 +339,7 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
>>  
>>  	lim = queue_limits_start_update(nbd->disk->queue);
>>  	if (nbd->config->flags & NBD_FLAG_SEND_TRIM)
>> -		lim.max_hw_discard_sectors = UINT_MAX;
>> +		lim.max_hw_discard_sectors = UINT_MAX / blksize;
> 
> We use 512 as the "sectors" measurement throughout the block layer, so our limit
> is actually
> 
> UINT32_MAX >> 9

UINT_MAX >> SECTOR_SHIFT

would be better.

> 
> since we can only send at most UINT32_MAX as our length.  Fix it to be that for
> both patches and you should be good.  Thanks,
> 
> Josef
> 

-- 
Damien Le Moal
Western Digital Research

