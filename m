Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6870C6
	for <linux-block@vger.kernel.org>; Tue,  5 Dec 2023 19:24:22 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b9b8522d91so1729438b6e.0
        for <linux-block@vger.kernel.org>; Tue, 05 Dec 2023 19:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701833062; x=1702437862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOmfNEl/HqgeH6GFWbZvKZ5Kav6LFVfBo6JMRZLHXAw=;
        b=oz4PBdzSxzzBQv4By5egysTxahxchgLEWwb18Zr+X7ZHMVZIuBLu2vaSqFj41L7SRs
         KPAwOrlClFNmaU85wT1LWMrhgeW7e3J7ayHafF3EtQrj2KHRnGoOdYYP1i7mzfpwFPfB
         JPvAuVJBY49Dh1O0/DWhpjRi0VA4kIGenZth4kM1PNK8ppXrLt8B+N0mGX6JlETAQals
         7scrC7nJBdW2cC46qH6mn8Bsw3JvaAEjRGXVq22jYntfXVGc4PH4SSoJwFJo10ojpIIf
         ZfpNxJyUm34s0sn4Eot7ixtDnB8DQE3IMol2ahJ89K4ka0qDivj+IFaD1XarmLML2BsM
         pjVw==
X-Gm-Message-State: AOJu0YwPFHtHXjjRDvfERCBO/WVSULlqvLwKZY6ACv0+X0AlyuIFlG3T
	Ov1fRjWF2TBoTUMZEiyhc8btJC/VfEI=
X-Google-Smtp-Source: AGHT+IEyZATv8spuuQ4PAln88TT6H9i71Ilc/V5+ITB36UFc0guXtVENkdXB9hx1wUf7GcAJR5TQOA==
X-Received: by 2002:a05:6808:23c3:b0:3ae:16b6:6338 with SMTP id bq3-20020a05680823c300b003ae16b66338mr437097oib.3.1701833061631;
        Tue, 05 Dec 2023 19:24:21 -0800 (PST)
Received: from [172.20.2.177] (rrcs-173-197-90-226.west.biz.rr.com. [173.197.90.226])
        by smtp.gmail.com with ESMTPSA id w2-20020aa78582000000b006ce6ba06a29sm2098689pfn.128.2023.12.05.19.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 19:24:21 -0800 (PST)
Message-ID: <5ab6bc79-eedd-4fc1-b104-a9960d5651aa@acm.org>
Date: Tue, 5 Dec 2023 17:24:19 -1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-4-bvanassche@acm.org>
 <100ddd75-eef5-44e9-93ff-34e093b19ab7@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <100ddd75-eef5-44e9-93ff-34e093b19ab7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/5/23 16:42, Damien Le Moal wrote:
> On 12/5/23 14:32, Bart Van Assche wrote:
>> Fix the following two issues:
>> - Even with prio_aging_expire set to zero, I/O priorities still affect the
>>    request order.
>> - Assigning I/O priorities with the ioprio cgroup policy breaks zoned
>>    storage support in the mq-deadline scheduler.
> 
> Can you provide more details ? E.g. an example of a setup that breaks ordering ?

Regarding prio_aging_expire that is set to zero: a third party Android
developer reported that request prioritization in
mq-deadline is not compatible with MMC devices
(https://android-review.googlesource.com/c/kernel/common/+/2836235).

Regarding zoned storage and I/O priorities: we are working on modifying
Android such that foreground apps have a higher I/O priority than
background apps. As one can see in
https://android-review.googlesource.com/c/platform/system/core/+/2768906, 
we plan to use the ioprio cgroup policy to implement this. We noticed 
that this CL breaks zoned storage support if the mq-deadline I/O 
scheduler has been selected. I think that this should be solved in the
mq-deadline I/O
scheduler and also that ignoring I/O priorities for zoned writes that
must be submitted in order is a good solution. Respecting the I/O
priority for writes would require to make significant changes in the
layer that submits the zoned writes (F2FS): it would require that that
layer is modified such that it adds writes from foreground apps to the
log before those of background apps.

>> -static u8 dd_rq_ioclass(struct request *rq)
>> +static u8 dd_rq_ioclass(struct deadline_data *dd, struct request *rq)
>>   {
>> -	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
>> +	return dd->prio_aging_expire ? IOPRIO_PRIO_CLASS(req_get_ioprio(rq)) :
>> +				       IOPRIO_CLASS_NONE;
> 
> I personally would prefer the simpler:
> 
> 	if (!dd->prio_aging_expire)
> 		return IOPRIO_CLASS_NONE;
> 	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
> 
>>   }
>>   
>> -static u8 dd_bio_ioclass(struct bio *bio)
>> +static u8 dd_bio_ioclass(struct deadline_data *dd, struct bio *bio)
>>   {
>> -	return IOPRIO_PRIO_CLASS(bio->bi_ioprio);
>> +	return dd->prio_aging_expire ? IOPRIO_PRIO_CLASS(bio->bi_ioprio) :
>> +				       IOPRIO_CLASS_NONE;
> 
> Same comment as above.

I will make the proposed changes.
> What about the call to dd_dispatch_prio_aged_requests() in
> dd_dispatch_request() ? Shouldn't that call be skipped if prio_aging_expire is 0 ?

That sounds like a useful optimization to me. I will look into this.

Thanks,

Bart.
