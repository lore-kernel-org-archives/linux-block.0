Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89A91CD08
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108443; cv=none; b=uvyPOvZslf8OMVGT+rj5YuzV0d7SOeP2lQ8usvEUcCnZTCDyBz7K0YgK+ai8VpkO6eDF+PnnYjrN2sArM5TE58teejIhmpkEwz1zVywJ7e8s3cbc2x7GdIy2TTsj73FmXE4OlujF2KYOlJSM6ctvv689hwh6zC7oTbeLSukj/Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108443; c=relaxed/simple;
	bh=8GiPMJfa5kMy9g5wq7yuUGkfo1MdFpMfxBsq5mHXilU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlhFBcALDAvSLOlhNqicznhwLuVa+9z7I4sqv9x2P9caE91NcszITzxw4NRHTKwa9kLXdaat7DZxMQaIFcrNkv8mStSyykZtq9EOIlget2nx1fdWb4cZqdcjnNMClbZlrIpSV9VlipmYmNOwFHu9Tm9qv/ZweGo+NYZ6Y0kFoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gT/MI1CK; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gT/MI1CK"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso69684739f.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 07:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706108441; x=1706713241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DVFxuFcvUZ91jVhn3jmAWIGGYe/ziVKPAkXOw844vqs=;
        b=gT/MI1CKY6waXPG6uCdTGMMxAOe+Vr7nLnGWTWp3NBCwqqL5n/D8FcfP5wE8tavmOD
         EvsokRAWD+TL3B8IhHWc3HykBSWqCS+pzx9HH38y6G1FiTZ46j/BztUE4NApjGLqLEdi
         uOCN7bhMKCVBS81QWLEjJXxWDxdUYcrImrb8OK4g/VlKblTGxqoTMgYT/R9VB1JMbxyU
         +pDp87XIvABem4drPxTKoYnFXBPMYM1nR+Xr0PVMYSPaJ4E+3vGLeArTB1s2/x0WnHe+
         tvmcCUYX8zYI/w1UGl3R1c/OXax2++cn4F/V8IxK7BeymuoGqB/3yBVkyZ2pa1pOZ8TN
         PDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706108441; x=1706713241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVFxuFcvUZ91jVhn3jmAWIGGYe/ziVKPAkXOw844vqs=;
        b=UOQdXyhBaM+SjTWdgsDAj9RvcyZ/L3cbEeHIKGyTXgKtz7HjfvGO7SqhFYA+iIYM5r
         8A5Cix2n7sLcN9mY/OjUHuxeX5y31k+xtyG2P4hh41p2iwCt86dnTkOoL4VMk30xQAsN
         6CR62jiqaUnqVDGjYlwW9dO8IhQq66dhAjE3eUKs6gIPpcrnhvRVTA2/HQzmHWfJXt3C
         4Bp8GEBpeENDOz3izWhznYPDDRDiQ7Y8Vu4ZTrw9QqXaEOQq2AJXMzKNvypnGB9aplx8
         Jd/PzS1iiOL5RjBKgzKv48X++5550ap0M0OQQKL7GplU/NHo8k6QiR0wNFsdQ/tWRY0M
         qQjQ==
X-Gm-Message-State: AOJu0Yz9Lqi5VlDEhc8ymZQtcTjn9RbgJ3oyLjMSJy1u10MyVsrJL+Y2
	zsD1Iu8GKvq/CcjOMSoRQ8hRw1SmbkWxWdvIrd7GslCnxBCVlqZzSzXu9fss1PEExECrZY9ZjMR
	ndbY=
X-Google-Smtp-Source: AGHT+IEEJU4qB8w2J/sBdQpGnI8WVKRdOGLKpsvzr3p0zpRPb7WSIuyioYTe0mFyI1khmjM/nWmNyg==
X-Received: by 2002:a05:6e02:1b83:b0:35f:f59f:9f4c with SMTP id h3-20020a056e021b8300b0035ff59f9f4cmr2911869ili.1.1706108440742;
        Wed, 24 Jan 2024 07:00:40 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j12-20020a056e02154c00b003627b70d918sm2353477ilu.66.2024.01.24.07.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 07:00:40 -0800 (PST)
Message-ID: <a0176135-ccf2-4948-a61c-9527b25f5d34@kernel.dk>
Date: Wed, 24 Jan 2024 08:00:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] block/mq-deadline: serialize request dispatching
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-3-axboe@kernel.dk>
 <1c695e25-af8e-41b2-adfe-58c843e7dbc1@acm.org>
 <77209dea-406f-4143-98b7-b034b4d1dfe6@kernel.dk>
 <ZbDY80W3Sr4DQHVJ@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZbDY80W3Sr4DQHVJ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 2:31 AM, Christoph Hellwig wrote:
> On Tue, Jan 23, 2024 at 12:13:29PM -0700, Jens Axboe wrote:
>> On 1/23/24 11:36 AM, Bart Van Assche wrote:
>>> On 1/23/24 09:34, Jens Axboe wrote:
>>>> +    struct {
>>>> +        spinlock_t lock;
>>>> +        spinlock_t zone_lock;
>>>> +    } ____cacheline_aligned_in_smp;
>>>
>>> It is not clear to me why the ____cacheline_aligned_in_smp attribute
>>> is applied to the two spinlocks combined? Can this cause both spinlocks
>>> to end up in the same cache line? If the ____cacheline_aligned_in_smp
>>> attribute would be applied to each spinlock separately, could that
>>> improve performance even further? Otherwise this patch looks good to me,
>>> hence:
>>
>> It is somewhat counterintuitive, but my testing shows that there's no
>> problem with them in the same cacheline. Hence I'm reluctant to move
>> them out of the struct and align both of them, as it'd just waste memory
>> for seemingly no runtime benefit.
> 
> Is there ay benefit in aligning either of them?  The whole cache line
> align locks thing seemed to have been very popular 20 years ago,
> and these days it tends to not make much of a difference.

It's about 1% for me, so does make a difference. Probably because it
shares with run_state otherwise. And I'll have to violently disagree
that aligning frequently used locks outside of other modified or
mostly-read regions was a fad from 20 years ago, it still very much
makes sense. It may be overdone, like any "trick" like that, but it's
definitely not useless.

-- 
Jens Axboe

