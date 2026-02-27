Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B281A3154
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210893; cv=none; b=erhjjM29aYamK9RvqPJRuRqkhMDfmyd4VfTXuqEn3juH/l64xbJhPmUjLMJxbyvsciQU1QGzoFR+rLxkhEuC0sIpowteEfur8cyd/03TsXTzdgS3QN3eFkdx5OlIK8FLLekxOK+77qomdrmZN4zAotw38Ttpd6Cp0tDf+eCodaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210893; c=relaxed/simple;
	bh=WdcgKOisl/3Pz2aZMgv4ysAytBvMWUyRVewFSKc7cFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3kXa4w5XqKG/S8ff9UWOZBtPRBD1N+LrcPJOGSNl6i7UqPJsNAVNw4jnHAeSNJ5ECt8U/icPHcOXzK6IzB37h4i9b7t6yY1kcy94dJUI8AdyGmTCBsV0ntxiNxDHuyVRYtRmYuxHNdVujL7VD1UbVKsstgbnbw8slyBkRIrFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZENWQWEU; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZENWQWEU"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb38e6d164so285402185a.3
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 08:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772210891; x=1772815691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hiE9IS4sVfvJ0jVFsXC7dT1wVCZ240JEvmTzP3RBOg=;
        b=ZENWQWEUYqJRTdOSg0eJM/h1/bWd7wIZIJbiNx3/zfuw0wyVWoFLCZYXDeiMn4fyp+
         jICJAub34LhDutgtnjjjYYtncLWGuyS79zyVC2oHEBKYAOH2Zzid4JQmVChPydvGZLow
         b+zkMYlRv7oAt9sTti3wLQWiW1LODBG6bJIMrb5/s8Noi/B7lBSvLkucwBwlxWS9kbSy
         3b5PMsfDehul+Xk592iQ1baDsan83o/w1uHrQjW+tfInbyoEkx9hoIIZZRDUNlng33uP
         f/zcO9FQ50SOUwHpzIMYjtuHEu2mMrcYfYDpAA0EX0KQGktpqDWHHxbxhsvmrhc2zMLZ
         ldfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210891; x=1772815691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hiE9IS4sVfvJ0jVFsXC7dT1wVCZ240JEvmTzP3RBOg=;
        b=GTkWP2FcIiRvYZqpGh0wv/zdiKlm8sODzSsRT+cn04BdL/I+ASpi7cDePjisJlEZ0X
         uYygU104qt88/Z0u6WElh6EPFAu9UMZjBeBim5dPBkbngIDEKQe7Dhg9jqFFbgoFoFw+
         M2FRupydl7lsqhipYhymlZDLmrFH/Ork/LM3+IhzOOOPOjkjZJ41vxrFW7AgrbwQEHOL
         xDl75zXCRYN7Bd//obQ//gAlAsMkNrRMoEqnphUXw4Q2MrjIECrtE7Pdx2bABW7rSi2c
         OZxSu84S3UeTaztZewMFSc7tgxWTJGWQAGhEmjRlCr6t44/Wb0rhFW32U0jQo0M4zWu+
         otxA==
X-Forwarded-Encrypted: i=1; AJvYcCVrM4OTYbhiiaX+NYhluyWoIbkyk2tf4LY0pWBPDMYRPWwhuLfxKIwRAmSs02UCr5xlGAA+PbeSJeEGQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOGI5Zkrme/Sugo4DqH3dWiWzLpUGVtFNjeVGnx5AZmqUwj1/
	kQdKHDWO/bEVCaJhEyMjKVWvhEqiYrQyCjR8DMOV3R3XipCIBBi0n/rS/ecC0+BMOwE=
X-Gm-Gg: ATEYQzwhLKp5hbbMTgRyWeNgDgZeaVv4m5PTwCbYcimvm79N0AE/mBJu4EecssC9TeP
	7YSDuotaY2hY4l1CFdDFWjDvDkwC4GX+5iGJyBxorxoHvmgDFU5kfe/45TSmjlP9uYCZzhUkPC0
	AyQpxR8/ZmrH0pljwCwnBxh6VFM82lAqSAms9HAju13IhhVJiVmOYsL+C8r+D9qo2f2BjANq3/p
	qyfL3r56TbdzT8EekFks8zZgRM32pYP/f/oSexw9z2+EIiojkP8qGrgd3qOAovk9SQadq2n3I6q
	MMO9hTbQFMwXmyF1iZsKwXi1jnASgOGtNOjkw5r5GEmu4s2Lk+KRnp3VvRRM/8IpNDz4fC9qafC
	qNr72RZ4ja3Q8BJaPT45jW6vJO3zEsii+6q74sCiBjrQomfQUJ5Ml+9hou5QPmyz67l7bnZuPFp
	guObAo9Fbv7gm63NIDdwmRC9mc8c0XKBeHBKCKpAtFI+r/eI9xNLeNk2H0xBGUIILZcmR03SqUF
	NfhdTi2
