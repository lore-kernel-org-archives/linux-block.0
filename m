Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0623ED5E
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862305; cv=none; b=KTG5KP8VSz35OrO32nazA9ZIdNph+oNGDKnVTNnk/2F/bNPKtQ5lue7D9jWzGKGVwNIN0ZQ0/p4ReIbkx16wpozxdJlmMnB248bLbxmBQgSQ7jTk0nhFm3SGd+GKVOiEjU7CNWJd7mHlpFFKyOB1UEN8i4sAwDhLJ9wm4HDZ6oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862305; c=relaxed/simple;
	bh=UNDFKh6EtR41sLGf3n/jLNncxCVeGRiamWNjmyGihgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXlH+Okj79Jt3lQDF+fAiokFPyyU4BEVaEEAzPk1GOvHcOA5sNuBZ8fc6nY65ekRNao3tRyeWMGV16EXHqfU6OntCbbz4IDDeutv6LqMcuYFVE9puoqt4vAZJQQg68K8dAXTlUgJ++C0zECAELo3Ob9d+4ST0TUJCNmXuoOoDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r0SLMtR7; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r0SLMtR7"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3eb4684f3cbso1465575b6e.3
        for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 12:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733862302; x=1734467102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4uVKrnhOb5OPOrCkL+Fhl0678KDfsGNRP28fCC0i1g=;
        b=r0SLMtR73vNy0NdMNMKYVqTM84grN3iHvWA+OAGsHjHJcUzeNqSrHaZ4PMMGNumGFq
         LJugvYdRof4PKN5yx63sj1HDyy2rEFKA9yWWfDMqZEvwMFrNjdNhAuAmg+dx9Ciul8c5
         4W/2+L1oMfejWTdqC49T8AchVdJbvA3qK9SfzBTLbCK4bw3dsuvdOLbDsfYJAOHrSAEY
         tXlq8WVsT47mfZ77qsZGseK7ApmF2zBEYk0BPfV6wMNO4RK3Z9mb4za1SKm5GqLVEuVd
         zWOLCxXyTvGd76sRfogCi33hQXhVWVGH0Z1xIYt94yAec7GiIHu1FsZhNp6bMR8q9C9g
         RdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733862302; x=1734467102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4uVKrnhOb5OPOrCkL+Fhl0678KDfsGNRP28fCC0i1g=;
        b=nAJGanxiSNBH9JsCHjuFJjMGP9c4nEGtupKbQtj6FJ6rjdNxIaa/j2w0P1+E6Fzvln
         /z/1AiC1I2Z2t11jIbcnJ1PMVH1f7ytBJsEtMzVtbiMjnFJIdCuZH4hMlLCdIkpTb1nv
         NA4Rh6N8qb7r+CHTtZd91XG3wjhyLJbsnhGwdSwfuZOGKQRc1/qSax9zQOI5gf5iROYe
         KIZbDo1rh4VByE+7YFhb+Pg4e0sSP+tnZzDXN8c7uI+uUapnYGzzogtaBd8Ar7u4kCNm
         DB2OgpIJZHxlxClj/rpcC/XqhQAdtyW64aHxTIdueNAr7xXek+2Vjz+hG8Yago8ag/Uy
         S9Eg==
X-Gm-Message-State: AOJu0YzpzmIRvOa7TgO1qIDq81nrHsnzmODz9AarzE6Y3LPP9WSFByKO
	twV8AFOrUtd3ua9MPplyVgH89zdfDz9WB00c1lbtVeCnql3Ho8Sxkhz7BoxnIswygrfdKguTGLa
	l
X-Gm-Gg: ASbGncvw8dzuSAqiuyp32Y8BjgeknQUMNU3Qb8NyyhxULrDsyj6IIUr8ihQcasrfaQI
	VX2gpmtgyVtb7Z0eI7+nQtt4XaQjDYdK2T3mb8m8YyyCQZbhsv6ce+Ek8LMbNt4XTOjz+GM3UW5
	uUI3UaY9iOw/9LdwH0khg1kRNHUeKn+f3hzfi0mtNMi22zv//zhFYEjUKu5vw7Qhqerh3lqJOrA
	JprtSh2vak+cw8XhR+/THjrQh0nR3dZvlb4lVQE5ZV0VkzhwA==
X-Google-Smtp-Source: AGHT+IENz/N20lGE1Cb9LYPVC1rDkVHiBlms49Lx+SUk0dw7nu41xde2awBttDC5mO+hqAQkijpQkQ==
X-Received: by 2002:a05:6808:1981:b0:3eb:6044:5a7e with SMTP id 5614622812f47-3eb85ba8b46mr220181b6e.19.1733862302366;
        Tue, 10 Dec 2024 12:25:02 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3eb7ca77f07sm225349b6e.35.2024.12.10.12.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 12:25:01 -0800 (PST)
Message-ID: <12eec6ff-8ddd-4a94-85c7-efc30cf70241@kernel.dk>
Date: Tue, 10 Dec 2024 13:25:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: get wp_offset by bdev_offset_from_zone_start
To: Bart Van Assche <bvanassche@acm.org>, LongPing Wei <weilongping@oppo.com>
Cc: linux-block@vger.kernel.org, bvanassche@google.com, dlemoal@kernel.org
References: <20241107020439.1644577-1-weilongping@oppo.com>
 <4ba9633b-472d-4d63-9282-bd68b79fba18@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4ba9633b-472d-4d63-9282-bd68b79fba18@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/10/24 1:23 PM, Bart Van Assche wrote:
> On 11/6/24 6:04 PM, LongPing Wei wrote:
>> Call bdev_offset_from_zone_start() instead of open-coding it.
>>
>> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
>> Signed-off-by: LongPing Wei <weilongping@oppo.com>
>> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>> v4: update commit message
>> ---
>>   block/blk-zoned.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index af19296fa50d..77a448952bbd 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -537,7 +537,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
>>       spin_lock_init(&zwplug->lock);
>>       zwplug->flags = 0;
>>       zwplug->zone_no = zno;
>> -    zwplug->wp_offset = sector & (disk->queue->limits.chunk_sectors - 1);
>> +    zwplug->wp_offset = bdev_offset_from_zone_start(disk->part0, sector);
>>       bio_list_init(&zwplug->bio_list);
>>       INIT_WORK(&zwplug->bio_work, blk_zone_wplug_bio_work);
>>       zwplug->disk = disk;
> 
> Hi LongPing Wei,
> 
> Since this patch has not yet been merged, how about reposting it?

No need, bubbled to the top and I got it applied.

-- 
Jens Axboe

