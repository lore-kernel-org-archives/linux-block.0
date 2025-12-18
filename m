Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B20349B1B
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070693; cv=none; b=YuS339bDD39FDUBEs2SdHetM7Gaiwmb+BusZtkKXKX4pzfWs/p0RqhVZ6AptFx28C8UMO9YUCS3PoSdxgwg6KOgzOZmIoaTh2VNVx3cPIGD3qu/m1cV7lbHdMs7QgHOm2PMl0spWEBh4bBUfhSk7N+b3NtcpPWady2EOXbIKKjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070693; c=relaxed/simple;
	bh=3Yysd5Lg7kG8Pnqa4Pe8WtSveucFTt/YAElgBDprsac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvLDlaDk5UFDxFp/R71TlHvZAOHjC7ILQ0n+pHgH+BgjwVlFeE/U2ZpRB4jIK8oryxvQZWjPJYEPNDqoDB9jazQeH8F8VDE/6sw1H5segEtesU7YAjGClaZHvjMP6mDO4wMonCmQS/0ink3yx3kkcu2C8UdLQVnCUZw6XoMXM88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Y4S4sX1B; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Y4S4sX1B"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c6cc44ff62so524126a34.3
        for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 07:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766070688; x=1766675488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6AokUHy2AwRWmloqykThInPrApKk4rI7DSKALb1PoE=;
        b=Y4S4sX1Bmih+Nr+O7ghElZYkPXegtVjErDjWLet+0q6kJZN/NSVDcot4MQav8lZHfx
         Xn3oX2u+cfv/tkdwhm7D/mla0qLcWxcXUwLRwpf0oQEoB8Xqyr2I7M2r5UTXEq7zLKEU
         mF9jTu8YyVeWeoNKRil59lukMhFVmvxOPphxEc723wp0aVMaMEin52XCjyzWBbZ26evD
         LGZ9GsY9KAqNR4b4EzKMwBTxEsm8jMShAyFXnb/92UFhdQRmVNvJ5fq+EYzVORMaC7TV
         VXWhIKHKNfzWI2007MzntifwcxERMKqMBt6RHMkEtx1FdeSfcBhbj5/AzfyxIII8v+q+
         b0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766070688; x=1766675488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6AokUHy2AwRWmloqykThInPrApKk4rI7DSKALb1PoE=;
        b=XrNLNOdfJvxaq1BxBoSvVwekYg4f14UMVFM0GP3y2wcD+jZCM6VCJKCoqbrkcBQVG3
         rZNlGKKpo4XY1tqm/RseQwhTH+rN6hibwJ7FLeCe0lD6uIrlwDJh0vjsdZ4uKvnZJU89
         zQDwJit/qV2nSmyQgUf76Xm45JH86nB+WNKZ7TjdH6B33RX70MdU9uocRXRaN24CM5rs
         ujseKYZIWPpFeVk1rq4F2cyPjcq6xFS2Ppj6o+q9Vgp7yCxv859mVDOPkxKcu6wzGFd4
         45goZl4leLQ7icqkmOTQ8NFsbSY4hE+IXwt/nMz1/b9MtUzkCZ6t5l6KiJwyIo54gBy2
         cvbA==
X-Forwarded-Encrypted: i=1; AJvYcCWOyHiZYr4TYerKG32l8Ap6uRKCfUSipX6E24pE8zkSTaYR/2eWD0gYKU0SInucbFTJKr4mgpgdU8HibQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQi4DoIMtVFvx6V0Co0ICbxHeMvnlssZeOAAGSHtW8NPEz9jjC
	ikO4IKtn/LMMb4frbJ5Lrvf7E7zY9uV+Pu3IVMApMBkf+CqidzsY2FtPxyNuJZWVzow=
X-Gm-Gg: AY/fxX5sKjmVXpicyqBILvXSlD91Fimxo0k/+UUXrsm13KUqY4Y4x6lPz67+H8V1qOT
	dbPJtJ3bAhFi6R9SbjdEr2CsRFoDhKYp9H7w9EGC177aSucTXBSna1nfieHAwSaNJ5Z5pzxBDey
	wjcZLCFNvl3EinXoO5nRrwv6GjjaJfUIIrT6oYenPXNPVWvD24pLPzk8JDu/SyaNhdSsgv9bmB7
	+DSeUmv5lYJjfYoeN5rVGT30qYx9yX7faK866Ozf6At6nVUa2POGw3ORti32dFeD3DiHWROWRaH
	V4pFOKHfV+on8xY7JPOt2o+4Yzzl3siefuS1UAFGGVZ1aXvQg/VUs4GprF5C3e2B5ENo8aDNsRS
	kw+10BUpbcnrM15C2vDcl+QZNBpL7NI1ApzYyXw8Ub7rClrRdyaLxrHkBLAb+mhIqWM0BqLLEqk
	V+0e4Pqh0=
