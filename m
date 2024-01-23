Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530297F7CC
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037489; cv=none; b=OZLX05yYjQPZ1HMK+kjyXcUOBFOR/VfdmU/sd1lc9sVWRPS/3U1V+T3mI3Z8yLiU3xoyv6j6EUqxyl8ouR5cmNCQmPQvb7lqae0oFyPQlFgsmBQE7Rx1McXytBhevvbvwabul280fOSCNaNzXqrZkQTIaFAzkvP+4qEJ+IJ+FqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037489; c=relaxed/simple;
	bh=iiRrK8anJwPJ+QrheDvFg+C+DfMIw8xs7qiifN/qEGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pb3TxC8vgPpJehOaHwcCe2szEd7MnR2mpIs1SuNSLk5uu0YLVsXjZVT9R4FZEA1iXZDyZxnMrg2D/tJpvJzm3rooHPwiWp5/qg/ZD06A0RR7MYftAKG0lzll7g51yuthFLrDBD8w68ZNNtCPQDT3lsJ70c3nZ0rCMo/JnU4gMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=goGrqR7w; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="goGrqR7w"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so63089539f.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 11:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706037486; x=1706642286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBjUWCkpPaww4aeACfE8GkQNEDnG/EV/35Dc0mnWln4=;
        b=goGrqR7wDIghqWLA8YTKEpHpezGCYX0+Wx4zS4C0mkC4Ty11Vhl83A9YKC5aLhNf9H
         DDtZhF3h9qX6EeXRLxRwWsd58IaRA0Jid/xlqdsh2r1YQXh2DygVRYHryMn6HxgFk+dF
         eP7RPlw7f3+rVUSRDlQoNwSssT69FRsSDjUuuJQV4Hs2B0qLZJkgnHcSbL6wP7+M9FLv
         ExYczmOieG+tp+cFJXWOXTmrw41WtD1oOEk4WQn8PjI2rTu27kv+MjTWoIbeEgZi9Wc8
         8Zl2hgP7Tqg+2d+y47fWcLq2hnK9y07CrVe4rlz7CPG0QIDUYUw+4ns195J8pufIHLK6
         pdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706037486; x=1706642286;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBjUWCkpPaww4aeACfE8GkQNEDnG/EV/35Dc0mnWln4=;
        b=gdFwIPMQUSJjQquHsjAW7nmE2X7fLztJnv5PJkXRP8P8hNdGxQLUhtmopCsMoWW4Tl
         lnuo+YH+UB7vnRgT/1qcPYrfaqeK6flsUQyVD8JvFXiFpnSeTKUYUm4zraVxduKUpUGs
         b7RxdmtedS090dWULZR42zh/Nm14rTPYLOr99O5zqbUzH4OrASEk4VsBBLA68XFpOAXd
         N4uLdSsx2DLs4qSysv2Wlc9QZpJi2QvLZSbkSlfnUUk7sRmY8k/xbVVJobOmziaGcDvz
         Og9qcV82jUodRn91yHiPbdTqOxEywCt+SosOoXQHWBVXW5Jefm40WKdP8tnWWgterHlE
         WYEA==
X-Gm-Message-State: AOJu0Yy1Diwe2WvvHsvRX5tgFjxIIruv/msd4XRq9mbFfdnjgcK4vkRw
	0RqBXW1XGSALWuLIs7Zpl7RrBXvRevlnDsX5AewOt7IK652thT6+YqXXedkNZImUD7VOrcCpgLn
	K5iI=
X-Google-Smtp-Source: AGHT+IHtr6V4ywmpVUFODw3V+X8W/+CBDjolk9kw91hm6DZNWY9hq4mjio8iAPslAQat2mygSnoa2A==
X-Received: by 2002:a05:6e02:2199:b0:35f:b16d:cd64 with SMTP id j25-20020a056e02219900b0035fb16dcd64mr235306ila.0.1706037486449;
        Tue, 23 Jan 2024 11:18:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a5-20020a92c545000000b00361b2dee4c2sm2676766ilj.78.2024.01.23.11.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 11:18:05 -0800 (PST)
Message-ID: <a4436085-f31e-4b46-966d-d43a122e0898@kernel.dk>
Date: Tue, 23 Jan 2024 12:18:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] block/bfq: use separate insertion lists
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-9-axboe@kernel.dk>
 <5db987f3-9f73-4ab8-856e-a4edd74d10b4@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5db987f3-9f73-4ab8-856e-a4edd74d10b4@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 11:47 AM, Bart Van Assche wrote:
> On 1/23/24 09:34, Jens Axboe wrote:
>> Based on the similar patch for mq-deadline, this uses separate
>> insertion lists so we can defer touching dd->lock until dispatch
>                                            ^^^^^^^^
>                                           bfqd->lock?

Thanks

>> with ~30% lock contention and 14.5% sys time, by applying the lessons
>> learnt with scaling mq-deadline. Patch needs to be split, but it:
> 
> Is the last sentence above perhaps incomplete?

It should just be removed, it's outdated as it doesn't need splitting
anymore, I already did that work.

>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
>> index 56ff69f22163..f44f5d4ec2f4 100644
>> --- a/block/bfq-iosched.h
>> +++ b/block/bfq-iosched.h
>> @@ -516,10 +516,14 @@ enum {
>>   struct bfq_data {
>>       struct {
>>           spinlock_t lock;
>> +        spinlock_t insert_lock;
>>       } ____cacheline_aligned_in_smp;
> 
> Can lock contention be reduced further by applying
> ____cacheline_aligned_in_smp to each spinlock instead of the
> surrounding struct?

Same as deadline, it doesn't really matter in my testing.

-- 
Jens Axboe

