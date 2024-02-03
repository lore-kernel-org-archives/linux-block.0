Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD75D8F8
	for <linux-block@vger.kernel.org>; Sat,  3 Feb 2024 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706962313; cv=none; b=fzBQv5lrV/Gh2bv0PLId4dblI2DlKwhv6xPm7CmvTJggjYT32Ikt2aRgXt6TL+6O/+4xhvP4IudQBFMG9T3LhK9cErWsRuPqu+3CwAyq0bx5uNKc1NK6ypJ9A40oaDPvM3QZK2esqksWF+BmOXtepyyd6MXdMh4ama2Jbsk0OzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706962313; c=relaxed/simple;
	bh=NKqKivxBa1UrOQdEFxuztVX+NR+bchaWhMeL9Kg6RHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmZexVshHHh41Yvz8BoX4dt68OG9Eiu4hQ8B0Aou8rT8x5lzzhCCLPcYHbVlXkcAs8ofynsc6tvKWOJWRwGUtbmxrROI8xfvAVLhaYv9s1Xlj/P7PKR4v9yhzILbRAeemhBgATD+Cquxs8jeJ8Cq15dnA2dSJK3rdd/MeqM+HBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=06yBGLqe; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="06yBGLqe"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bc21303a35so912745b6e.0
        for <linux-block@vger.kernel.org>; Sat, 03 Feb 2024 04:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706962310; x=1707567110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6At8w3BY+bHriEibzEnUgO2+DI0oRR4cvw0MljHLkA=;
        b=06yBGLqeHFw4mSGiacaeJNTR2oRDBrJ4z/lfOSjnU8WD3Gxu4j3TKz5pJ34XjRxB0E
         uPbyJ7LpxLyYtdVyXT5b5J2/BQXn/Ds6g0EWVkpOu0g/V3Hl1D5JHViMG9RDs1eVNn2T
         K+UZInWXohWBA30YZGuPnz4fTjXjsfeGNivmUUs2eh5SqBglIRlPBahE/qoXG7EVwWER
         DKF7q44T+Zk1B3j5UHsCGhGwFgAM6r2245Zo/sojBP4UU277oNuKXFehXCdG5sKZOvWB
         2Oask9QIYvaT6XUF4U/elkqaOGiULRrqEXUKczUXesl69LXjuNgNnBPZ2FXgg5ugET+o
         L5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706962310; x=1707567110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6At8w3BY+bHriEibzEnUgO2+DI0oRR4cvw0MljHLkA=;
        b=Abona0mrVouc3H02oMOgRw0OvwnOiLqXS3iGSeR5CLAXsuHw/p4VZeoje1naDG1rE8
         gFiT+Z42G5LM0Vjz1Wm9LVS2IbhZx6ZFpLyuXauEO/O6F3U+SK0w7XwmukjSEwMwMl5l
         Eurx+AogUWM1gLLT/1Fl83glRSEeW+R2m3LfDSxwB0YZhunwNipN7Ih8wtmSeEZhl6YL
         sLw1UAQVKpucrk5CkUBXe+M/9MlUhAXqa92buyl3JPdDgZSran4YkYDPtkSvUFAMGvBx
         T/Oi0TPqFe6BQKac/LaktF8TGnE3tVG2KQ0ZZGdFsc/CvjN6RjX+iSJ5ifYsLRZSbQUa
         +neg==
X-Forwarded-Encrypted: i=0; AJvYcCVvqyAbCTQaml1+9ILLl7sOb0N+iASmdQyDX+RHHkrslwZefuoeptI2owkCzcXgei29IiX0kjn8YaLnHn8NK1ipaSo8zeUDQbt0BSs=
X-Gm-Message-State: AOJu0YzbcR4nnD/NZ9m4UjcXL/cJD6afsdez7RRitg2KfBvyCHCkB7Xl
	gbN1rSz0htfNv95Z2KcPqhIYMUJTZHZz12hOBH7SMCvpIAyuezPljGS4VfQtuAA=
