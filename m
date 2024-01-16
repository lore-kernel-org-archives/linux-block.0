Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA271BF22
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="D7yN45go"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-360630beb7bso7778265ab.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705416193; x=1706020993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrKHxnpFL43gNtqjixFGO85ojRP7W+RwELBqauGPTUk=;
        b=D7yN45goia7yRk+rDVYjL7DuvE8be256fJqL4B0paptHYWBroEQUVOkpFsn+npkm/T
         CJoyIKR65Y2rCU/QH0SrcwgMVJueE1bidTW9A0xgyp6BItLwgY4PQLRxYt0CUIjJuTPE
         a754KTwMTgBk3+64O6JyDYwJGMweHyuqPY2dhCdTXrlg8oHva/vtOrQeidpcHEUqmiS7
         HsS+Zuw68NhW7RBRQ13Va+YjnI86v4rfZ+oX1MdVmPlB3Ho6vSx7OHnhMybcpn/6S2sS
         mLhR5NM8fDIyhjBzlDxfGrO6GLyW06ShAOL1kUUW45RoWvHXp1RL45Bs7HuLdvj4Wt9A
         uA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705416193; x=1706020993;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrKHxnpFL43gNtqjixFGO85ojRP7W+RwELBqauGPTUk=;
        b=SH96jSSlqE2MGwP384mMkMY1a7EH9itNfsrKmJjuvXarHI5Ckhu5b14qMUOUYDVPiz
         phat2RDmy+B+7BuOTGxEs4XQgdk17QslLBjuh5dKQMVUwwayjtifLnt+GhRVRY8umqci
         3wzY6ONeDgLEvgqDckfp8kQ49hdK+q2QsUoeQwP2rFyf3+B/Hq/x4rO8k8o2Is+WnTeS
         rTZr+hdKT06QlMfFz/V+mcx7Ao1nPTugKpVjtnxDU7HXX0cbwQQuq9osxUwlc5FAxd/z
         TCRU+/XKvqG8nmTOCRszoL8Q14kn8pAG/D4XDzZxSv6LKcyIp2u8JjmNuDqbM6fKUX5n
         k/jw==
X-Gm-Message-State: AOJu0YzptwH3k/NKG7Kp8RFt83+B0e8yX3albu696udq0t9aTS/uUSgw
	+O5Kn3D+nud2FTE/2z3QfuPWkdlZbgpwrg==
X-Google-Smtp-Source: AGHT+IGEDZDWtxDpwZAWR9ay3DfGokiow/x1zwcvh/FkAoj7YSLMXApURRI7WLCOHevnHmseN/6nFA==
X-Received: by 2002:a92:ca07:0:b0:35f:b559:c2c7 with SMTP id j7-20020a92ca07000000b0035fb559c2c7mr12627242ils.3.1705416192396;
        Tue, 16 Jan 2024 06:43:12 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bq7-20020a056e02238700b0036088147a06sm3603463ilb.1.2024.01.16.06.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 06:43:11 -0800 (PST)
Message-ID: <17a5683c-8883-4adf-8c98-812f7176eff1@kernel.dk>
Date: Tue, 16 Jan 2024 07:43:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: cache current nsec time in struct blk_plug
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org
References: <20240115215840.54432-1-axboe@kernel.dk>
 <CGME20240115215903epcas5p1518ca37cf0c83499dadba07bd3e51c77@epcas5p1.samsung.com>
 <20240115215840.54432-3-axboe@kernel.dk>
 <ff4a6649-9f09-23fc-ad33-06deb4845590@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ff4a6649-9f09-23fc-ad33-06deb4845590@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/24 2:51 AM, Kanchan Joshi wrote:
> On 1/16/2024 3:23 AM, Jens Axboe wrote:
> 
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 11342af420d0..cc4db4d92c75 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1073,6 +1073,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
>>   	if (tsk->plug)
>>   		return;
>>   
>> +	plug->cur_ktime = 0;
>>   	plug->mq_list = NULL;
>>   	plug->cached_rq = NULL;
>>   	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 2f9ceea0e23b..23c237b22071 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -942,6 +942,7 @@ struct blk_plug {
>>   
>>   	/* if ios_left is > 1, we can batch tag/rq allocations */
>>   	struct request *cached_rq;
>> +	u64 cur_ktime;
>>   	unsigned short nr_ios;
>>   
>>   	unsigned short rq_count;
>> @@ -977,7 +978,15 @@ long nr_blockdev_pages(void);
>>   
>>   static inline u64 blk_time_get_ns(void)
>>   {
>> -	return ktime_get_ns();
>> +	struct blk_plug *plug = current->plug;
>> +
>> +	if (!plug)
>> +		return ktime_get_ns();
>> +	if (!(plug->cur_ktime & 1ULL)) {
>> +		plug->cur_ktime = ktime_get_ns();
>> +		plug->cur_ktime |= 1ULL;
>> +	}
>> +	return plug->cur_ktime;
> 
> I did not understand the relevance of 1ULL here. If ktime_get_ns()
> returns even value, it will turn that into an odd value before
> caching.

Right, it's potentially round it up by 1 nsec.

> And that value will be returned for the subsequent calls. But
> how is that better compared to just caching whatever ktime_get_ns()
> returned.

0 could be a valid time. You could argue that this doesn't matter, we'd
just do an extra ktime_get_ns() in that case. And that's probably fine.
The LSB was meant to indicate "time stamp is valid".

But not that important imho, I'll either add a comment or just use 0 as
both the initializer (as it is now) and non-zero to indicate if the
timestamp is valid or not.

-- 
Jens Axboe