X-Received: by 2002:a05:620a:bd5:b0:8ca:2e36:18b3 with SMTP id af79cd13be357-8cbc8e4e8b3mr441837985a.50.1772210891027;
        Fri, 27 Feb 2026 08:48:11 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf717301sm504582385a.36.2026.02.27.08.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 08:48:10 -0800 (PST)
Message-ID: <488e0beb-d18c-4fce-9787-2fb9ea01f677@kernel.dk>
Date: Fri, 27 Feb 2026 09:48:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blktrace: fix __this_cpu_read/write in preemptible
 context
To: Chaitanya Kulkarni <kch@nvidia.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260227050303.10945-1-kch@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260227050303.10945-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/26 10:03 PM, Chaitanya Kulkarni wrote:
> tracing_record_cmdline() internally uses __this_cpu_read() and
> __this_cpu_write() on the per-CPU variable trace_taskinfo_save, and
> trace_save_cmdline() explicitly asserts preemption is disabled via
> lockdep_assert_preemption_disabled().  These operations are safe only
> when preemption is off, as they were designed to be called from the
> scheduler's context probe_wakeup_sched_switch() / probe_wakeup().
> 
> __blk_add_trace() calls tracing_record_cmdline(current) from process
> context where preemption is fully enabled, triggering the following
> splat on using blktests/blktrace/002:
> 
> blktrace/002 (blktrace ftrace corruption with sysfs trace)   [failed]
>     runtime  0.367s  ...  0.437s
>     something found in dmesg:
>     [   81.211018] run blktests blktrace/002 at 2026-02-25 22:24:33
>     [   81.239580] null_blk: disk nullb1 created
>     [   81.357294] BUG: using __this_cpu_read() in preemptible [00000000] code: dd/2516
>     [   81.362842] caller is tracing_record_cmdline+0x10/0x40
>     [   81.362872] CPU: 16 UID: 0 PID: 2516 Comm: dd Tainted: G                 N  7.0.0-rc1lblk+ #84 PREEMPT(full)
>     [   81.362877] Tainted: [N]=TEST
>     [   81.362878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
>     [   81.362881] Call Trace:
>     [   81.362884]  <TASK>
>     [   81.362886]  dump_stack_lvl+0x8d/0xb0
>     ...
>     (See '/mnt/sda/blktests/results/nodev/blktrace/002.dmesg' for the entire message)
> 
> [   81.211018] run blktests blktrace/002 at 2026-02-25 22:24:33
> [   81.239580] null_blk: disk nullb1 created
> [   81.357294] BUG: using __this_cpu_read() in preemptible [00000000] code: dd/2516
> [   81.362842] caller is tracing_record_cmdline+0x10/0x40
> [   81.362872] CPU: 16 UID: 0 PID: 2516 Comm: dd Tainted: G                 N  7.0.0-rc1lblk+ #84 PREEMPT(full)
> [   81.362877] Tainted: [N]=TEST
> [   81.362878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [   81.362881] Call Trace:
> [   81.362884]  <TASK>
> [   81.362886]  dump_stack_lvl+0x8d/0xb0
> [   81.362895]  check_preemption_disabled+0xce/0xe0
> [   81.362902]  tracing_record_cmdline+0x10/0x40
> [   81.362923]  __blk_add_trace+0x307/0x5d0
> [   81.362934]  ? lock_acquire+0xe0/0x300
> [   81.362940]  ? iov_iter_extract_pages+0x101/0xa30
> [   81.362959]  blk_add_trace_bio+0x106/0x1e0
> [   81.362968]  submit_bio_noacct_nocheck+0x24b/0x3a0
> [   81.362979]  ? lockdep_init_map_type+0x58/0x260
> [   81.362988]  submit_bio_wait+0x56/0x90
> [   81.363009]  __blkdev_direct_IO_simple+0x16c/0x250
> [   81.363026]  ? __pfx_submit_bio_wait_endio+0x10/0x10
> [   81.363038]  ? rcu_read_lock_any_held+0x73/0xa0
> [   81.363051]  blkdev_read_iter+0xc1/0x140
> [   81.363059]  vfs_read+0x20b/0x330
> [   81.363083]  ksys_read+0x67/0xe0
> [   81.363090]  do_syscall_64+0xbf/0xf00
> [   81.363102]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   81.363106] RIP: 0033:0x7f281906029d
> [   81.363111] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d 66 63 0a 00 e8 59 ff 01 00 66 0f 1f 84 00 00 00 00 00 80 3d 41 33 0e 00 00 74 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
> [   81.363113] RSP: 002b:00007ffca127dd48 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [   81.363120] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f281906029d
> [   81.363122] RDX: 0000000000001000 RSI: 0000559f8bfae000 RDI: 0000000000000000
> [   81.363123] RBP: 0000000000001000 R08: 0000002863a10a81 R09: 00007f281915f000
> [   81.363124] R10: 00007f2818f77b60 R11: 0000000000000246 R12: 0000559f8bfae000
> [   81.363126] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000000a
> [   81.363142]  </TASK>

Is this a new issue? Needs a Fixes tag.

-- 
Jens Axboe