X-Google-Smtp-Source: AGHT+IHqU4+fGOqr+6hwk36/z50UDpr7B1lwfquHREOClNc/Ohn+gEBSJJY/qwk/nminNs/414tyZA==
X-Received: by 2002:a4a:a787:0:b0:59c:7c63:928f with SMTP id l7-20020a4aa787000000b0059c7c63928fmr8736332oom.0.1706962310299;
        Sat, 03 Feb 2024 04:11:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWw+Y7AW9dyMB0A0M0XJRjY7ktYhP9Rs6oOd4pjM3Nn23QgvIv2kdSR8OtCYTZbFONZNotZbS/djXmBPiB5wK8MshAwqwVzOHXqYP3QikyM9c5lEiOO9fkF9xPMfdQ8gKSpyPao5UBzBEKLARyyNp9OGzklmYmjlsJC5duJwSmlDhvH7tEAGdm52Cs1CVEXwgwEL8GgSSx7foRnA0CQU/6FpNZedtv8nWbAM/0cIzgWin8=
Received: from ?IPV6:2600:380:9b5a:c5dd:b564:550c:8958:e9dc? ([2600:380:9b5a:c5dd:b564:550c:8958:e9dc])
        by smtp.gmail.com with ESMTPSA id y6-20020a4ab406000000b0059a9652eee4sm814630oon.25.2024.02.03.04.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 04:11:49 -0800 (PST)
Message-ID: <a387f08c-05c1-4c47-8ba1-27493b7853ef@kernel.dk>
Date: Sat, 3 Feb 2024 05:11:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] Zone write plugging
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
References: <20240202073104.2418230-1-dlemoal@kernel.org>
 <147de7c4-7050-4b1d-a48c-c0316a81baee@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <147de7c4-7050-4b1d-a48c-c0316a81baee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 12:37 AM, Damien Le Moal wrote:
> On 2/2/24 16:30, Damien Le Moal wrote:
>> The patch series introduces zone write plugging (ZWP) as the new
>> mechanism to control the ordering of writes to zoned block devices.
>> ZWP replaces zone write locking (ZWL) which is implemented only by
>> mq-deadline today. ZWP also allows emulating zone append operations
>> using regular writes for zoned devices that do not natively support this
>> operation (e.g. SMR HDDs). This patch series removes the scsi disk
>> driver and device mapper zone append emulation to use ZWP emulation.
>>
>> Unlike ZWL which operates on requests, ZWP operates on BIOs. A zone
>> write plug is simply a BIO list that is atomically manipulated using a
>> spinlock and a kblockd submission work. A write BIO to a zone is
>> "plugged" to delay its execution if a write BIO for the same zone was
>> already issued, that is, if a write request for the same zone is being
>> executed. The next plugged BIO is unplugged and issued once the write
>> request completes.
>>
>> This mechanism allows to:
>>  - Untangle zone write ordering from the block IO schedulers. This
>>    allows removing the restriction on using only mq-deadline for zoned
>>    block devices. Any block IO scheduler, including "none" can be used.
>>  - Zone write plugging operates on BIOs instead of requests. Plugged
>>    BIOs waiting for execution thus do not hold scheduling tags and thus
>>    do not prevent other BIOs from being submitted to the device (reads
>>    or writes to other zones). Depending on the workload, this can
>>    significantly improve the device use and the performance.
>>  - Both blk-mq (request) based zoned devices and BIO-based devices (e.g.
>>    device mapper) can use ZWP. It is mandatory for the
>>    former but optional for the latter: BIO-based driver can use zone
>>    write plugging to implement write ordering guarantees, or the drivers
>>    can implement their own if needed.
>>  - The code is less invasive in the block layer and in device drivers.
>>    ZWP implementation is mostly limited to blk-zoned.c, with some small
>>    changes in blk-mq.c, blk-merge.c and bio.c.
>>
>> Performance evaluation results are shown below.
>>
>> The series is organized as follows:
> 
> I forgot to mention that the patches are against Jens block/for-next
> branch with the addition of Christoph's "clean up blk_mq_submit_bio"
> patches [1] and my patch "null_blk: Always split BIOs to respect queue
> limits" [2].

I figured that was the case, I'll get both of these properly setup in a
for-6.9/block branch, just wanted -rc3 to get cut first. JFYI that they
are coming tomorrow.

-- 
Jens Axboe

