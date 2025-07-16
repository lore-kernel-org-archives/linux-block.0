Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6EE265609
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752630863; cv=none; b=Rr9qL78flYhGm8mk/ekd9mtIeNWoatNYXYcO7AbKQnxplZKVJMsTEU47+eUfd9lKkeZ8iQdTP4uuZbW+enay+FqOaN/TX+A1Q1uoP41c0bfews9Rqxa4s5rWr41byTJ36TJU9jjJAgpkYMKFaXJzyHJjfAbi8CUm20v95zPc5GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752630863; c=relaxed/simple;
	bh=hTV3r6/XDkRjptq9O4ZKFp8aAzwD1Pu4WVB01ZErpNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oanckDRmESKZyACQEMTFKbdNFccwxpvwpeL3+jeb8P+sFiI2nObzo36q0tgB9e/+kiHQs8yZYm6cNwd7wQZlrG/y5vGHH6U6pROdt6eGjL9+S5lu65nTypsfY0GTKCvLMoTkubSoWLYHN3uqeXanwahL2MwnsL8WEsPHEjrO6fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aL2hHK5G; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aL2hHK5G"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3df2d8cb8d2so22097785ab.2
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 18:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752630856; x=1753235656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aTmeP8qpyCHmA/g2+LUU/MHMZPdFolBFtPEoJnC4prM=;
        b=aL2hHK5GTaUid01+T4j/cATzw0Nu6OEZMml4xNFBaDQknyNNQ4rz6/xQ8IXwvckB2M
         4KFNBq0c21LlK9eMyECikPYHaB0Tuv+v/PPsBsRjwt3wKe6qtT4Q0kfUwjN9VK03EzkV
         77TOvuPx2ViS5/HS0zfvcZFd675QsqwvtMYOFL70xQxS0nsl/86ogw0SZkv4z9VzAAOG
         bFcQ7e2AurM9WAECAgSF0KVRhPHFrRfCL9UWSZvgMm21qhcZlYRbOI1ubtwyUFLqYHmQ
         J2w42cEBqQuInBtNj3EOTmaecMVZvJHviGfmihEANusYUorSSVzin8xX7/nMRHbAGXAX
         7NOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752630856; x=1753235656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTmeP8qpyCHmA/g2+LUU/MHMZPdFolBFtPEoJnC4prM=;
        b=oA4YgOvxq99W9Dea1HxODfVzk4AY87Ff6lT5xjeWSko7fXeZJ/UXxMFtAvHEsW4E1m
         Hbg3Ysr3UWzlxBSCBBPwLbh/4OnrnhZEgi4L9XtC2m2fO2s7StBa+ZBop5yE0qSVm+an
         OWt0ytSuwQ6AeUiBH3ddvF1aPsbIUHv4LgGS5EQZETmnnyRewa6bxxUcA/IgV+DbBPfu
         bHQIpwgtqwYAHUVl332F6AqJiZfPLbNkuo0bw88U5lV/xJ+qNky5XgMlRMUMHS88jysR
         7NENgxEcMajFq2PgTbdYuFNgEO5dBlr1niBBWNCGx57N2tcnYwqOP7wCiYKmi2q2vRvE
         ILDw==
X-Forwarded-Encrypted: i=1; AJvYcCXURr3WKub3K03D7SFpCKFuZSFWJooAyphh2a4FWtl1eIRleUdK3ljg7vzvY8fpPwzwtiiBtBszugJmNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzrMuZvQmarNtxa5gb7DkL00zSoRjtLE5jNPtHpI2uvhNbgJw+
	Ns/fzx4MmqBouiKJMB26RIye57HR8Do2HxSeBPJCebl7546n84zJMjahpytgyo4mTVI311CjMiR
	nl9y8
