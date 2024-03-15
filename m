Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB852F62
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529337; cv=none; b=jFzZRkucFXwE0yjNtDhiA+MhSMWR/yBAimNfqEou00N7+yyiaVIYlSiORi4diIOIGajsWZyUqXFJQ45vJTeCn3GBkAjQn7cwc7maDI/zUVYzGoX/Qw9a/Lk6/LRnT3UAAZVLOyFrLYLa6FZTs03/V85KXWebieA+SmLL/7gjAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529337; c=relaxed/simple;
	bh=TG3tmA7bXchxJD1xvLU6smvS9nW3sDt3aeLwVgPR6Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJx/psXp+Kg9zYMkkypSoz18xZCcQaGrWUDvQx+JQCBTFm3RLP+zt1/JIqTexv1pj5dRn7J8To21ucNPsw6kYRGpg8Kk+n8lMUN0r2Lgbx9kKylNmEK1qXyZs53qTNgJcK4o8xFWi5Iutnh/Ac/yX85HwoyoX3VzUaRkQOg+aCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xR8OcZC4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xR8OcZC4"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6c18e9635so533675b3a.1
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710529334; x=1711134134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=it/z+RqqCKmSoeiz7X95yFC04XjqPpL5LXqSDjefUFQ=;
        b=xR8OcZC4UQTo/mVpao1xxWSeIx9iL/QTz3pHgGCLZaginncUse/KSTzj8uMNTj/spg
         gzKoj4C2PujsLuO6dsnf+D0f9Lt8tLw9FvuK0FgzOXHqoXjq43Cmf5JdIUIp+VIGf+SJ
         zVF1H2Upj9H9FvCCyZ1jWfhtDBjcUG6pK9Q7G5LOcFmlsCgaVqYnBGacRvuYYnqCia2M
         2+mrafmPcNjhqwByu+Kyo3AVpJewgcJPqh6QNWShZW0/I6q7MpslCCX4sAL9NyruNCy+
         cfHI9twq1xTPJi7S/sW1FCVACtx8Xhxn4lZgDZDPt24Ps+VhFHDeSFoWT3cGnnW4pBmY
         f5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710529334; x=1711134134;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=it/z+RqqCKmSoeiz7X95yFC04XjqPpL5LXqSDjefUFQ=;
        b=ClyjE9JWptR56o+IoFtB51I2QKn4bj7GrKzxM6yB8azZZx3W7wdCiHPLQFhLD27f6K
         FEzNTiQ2hrkyxICoy2NqKMYNHoij5+jUNSosfokPVPbJmtVRO1Y5saV3JHrdmvRx2xE8
         g3COLn4cTaoJk6pSLvdpR4tdtJE57EacXagHqheZKM1J4Pc2Yy/dFpMONJtPGTRqiUvy
         Vs3es0AVcX1GTn7GFRY/lzfUQJrm8AVmIMBnTr580S/0uWavbcYsukgW943zejyC7WS4
         yKBC+uEjZ7H6E95xINBQ7H5xf1g99sip9ztuzjVrdN4GOsU+70BHDEh135MYOY0m4JWe
         2sbQ==
X-Gm-Message-State: AOJu0Yx0LIuZp8BAnvou+55P01vQNcLBwLPRKURNl9atA9s6x2QKbtV2
	RAXqC4xHYt7JwYqIk27I7Ct4HrYkaiaSLlF5q3AimJoJFqMf6T7TTsbIApLRd8o=
X-Google-Smtp-Source: AGHT+IF0oVdOWebbUUGmX/a0wl7i3VglTJMsjuN5eoJgBXm9tCMGYOQRZl809pEw2dMAEBvKoCLWvw==
X-Received: by 2002:a17:903:1386:b0:1de:ddc6:27a6 with SMTP id jx6-20020a170903138600b001deddc627a6mr5469489plb.2.1710529334038;
        Fri, 15 Mar 2024 12:02:14 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b001def777afc5sm1308432plg.77.2024.03.15.12.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 12:02:13 -0700 (PDT)
