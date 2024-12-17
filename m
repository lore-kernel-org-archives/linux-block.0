Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8073F1F9410
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463969; cv=none; b=NFa7/LC6irUTCw7KAjE+GFvwCAEt5ZeWmYfzSx7DoIbI2OaWxIWL50BmKuqziLzzGdObM9MDgai2uaLS/2oSemLLhi4bDMhNlDYAZzrREqAkBz5w26l/UfAZowu9mAYezbtfd47ftxkWFsuziUweNIy2TM2SwapL6FtkAfvsGAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463969; c=relaxed/simple;
	bh=tNmaacFjPKi88iOhxo5q6N4RiCQzshJ1p3WfipRUadw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNeNA/8AjgMdumW7KVqrzjMkZEL5OhUE8j7IZGmaG5ldcPDMuKsuf7RdTb+aIptYH+JW0RbfLw5fGLnfMW1qebu6hW1Da4akdeWQjDA3DrmN+XikQfb95qwP4f2PmvVAyaBaaFTAw1wgoBwSKsrRCm67u4c7dC4PSD4Kk4pAq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gT1N4wDu; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gT1N4wDu"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a8c7b02d68so47244515ab.3
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 11:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734463965; x=1735068765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVMEQu4hw7cLhksID7H0Mo1r+oNz4ECmruMLq1DMQcM=;
        b=gT1N4wDuCyUoxKu57MZxrGxNzOr4Ln3oHV3EO2qqs4K++J2R+akoMXKRN+Uku8hsT0
         RL+ODxo7PsaMLN/WHOgjI4PfCzB1jGWykUVByhzwRjH7bZ+wwiS0pM1f4ey6yRxAiglA
         akjqGd98J+pROARzoOoSU+tlqpW++nn2ZQn5AKtj++6FkUFECKDfJTzX7rg649v3IWQK
         queZ9LSeazrlBZgva4ibmQlixA4STHHbkw/yq3TLo2kquHzKkgtfdLJ1ZEgumsOV7jkO
         ym0nK4vf2UOUpBBYWg2Ot4OKcWnO+UH/6uatd4j2qld3sSW8pQxnbH5mI6slSr+/NtD5
         ThkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734463965; x=1735068765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVMEQu4hw7cLhksID7H0Mo1r+oNz4ECmruMLq1DMQcM=;
        b=pOvhMg24EEMvHRNavnJUF50tYTWyO+8aJg7ohA+IwAtbZHPkPTzIaXR/6HuIkxebAC
         2y2wLTMSO+Rcl/lazzz/JaA1NXbQSXrjsKPXbmDzx0RKEHPDM3KQXiMiVMf7ssVxm4oG
         /aIFWgCH0Rpit7ehK/pTTkWZmX/yemvFLOOvCqe62Zekh0RlSlQrzMiboCoYIudOrE1/
         Q6pxfIjaO0h5S/4poKH4IyMyx6A+ly1GlUyMu0bOW5VSmiB95hLjFS2DjTISSKkyEwyX
         ElSw1AVC/iygqAKxNY+2PkyHeuvauGG9EJ8gZfwVvNDtcOx6l8AlFy+Mv4g6LigVj/Ra
         XGHw==
X-Gm-Message-State: AOJu0Yy+NpsVKE+GyFbLJ6gFDh7Gw3L0iWxoLgvM/Tsg8dG8mw3kbj9a
	oKcDYViLCdAtJUNAuEdDiCvRcNebGW/N+sVa1Glio3qAZtlLd0wKNVIWmTLHtyU=
X-Gm-Gg: ASbGncu8m1NQsXsjqqMVXpSlHiYTPQ2kftJ3OZYD33C3aKC3XnuvRPZwfHqC0uC9Xt4
	+VuErfYrmmWVZj3rpI5bVh707Lk97o4nS2G6TODTZCsF4vHRA9crYNm5mkaRKA3cItF3+5A8YUu
	5KCJp53N8HscHViDdKc8T2pDg2cvyjP5amkVAo/xqDe45oU9RoPJZDRgdF3yC+JBKy0b0sYyBg9
	gk3xC2W6ux1f3OcknVXFXBAsa64qHTTmtrdD4952AN/7vub+EOC
X-Google-Smtp-Source: AGHT+IGoI/u8QP0V4bN2f2sj6ZSp3oTLsAXdWFNtaHr1pzdkQXWrNSoa81NFvRE9dbYBu8GmLUG5iQ==
X-Received: by 2002:a05:6e02:99:b0:3a7:c60b:ad90 with SMTP id e9e14a558f8ab-3bdc01331b3mr3535855ab.3.1734463965506;
        Tue, 17 Dec 2024 11:32:45 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b24cf3a9dfsm22565035ab.59.2024.12.17.11.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 11:32:44 -0800 (PST)
