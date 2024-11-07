Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C7621
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938474; cv=none; b=ZsGR+MlSgipaEhDCAxrQF9TbEKd4rElGDh51SWYIOz2FDL+jOD/wDXWKpyfhL9w2+pcmGEu8xWCV/dF+smIhuAwNod7DNSw11WuaM5dcxp/PBL07v67FF1nChin2paN76kZ9zSP/3HVFm+lgkhIVgY9J0hKUG4Gy0nlLsYGMn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938474; c=relaxed/simple;
	bh=AzoYGvEC6abttoKFiqEGKacH16U2yiN4/oWTb2+Aads=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WDXi6SSTK0C7pPVRujR0lRdATOwAYYa6v/9XvPqPOcZP5Mg83wdjwKf6gK2YnkIRHKajn2P8vXzCX4JrAh05ObsNSrTuBGCI8hvPd8dwOUyEalhr6MKtk8/GShrBzXlNn4H1vNwsNtRI2ry8mlWlr2kSvgBPaRgPFQ/QuKD8LEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3S+NhCe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3S+NhCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C526C4CEC6;
	Thu,  7 Nov 2024 00:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730938474;
	bh=AzoYGvEC6abttoKFiqEGKacH16U2yiN4/oWTb2+Aads=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=u3S+NhCeDRDHBfn2x9TwgZf53C4frwq0/Ge4h3LABrdNDt4SMhEuhKnejJe23R4hJ
	 43hUWHzflUVhRh9E9q9tYop0rTcuObZNfOX2ye79iYCLTNe/d1fmX8xG3+mVBxTtiE
	 A0n0RPwVSocP/Vfqu10IYP6Z6z2PxLHu11+6qp3k51Ig7ma3hmwL/U/GDDoDJdSxNw
	 PQO4PeUELKts6RFEz6Nbr1F+mWW+YsklrIzUIwBWCbHf9czLTrSA+mb5IqGWJoZoDg
	 aweqsxxciIePJygIevLjcZh9RXNIwiXXu09Z5ks7b6LOhPGpVp3nIeoeXuRKgCG8wn
	 xjzIy9gKzJHUg==
Message-ID: <40c059e7-a474-4516-b70e-fe59bf194294@kernel.org>
Date: Thu, 7 Nov 2024 09:14:32 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/2] block: RCU protect disk->conv_zones_bitmap
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20241106231323.8008-1-dlemoal@kernel.org>
 <20241106231323.8008-2-dlemoal@kernel.org>
 <f199b1e4-2fef-465a-bbff-88008f521e22@acm.org>
 <de2ebedc-1e04-4c0b-8435-ff984ff83818@kernel.org>
 <01f3c56e-ed53-4d7d-af3a-bfe2be805cfb@kernel.dk>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <01f3c56e-ed53-4d7d-af3a-bfe2be805cfb@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/24 09:02, Jens Axboe wrote:
> On 11/6/24 4:44 PM, Damien Le Moal wrote:
>> On 11/7/24 08:20, Bart Van Assche wrote:
>>> On 11/6/24 3:13 PM, Damien Le Moal wrote:
>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>>> index a287577d1ad6..7a7855555d6d 100644
>>>> --- a/block/blk-zoned.c
>>>> +++ b/block/blk-zoned.c
>>>> @@ -350,9 +350,14 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
>>>>   
>>>>   static inline bool disk_zone_is_conv(struct gendisk *disk, sector_t sector)
>>>>   {
>>>> -	if (!disk->conv_zones_bitmap)
>>>> -		return false;
>>>> -	return test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
>>>> +	bool is_conv;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	is_conv = disk->conv_zones_bitmap &&
>>>> +		test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
>>>> +	rcu_read_unlock();
>>>> +
>>>> +	return is_conv;
>>>>   }
>>>
>>> The above code can be simplified significantly by using guard(rcu).
>>
>> I personally dislike very much annotations that hide code. So unless
>> Jens prefers using guard(rcu), I would prefer leaving the code as it
>> is.
> 
> I don't mind it, and I do use it myself when it makes sense - but imho
> it's up to the person writing the code, particularly when it's their
> code in the first place.

OK, then I would prefer leaving the code as is :)

-- 
Damien Le Moal
Western Digital Research
