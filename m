Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282B1CDA36
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936691; cv=none; b=iPVAFZmc2ftNiHvSmED3aao3jPY9TnxOHASBgu1Y5wsP8sIm5TJ+sAaFO92pS4VuZQSnzrFH7D+ygRigggtiqsv7nliQ7nkqvKQZHwWE+5oX4WgX30TigmknY0ahQHqxXR646z7OUgF6YvEcXuYqqC5f7Er4HxvVTRAWnPoh2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936691; c=relaxed/simple;
	bh=bVVkpzvezcvs3SyiZuCSzE3cYCFQ+/Zwqms842WtnGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0dEXUr5jL38OCwpGfkEmChYa1G7QZ0uyh3v+Bqr22rsFfuozpzM62vN9Uujax2SJR2nUmP0gJTdAf8pVazMHkVD4XYStGGWgVQLjBWwwsIqDl554sVN99oRf2P2nkG5MW2nAx30X5ba530qDCZGBifPfCmqbpfO4NzGGFx4joo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apDdKUlt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apDdKUlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AF2C4CEC6;
	Wed,  6 Nov 2024 23:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730936691;
	bh=bVVkpzvezcvs3SyiZuCSzE3cYCFQ+/Zwqms842WtnGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=apDdKUltNhfo3QyaK18P+pYaAWEIYcbK5W2Asu/EfYtOockYdMpPtdEn+mqvMJvuF
	 4AxpjU/tm2iQBEYeKHeblycXVAMSU511Haz5rJClvzA/g2Nk2chyr4gLRGoPyITl1e
	 YE6nG33OT1iKugcXuzmjqQdepM4qKFElkxBSCbEJKGGBDNCojdbzS50b2lsuzY3xaY
	 e6w7F0nhcxgiqI7ZueTQX9XGUvwjDZvnmu0fklWC41IogxeEieR22tqMCfFrHGwvVy
	 c3zL+js7fdjH747fbz8viDhnMGittfzVnKmn6wtwE7mJUoHuY1KWx8IIRmFHNE6hd6
	 X3loXLr2fHzVA==
Message-ID: <de2ebedc-1e04-4c0b-8435-ff984ff83818@kernel.org>
Date: Thu, 7 Nov 2024 08:44:49 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: RCU protect disk->conv_zones_bitmap
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20241106231323.8008-1-dlemoal@kernel.org>
 <20241106231323.8008-2-dlemoal@kernel.org>
 <f199b1e4-2fef-465a-bbff-88008f521e22@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <f199b1e4-2fef-465a-bbff-88008f521e22@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/24 08:20, Bart Van Assche wrote:
> On 11/6/24 3:13 PM, Damien Le Moal wrote:
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index a287577d1ad6..7a7855555d6d 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -350,9 +350,14 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
>>   
>>   static inline bool disk_zone_is_conv(struct gendisk *disk, sector_t sector)
>>   {
>> -	if (!disk->conv_zones_bitmap)
>> -		return false;
>> -	return test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
>> +	bool is_conv;
>> +
>> +	rcu_read_lock();
>> +	is_conv = disk->conv_zones_bitmap &&
>> +		test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
>> +	rcu_read_unlock();
>> +
>> +	return is_conv;
>>   }
> 
> The above code can be simplified significantly by using guard(rcu).

I personally dislike very much annotations that hide code.
So unless Jens prefers using guard(rcu), I would prefer leaving the code as it is.

> Otherwise the two patches in this series look good to me.
> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
