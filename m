Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DF4A24
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316946; cv=none; b=gMpFMrU9tiuB0PVnzwL0gLHI3zpWMPLD6H7a2fifD3XLpVE9OZCOxw4xpK63KhqxonlbfJgGx/WFsl0ydC6EuqvHa+o7ja+9FRjB1+nW9W56bPBjtIf/iV/0IZlZ8Vig0P1HGGZf80bI5UTRFwACNnYtV0HcPfxQWarBPDwFc6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316946; c=relaxed/simple;
	bh=d/leWpHlEPGQlMaMAAMtLjzZgXpZA3ZgX9evMbjp/Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iweTfZusOUs+BpZeqfK3z+L/59zC+Qa94su3RjLSQRJ48ncuhuJXNrPnYnLSeqUYjLYDnqRYtQUBiY5G2ZPLIDAOCpzx9SeM/7io8QJrBbvzY/ibki26Z6I5/8dj5wyJHI3mEzLtw7Id4gTn0aDIHe1UvaFIvYOySn6p+SxMfwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Od4OWOkG; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Od4OWOkG"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-867347b8de9so72022139f.0
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747316944; x=1747921744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+JUx5KIhrXbK+DsPcpxDViF6E++iBcSFyFTHkWCT10=;
        b=Od4OWOkGx0hUpG2mf9KDmMaUt2brBSNqLcBQB01/P5tYrxC5G2j6qIrFzDmCjcJOky
         RQ2wtKtP1HnSlI6ypj36OtNHdlnDCFwcPJx1Kd+JD8bD50GXXtmVhxEZbbSje+8aTrN2
         hI50qB3L8cbwoygqkhAmHT/JMGmivCSL1Dt3NieG/eowys0eRWw2ZWHetZ6h2CmZJHfz
         4pWvv2SMJMeQvzH4VM0GXeRTpwqft2M/eTHNKb6za1SSn5UY7Pc5cu+hXnFeuiv88nh3
         bNt0gDdWEmJs6eCDZoEDwZZSlpYd1ilF+Tn8FD0HyLQGvy8TY9YgrHS4OCD1H/2Nsfdg
         ixHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747316944; x=1747921744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+JUx5KIhrXbK+DsPcpxDViF6E++iBcSFyFTHkWCT10=;
        b=ujTOePCJvNc+5klE1NuxURPOqQF0ZE5yd3h8qpiMfoiCJWYkArHEZ5RXDN1N9HCdsb
         Dz/Pstjcz0ID3yjVmUEvIVm9vwwNY7Bt+tEQqRvV/w6LSteEKwG31qSQxrfMOcHBzoLN
         NbLwK0b/+Cv6cg2fDlO7jgDc30wUP131OmpeDx+ZvfM6xrz3v3Grl1iF0GG5Wi0hvqWx
         FiRLRqheANaS7K5mgD1DwVhymBEozw+Cci8pat7gZi8snzFuzIytwxgmPknRyeG6fg2g
         UCRlZyWCsO+CjNdXq2IUhu11oaRf+vOJ+p7EUVeS/fFb56iXQes4Ji4lYbio+yyYSaod
         d6Ag==
X-Gm-Message-State: AOJu0YxUbOGKyta3Tg0Hucc7xgPzuDaJkOVC71vj76GW67dB8rOlTnpr
	Y7/X/vgiLH8JLmGxTrxSVCpIJfN8RL9acKY6ojrR34+At3C2zm2uqQ+alTs7qas=
X-Gm-Gg: ASbGncud6WvMclDMaOM5ewpO0i/1MlXAvlq1quZWHBwtdOF6kBDculOn0BU3bnVrTXZ
	C1n//kYl7czZ3jq6rSce96xzG4xmdeSxYN7HIHcZBFDDazYFB0TFjJ7NQdv3PjO+AEMPhelEWnl
	Jsh3aZOFlmr+WKfPT8bU97d3MRpxRo5ZXiVPos6lHdvEDmigySmZ2I+1vtjTp8dLU08o0rWlkUP
	hb7nlkiMwZvv/brUuVcw7pK4EnV8d8Rq+2tZVGWwb9C4zY4j6GHoDiR92Kd+uKbgqJHeX/XdwXZ
	2mlH5Ny1GX4wox7RMYhF8Yyb5FYa+E/KP8k80IHrBa6IU1tP6byu1HcdxUk=
