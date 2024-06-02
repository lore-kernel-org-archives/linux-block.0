Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097BF7E765;
	Sun,  2 Jun 2024 23:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717372753; cv=none; b=Z2thakL7TgxXTlBk3cuk85FVkuUC7Y8v8mHLVIxO9l4z9Ge9s8+XtY2rMgdD7yzylAJ6O+lx1fui5M7px6JWKgkLqMx/blmYDcAHz6W7Y4hYdRRyzjpddOPIWOy3rdHlZb/beuVAFPHsLOxfVAFRN+9DZGF6l2Paze/S5+yjRjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717372753; c=relaxed/simple;
	bh=f9O5QybcaMD2WnAIw2zJMF2wywEOo5ijEP+aNWm+CN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiVGFslJfd7h3bcqG6w+UCji3ROPX+oJFNRhreaLcbrHBQKk/VMLF1L8x/nn+ZLN5p1yMZq2ZYrBhxZdEKSorCZgFBVmAJKTp5ZeEne4e0941VzhQxcYnE0HT+c7VW7KDiCInhLFirpD4Q2BIen/LvV+Oq4SU/G/u6Rnb28ueLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ4cfxlM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ4cfxlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81146C2BBFC;
	Sun,  2 Jun 2024 23:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717372752;
	bh=f9O5QybcaMD2WnAIw2zJMF2wywEOo5ijEP+aNWm+CN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lZ4cfxlMdcwhOVhbqsf9w4uFBEq+LN8pDb0XkjLabo/Zy97mJnI9UreSoibY7uHl7
	 3ZpWy1VJOLx3FpzUmjzhhsXsXRpzoFTlA8q3sp+cXgdrSBw8DRZcStV9JGQ37KhzVh
	 RJ4N/06Hcvml4sBrmT2zbaXVJoo3Xif7/7QLvtYSTuU+AEBV2WWTlz+FKseOz6w4zC
	 JW79RueDt6DIdpx0uwHAgcHV1TCJtLDWZJ4mhHO1Jd0vvRKbQI+DvFFnsn8XD4wmwq
	 zuLmEogyxrmCesQe9NSvRHAf3mKQCNFKx6ZQRFNlD0Jkk7ZKrxHAHGsyemQDXFcc8U
	 F5ZjC0rwW0a1w==
Message-ID: <9d68c7c1-b1e6-4f42-8d4b-8c986ab688b5@kernel.org>
Date: Mon, 3 Jun 2024 08:59:10 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: fix validation of block size
To: John Garry <john.g.garry@oracle.com>, Andreas Hindborg
 <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Keith Busch
 <kbusch@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240601202351.691952-1-nmi@metaspace.dk>
 <d6999fef-aadf-494e-ad58-f27dfd975535@oracle.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <d6999fef-aadf-494e-ad58-f27dfd975535@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/24 19:57, John Garry wrote:
> On 01/06/2024 21:23, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>
>> Block size should be between 512
> 
> 
>> and 4096
> 
> Or PAGE_SIZE?

PAGE_SIZE can be larger than 4096. But most drives are 512 or 4096 LBA-sized.

> 
>   and be a power of 2. The current
>> check does not validate this, so update the check.
>>
>> Without this patch, null_blk would Oops due to a null pointer deref when
>> loaded with bs=1536 [1].
>>
>> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/87wmn8mocd.fsf@metaspace.dk/__;!!ACWV5N9M2RV99hQ!OWXI3DGxeIAWvKfM5oVSiA5fTWmiRvUctIdVrcBcKnO_HF-vgkarVfd27jkvQ1-JjNgX5IFIvBWcsUttvg$
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>   drivers/block/null_blk/main.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index eb023d267369..6a26888c52bb 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -1823,8 +1823,10 @@ static int null_validate_conf(struct nullb_device *dev)
>>   		dev->queue_mode = NULL_Q_MQ;
>>   	}
>>   
>> -	dev->blocksize = round_down(dev->blocksize, 512);
>> -	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
>> +	if ((dev->blocksize < 512 || dev->blocksize > 4096) ||
>> +	    ((dev->blocksize & (dev->blocksize - 1)) != 0)) {
>> +		return -EINVAL;
>> +	}
> 
> Looks like blk_validate_block_size(), modulo PAGE_SIZE check

Not PAGE_SIZE...

> 
>>   
>>   	if (dev->use_per_node_hctx) {
>>   		if (dev->submit_queues != nr_online_nodes)
>>
>> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> 
> 

-- 
Damien Le Moal
Western Digital Research