X-Gm-Gg: ASbGncuh4lTVvALsTrJaUqvaQwUU6OI1/C2mpi8agsM536D9v5mvCgSucJ5ynDFTjT3
	x3amr9rADmuWYOqllRuFnsNMY9oXNI/tveHvGjXZtTwvx0N2Oth/wdAJ/cYQcjwTBRM4zH2aJAS
	6rV3a2XDEKo4BVu3VeYtbVBTbSEFGAJSREPPa8rYxebgjsg5ROBPnf0zpqCciLyO5sgm1Kyos1e
	hLgnRaQtfOFvKJ8lfIQ27hZNWR+t6eS4X3J9lOpYpIoCbxWuMHR4ebZhvqiDQwUaJGrCwXSLLFT
	uzbWhU5H2DH1PMfBQ6JGCmTRPu2AVbPc+7sV/Ct8OEB1bTkIfe/VnNppW8NhnmJIFFEzkm3v8MY
	fvWaYf6odaWJFy9ZwOns=
X-Google-Smtp-Source: AGHT+IGxq71zOazX9frNe40QOYlU0yiVuzBNaRtc144t7dJRYEozgrUBmSNeWxaafc0OmaqBbBHu8Q==
X-Received: by 2002:a05:6e02:216c:b0:3df:29c8:4a0f with SMTP id e9e14a558f8ab-3e28249b9demr14939895ab.21.1752630856297;
        Tue, 15 Jul 2025 18:54:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24620a9f8sm41060885ab.36.2025.07.15.18.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 18:54:15 -0700 (PDT)
Message-ID: <d52a8216-dd70-4489-a645-55d174bcdd9e@kernel.dk>
Date: Tue, 15 Jul 2025 19:54:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kmemleak issue observed during blktests
To: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 7:42 PM, Yi Zhang wrote:
> Hi
> 
> I found the following kmemleak issue on the latest
> linux-block/for-next, please help check it and let me know if you need
> any info/testing for it, thanks.
> 
> commit: linux-block/for-next: 8192f418ee2f (HEAD -> for-next,
> origin/for-next) Merge branch 'for-6.17/io_uring' into for-next
> 
> # dmesg | grep kmemleak
> [31404.993877] kmemleak: 608 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> 
> unreferenced object 0xffff8882e7fb9000 (size 2048):
>   comm "check", pid 10460, jiffies 4324980514
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc c47e6a37):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x416/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     find_fallback+0x510/0x540 [nbd]
>     nbd_send_cmd+0x24b/0x1480 [nbd]
>     configfs_write_iter+0x2ae/0x470
>     vfs_write+0x524/0xe70
>     ksys_write+0xff/0x200
>     do_syscall_64+0x98/0x3c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff8882e7fbb000 (size 2048):
>   comm "check", pid 10460, jiffies 4324980514
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc c47e6a37):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x416/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     find_fallback+0x510/0x540 [nbd]
>     nbd_send_cmd+0x24b/0x1480 [nbd]
>     configfs_write_iter+0x2ae/0x470
>     vfs_write+0x524/0xe70
>     ksys_write+0xff/0x200
>     do_syscall_64+0x98/0x3c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff88819e855000 (size 2048):
>   comm "check", pid 10460, jiffies 4324980514
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc c47e6a37):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x416/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     find_fallback+0x510/0x540 [nbd]
>     nbd_send_cmd+0x24b/0x1480 [nbd]
>     configfs_write_iter+0x2ae/0x470
>     vfs_write+0x524/0xe70
>     ksys_write+0xff/0x200
>     do_syscall_64+0x98/0x3c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e

Can you try and revert:

commit 8b428f42f3edfd62422aa7ad87049ab232a2eaa9
Author: Ming Lei <ming.lei@redhat.com>
Date:   Wed Jul 9 19:17:44 2025 +0800

    nbd: fix lockdep deadlock warning

and see if that fixes it? If not, then checkout for-6.17/block instead,
and then run a bisect with that sha marked as bad, and v6.16-rc4 as the
known good one.

-- 
Jens Axboe