X-Google-Smtp-Source: AGHT+IF88PkE2c2ivA0JTONIWvaudi64RdDMGgingFXSeSBofaJKwH5OnEF9Z6wESXx9goFz/LwTvw==
X-Received: by 2002:a05:6e02:12ec:b0:3d3:f15e:8e23 with SMTP id e9e14a558f8ab-3db778e200emr41817415ab.10.1747316943722;
        Thu, 15 May 2025 06:49:03 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3da7e158903sm40404595ab.55.2025.05.15.06.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 06:49:03 -0700 (PDT)
Message-ID: <f4881af5-8006-42f5-bdb1-dc6f3ade266b@kernel.dk>
Date: Thu, 15 May 2025 07:49:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 6/7] blk-throttle: Split the service queue
To: Zizhi Wo <wozizhi@huaweicloud.com>, Aishwarya <aishwarya.tcv@arm.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, tj@kernel.org,
 yangerkun@huawei.com, yukuai3@huawei.com, ryan.roberts@arm.com
References: <20250506020935.655574-7-wozizhi@huaweicloud.com>
 <20250515130830.9671-1-aishwarya.tcv@arm.com>
 <0d059764-76ba-4681-8cc1-4783424ad3bf@kernel.dk>
 <fd74ab33-0d72-4924-a849-25e655988f5d@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <fd74ab33-0d72-4924-a849-25e655988f5d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/15/25 7:47 AM, Zizhi Wo wrote:
> 
> 
> 在 2025/5/15 21:39, Jens Axboe 写道:
>> On 5/15/25 7:08 AM, Aishwarya wrote:
>>> Observed the following build warning when building the next-20250515 kernel with defconfig+CONFIG_BLK_DEV_THROTTLING applied:
>>>
>>> Warning output:
>>>
>>> ../block/blk-throttle.c: In function 'throtl_pending_timer_fn':
>>> ../block/blk-throttle.c:1153:30: warning: unused variable 'bio_cnt_w' [-Wunused-variable]
>>>   1153 |                 unsigned int bio_cnt_w = sq_queued(sq, WRITE);
>>>        |                              ^~~~~~~~~
>>> ../block/blk-throttle.c:1152:30: warning: unused variable 'bio_cnt_r' [-Wunused-variable]
>>>   1152 |                 unsigned int bio_cnt_r = sq_queued(sq, READ);
>>>        |                              ^~~~~~~~~
>>>
>>>
>>> There?s no warning with defconfig alone, and I?ve confirmed that the warning appears when CONFIG_BLK_DEV_THROTTLING is explicitly enabled.
>>
>> This should fix it. The issue is if blktrace isn't enabled.
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index bf4faac83662..bd15357f23bd 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -1149,8 +1149,8 @@ static void throtl_pending_timer_fn(struct timer_list *t)
>>       dispatched = false;
>>         while (true) {
>> -        unsigned int bio_cnt_r = sq_queued(sq, READ);
>> -        unsigned int bio_cnt_w = sq_queued(sq, WRITE);
>> +        unsigned int __maybe_unused bio_cnt_r = sq_queued(sq, READ);
>> +        unsigned int __maybe_unused bio_cnt_w = sq_queued(sq, WRITE);
>>             throtl_log(sq, "dispatch nr_queued=%u read=%u write=%u",
>>                  bio_cnt_r + bio_cnt_w, bio_cnt_r, bio_cnt_w);
>>
> 
> Oops.. I didn't take that into account. Those two variables are only
> used in throtl_log. I'll check if there are any other similar issues and
> send out a fix patch shortly. Thanks for pointing it out!

Easy to miss, as it needs throttle enabled and blktrace not enabled.
I did test compile the above, and I didn't spot any other ones.

-- 
Jens Axboe

