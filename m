Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6046534
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MfTF8Azt"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-360412acf3fso1113785ab.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2024 11:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704741983; x=1705346783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TE/Awr0hPNu2sSXFJuY8YTeyP9cPcYFCx1/2+4gmLM=;
        b=MfTF8Azt96NP8P2h9vR1UNqLKpo3wszcWRyj4GcbL5kCoQidcl/42xaH/EO8X7P23I
         TORRco674qc0gFo3msb1zr8OJIvAHL2GTfIoOOhYR93wTvluFll+NAagJRlSgmRdQJNe
         4ZH2lMn2pE4D24GPl7vEpGTdzJsXqC19EkRNCFgeZswxAFZmVlbk8d6ZktLsDHZ096Kg
         oP1NSQOMnp3ToK4cVZlGj4ecNAze/xPqd8G/kGRblZ9pmTLriRh4OloU9Ncv6la75Hig
         0gxaZu7SXIojdnkEAjUKQg09JGrEomRJ6Sz7NxlPEX89EEUt3RnrBZXQ2TUUNKd4KQQx
         epEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741983; x=1705346783;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TE/Awr0hPNu2sSXFJuY8YTeyP9cPcYFCx1/2+4gmLM=;
        b=qHD9J9OZX+qGjjciLSGUO9D7odCctfrNVFVOIxBLmzeVwu+qwlN5YmtpFrf3I5ofOp
         bj/Hz9ITqCXab3RAptKoiw2UAj+iaZT7GzGwCMHhV1HY09kKvsZ+Fngfu7OcZakKiTda
         otojWa4EFfW4XcHh8rHv9qlakzMuc8NpEZ9ppxHTINC1qEDfrfIqsZF1chGlh9qEjrJ7
         +48IP2xk1hcks0hwqMPyC9FI9dwymSWqQR16aKBWCfZc0IZRLUYXDZUuUZVvIvJC41ev
         wcBpVtxiEBqKBsI9Oaa9Aywm7jBu1WtwDALyYlrW16vkrXTwfzcRaolObX1E7eyKm003
         fNdw==
X-Gm-Message-State: AOJu0Yx1OCHBHMI1rRhmaSSjjJkCCgbk4li49I3nYwvQy6/Ik+um7Olc
	ZxxOC2EROyziae6Cxx1nwTBp4D4bHua+J0S1uKBb5gQIusY76g==
X-Google-Smtp-Source: AGHT+IFUUrUBwQ93PkZCC6ulf8LP1xSBIV7Odz1Nn+9NRBTWOBE/a1md+5Jf/yw5yAVEiLYEvTY0EA==
X-Received: by 2002:a5e:dd41:0:b0:7ba:c855:9cf7 with SMTP id u1-20020a5edd41000000b007bac8559cf7mr7239108iop.2.1704741983569;
        Mon, 08 Jan 2024 11:26:23 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q21-20020a6b7115000000b007bc1e8a24fcsm89043iog.32.2024.01.08.11.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 11:26:23 -0800 (PST)
Message-ID: <b1092988-4f8c-40e9-a732-ceda34d25016@kernel.dk>
Date: Mon, 8 Jan 2024 12:26:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: make __get_task_ioprio() easier to read
Content-Language: en-US
To: Bart Van Assche <bart.vanassche@gmail.com>, linux-block@vger.kernel.org
References: <20240108190113.1264200-1-axboe@kernel.dk>
 <20240108190113.1264200-3-axboe@kernel.dk>
 <5c07dc1b-9247-482f-8f38-75e578201f5b@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5c07dc1b-9247-482f-8f38-75e578201f5b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/24 12:22 PM, Bart Van Assche wrote:
> On 1/8/24 10:59, Jens Axboe wrote:
>> We don't need to do any gymnastics if we don't have an io_context
>> assigned at all, so just return early with our default priority.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>   include/linux/ioprio.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
>> index d6a9b5b7ed16..db1249cd9692 100644
>> --- a/include/linux/ioprio.h
>> +++ b/include/linux/ioprio.h
>> @@ -59,13 +59,13 @@ static inline int __get_task_ioprio(struct task_struct *p)
>>       struct io_context *ioc = p->io_context;
>>       int prio;
>>   +    if (!ioc)
>> +        return IOPRIO_DEFAULT;
>> +
>>       if (p != current)
>>           lockdep_assert_held(&p->alloc_lock);
>> -    if (ioc)
>> -        prio = ioc->ioprio;
>> -    else
>> -        prio = IOPRIO_DEFAULT;
>>   +    prio = ioc->ioprio;
>>       if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
>>           prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
>>                        task_nice_ioprio(p));
> 
> Shouldn't it be mentioned in the subject that this patch is a performance
> optimization? Anyway:

I doubt this matters for performance really, it's more of a readability
thing for me.

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks!

-- 
Jens Axboe

