Received: from mta0.migadu.com (out-89.mta0.migadu.com [91.218.175.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA403AB272
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029976; cv=none; b=GOXAa85CiqEOswSmqkdirJVtLXFGwrG2xFA16dHz/dNlEM+AtUcMad8Dh2WyF30LjlJpa4/NbdYsLHg4HQYzur6eZLrmEhwPLoF//DE/dcRBDdlSDTslwW3u+unwnMCXxpnBWbR+rJOrfj3GbwbVJ+Budq7LOcGcM/l7g5Ag+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029976; c=relaxed/simple;
	bh=uNk98S24xdDQAd9sR/oPvfM7Xxt/HxIpY5XMKOE8m7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzHp3mt6fc/qojj49+S8Uo592/pB35EAwiUyqMKcruSRZTBVV9uEjoVghpZ72i9NNjraFWwSfGtQ1BvEz2iFYEIW+4EuXys/Et5nkAKXs1cquwcMG++C+lWfv+8KKUW7/R9UmnSZ1wHgjL5u7eycEHpOvCHaPL7mTSbmVElWAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uyIK/dEv; arc=none smtp.client-ip=91.218.175.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uyIK/dEv"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uNk98S24xdDQAd9sR/oPvfM7Xxt/HxIpY5XMKOE8m7w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789029961; v=1; x=1789634761;
 b=uyIK/dEv+gw9O3PPOah9gucNvdnybMNa+Vuco3a7MQqpbwrhxe3TBZSrjVqbp3CkyHC+Zcja
 7XTzvOBcdkZqMEavyKVZ/mj0V2vrdSxlV3La9f70mEpz/6HWo63IpH70yYsZpIHf0/Q0yZN/c3s
 f+9FY5DQCKsUyyUjmJOfSjJ0=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id cb036e4150614f0a;
	Thu, 10 Sep 2026 08:46:01 +0000
X-Mizu-Trace-ID: cb036e4150614f0a
X-Migadu-Flow: FLOW_OUT
Message-ID: <b800ecf7-1e78-4605-9db0-7bf891d8ca51@linux.dev>
Date: Thu, 10 Sep 2026 09:45:59 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: cap atomic write size by PI buffer size
 constraints
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org
References: <20260907074111.721054-1-hch@lst.de>
 <20260907074111.721054-3-hch@lst.de>
 <a17ccccc-a91c-4e45-a97e-d899c739e159@linux.dev>
 <20260910053636.GA27408@lst.de>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260910053636.GA27408@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/26 06:36, Christoph Hellwig wrote:
> On Wed, Sep 09, 2026 at 10:16:17AM +0100, John Garry wrote:
>> Furthermore, I don't think that this is the change above is correct. We
>> have 4x atomic limits and I think that 3x would need updating:
>> - atomic_write_max_sectors
>> - atomic_write_unit_min
>> - atomic_write_unit_max
>>
>> The expectation is that the driver sets atomic_write_hw_max,
>> atomic_write_hw_unit_min, and atomic_write_hw_unit_max individually. We
>> don't assume that atomic_write_hw_unit_max ==
>> rounddown_pow_of_two(atomic_write_hw_max). The is because of SCSI and it's
>> granularity and alignment atomic limits 🙁
>> Anyway, maybe this is a better change:
>>
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index 8274631290db..b88744d42719 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -233,11 +233,15 @@ static void blk_atomic_writes_update_limits(struct
>> queue_limits *lim)
>>   	unsigned int unit_limit = min(lim->max_hw_sectors << SECTOR_SHIFT,
>> blk_queue_max_guaranteed_bio(lim));
>>
>> +	unit_limit = min_not_zero(unit_limit, max_integrity_io_size(lim));
>>   	unit_limit = rounddown_pow_of_two(unit_limit);
>>
>>   	lim->atomic_write_max_sectors =
>>   		min(lim->atomic_write_hw_max >> SECTOR_SHIFT,
>>   			lim->max_hw_sectors);
>> +	lim->atomic_write_max_sectors =
>> +		min_not_zero(lim->atomic_write_max_sectors,
>> +			max_integrity_io_size(lim));
> This needs to be conditional on a non-zero lim->integrity.metadata_size.
> 
> Otherwise this looks sane.

ok, I can add that.

I'd like to test this, I suppose scsi_debug is all I have to sanity test 
this...
