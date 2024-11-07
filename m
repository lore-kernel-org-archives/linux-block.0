Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2AD366
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730937768; cv=none; b=RkerLDyJB97h80kSlargNT0IjK03MN7ZQGWZO48RD6HCsqzF1ZURxUt2uVIKj+8D1pKBjubGOl44CRik40VuwxoZXmYm5DzQMlQAeXCiWI9wd5uFmyEO8Q4/15SQPhmaqvwUMm4FGUzcy2tJb9oswvIdK7fmfm4DGUTKbu/JE7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730937768; c=relaxed/simple;
	bh=4udzTu4NF1MHwDSUJcpd5e1CtYDheEQhJBEGF/NmuEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0TAInGM6Y8avzNMvw311E1n4UMQZf+OJSXIeZnY67KNn8mefIOKxNLaBVRrgEpzWtJPdtAnMMcbyQApy45q0TBHZuh70ImYm3YkUf1WnA5VAapFMqZZe9PRzU+Z98hzgU8Xd5XgGnZ9WZGyjJNGFjTEdhyrNv4n7ysk7Y28CyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hEXExLYo; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hEXExLYo"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so351530a12.2
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2024 16:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730937764; x=1731542564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3xDaZkx8tPapIHX+cQE/WMZ1PuLs5f/KEfNvRxsqrU8=;
        b=hEXExLYoyBdK7gNCwihYJ4+waCd4x2HVzfbN5iQsoKTnaSe4XMyZMaBuYtSw0W71Eu
         URiDuZdAfh8xMdKNFHBBqVO4FvKx+PHj/SAV43nTOAogiB/NMMYziwuyBF0NeDU2XRA8
         y0ldlyqfEDvYVRLgxIbws+1VlkubMceNhhNCqI30SrcXHRWt8hnbiL2WOeIU+dsaf16z
         +KwKEi3zVcos0t+xd2/otH2XxmbiBDrADXbHsU7yOqjFXftTDbJkJ+TKWltz5R5LR9yP
         zM5icjN9v9WYHSl0DLmrG33ezgay/WJuD2UkK+eofBjL2ZX8LT890W9xJKsaPn20nq2P
         qLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730937764; x=1731542564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xDaZkx8tPapIHX+cQE/WMZ1PuLs5f/KEfNvRxsqrU8=;
        b=uwqd/GfF0ELoIWHgQFvhznijJzE2Ri9KHhvBtVitgHwDzrYEIrnYmbpYsysIn+e5JV
         GlwZW0/ehMwMuL1gefCX77l8O7P6rlzTA0wBFtlP5iN+N3lPfrwDlf8vHN0natVBHjUU
         VF2J3qbVbeF99rAHSshmYkMYUOQcxrpYzodp1d/fEVAG8Hol+9YZAyFz6WgHpzxwN+Ej
         +Ud/yDEyesoRjwW2ZNKk55gSyyBX091F4llwnruoa/17RzA9OtyJnQkQ6lsi422PEFQt
         uvfT9z/BfhRrVu5vbq+V/HbUx28b9/fZRvD7R4GCYfxMm3zaal36ijL5sakU8tK/00z4
         bwUA==
X-Forwarded-Encrypted: i=1; AJvYcCU2RUNzjUZufqxpKA2zowHP/AK1e9fVuPPMGREwR9r+LcjfLGJBxVEekIjTPMiLk1Bcu5WzIEFvmssvdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYmsiIgxPiIm2P1gh7YSKa09DizwvJYiOoXDMcffTkOte6fOt
	ciFsyTQTYbdF+9I+wVuqEp6FWWRTzH3gVe3cZfRgAY6SVy/KNIT4F+C1BEQm6hg=
X-Google-Smtp-Source: AGHT+IGC43hbOgOBpK0p27JmB5LYUXWgUD698RIum6Q1448ST57jNkUP7hUG7QhliAI+vN8tEYtISg==
X-Received: by 2002:a17:90a:9a8d:b0:2c9:a3ca:cc98 with SMTP id 98e67ed59e1d1-2e8f1057e99mr45529573a91.7.1730937764100;
        Wed, 06 Nov 2024 16:02:44 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd180fsm161679a91.33.2024.11.06.16.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 16:02:43 -0800 (PST)
Message-ID: <01f3c56e-ed53-4d7d-af3a-bfe2be805cfb@kernel.dk>
Date: Wed, 6 Nov 2024 17:02:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: RCU protect disk->conv_zones_bitmap
To: Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche
 <bvanassche@acm.org>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20241106231323.8008-1-dlemoal@kernel.org>
 <20241106231323.8008-2-dlemoal@kernel.org>
 <f199b1e4-2fef-465a-bbff-88008f521e22@acm.org>
 <de2ebedc-1e04-4c0b-8435-ff984ff83818@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <de2ebedc-1e04-4c0b-8435-ff984ff83818@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 4:44 PM, Damien Le Moal wrote:
> On 11/7/24 08:20, Bart Van Assche wrote:
>> On 11/6/24 3:13 PM, Damien Le Moal wrote:
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>> index a287577d1ad6..7a7855555d6d 100644
>>> --- a/block/blk-zoned.c
>>> +++ b/block/blk-zoned.c
>>> @@ -350,9 +350,14 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
>>>   
>>>   static inline bool disk_zone_is_conv(struct gendisk *disk, sector_t sector)
>>>   {
>>> -	if (!disk->conv_zones_bitmap)
>>> -		return false;
>>> -	return test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
>>> +	bool is_conv;
>>> +
>>> +	rcu_read_lock();
>>> +	is_conv = disk->conv_zones_bitmap &&
>>> +		test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
>>> +	rcu_read_unlock();
>>> +
>>> +	return is_conv;
>>>   }
>>
>> The above code can be simplified significantly by using guard(rcu).
> 
> I personally dislike very much annotations that hide code. So unless
> Jens prefers using guard(rcu), I would prefer leaving the code as it
> is.

I don't mind it, and I do use it myself when it makes sense - but imho
it's up to the person writing the code, particularly when it's their
code in the first place.

-- 
Jens Axboe
