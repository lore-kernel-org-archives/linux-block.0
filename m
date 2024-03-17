Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474A20DD3
	for <linux-block@vger.kernel.org>; Sun, 17 Mar 2024 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710714253; cv=none; b=rdqBWE8UH1HpNSPfEoUt1OrH0MCwfWFngrhFjqHvsCdpwI/y4bot2bIEQgVKewdBzP4MnqsWashsNS8E4gRkOLXmlpd4mzSbtDKTRGNKZ0igjV2HlQbTxKbAmTPVGs2P8+rpCmeEHfpk4XXc9LXyi0KT5Bwf7PKP1XKGOLVbugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710714253; c=relaxed/simple;
	bh=6ZocdE/PKJfgn0GYyaxJcVvvPnBIKbi5H8WIPFXQBFU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q7JvTWISK7Sri8U8gVAgEN8w2q2McPfHaE/W4dGWyLMMPtorN0Xt8WwuLM+hL49E42mQN/b2hlzlQ1rIFHzI2ho6V5AHjbQd2gQ/WHYq15ocqLvor2oVcWYWKI29clkLtz/vhYjgZh2tC//eTWCr9U6MNeW7bUjx0wKMOcPEpSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MItCRXK/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MItCRXK/"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29f66c9ffa5so483464a91.0
        for <linux-block@vger.kernel.org>; Sun, 17 Mar 2024 15:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710714249; x=1711319049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ckqXWJgYfwYIHcNzOu2EVF/5RsxmXgV0EsFucBhZuM=;
        b=MItCRXK/tJOe4WqCJD7Tn6naX00hyegssNHGHk+hv8kUcJXksUYAp9Fsq+UT1nL7mf
         udGyV25GGXBV9WFfgLE45/OQeKmf47I0lBlkFUBPxuEMCoCZtgp7MtA1y1jooSUztsAU
         aY1QXjtK3YP1PbsWeEwkCkeddo9l9gHoqUQEJC39wTF/8D+HaSUK0KVnRNp34VP+wnqL
         qkTuJtqMTv1+HmWx06VxewuwNkyjfpXM/rkqMlDxFMGu8/V4wzAZu/uaaN28tOprmSHZ
         AAeXuH+zl/934Oa/WNHwYRI5HwCPG8VrSbBdslfIqv9Db8JuyYRasmpo5OA2lel8yFir
         /S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710714249; x=1711319049;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ckqXWJgYfwYIHcNzOu2EVF/5RsxmXgV0EsFucBhZuM=;
        b=B3e1FX+QWCbeqWslCKpNOzs6+/wVo7nBCYi38Q1CKXbhYbpiP8bc5v92nYG8V0kM9U
         CWcb4ocy77q2z86JFmhsb3wZAfjCi1Cgvl3JZ9dtznvPFaIFb7cTjctcgOyd/gY4k2Vd
         JuwI2LQ4JrCGfQbHv6LqQEDfdjViuodynjkLX41tSBm10XdMF64KiKHbf3T/ZokId9R+
         NpUqWALP+xJEixjfdCAvPH7fapO13T8Ddw9OIRYW6jnFdFYl9JZGIEhA5CEiElkv3mqT
         TVrxsrQEUZbvQ8dIa3DsHu8I3ggn2hHJCmg2LuzGyiMU41/dtWpaM/T524+3xTMyBxSW
         teMA==
X-Forwarded-Encrypted: i=1; AJvYcCW8xNA1SRk7FI5aduaBdH0lIHup4wUCd1CWt+VltYnrNCRxFUqycb9XVr9AL9xSVYf+R9HIQZm73+zp3bvVJsoTzM5wcDPW1RBpM2Q=
X-Gm-Message-State: AOJu0Yw7vtgtVSixq7g55pbsuQCNM8UW7Lm/hktyNaCR/WFb+hHeZu/6
	bejw3008f5eTw0feqcz44RNIWsK7K/zn/OAajm2pzOJ7LJAKe0JL5igIgHRMghs=
X-Google-Smtp-Source: AGHT+IG8dVwwHYlr0vrG2oPpuZDj+rnEaGMvt5ezlDRyxguExmchjFVZ00fZJKFznnHnd38MuvYPNQ==
X-Received: by 2002:a17:902:fc8b:b0:1de:faa3:54d9 with SMTP id mf11-20020a170902fc8b00b001defaa354d9mr8352789plb.5.1710714248992;
        Sun, 17 Mar 2024 15:24:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id iw9-20020a170903044900b001defa712890sm4487110plb.72.2024.03.17.15.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 15:24:08 -0700 (PDT)
Message-ID: <4320d059-0308-42c3-b01f-18107885ffbd@kernel.dk>
Date: Sun, 17 Mar 2024 16:24:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 00/11] remove aux CQE caches
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 Kanchan Joshi <joshi.k@samsung.com>
References: <cover.1710514702.git.asml.silence@gmail.com>
 <171054320158.386037.13510354610893597382.b4-ty@kernel.dk>
 <ZfWIFOkN/X9uyJJe@fedora> <29b950aa-d3c3-4237-a146-c6abd7b68b8f@gmail.com>
 <ZfWk9Pp0zJ1i1JAE@fedora> <1132db8f-829f-4ea8-bdee-8f592b5e3c19@gmail.com>
 <e25412ba-916c-4de7-8ed2-18268f656731@kernel.dk>
 <d3beeb72-c4cf-4fad-80bc-10ca1f035fff@gmail.com>
 <4787bb12-bb89-490a-9d30-40b4f54a19ad@kernel.dk>
 <6dea0285-254d-4985-982b-39f3897bf064@gmail.com>
 <2091c056-d5ed-44e3-a163-b95680cece27@gmail.com>
 <d016a590-d7a9-405f-a2e4-d7c4ffa80fce@kernel.dk>
 <4c47f80f-df74-4b27-b1e7-ce30d5c959f9@kernel.dk>
