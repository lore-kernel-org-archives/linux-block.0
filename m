Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1CB22A7EF
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943436; cv=none; b=Aa7fiS6WJHTBFqgWbMXs/zXWW5jx9ANXo28bEviS4r4VZjXO10/0ouVJnlqxoR4jLulbH0G6sof5Q7/nviOguhBoQm2HTXDa6PzKUNKXWZgBZsc40o9x35rnHVuves2gtFjwvbEL0oO1IvrWoAwcGju1o9WcgQVuGzfAj6elX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943436; c=relaxed/simple;
	bh=Dd7R3WHb1uxVnekOUpen1sbswsRODZZSYfeRkRcwmWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAp6AqWv2FRrSGyfUTO2LR9UQOw/oEgbobyvCdts7by1v5yiXDsJYSvmLh58Xeh7uHGKoqbUlBbywFAeHSvCFjrvEjZegMlge9mK2pvj1dzGDYoR7a3fmWx9lg8iLnF9efeZcliSIpNysAuaAAoHxTIbi4arZjprEsolfKxaoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dOigykst; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dOigykst"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d7f111e9e1so13263045ab.1
        for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744943432; x=1745548232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KtO6op49z44/ebWGqhUaeKIrduOhCMbLk/MWlbQrcZU=;
        b=dOigykstWkt6ai10kDMiqr5P0TA5BE6FhkKgTBz7xpa5/loFVr2ZM791NczAu0nLLX
         LjJLW+Vf1TZIkb2dkuzt8hS0BimuQpcrbCAuEyd+jTUR21f0aCLmRLlUr3QNY5b17j/l
         y3ecEgk8keZctdYxAVb8apUosK7o0aXso6pvLOOrosTPJbhnbqVx/H9TdEgOadXtCriJ
         pwUjaduFhyPtmgJPFZlh08tEgvv9B7+Poqhi1afZDJOod3lFSC4KWmuFljRRTSJSH7E0
         wjL33q09fJXzuKiQMeHeaaauQavOVN1uTC7Os1ceUAVwE/IF9NOgBt78PvBJnBBoLlRP
         Q+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744943432; x=1745548232;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtO6op49z44/ebWGqhUaeKIrduOhCMbLk/MWlbQrcZU=;
        b=e3IZZHAZV1rlLn2vgLhenBd7/jrMYR8Pc9uHQi9B0vf08lRasLEE7Bl4pj3sU2GJ0F
         ETCQLmgV+Vi/pLqg48vS8LImzaTC0/E5066M4Pz0ha2x20AXp7fFJkXVDvs0SBbo/7mB
         Eh3ofjvcWYgO+5BfzO6O55TGdVyue6fy/bDa+BM/AW+zvIex0cZDreyEu8wqcIi+ktYp
         MkdJ+IcNyBV7hGP9DSkNKSqeBAfLNL94qovqQngvFi7mSvQIgoNlghpOTSb/B5nvItCU
         K1mP/s2ESgZ0bGpyPhXmQfFOPvcjT7XK/V9RgwyWrNJ4EOnv6nyuHinV493IAEjZf46w
         v1yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY8WUtc2rhjhD/RuFFw09OStSSAweOpewHHK7KzYTYUu+uxrv9k2J1pRAhh+K7jvKNWkzRS+zyQT7Ovg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvEOF+n+bwi2Qeg6wxsxdJu70+1MwWmZMi6N18JC6EXye/3Dv
	z2ThIjSwkO22pgeiS5+aC7VADDqWt5qkbBt1HgKkI2aeu4ynWwea4ESb0JizD3c=
X-Gm-Gg: ASbGnct/36yd9mcdEPTXqJKRiHWz4Ud1voQOworKYy071e62uosRDyS3hsLv2+zLnHH
	MjwbmkdhwubKbhL+MLVDbr95UOmFvmvPoGBbpFPYhUyfGvgkOefAl7fQcyLsOKVSW3wy2Gc9Jb4
	QKsxuqK7enau+S7L6+fj4ppT9zB+B1cVtu1A5rJDZhSN6Gpg8VwYI34QmGpfo+WwgVLvo87xoJ7
	Q8Tj8z1DnOssxXrSeWg45OL0EtbXFUJVeur6ZxJgkqJ+SMW5FZmoLan2i4y/O8rcRMYjr5XP6NX
	suvLZvcp1xX/+ohSoo3SDZVixTrihjfsA8Bs9ssjTTlAKjf3