Message-ID: <345dbcd8-777c-4619-90ec-c7424c4f2b1a@kernel.dk>
Date: Fri, 15 Mar 2024 13:02:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] io_uring: get rid of intermediate aux cqe caches
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
 Ming Lei <ming.lei@redhat.com>
References: <cover.1710514702.git.asml.silence@gmail.com>
 <0eb3f55722540a11b036d3c90771220eb082d65e.1710514702.git.asml.silence@gmail.com>
 <6e5d55a8-1860-468f-97f4-0bd355be369a@kernel.dk>
 <7a6b4d7f-8bbd-4259-b1f1-e026b5183350@gmail.com>
 <70e18e4c-6722-475d-818b-dc739d67f7e7@kernel.dk>
 <dfdfcafe-199f-4652-9e79-7fb0e7b2ab4f@kernel.dk>
 <e40448f1-11b4-41a8-81ab-11b4ffc1b717@gmail.com>
 <0f164d26-e4da-4e96-b413-ec66cf16e3d7@kernel.dk>
 <d82a07b8-a65d-4551-8516-5e50e0fab2fe@gmail.com>
 <47ab135e-af1c-4492-8807-d0bc434da253@kernel.dk>
 <e3e3496b-244c-4fb9-ab37-a032b178b485@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e3e3496b-244c-4fb9-ab37-a032b178b485@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 12:51 PM, Pavel Begunkov wrote:
> On 3/15/24 18:26, Jens Axboe wrote:
>> On 3/15/24 11:26 AM, Pavel Begunkov wrote:
>>> On 3/15/24 16:49, Jens Axboe wrote:
>>>> On 3/15/24 10:44 AM, Pavel Begunkov wrote:
>>>>> On 3/15/24 16:27, Jens Axboe wrote:
>>>>>> On 3/15/24 10:25 AM, Jens Axboe wrote:
>>>>>>> On 3/15/24 10:23 AM, Pavel Begunkov wrote:
>>>>>>>> On 3/15/24 16:20, Jens Axboe wrote:
>>>>>>>>> On 3/15/24 9:30 AM, Pavel Begunkov wrote:
>>>>>>>>>> io_post_aux_cqe(), which is used for multishot requests, delays
>>>>>>>>>> completions by putting CQEs into a temporary array for the purpose
>>>>>>>>>> completion lock/flush batching.
>>>>>>>>>>
>>>>>>>>>> DEFER_TASKRUN doesn't need any locking, so for it we can put completions
>>>>>>>>>> directly into the CQ and defer post completion handling with a flag.
>>>>>>>>>> That leaves !DEFER_TASKRUN, which is not that interesting / hot for
>>>>>>>>>> multishot requests, so have conditional locking with deferred flush
>>>>>>>>>> for them.
>>>>>>>>>
>>>>>>>>> This breaks the read-mshot test case, looking into what is going on
>>>>>>>>> there.
>>>>>>>>
>>>>>>>> I forgot to mention, yes it does, the test makes odd assumptions about
>>>>>>>> overflows, IIRC it expects that the kernel allows one and only one aux
>>>>>>>> CQE to be overflown. Let me double check
>>>>>>>
>>>>>>> Yeah this is very possible, the overflow checking could be broken in
>>>>>>> there. I'll poke at it and report back.
>>>>>>
>>>>>> It does, this should fix it:
>>>>>>
>>>>>>
>>>>>> diff --git a/test/read-mshot.c b/test/read-mshot.c
>>>>>> index 8fcb79857bf0..501ca69a98dc 100644
>>>>>> --- a/test/read-mshot.c
>>>>>> +++ b/test/read-mshot.c
>>>>>> @@ -236,7 +236,7 @@ static int test(int first_good, int async, int overflow)
>>>>>>             }
>>>>>>             if (!(cqe->flags & IORING_CQE_F_MORE)) {
>>>>>>                 /* we expect this on overflow */
>>>>>> -            if (overflow && (i - 1 == NR_OVERFLOW))
>>>>>> +            if (overflow && i >= NR_OVERFLOW)
>>>>>
>>>>> Which is not ideal either, e.g. I wouldn't mind if the kernel stops
>>>>> one entry before CQ is full, so that the request can complete w/o
>>>>> overflowing. Not supposing the change because it's a marginal
>>>>> case, but we shouldn't limit ourselves.
>>>>
>>>> But if the event keeps triggering we have to keep posting CQEs,
>>>> otherwise we could get stuck.
>>>
>>> Or we can complete the request, then the user consumes CQEs
>>> and restarts as usual
>>
>> So you'd want to track if we'd overflow, wait for overflow to clear, and
>> then restart that request?
> 
> No, the 2 line change in io_post_cqe() from the last email's
> snippet is the only thing you'd need.

Ah now I follow, so you're still terminating it, just one before
overflow rather than letting it overflow. Yes I agree that makes more
sense! It could still terminate early though, if the application reaps
CQEs before another one is posted. So I think the opportunistic early
termination is probably best ignored.

Or the app could always be using the full size of the CQ ring, and never
above. With the change, it'd still terminate every CQ-ring-size
requests, even though it need not.

IOW, I think we just leave it as-is, no? Neither of these should cause
an app issue, as CQE_F_MORE is the one driving terminations. But you
could have more unneeded terminations, even if that may be far fetched.
Though you never know, an opportunistically terminating with a known
racy check seems like something we should not do.

> I probably don't understand why and what tracking you mean, but
> fwiw we currently do track and account for overflows.

Misunderstanding, I thought you'd still post with CQE_F_MORE and need to
restart it. But that wasn't the case.

>> I think that sounds a bit involved, no?
>> Particularly for a case like overflow, which generally should not occur.
>> If it does, just terminate it, and have the user re-issue it. That seems
>> like the simpler and better solution to me.
>>
>>>> As far as I'm concerned, the behavior with
>>>> the patch looks correct. The last CQE is overflown, and that terminates
>>>> it, and it doesn't have MORE set. The one before that has MORE set, but
>>>> it has to, unless you aborted it early. But that seems impossible,
>>>> because what if that was indeed the last current CQE, and we reap CQEs
>>>> before the next one is posted.
>>>>
>>>> So unless I'm missing something, I don't think we can be doing any
>>>> better.
>>>
>>> You can opportunistically try to avoid overflows, unreliably
>>>
>>> bool io_post_cqe() {
>>>      // Not enough space in the CQ left, so if there is a next
>>>      // completion pending we'd have to overflow. Avoid that by
>>>      // terminating it now.
>>>      //
>>>      // If there are no more CQEs after this one, we might
>>>      // terminate a bit earlier, but that better because
>>>      // overflows are so expensive and unhandy and so on.
>>>      if (cq_space_left() <= 1)
>>>          return false;
>>>      fill_cqe();
>>>      return true;
>>> }
>>>
>>> some_multishot_function(req) {
>>>      if (!io_post_cqe(res))
>>>          complete_req(req, res);
>>> }
>>>
>>> Again, not suggesting the change for all the obvious reasons, but
>>> I think semantically we should be able to do it.
>>
>> Yeah not convinced this is worth looking at. If it was the case that the
>> hot path would often see overflows and it'd help to avoid it, then
>> probably it'd make sense. But I don't think that's the case.
> 
> We're talking about different things. Seems you're discussing a
> particular implementation, its constraints and performance. I care
> purely about the semantics, the implicit uapi. And I define it as
> "multishot requests may decide to terminate at any point, the user
> should expect it and reissue when appropriate", not restricting it
> to "can only (normally) terminate when CQ is full".

Yep fully agree, I think it was largely a talking past each other on
exactly what it'd do.

> We're changing tests from time to time, but the there is that
> "behaviour defines semantics", especially when it wasn't clear
> in advance and breaks someone's app, and people might be using
> assumptions in tests as the universal truth.

Agree, any time a test needs changing, it should be cause for extra
thinking in terms of whether this will have application impacts as well.
In general, the tests are overly anal, and sometimes they do end up
testing implementation details. The API is pretty clear in this regard,
if you see CQE_F_MORE, then you get more completions. If you don't, the
request has terminated. The change doesn't really impact that.

-- 
Jens Axboe