Message-ID: <8c0f9d28-d68f-4800-b94f-1905079d4007@kernel.dk>
Date: Tue, 17 Dec 2024 12:32:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <20241217041515.GA15100@lst.de>
 <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
 <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
 <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 12:20 PM, Damien Le Moal wrote:
> On 2024/12/17 11:07, Jens Axboe wrote:
>> On 12/17/24 11:51 AM, Damien Le Moal wrote:
>>> On 2024/12/17 10:46, Jens Axboe wrote:
>>>>> Of note about io_uring: if writes are submitted from multiple jobs to
>>>>> multiple queues, then you will see unaligned write errors, but the
>>>>> same test with libaio will work just fine. The reason is that io_uring
>>>>> fio engine IO submission only adds write requests to the io rings,
>>>>> which will then be submitted by the kernel ring handling later. But at
>>>>> that time, the ordering information is lost and if the rings are
>>>>> processed in the wrong order, you'll get unaligned errors.
>>>>
>>>> Sorry, but this is woefully incorrect.
>>>>
>>>> Submissions are always in order, I suspect the main difference here is
>>>> that some submissions would block, and that will certainly cause the
>>>> effective issue point to be reordered, as the initial issue will get
>>>> -EAGAIN. This isn't a problem on libaio as it simply blocks on
>>>> submission instead. Because the actual issue is the same, and the kernel
>>>> will absolutely see the submissions in order when io_uring_enter() is
>>>> called, just like it would when io_submit() is called.
>>>
>>> I did not mean to say that the processing of requests in each
>>> queue/ring is done out of order. They are not. What I meant to say is
>>> that multiple queues/rings may be processed in parallel, so if
>>> sequential writes are submitted to different queues, the BIOs for
>>> these write IOs may endup being issued out of order to the zone. Is
>>> that an incorrect assumption ? Reading the io_uring code, I think
>>> there is one work item per ring and these are not synchronized.
>>
>> Sure, if you have multiple rings, there's no synchronization between
>> them. Within each ring, reordering in terms of issue can only happen if
>> the target response with -EAGAIN to a REQ_NOWAIT request, as they are
>> always issued in order. If that doesn't happen, there should be no
>> difference to what the issue looks like with multiple rings or contexts
>> for io_uring or libaio - any kind of ordering could be observed.
> 
> Yes. The fixes that went into rc3 addressed the REQ_NOWAIT issue. So
> we are good on this front.

I do remember that fix, but curious if there's still something wrong
here...

>> Unsure of which queues you are talking about here, are these the block
>> level queues?
> 
> My bad. I was talking about the io_uring rings. Not the block layer
> queues.

Gotcha

>> And ditto on the io_uring question, which work items are we talking
>> about? There can be any number of requests for any given ring,
>> inflight.
> 
> I was talking about the work that gets IOs submitted by the user from
> the rings and turn them into BIOs for submission. My understanding is
> that these are not synchronized. For a simple fio "--zonemode=zbd
> --rw=randwrite --numjobs=X" for X
>> 1, the fio level synchronization will serialize the calls to
>> io_submit() for
> libaio, thus delivering the BIOs to a zone in order in the kernel.
> With io_uring as the I/O engine, the same fio level synchronization
> happens but is only around the IO getting in the ring. The IOs being
> turned into BIOs and submitted will be done outside of the fio
> serialization and can thus can endup being issued out of order if
> multiple rings are used. At least, that is my understanding of
> io_uring... Am I getting this wrong ?

Yes, this is totally wrong. If we assume a single ring, and a single
thread/task driving this ring, then any IO being put into the ring is
issued IN ORDER on the kernel side by that very same task once said task
does io_uring_enter() to submit whatever it put in the ring.

Like I mentioned earlier, there's _zero_ difference in the ordering in
which these are issued between libaio and io_uring, for a single ring
(or context) and a single task doing the submit and/or wait for events
call.

Fio doesn't have multiple threads operating on a ring, there's always a
single ring per IO thread. Yes if you use multiple jobs and expect those
to be ordered, that would obviously be broken across the board,
regardless of IO engine used. So I realize this isn't the case. But
there still seems to be some misunderstandings here on how io_uring
works, and maybe even then an issue that's not being fully understood or
blamed on something else.

-- 
Jens Axboe
