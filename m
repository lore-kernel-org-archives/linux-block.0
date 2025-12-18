Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCD513D539
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766025483; cv=none; b=ruxdkZxO95DQdeW1mctY7akWZ1I4cxXYUPAu8l9vMwldjq8LANYiUDDInNRWt2qGDuKQ9vIQ0JLiytgKTXZYMCtfzSKIqp1Psll/uDJWkKyhTR5U8zRWhq8ByHzssyvZuV+n8FO6w7X1hO1WecqQj6/vIkRGHnWrSKcdVr6Hb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766025483; c=relaxed/simple;
	bh=qWDgjQG2OEazxo1OcooQvbWSOSMZGQ4DUYjR4o1Ni+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQXn7Ha1kuh04JoRHfMG5RYyyPLw5nFQsoRHlCtgZp1P3aeC9QrgnVQT7gX0sSXPffqFrBclm1bIVouP1zz3RCYriLrXGDCwRUug16FWnlWWQ0XuQknvpAX4kNb77OkRzoLfM8A9OYBa+mL7uxCqc4fRftmdCwd9ZraknQm3JgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TjNS/23M; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TjNS/23M"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-450ac3ed719so158201b6e.0
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 18:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766025479; x=1766630279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wefNA0QDUm5/2LhbiDBPYFfcFLTT1tYARYWf2em7l/I=;
        b=TjNS/23M+HYJn69Khrj3TIAWCcE4kY33HjvjTytT3bpR5BIljPOJUc4+zNwDa+qa83
         E9O0CFnYNBuAgWCL7LfkdFIJRQ8hUP6vmHASJBsk9sjoUCGvZj7EGiYHDEphxKBpzj4u
         qTMk57nDoBZzxn0YG4J18xVVIvXwF04u5HLWleLJ+sk/isMvN1lWjx0u/lT93mgFVxQ8
         bo8U/DYfjnK2v+cKl8R8Vv2UVxeZwkmfK241ua8pENuU7V+DALxV6/LMMmk5j0xAPiJ3
         S3KFbKASddYK2S8l8GUyG0HjZpCfAGZuD2Ygl9/hIsdkp6HYuLQmRqKAntZ9WG92kG9a
         NLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766025479; x=1766630279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wefNA0QDUm5/2LhbiDBPYFfcFLTT1tYARYWf2em7l/I=;
        b=tiDzvTHjUrCfKX722cco/7Pqwt6Ng9yoPoO9we124fLj1ICC/3XYXzYWgzMoYbqQs8
         AQjrcLXmDWJycHd6ajEm4RTqk2UmFmI1qexHMtY+0ZBMfzszoFrEfcdm3/i8efLhyLv1
         aTqrTiSpAmE6/x6TD/rHJTgg6Nt+Ihopoi3nKcRmkOyihPA3UHFb/UJYErujPqCOeLMI
         YXFOlhnTCKb55h38uQVILrAPL6dOdxXfN/VtFr6Z2OQW2/NAOcm3CFt0qoJn9TaK8yoE
         G6+j2SpBlr6i8GRpRzOzhbaCd2aRlu7Mn1ji6p0GQVxlJcMtOV/77WRlWpZgCChPxZ3S
         zc2A==
X-Gm-Message-State: AOJu0YxZKTx3rwV7g5qovk1eZAnAexkNLLzpXpKKv57RSYx+OWpcOApM
	0iyIFgQ3hwhdHOtfJppverNCETu1hiOC6Jm3FKealHZJasLU+ULixH9mdux+mz/pBBQ=
X-Gm-Gg: AY/fxX43Gk4QGl6KuAw9oIgWSM0S9WmCHelPE3RIoDN/Te2F8TQfSJAloRo1sFVyNIt
	11gxmL7P9iohzqkWT8vQV4FAAoyJz9sm9NP3Ze8rMQgeAmUM7l51/iXqwGeAEs1YZ2z+zLwwJj9
	CXIm9/1aFgLC9+rmKYcEMG1+qKfCrcLKCWXqsEsyKQ3uM4SSGEE7/TYf94nKs4TcVNBCAZUTxLN
	pbjZyt9BS0keO2SpHDgH+R472HiNuybaHswG3ec9EA+EO0uxO6autRFEZzsqzzhK7pGgqlhCcXX
	1M3RvMcQWoIRsIZROJnPrmtAWF3CPGDnzJ5z+5u7x3fx9bVACF8LMrOd23RNZua9iM8z/HzjPKL
	zyryv93Iv1i/D5CuNC1MPH67BKw8yQUIUDyqLi/XOuIQ1fR4DSPTBgthONKrS2/US5JBuDDZe4i
	WfKPUKv8hY
