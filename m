Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99101B86ED
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888177; cv=none; b=VygSgZRtbeHMBJFR0zxvdpwoC/0C2bU5zPEjAuD+htm0AIwibYC/c4q9p+TvtdnnUFrhWxSbS8CbaSRlMBz6GTKer4gTE311Wos0Bmr3x008lvHRI7k3C5W1oQX/462I06vob3Z0U2zzP7x8YMae8B+foORRumR2N8eqxbUzNxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888177; c=relaxed/simple;
	bh=eIXiGEb9fEMsnBuzt8H145t5ust95PJvZUeKqz+/aac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cj8TO/aNnRoTYVbAaZZjwANGXtrhwWEc2HJHrQSTtjV95p/BhyJATghYHw930t/80aTXsYaekDiXIcbPShfttVr4zr7VNOU16qNHDos/Abm+04EkijpT2h8kZYsOeO37uBXrvOOaVtWi9myMnBcD087DRS7EXI98MWI0FDeI9Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zKnCM/55; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zKnCM/55"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718e1ce7e84so1666163b3a.1
        for <linux-block@vger.kernel.org>; Mon, 09 Sep 2024 06:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725888175; x=1726492975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jhHNhxZrDlswyis9D91GRtCbqyad0tt61fKmr73vaCM=;
        b=zKnCM/55tvWn++sWyEDUZeLQQoJ1fPfT8aALiFOtpLVJz7Yqz85qSR/Qgo7DJ5wesn
         ZEIiKT/P8G53HvB40PIbZt8RneEZJKNBlVuSvfAt9d921bJ9GmRDMGiwS7KcQ4vCEyWp
         iyefZTHHphBJuqhTuH9oySU2JGM45G2kGqak1LrJfEZac79w5tTvM4LuWgMXmgb1NFhY
         v/wWiUPBLsm2sdcYS9fy13eQ0CU2h2bX5g0ne+h2qE1c13ppPuyhjlPwT0/zrDF0rzB5
         LLLKzv4wPcnJdCxOcmICQiP6o4/AWGgd9fkdgyu82MwtpTmx83BkPZNW14s5+gE26MW8
         RLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725888175; x=1726492975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhHNhxZrDlswyis9D91GRtCbqyad0tt61fKmr73vaCM=;
        b=ci42JjzjHWN46Vz0wVv9GDt1ExYELJBoIbEI1xRbJNdi+p3/wJN7ht5Xdgr52ybfXs
         OgJ54cP/uiMzDJf1uUhf8acqSnHut3pJPxw2imFuN+P/38/ZQBWTCJIFTbg/B3qvEbrH
         p+TX+7ZiDxp6nC/nNAcQYDO6/xPDUHtArfErDL6oI8ctFoBbvyMFhR21k1cIxgRjPxpB
         KZzlazEZApCVYDNk6NpIBlELdwFFTp7gUjL3R8tfOIR26yzwm6lFANFYRwuIXW+qOYU6
         5I+yApGCMJvxUqf0FSYmkuX+upP4c4y+J0nxaZDYa4+A8mSHCY3SE9GBzxmcJ6Fdotsz
         /J4Q==
X-Gm-Message-State: AOJu0YzCcNA2g5DkvtKGGFuGtKjvgBhKQkNK1NM2WdtF5gxWrkquLs2a
	FltG5I0anKP3ocwyV9rZbffqlUKGeXzZYOWeiVhJ/18bp6x2hT2MzSOM13VZWiqvA4jbDWDsH94
	Y
X-Google-Smtp-Source: AGHT+IERzk2rdOii9yopgINOJJKMQXfYzgeHMkBkoR5+0ipjq1etOcJ5mLqLQyt+3kMsPmz+wa85Ng==
X-Received: by 2002:a05:6a00:218e:b0:717:9768:a4e7 with SMTP id d2e1a72fcca58-718d5ded0acmr9674184b3a.2.1725888174500;
        Mon, 09 Sep 2024 06:22:54 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58bd261sm3501772b3a.67.2024.09.09.06.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 06:22:53 -0700 (PDT)
Message-ID: <dca2f540-4820-48d4-90d0-3d73c994cd18@kernel.dk>
Date: Mon, 9 Sep 2024 07:22:52 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External Mail]Re: [PATCH v6] block: move non sync requests
 complete flow to softirq
To: =?UTF-8?B?56ug6L6J?= <zhanghui31@xiaomi.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "dlemoal@kernel.org" <dlemoal@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240907024901.405881-1-zhanghui31@xiaomi.com>
 <38a71a3f-b505-48a3-bbaf-2bdf60dfcd9d@kernel.dk>
 <ae5739ae-5d9a-4efc-8e64-6a44fe37ed12@xiaomi.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ae5739ae-5d9a-4efc-8e64-6a44fe37ed12@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/24 8:17 PM, ?? wrote:
> On 2024/9/7 21:46, Jens Axboe wrote:
>> On 9/6/24 8:49 PM, ZhangHui wrote:
>>> From: zhanghui <zhanghui31@xiaomi.com>
>>>
>>> Currently, for a controller that supports multiple queues, like UFS4.0,
>>> the mq_ops->complete is executed in the interrupt top-half. Therefore,
>>> the file system's end io is executed during the request completion process,
>>> such as f2fs_write_end_io on smartphone.
>>>
>>> However, we found that the execution time of the file system end io
>>> is strongly related to the size of the bio and the processing speed
>>> of the CPU. Because the file system's end io will traverse every page
>>> in bio, this is a very time-consuming operation.
>>>
>>> We measured that the 80M bio write operation on the little CPU will
>>> cause the execution time of the top-half to be greater than 100ms,
>>> which will undoubtedly affect interrupt response latency.
>>>
>>> Let's fix this issue by moving non sync requests completion to softirq
>>> context, and keeping sync requests completion in the IRQ top-half context.
>> You keep ignoring the feedback, and hence I too shall be ignoring this
>> patch going forward then.
>>
>> The key issue here is that the completion takes so long, and adding a
>> heuristic that equates not-sync with latency-not-important is pretty
>> bogus and not a good way to attempt to work around it.
>>
>> --
>> Jens Axboe
>>
> hi Jens,
> 
> Sorry for not replying in time.
> 
> We have basically determined the plan for the f2fs side. The short-term
> plan is to limit the size of a single bio, and the long-term plan is to
> change f2fs from page to folio to reduce the pagecache traversal time.
> 
> However, I think it also makes sense to move less urgent work out of the
> IRQ top-half.

What you are missing is that what you think is less urgent, may be just
as urgent as other requests to others. !rq_is_sync() doesn't mean that
it's necessarily a background or low priority request. So no, I'm not
interested in merging an odd work-around for what is really a different
issue.

Fixing f2fs is indeed the right way, and I'd suggest in the mean time
you just limit the per-request size to something a lot more reasonable.
If you see high latencies with 80MB requests, then perhaps don't be
doing 80MB requests. That should be well beyond the diminishing returns
point for bandwidth anyway, there's no reason why anyone should be doing
requests that huge and not expect longer processing times.

-- 
Jens Axboe

