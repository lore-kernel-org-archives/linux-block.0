Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4677462;
	Tue,  3 Sep 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379363; cv=none; b=nJYgCsRkIPUzlwr84Ij+BK0Q5CK5a7aq4J6UOg1k96WkVTvewcD7sXkYbfXBdyBVAun/vYM91HHIsxOVCD0+GGaCqnxCOhPOsCHBkdW5XTSLeHRgpB3Kgbkx63xF4oTk3azWfapU8cQxcDDn43yq5mOY8TiSAb/cOJK6Hb327js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379363; c=relaxed/simple;
	bh=FlG0P/a8/LjKfzT07rX6IuqJDUQD4dupqho4dM495L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTSy2BHMB2HeS3kMQgnYMXPyt2EJjv9NYGFENRFRKxXibOBXJ4Jcr+WC3SZ76k5yjBwsr4LRIsRyEZ6nRTgPF4Zsw/BInpncVZzLnWao1rPvaCMxuF7rpvd4VM6VV+zHZYZHMQdZvjIr+vcQaAqNJJ5ye+JoN3NQoB0z8Yc9KZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOcr5b0T; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOcr5b0T"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5334b0e1a8eso7251289e87.0;
        Tue, 03 Sep 2024 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725379360; x=1725984160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4aCoypAsKmzFZppdJCHZk5LXiRNLHO4vzm+kgetzzDo=;
        b=gOcr5b0T4ZKK1qObHn6GSnV395smKG1aQpC4jZdysqYRNLrCUCUv+zz0JHc7FYWJuO
         qrWa7TSVZHkNHYwfA+vE/krRbsALvkixXhem5Mx7o/rdqi9S/IiHnrC3EGZvoL9i8CIw
         ocOW4A/zuMmZPguF+kqjcMSlQTQAqCrNGF7wWzZpICIDL7csviR6dAj/y7XgTpUYV0TM
         sgCg8B6Za5mBwa/QLEgH7M0koRNqR/HQts+XoA7/59RlOsZ2aiLMo37SD+oq7qPgqAtJ
         j+sX1Cut0XwoVuT00UKbS3TGThFDSspj3EkWu9W4wzUmYe3Uq4g89OP7N5DkOGdzrdW1
         yASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725379360; x=1725984160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4aCoypAsKmzFZppdJCHZk5LXiRNLHO4vzm+kgetzzDo=;
        b=YD0c6dOoJG28wZRoUetoDdjCojFHCxpnnrz5BKSfx5tBnkPuF7RQkPLvHeSXNXsf+U
         vrrgbEDNDkXiwWmwmMoEBL2SlfKBSwpPmZ2Dja3ddGRZAGoKMRsaLapUXVgTXjDXXP32
         jTer7BSlKUM/vG0CG6aRRZPWAUEEzYSqbX+wMWj4YUSIQ9GleG1FrWUiJEuhP7N8OXH/
         fCDNgT+dnW+MCpcKpnkjc8SFZeNiJJkOMWJEtsZvxY3gEKsFJq8JLB/+4XepUh6M+dSL
         J3ZV+o/YY8HNosKm8BplN6WVslut75vmELBTRgu64V/KzNxtUdbzfjPWyyeLBMVvZAV2
         CmnA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5U4lBN/FGTLD99skp0J/HnXJxJIr5waCFhckUahkhl/1jO9zHU1DT7Rm3aJDOS0tH88FoyGKYLYFRxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzswOmePGNyXPR44oiNScJiROjrkHKRcznP5VPmrFF/BruQt++B
	cqukbwgz3CyThoJh6zXKJrtm4YvpOHjWk4DOigT9VKcxmcQDk9/J
X-Google-Smtp-Source: AGHT+IF7iiLnFlcvVX0QRMw+6iyyHZ4NDafQthpozDOmvSA/ld4dv9KH9F48b5E5gcLWjNZ0jEquXA==
X-Received: by 2002:a05:6512:39d4:b0:530:e228:7799 with SMTP id 2adb3069b0e04-53546bab2e9mr10840141e87.58.1725379359267;
        Tue, 03 Sep 2024 09:02:39 -0700 (PDT)
Received: from [192.168.50.7] (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba8esm14619644f8f.50.2024.09.03.09.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 09:02:38 -0700 (PDT)
Message-ID: <8f7269b0-e8f1-47cc-9ad7-1f1c2e452b02@gmail.com>
Date: Tue, 3 Sep 2024 18:02:37 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Export blk_alloc_discard_bio
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Zta6RR1gXPi7cRH3@infradead.org>
 <20240903073915.989741-1-luca.stefani.ge1@gmail.com>
 <8d5a0a41-0112-4c53-a7c4-67bfc5332ba9@kernel.dk>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <8d5a0a41-0112-4c53-a7c4-67bfc5332ba9@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/09/24 17:49, Jens Axboe wrote:
> On 9/3/24 1:39 AM, Luca Stefani wrote:
>> The fs trim loops over ranges and sends discard requests, some ranges
>> can be large so it's all transparently handled by blkdev_issue_discard()
>> and processed in smaller chunks.
>>
>> To support cancellation (or suspend) requests we need to insert checks
>> into the the loop, exporting the symbol allows to reimplement
>> such loop with the desired behavior.
>>
>> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
>> ---
>>   block/blk-lib.c        | 1 +
>>   include/linux/blkdev.h | 2 ++
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>> index 4c9f20a689f7..ebaef47d8ce7 100644
>> --- a/block/blk-lib.c
>> +++ b/block/blk-lib.c
>> @@ -59,6 +59,7 @@ struct bio *blk_alloc_discard_bio(struct block_device *bdev,
>>   	cond_resched();
>>   	return bio;
>>   }
>> +EXPORT_SYMBOL_GPL(blk_alloc_discard_bio);
>>   
>>   int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>>   		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index b7664d593486..f3631044d905 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1088,6 +1088,8 @@ static inline long nr_blockdev_pages(void)
>>   
>>   extern void blk_io_schedule(void);
>>   
>> +struct bio *blk_alloc_discard_bio(struct block_device *bdev,
>> +		sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask);
>>   int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>>   		sector_t nr_sects, gfp_t gfp_mask);
>>   int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> 
> Since blk_alloc_discard_bio() is already defined in a header (otherwise
> it would've been static and your export symbol above would have failed
> miserably), why add it to another header?
> 

ACK, will remove the header change in v4,

Thanks.
