Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B954F8D
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679357; cv=none; b=WyYboV/uoSR7mw+kP62DJaLiPaePNTrsdWeBHljIfKrqf3PU/PQSSnWKnypHYnnb8+njWVxRjrht/dSdw/71m7ezfMdLqqQKzsiQvUoS7hr73AF7ZMxESfLMl9A6BK4mzGItYzyTeKKpVn9c1z2NifQ1mI9Opep/GWLLdY14O6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679357; c=relaxed/simple;
	bh=2YI418v4TabqOEskSkhda35882fqJEANS3PODQpwtd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMREW4wliL0RIaRWoQ0qyy3LmAFVnaTAgaH996TTRNhh+n4AR8sO9YTLAKKlqmKUYxxEpRTuzKQRoMSB/GQ5SfqrO7tMeLSiN850AeIWtEDzguNQvYIb/2i+zJX8bi7zSO2bWH0mBSLaKk2PHO9JlMe/z0v5QAjo7qDnsBlTuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mpYn2zBl; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mpYn2zBl"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso8934439f.1
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 07:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705679352; x=1706284152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WKapYxw0olTh7QYnz3zk/dvq2XdeKyn458JEWouS18=;
        b=mpYn2zBlAiBwO0J9O7cWbOcRYXlA8+tl1A1bsTnI5ETFc8+EKwlgNmRmMiIENCuue0
         Co6bXykQIzk0H+cnndvvg7C7j/MLs4742nKSI2pDL1/ld10iTW4PlO5LyFWZi2+fHdt4
         qM+islh/14k9exW46U0st5dJSxdzQEqXGKuTHyZaeXL2Wbv4CA1LYyv5Sqp+K3jsfxV1
         KrBUqfj+fP2pTGY+K/8tE5anT7Xu1x81GezqxDADgtSYVR4r9BedEKVhVVxLvjaME5T+
         JK0snR6+9k1/Q+8ekW4/uqylQkIJnFOrG+BuBylut66sagBM58WAqn/k+JT446RlFQrz
         J6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705679352; x=1706284152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WKapYxw0olTh7QYnz3zk/dvq2XdeKyn458JEWouS18=;
        b=nIu644y/0uBcHnQaqWaev1x6nht6cW6usyqUZD7zM2fgu1/xS1rChzcggpk9pISvJc
         at7v8iPRdpHuLEYaZYUDl3eR6EzafaS5EJVs34fGOy/LA657yV+sW8WEhEjzA0akNaIX
         MU6jZ1m6hZJQ+fFMqWTluOHnvEek94tlSLX+fdulon+pRNHUOO82OUA62sg/Si8Wp6uf
         SDhpVaCXmKItyhMXV5HPv5ejtG7jP//eTEcyx9iAg86uGK9qG7UsrIioY66MpeQrE53v
         xLYd+KQZDu9VMsYNEH+ITtBTLUIR6miZj0z51rGb3Y8Ea4Zu+dZOwLDPM1vin569RDza
         IjXw==
X-Gm-Message-State: AOJu0YzB100kaCFXhCzdpVlEYgeck4YqLuqfJhs1YPlkqyphnA/yWF8K
	s2380PiaBhqYE1dPwDaplynWJiLpizLsRHneDTJj78/w8JAWCfjnQ0BuSm8Inx8=
X-Google-Smtp-Source: AGHT+IG2O3Glnw1iNXj6xsauW8+VdK2a0giISK1vfJMq14HiKLsyCy0VcS253XBzASUy7Rx+dE8sfg==
X-Received: by 2002:a05:6e02:1ca2:b0:35e:6ae2:a4b7 with SMTP id x2-20020a056e021ca200b0035e6ae2a4b7mr12671ill.2.1705679351973;
        Fri, 19 Jan 2024 07:49:11 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v10-20020a056e0213ca00b00361a86442eesm607139ilj.30.2024.01.19.07.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 07:49:11 -0800 (PST)
Message-ID: <39a3740e-f629-49a3-8536-1b0667f25735@kernel.dk>
Date: Fri, 19 Jan 2024 08:49:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/mq-deadline: serialize request dispatching
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, bvanassche@acm.org
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-2-axboe@kernel.dk> <ZanhL+fOWNSz2zJf@fedora>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZanhL+fOWNSz2zJf@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 7:40 PM, Ming Lei wrote:
> On Thu, Jan 18, 2024 at 11:04:56AM -0700, Jens Axboe wrote:
>> If we're entering request dispatch but someone else is already
>> dispatching, then just skip this dispatch. We know IO is inflight and
>> this will trigger another dispatch event for any completion. This will
>> potentially cause slightly lower queue depth for contended cases, but
>> those are slowed down anyway and this should not cause an issue.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/mq-deadline.c | 28 +++++++++++++++++++++++-----
>>  1 file changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>> index f958e79277b8..9e0ab3ea728a 100644
>> --- a/block/mq-deadline.c
>> +++ b/block/mq-deadline.c
>> @@ -79,10 +79,20 @@ struct dd_per_prio {
>>  	struct io_stats_per_prio stats;
>>  };
>>  
>> +enum {
>> +	DD_DISPATCHING	= 0,
>> +};
>> +
>>  struct deadline_data {
>>  	/*
>>  	 * run time data
>>  	 */
>> +	struct {
>> +		spinlock_t lock;
>> +		spinlock_t zone_lock;
>> +	} ____cacheline_aligned_in_smp;
>> +
>> +	unsigned long run_state;
>>  
>>  	struct dd_per_prio per_prio[DD_PRIO_COUNT];
>>  
>> @@ -100,9 +110,6 @@ struct deadline_data {
>>  	int front_merges;
>>  	u32 async_depth;
>>  	int prio_aging_expire;
>> -
>> -	spinlock_t lock;
>> -	spinlock_t zone_lock;
>>  };
>>  
>>  /* Maps an I/O priority class to a deadline scheduler priority. */
>> @@ -600,6 +607,15 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>>  	struct request *rq;
>>  	enum dd_prio prio;
>>  
>> +	/*
>> +	 * If someone else is already dispatching, skip this one. This will
>> +	 * defer the next dispatch event to when something completes, and could
>> +	 * potentially lower the queue depth for contended cases.
>> +	 */
>> +	if (test_bit(DD_DISPATCHING, &dd->run_state) ||
>> +	    test_and_set_bit(DD_DISPATCHING, &dd->run_state))
>> +		return NULL;
>> +
> 
> This patch looks fine.
> 
> BTW, the current dispatch is actually piggyback in the in-progress dispatch,
> see blk_mq_do_dispatch_sched(). And the correctness should depend on
> the looping dispatch & retry for nothing to dispatch in
> blk_mq_do_dispatch_sched(), maybe we need to document it here.

Thanks for taking a look, I'll add a comment.

-- 
Jens Axboe

