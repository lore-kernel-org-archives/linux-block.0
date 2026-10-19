Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444962;
	b=zvekBjrdXXLHf9pNU3R6HAzLFbjE0cw4f5K2zzrHHVpwoeKmxgZ0FuTvwTOIOY5TQh8Z
	 biNDN1JAer/d7/cPQ/BT17LXuKTfbxzZO6fdce6CGhe5JROnspER4sTdsyaZzDeMPDlNE
	 wI9LxhfUTJIJqH0uucduSIeNmIHnGkU317+G6O1aiwEs6He4YpUQLKe125deNaKqdxZV0
	 WLKtUaq16OCR5uiAnOFdGhG4HXUA4FjEX9Ejsb4Y6HX8iKEx/AJYFhnOQp/GX631y3rt4
	 zwfSSR1dTv+oE1w3i0dgVfbbiRZnV9Kq4uYlAxeYnZgk6PTToI8h+tLjOugR61RJahQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CEb54PbMcZ4QC2hOQFDpn9YXBC5p2LNF1QebXmTTnaw=;
	b=C8+KcCpYj9XTai4kIzsLLFx03tYNESWxU3DI3BN7qOqR1xKxXylY5hJBLVs+dmNkRkWX
	 89JbU2X0locdzJj4XM56S5GJvBshJb+sivJcg19LqoXZhHQVGI/UPRKA/oU+KoWQ/J9zi
	 xeYp7HPBPMqkD8l1Idvh8rSUpq6hKZCuI3gE3F+cT6zBdBmzZfkKVkGxrHeiGjk5lnpzf
	 v8C0IKpYXH04JS9pXROKphCW+VQvqXMwmjLEU4UD3W4hVTJwsryUeU3I+PyvGw+qEcOQv
	 Mj33LIAe8apz9IHpwYnTVswLqh2K+ECLVWuhFHjmIjLxGdfZ6Hfq1fk6V6I68bMF8BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=crQKpPzk;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F14F606A31B
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 21:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F14F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=crQKpPzk
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-8470d7d430fso882584a34.3
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 14:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792444960; x=1793049760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEb54PbMcZ4QC2hOQFDpn9YXBC5p2LNF1QebXmTTnaw=;
        b=crQKpPzk4HbGrVKiuAlEdOyeK7Z+qQz5C8fVvQQ/dJQ+687M5eYHFURY+QuLZMNrE9
         74mVHPdEucO20wUp6sZifiVrFukZyp0kcbqxmTDABgkCJ7Yph56xWNUwA/JgfmqUSlN+
         msWIhZ+DLsA9DtwsT4J2vo7Y3ZPKdRxgO/uoWOZ36ylEZQSpUCS/lPHtWbJ+Ub/v3y86
         ebf/Zeie1KdqNQsVLyPPHiN07FP/PGZujHEJkEHXWhwjRDrVMcPIgMFSbU4lyAY/5Gpk
         X6aP1Gu4m6bqpRcDqF1/QNTodn208biEzKdDvX9uNudWH0DbNW19O1aamsBIaYu9NUa/
         wGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792444960; x=1793049760;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEb54PbMcZ4QC2hOQFDpn9YXBC5p2LNF1QebXmTTnaw=;
        b=pX2k+jhZg86KBHdNpjOPIDT/KFgP08xP9tgZ2CyPawOAxAFJJ6fShvsY/8ONmp19ov
         AMh4xCy6ROT5XVQyzQVS8XpUUp7TwPBgkMq1F4g/5BGBy76QAYPjcEJD8kT2vP5PnVEu
         ASMxmEuQe3djch0/Z2d6A6lMX8xSWImlxEpEAv5H5f0dY8gJNhwrPJxETnZeV//F40EO
         yqcTF751RcQ6dARLEiu/CXJN+xn6PW3ohqPvMDBs5eIXYXKcwG7Vvlv9BR5AHLJiEQfG
         4lvSIN8FBjevGAXoxeKJORLkVAfqsYk5WTrmzLob6wm83B2Aihmc9G8Sbcjs6lv37ikD
         89zg==
X-Forwarded-Encrypted: i=1; AKwUvBx00jnJSgfRq0vuyvFtZb3K/hEi6qktVWVkDX2OR7Vx47I271s9ibMbwPS4WxTY5FYYUB0VZqUXiV09Ew==@vger.kernel.org
X-Gm-Message-State: AFq9FYKGBzrv6ml3Ts8sJ5hLlgt3ZeHHbd5lUshfmItDELZAGXu9L4+G
	hQcq4cuDbK/Kos1wZJgKGW5AUuYvlic2dlKBuAwJJ11HyoJCKJT5/jopLSI65G2Pa+s=