X-Google-Smtp-Source: AGHT+IFqjPw6U5NtQE2k8IsIj8gExrzTiktu9UJd6PwwstPaGPPXrHJprgjk5kqM0YZvIsoxVHvZIg==
X-Received: by 2002:a05:6e02:3102:b0:3d3:d067:73f8 with SMTP id e9e14a558f8ab-3d88ed9fbf7mr12814555ab.11.1744943431784;
        Thu, 17 Apr 2025 19:30:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d821d377d6sm2441395ab.22.2025.04.17.19.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 19:30:31 -0700 (PDT)
Message-ID: <5b2bb7aa-43f5-4c25-af79-5f8c896254d3@kernel.dk>
Date: Thu, 17 Apr 2025 20:30:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] ublk: require unique task per io instead of unique
 task per hctx
To: Ming Lei <ming.lei@redhat.com>, Uday Shankar <ushankar@purestorage.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com>
 <20250416-ublk_task_per_io-v5-1-9261ad7bff20@purestorage.com>
 <aAGrI8wqLLCWzqNe@fedora>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <aAGrI8wqLLCWzqNe@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 7:30 PM, Ming Lei wrote:
> On Wed, Apr 16, 2025 at 01:46:05PM -0600, Uday Shankar wrote:
>> Currently, ublk_drv associates to each hardware queue (hctx) a unique
>> task (called the queue's ubq_daemon) which is allowed to issue
>> COMMIT_AND_FETCH commands against the hctx. If any other task attempts
>> to do so, the command fails immediately with EINVAL. When considered
>> together with the block layer architecture, the result is that for each
>> CPU C on the system, there is a unique ublk server thread which is
>> allowed to handle I/O submitted on CPU C. This can lead to suboptimal
>> performance under imbalanced load generation. For an extreme example,
>> suppose all the load is generated on CPUs mapping to a single ublk
>> server thread. Then that thread may be fully utilized and become the
>> bottleneck in the system, while other ublk server threads are totally
>> idle.
>>
>> This issue can also be addressed directly in the ublk server without
>> kernel support by having threads dequeue I/Os and pass them around to
>> ensure even load. But this solution requires inter-thread communication
>> at least twice for each I/O (submission and completion), which is
>> generally a bad pattern for performance. The problem gets even worse
>> with zero copy, as more inter-thread communication would be required to
>> have the buffer register/unregister calls to come from the correct
>> thread.
>>
>> Therefore, address this issue in ublk_drv by requiring a unique task per
>> I/O instead of per queue/hctx. Imbalanced load can then be balanced
>> across all ublk server threads by having threads issue FETCH_REQs in a
>> round-robin manner. As a small toy example, consider a system with a
>> single ublk device having 2 queues, each of queue depth 4. A ublk server
>> having 4 threads could issue its FETCH_REQs against this device as
>> follows (where each entry is the qid,tag pair that the FETCH_REQ
>> targets):
>>
>> poller thread:	T0	T1	T2	T3
>> 		0,0	0,1	0,2	0,3
>> 		1,3	1,0	1,1	1,2
>>
>> Since tags appear to be allocated in sequential chunks, this setup
>> provides a rough approximation to distributing I/Os round-robin across
>> all ublk server threads, while letting I/Os stay fully thread-local.
>>
>> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
>> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
>> ---
> 
> I guess this patch need to rebase against yesterday Jens's merge.

Given the set of changes on both the io_uring and block side, I'm going
to rebase those trees on -rc3 once that is out. So yeah, I think
rebasing and reposting this series against block-6.15 now would probably
be a good idea, and should then apply directly for the 6.16 tree.

> Given this change is big from ublk serer viewpoint, it should aim at
> v6.16

Agree.

-- 
Jens Axboe