In-Reply-To: <4c47f80f-df74-4b27-b1e7-ce30d5c959f9@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/24 4:07 PM, Jens Axboe wrote:
> On 3/17/24 3:51 PM, Jens Axboe wrote:
>> On 3/17/24 3:47 PM, Pavel Begunkov wrote:
>>> On 3/17/24 21:34, Pavel Begunkov wrote:
>>>> On 3/17/24 21:32, Jens Axboe wrote:
>>>>> On 3/17/24 3:29 PM, Pavel Begunkov wrote:
>>>>>> On 3/17/24 21:24, Jens Axboe wrote:
>>>>>>> On 3/17/24 2:55 PM, Pavel Begunkov wrote:
>>>>>>>> On 3/16/24 13:56, Ming Lei wrote:
>>>>>>>>> On Sat, Mar 16, 2024 at 01:27:17PM +0000, Pavel Begunkov wrote:
>>>>>>>>>> On 3/16/24 11:52, Ming Lei wrote:
>>>>>>>>>>> On Fri, Mar 15, 2024 at 04:53:21PM -0600, Jens Axboe wrote:
>>>>>>>>>
>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>>>> The following two error can be triggered with this patchset
>>>>>>>>>>> when running some ublk stress test(io vs. deletion). And not see
>>>>>>>>>>> such failures after reverting the 11 patches.
>>>>>>>>>>
>>>>>>>>>> I suppose it's with the fix from yesterday. How can I
>>>>>>>>>> reproduce it, blktests?
>>>>>>>>>
>>>>>>>>> Yeah, it needs yesterday's fix.
>>>>>>>>>
>>>>>>>>> You may need to run this test multiple times for triggering the problem:
>>>>>>>>
>>>>>>>> Thanks for all the testing. I've tried it, all ublk/generic tests hang
>>>>>>>> in userspace waiting for CQEs but no complaints from the kernel.
>>>>>>>> However, it seems the branch is buggy even without my patches, I
>>>>>>>> consistently (5-15 minutes of running in a slow VM) hit page underflow
>>>>>>>> by running liburing tests. Not sure what is that yet, but might also
>>>>>>>> be the reason.
>>>>>>>
>>>>>>> Hmm odd, there's nothing in there but your series and then the
>>>>>>> io_uring-6.9 bits pulled in. Maybe it hit an unfortunate point in the
>>>>>>> merge window -git cycle? Does it happen with io_uring-6.9 as well? I
>>>>>>> haven't seen anything odd.
>>>>>>
>>>>>> Need to test io_uring-6.9. I actually checked the branch twice, both
>>>>>> with the issue, and by full recompilation and config prompts I assumed
>>>>>> you pulled something in between (maybe not).
>>>>>>
>>>>>> And yeah, I can't confirm it's specifically an io_uring bug, the
>>>>>> stack trace is usually some unmap or task exit, sometimes it only
>>>>>> shows when you try to shutdown the VM after tests.
>>>>>
>>>>> Funky. I just ran a bunch of loops of liburing tests and Ming's ublksrv
>>>>> test case as well on io_uring-6.9 and it all worked fine. Trying
>>>>> liburing tests on for-6.10/io_uring as well now, but didn't see anything
>>>>> the other times I ran it. In any case, once you repost I'll rebase and
>>>>> then let's see if it hits again.
>>>>>
>>>>> Did you run with KASAN enabled
>>>>
>>>> Yes, it's a debug kernel, full on KASANs, lockdeps and so
>>>
>>> And another note, I triggered it once (IIRC on shutdown) with ublk
>>> tests only w/o liburing/tests, likely limits it to either the core
>>> io_uring infra or non-io_uring bugs.
>>
>> Been running on for-6.10/io_uring, and the only odd thing I see is that
>> the test output tends to stall here:
>>
>> Running test read-before-exit.t
>>
>> which then either leads to a connection disconnect from my ssh into that
>> vm, or just a long delay and then it picks up again. This did not happen
>> with io_uring-6.9.
>>
>> Maybe related? At least it's something new. Just checked again, and yeah
>> it seems to totally lock up the vm while that is running. Will try a
>> quick bisect of that series.
> 
> Seems to be triggered by the top of branch patch in there, my poll and
> timeout special casing. While the above test case runs with that commit,
> it'll freeze the host.

Had a feeling this was the busy looping off cancelations, and flushing
the fallback task_work seems to fix it. I'll check more tomorrow.


diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index a2cb8da3cc33..f1d3c5e065e9 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3242,6 +3242,8 @@ static __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
 	ret |= io_kill_timeouts(ctx, task, cancel_all);
 	if (task)
 		ret |= io_run_task_work() > 0;
+	else if (ret)
+		flush_delayed_work(&ctx->fallback_work);
 	return ret;
 }
 

-- 
Jens Axboe