X-Gm-Gg: AYBFou2xeCloAC1i15JOL6U7eb5rBCNgRxxfySg4aXX1hD61eT8Ev2rpW9VJrjRNzmG
	MOPJi5T5WnoDdl2RHHo6jAaJBnqBcM1Ojcs8KY7G0mMqRDKwYgM5WZwa9V6f7Jozsq7K/0NxyE0
	u3oV9Ak2mKjbR+y03qXFHijfT9tYGbOUESPRunCW8kPjLU9D1rBpJmx4VzR1k/kFWB8QRvsa1K0
	zW9qOa4GdwjHzui5QTGQWlw5RW5b3TQHjdjFgiHKC8kR/iW6APhAkBaoSoERNvn/K/XXiSJmHgh
	vrm4Nv6X/wZfeJ0VwUJWHAgCV96CRLaI1t9RzEsXVwskCD+VpJO3vVClhtnK8UdqMUqFCAf2Uoi
	fS1g0MioIko8dPW7+COTaCGfVZVSRzmhXgrcLej8XjVIlYT4SECaEiwFvpCqERNThZ8TL9mA+AX
	EnrXBDbZoGEqX8yE/RoshWC6EgzxCymxyOLqNT48/W/2cbuUWxpYx3PM1PjJqADqw1DjECyEx48
	/xZT9BMp1YgjHu3jITysDV1gttsoKaKlI34F/bbAifRKG6Xt3evKjzn
X-Received: by 2002:a05:6830:67e3:b0:821:a094:b26d with SMTP id 46e09a7af769-844ff9f4095mr9582081a34.13.1792444960202;
        Mon, 19 Oct 2026 14:22:40 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8438ce16e37sm10588561a34.13.2026.10.19.14.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 14:22:39 -0700 (PDT)
Message-ID: <956e10db-bcc1-4e6d-a0ce-b5f5fe25354e@kernel.dk>
Date: Mon, 19 Oct 2026 15:22:38 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about asynchronous blk-mq tag waiting for io_uring
To: Maks <mi9992828@gmail.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org
References: <20261008214137.1267424-1-mi9992828@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261008214137.1267424-1-mi9992828@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/26 3:41 PM, Maks wrote:
> From: Maks Ivanov <mi9992828@gmail.com>
> 
> Hi,
> 
> I read your comment in liburing issue #1492 about callback-based retry
> when storage tags are exhausted:
> 
> https://github.com/axboe/liburing/issues/1492#issuecomment-4696489936
> 
> I'm considering this direction for my bachelor's thesis and would like
> to clarify its scope and design.
> 
> The initial scope would be io_uring direct reads on raw block devices.
> For requests without explicit RWF_NOWAIT, the mechanism would register
> a continuation when tag allocation cannot complete immediately, then
> retry submission when a tag becomes available.
> Explicit RWF_NOWAIT requests would retain their existing
> behaviour when tag allocation would require waiting.
> 
> Could you clarify a few points?
> 
> - Is this still an open direction worth investigating?

I think so, yes, as it'd avoid needing to punt to io-wq. Which
is ALWAYS a good thing.

> - Is there related work or an existing approach I should look at first?

Not on the block/storage front. Basically the tag waiting is just
a normal sleep operation for the current task. The alternative
would be to add a private wait_queue_entry to the list instead,
and then retry when you get the callback.

> - Which layer should own the continuation: io_uring, the block submission
>   path, or blk-mq?

Just spit balling here, but it'd be an -EIOCBQUEUED operation on
the io_uring side, even though the operation hasn't really started
yet on the device side. On the block side you'd need to handle this
at tag starvation time. Right now that'd put the current task to
sleep, and then wake it when it can get a tag. With the callback
approach, you'd need to be able to tell in the blk-mq sleep side,
and get access to the wait_queue_entry to use. On the block side,
this would be a 0 return, just like if the IO was queued.

> - What lifetime and cancellation constraints would such a mechanism need
>   to satisfy?

That requires a bit more in-depth analysis to answer. Presumably
the wait_queue_head would have the same life time as the io_uring
request, so if a device is ever torn down with IO queued, then
these entries would need pruning too. I suspect the block side
probably does all of that already, as it'd need to wake tasks
sleeping too.

-- 
Jens Axboe