X-Google-Smtp-Source: AGHT+IFZNGgV7p1T/Z7ppTTaHKyKE3Xbm6EL6wWADguMBVQ3Kx5Y9ySQLTDPmaf7deaoSn9yudPMeA==
X-Received: by 2002:a05:6808:2016:b0:438:2d68:bf32 with SMTP id 5614622812f47-455ac84a768mr9484842b6e.25.1766070688032;
        Thu, 18 Dec 2025 07:11:28 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457a42f8186sm1327635b6e.5.2025.12.18.07.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 07:11:27 -0800 (PST)
Message-ID: <54f07e42-0484-4d69-be8c-aee7182d97a6@kernel.dk>
Date: Thu, 18 Dec 2025 08:11:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] block: fix race between wbt_enable_default and IO
 submission
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai@fnnas.com>,
 Guangwu Zhang <guazhang@redhat.com>
References: <20251212143500.485521-1-ming.lei@redhat.com>
 <CAFj5m9KVcKzEqpXt0J_28L+bHojeAv4+cu8hTyfdfA_c-q4nWw@mail.gmail.com>
 <7f5a7801-0403-44e1-8629-3196092f32a9@kernel.dk>
 <CADUfDZq8F2YL-vWcbop4KDrZ1fz5nBP6dbXVB6765kpFgxuy1g@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZq8F2YL-vWcbop4KDrZ1fz5nBP6dbXVB6765kpFgxuy1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/17/25 9:41 PM, Caleb Sander Mateos wrote:
> On Wed, Dec 17, 2025 at 7:20 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 12/17/25 8:18 PM, Ming Lei wrote:
>>> On Fri, Dec 12, 2025 at 10:35?PM Ming Lei <ming.lei@redhat.com> wrote:
>>>>
>>>> When wbt_enable_default() is moved out of queue freezing in elevator_change(),
>>>> it can cause the wbt inflight counter to become negative (-1), leading to hung
>>>> tasks in the writeback path. Tasks get stuck in wbt_wait() because the counter
>>>> is in an inconsistent state.
>>>>
>>>> The issue occurs because wbt_enable_default() could race with IO submission,
>>>> allowing the counter to be decremented before proper initialization. This manifests
>>>> as:
>>>>
>>>>   rq_wait[0]:
>>>>     inflight:             -1
>>>>     has_waiters:        True
>>>>
>>>> rwb_enabled() checks the state, which can be updated exactly between wbt_wait()
>>>> (rq_qos_throttle()) and wbt_track()(rq_qos_track()), then the inflight counter
>>>> will become negative.
>>>>
>>>> And results in hung task warnings like:
>>>>   task:kworker/u24:39 state:D stack:0 pid:14767
>>>>   Call Trace:
>>>>     rq_qos_wait+0xb4/0x150
>>>>     wbt_wait+0xa9/0x100
>>>>     __rq_qos_throttle+0x24/0x40
>>>>     blk_mq_submit_bio+0x672/0x7b0
>>>>     ...
>>>>
>>>> Fix this by:
>>>>
>>>> 1. Splitting wbt_enable_default() into:
>>>>    - __wbt_enable_default(): Returns true if wbt_init() should be called
>>>>    - wbt_enable_default(): Wrapper for existing callers (no init)
>>>>    - wbt_init_enable_default(): New function that checks and inits WBT
>>>>
>>>> 2. Using wbt_init_enable_default() in blk_register_queue() to ensure
>>>>    proper initialization during queue registration
>>>>
>>>> 3. Move wbt_init() out of wbt_enable_default() which is only for enabling
>>>>    disabled wbt from bfq and iocost, and wbt_init() isn't needed. Then the
>>>>    original lock warning can be avoided.
>>>>
>>>> 4. Removing the ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT flag and its handling
>>>>    code since it's no longer needed
>>>>
>>>> This ensures WBT is properly initialized before any IO can be submitted,
>>>> preventing the counter from going negative.
>>>>
>>>> Cc: Nilay Shroff <nilay@linux.ibm.com>
>>>> Cc: Yu Kuai <yukuai@fnnas.com>
>>>> Cc: Guangwu Zhang <guazhang@redhat.com>
>>>> Fixes: 78c271344b6f ("block: move wbt_enable_default() out of queue freezing from sched ->exit()")
>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>> ---
>>>> V2:
>>>>         - explain the race in commit log(Nilay, YuKuai)
>>>
>>> Hi Jens,
>>>
>>> Can you consider this fix for v6.19 if you are fine? Yu Kuai has one
>>> patchset which depends
>>> on this fix.
>>
>> It was queued up on the 12/12, now I'm pondering if the "thanks applied"
>> email never got sent out? In any case, it is in block-6.19.
> 
> I also don't see an email about this series being applied, though it
> appears to be queued in block-6.19:
> https://lore.kernel.org/linux-block/20251212171707.1876250-1-csander@purestorage.com/

Funky! Applied on the same day, so quite possible I messed it up
by flushing the b4 queue or something.

-- 
Jens Axboe

