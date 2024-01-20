Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1325439C
	for <linux-block@vger.kernel.org>; Sat, 20 Jan 2024 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705710669; cv=none; b=PfIfsnjq8r6WLvdRQujNy8qyPkG+ASO1QrujpvQNj4wrZxqchnvTYGzOPHBJsF5vOvPO83MQNvYnZ9ocZ4Px4nifWG/Blt1E5hKnuVdrwzu70Kjvme3Q4i/GTnd03id2E7doquFq23HxltMXHN+kX8LlRjpAaKj1AIOmCjjFQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705710669; c=relaxed/simple;
	bh=g0UGGmWeLAg6DyAuAlHm6I6H9Seo1NDjCVDotbPdadA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Hf+1UThUUeJpyjRypjAUZbZYlEP78hhNYtDs58zASM7W2DwrgTutf2MGxoWr4jcNNYFOfvA93y2EgdX7Gc+qVm1sSw+1ytlsBnOyxxB3WLz6utjhXOyoRpifBGdfBU3soaFh7GybhHR3SkGdOf+mldyMLwqmJdla+XhlNFzO5ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0dx9Pdya; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0dx9Pdya"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9b41a3cb7so349420b3a.0
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 16:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705710663; x=1706315463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TGmXAoUQHt8aDfak0ug6bpaZtnyVT7ONfXQ8J1tL1o=;
        b=0dx9PdyalAHQhg5qmX1RRywqTSkk/dr+maqXpftNsJSkTmT6wGvpsu31jgA63v/9Xy
         224T7ob+PGhJXgjwXoDz0yupsttb17cloklCkABxq3zt2w1qMrFb7Fk0dHwW9h9YzFjF
         5WMW9O3mghsi4GrUYIv5iMz8sOpslM0gbeI/stKTON739zbjqxF/PtGKLQVNk6bIij/Z
         eLBfQeWn73YKg+XeCq6/Na5Nxz3aoy4Bo6qRlbnzOXOdGXXfUwM8/DSwiDhFkQDmwj2G
         wyAOcOVnQxEB/z8nt7LqNJWok+hR0G4B7UiMOQXO9XU/Yb3zeUDbcb4HTwNqZipuvsbj
         JKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705710663; x=1706315463;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TGmXAoUQHt8aDfak0ug6bpaZtnyVT7ONfXQ8J1tL1o=;
        b=qetlr0Dm9n3L0VmX9wJgrpeIskN3HBJ/zO42PlhfiAGSFUN7J3NOpYIXfDCFCHPQoA
         Z+Ad2MIY8EPF2kMA/crb+LC9qLpG+CsBoLop4ihk3M0Fw4bEF5Hjty++uVa9mmb3rinA
         cdfD8qgezyMm9B2hYYApJmjJ556e6Zfuy2TWoSLE3XKt9HyV81WsCG8IjGfrTHOh62HB
         xjQi7dxmWJb40F8YfN2u7noOuKLvci+6u+uwCvyL8COPbJTiD6qeLvXRajaVTPYSS+1N
         xb4m50AL1tICS8YHW5tL2mzUoC8wPQAESqok/OcM2gqAbssrpwUEdio71TbgiqEdn87M
         dGjw==
X-Gm-Message-State: AOJu0YyoFOWnfqlYm4ORGtN9EZJ8FQYsuBGrUhj+K5dkSyFlu6so5JRW
	BUiEvPUYcIqqI3HHZZPMywLaryE/vlrxbYJWr7SXxbhTSbobQjUdpnyEMgRmEC0=
X-Google-Smtp-Source: AGHT+IE0yBuziGiUMLYTKLit3m+CHS49T6t31Tj6RccdjB1f6Vl62rPQ7XcTUY1AyDA81GUNWI17GQ==
X-Received: by 2002:aa7:9d0f:0:b0:6db:936c:aabe with SMTP id k15-20020aa79d0f000000b006db936caabemr1357481pfp.2.1705710663333;
        Fri, 19 Jan 2024 16:31:03 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id fh35-20020a056a00392300b006da1d9f4adcsm5690148pfb.127.2024.01.19.16.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 16:31:02 -0800 (PST)
Message-ID: <8ef6eba4-b7b1-48b4-84a3-db6a4e27a348@kernel.dk>
Date: Fri, 19 Jan 2024 17:31:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] block/mq-deadline: fallback to per-cpu insertion
 buckets under contention
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240119160338.1191281-1-axboe@kernel.dk>
 <20240119160338.1191281-4-axboe@kernel.dk>
 <9bf23380-b006-4e80-95a6-f5b95c35a475@acm.org>
 <af2f895c-ee57-41a1-ae14-1f531b5671e0@kernel.dk>
In-Reply-To: <af2f895c-ee57-41a1-ae14-1f531b5671e0@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 5:05 PM, Jens Axboe wrote:
> On 1/19/24 4:16 PM, Bart Van Assche wrote:
>> On 1/19/24 08:02, Jens Axboe wrote:
>>> If we attempt to insert a list of requests, but someone else is already
>>> running an insertion, then fallback to queueing that list internally and
>>> let the existing inserter finish the operation. The current inserter
>>> will either see and flush this list, of if it ends before we're done
>>> doing our bucket insert, then we'll flush it and insert ourselves.
>>>
>>> This reduces contention on the dd->lock, which protects any request
>>> insertion or dispatch, by having a backup point to insert into which
>>> will either be flushed immediately or by an existing inserter. As the
>>> alternative is to just keep spinning on the dd->lock, it's very easy
>>> to get into a situation where multiple processes are trying to do IO
>>> and all sit and spin on this lock.
>>
>> With this alternative patch I achieve 20% higher IOPS than with patch
>> 3/4 of this series for 1..4 CPU cores (null_blk + fio in an x86 VM):
> 
> Performance aside, I think this is a much better approach rather than
> mine. Haven't tested yet, but I think this instead of my patch 3 and the
> other patches and this should further drastically cut down on the
> overhead. Can you send a "proper" patch and I'll just replace the one
> that I have?

Ran with this real quick and the incremental I sent, here's what I see.
For reference, this is before the series:

Device		IOPS	sys	contention	diff
====================================================
null_blk	879K	89%	93.6%
nvme0n1		901K	86%	94.5%

and now with the series:

Device		IOPS	sys	contention	diff
====================================================
null_blk	2867K	11.1%	~6.0%		+326%
nvme0n1		3162K	 9.9%	~5.0%		+350%

which looks really good, it removes the last bit of contention that was
still there. And talk about a combined improvement...

-- 
Jens Axboe