X-Google-Smtp-Source: AGHT+IFq1oG3wJSV0ACQ7bbNufDK8d7LbK3BSZ9m3tHVdc+lR3oHssaA1LlpPq3GBCH8poC21Cqwsw==
X-Received: by 2002:a05:6808:660b:b0:43f:7287:a5de with SMTP id 5614622812f47-455ac93597amr7589349b6e.41.1766025479236;
        Wed, 17 Dec 2025 18:37:59 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457a4538f69sm530283b6e.12.2025.12.17.18.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 18:37:58 -0800 (PST)
Message-ID: <939d7da5-d66d-4928-913f-7f57e7d44dc0@kernel.dk>
Date: Wed, 17 Dec 2025 19:37:56 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] ublk: fix deadlock when reading partition table
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Caleb Sander Mateos
 <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
References: <20251212143415.485359-1-ming.lei@redhat.com>
 <8dd3c141-3e92-44f3-91e2-2bf4827b36a4@kernel.dk> <aTzPUzyZ21lVOk1L@fedora>
 <93163617-11bb-4700-aca9-940c0df7429f@kernel.dk> <aUEeu9luJ9ZNvJzA@fedora>
 <6d40e8a0-14e9-45f4-bbea-360678524767@kernel.dk>
 <5e2038e1-efcf-4313-8a14-565b970370f2@kernel.dk> <aUIe3RXASOEKKc0m@fedora>
 <8b2d7335-fd49-4c15-87d9-0eb50e0a09a1@kernel.dk> <aUIkd9Nt9oSmHKKp@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aUIkd9Nt9oSmHKKp@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 8:33 PM, Ming Lei wrote:
> On Tue, Dec 16, 2025 at 08:19:15PM -0700, Jens Axboe wrote:
>> On 12/16/25 8:09 PM, Ming Lei wrote:
>>> On Tue, Dec 16, 2025 at 10:57:25AM -0700, Jens Axboe wrote:
>>>> On 12/16/25 8:03 AM, Jens Axboe wrote:
>>>>>> The issue for ublk is actually triggered by something abnormal: submit AIO
>>>>>> & close(ublk disk) in client application, then fput() is called when the
>>>>>> submitted AIO is done, it will cause deferred fput handler to wq for any block
>>>>>> IO completed from irq handler.
>>>>>
>>>>> My suggested logic is something ala this in bdev_release():
>>>>>
>>>>> 	if (current->flags & PF_KTHREAD) {
>>>>> 		mutex_lock(&disk->open_mutex);
>>>>> 	} else {
>>>>> 		if (!mutex_trylock(&disk->open_mutex)) {
>>>>> 			deferred_put(file);
>>>>> 			return;
>>>>> 		}
>>>>> 	}
>>>>>
>>>>> and that's about it.
>>>>
>>>> I took a look at the bug report, and now it makes more sense to me -
>>>> this is an aio only issue, as it does fput() from ->bi_end_io() context.
>>>> That's pretty nasty, as you don't really know what context that might
>>>> be, both in terms of irq/bh state, but also in terms of locks. The
>>>> former fput() does work around.
>>>>
>>>> Why isn't the fix something as simple as the below, with your comment
>>>> added on top? I'm not aware of anyone else that would do fput off
>>>> ->bi_end_io, so we migt as well treat the source of the issue rather
>>>> than work around it in ublk. THAT makes a lot more sense to me.
>>>
>>> It doesn't matter if fput is called from ->bi_end_io() directly, it can
>>> be triggered on io-uring indirectly too, in which fput() is called from
>>> __io_submit_flush_completions() in case of non-registerd file.
>>
>> Because of the work-around in io_req_post_cqe()? Or just because of
>> !DEFER_TASKRUN?
> 
> When fput() is called from __io_submit_flush_completions(), its release
> handler will be deferred to run task work, where the current task
> is blocked because of ->open_mutex.
> 
> It is actually one ublk specific issue which relies on the current task
> for handling IO and providing forward progress, so cause deadlock since
> reading partition table(with ->open_mutex) requires the task for handling IO.
> 
>>
>> The real problem is holding ->open_mutex over IO, and then also
>> requiring it to put the file as well. bdev_release() should be able to
>> work-around that, rather than need anyone to paper around it.
> 
> deferred bdev_release is not safe, for example of suggestion:
> 
>         if (current->flags & PF_KTHREAD) {
>                 mutex_lock(&disk->open_mutex);
>         } else {
>                 if (!mutex_trylock(&disk->open_mutex)) {
>                         deferred_put(file);
>                         return;
>                 }
>         }
> 
> deferred_put(file) will cause disk released after returning to userspace.
> 
> Yes, __fput_deferred() allows that in case of in_interrupt(), which usually
> means one abnormal application(close(disk) before completing/handling IO),
> but it will cause normal application to release disk after returning to
> userspace, it may cause -EBUSY for following syscall.

OK, let's just go with the hacky work-around. At least for now. Still
hopeful we can improve it in the future...

-- 
Jens Axboe
