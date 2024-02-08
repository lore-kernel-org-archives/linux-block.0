Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048531D526
	for <linux-block@vger.kernel.org>; Thu,  8 Feb 2024 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707361297; cv=none; b=R2ee529eU/EoOKYR/LH3Y9Gs/Ot+k9tZBnOteDx2YyT6iD4XEiqOEhx4CBIzWILicW66Gux5tuhYtFxOjWOHE6Ps9viVFAEwomA6QL/n+UWIzkrjfKT3FFPfNa6MN3t3zSiS17IvcWSW+UNgEaXQAW/s/He4GydU0lcFSEz+5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707361297; c=relaxed/simple;
	bh=3+hAdbRbRd/GeQ9qv9QFAghd9lhHiHTSFWq+ekjSIBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YaZfYDmMAuQhJVJdQctevVQ2l1dKXUjfvswhFxGWhcBA862eWUSl6Unz4ljmxOU43+WTerg1Xs2eXxKr6CuZjply6kZWHTLiwQqrzOhbSv/zhR4qYZw31Po2u6eiouih1hLRuRBC6TPKjh0f5LSVVgzKHi8iLGYMIl7NXBUpO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=On6zQFLZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="On6zQFLZ"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5a0dc313058so291338a12.0
        for <linux-block@vger.kernel.org>; Wed, 07 Feb 2024 19:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707361293; x=1707966093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7BVm+pX1kkdklUSxefDQmQkSascJM9q5mxgl9cxHyj0=;
        b=On6zQFLZGXhqbdl/BsMZfFPwn3DYh0IhFvNBveQsrduAMcaCdklqpljC36Z9OQGfJe
         dHR6Kh+OsCHWeySn7aVtMscRbWvpCHSOMrY6CaFYxv1mJ1+JqvAmwKgA0tm+4Hcc/1+/
         Z3/fyu1dFfXkii7yzDeI5UZIdm7LJm8gR9QnRexT0tfBDYldxH+dt7gWmdlcw5bZhIph
         gWaUZ4bdNwNtFq7KsoH2Lx6MGSpai6JrzlfJrkWwEvHSHFJVHUJ2YrxvwjhZBJyv+g60
         dx63NWdtQaUGqqsjdy/ifUrUZ+vB8hY5vyje19cHDnEVzxdmfgatjYjt/bobDqHzriqD
         kfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707361293; x=1707966093;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BVm+pX1kkdklUSxefDQmQkSascJM9q5mxgl9cxHyj0=;
        b=AfK/2JObZIZqLxc/OoyKWzNyQOaBVjy+IZ69ZDHJM3sMOtojCDEug3kmQIi+YKvg26
         3TR4KxekIYlxA+4ANBWDWCiq6TZOzM0y5Nnjjgavn6yJVmM8Ek9RKd7+ajvBXy4k6QxD
         CWWr8zLRfXA07Z7/tNd1ieNb7AaM7FfTcSHKdJAF3rfxjzcbLUx56CF9qdnc3pTdflWw
         r4jfv15p5m+GP/NLmIm7pg6tdRLPKXlfyQBzBHOSMwOb5ET4QjZd3dp3JJQhFT+I9V7o
         ro6WWQjFVZAiP0ZwirqIBwA8FtzxLMDm1ZCcDIEE2E1aL+AoWBq9IlpZfxJGdOGLWQDf
         Kiyg==
X-Forwarded-Encrypted: i=1; AJvYcCVC0aklOn+ss1OHZp9UWF11FFzUG6R3dLTGKSsvdDnNgLoGDDJYoNCRkiJK11ZSm1txhB43n0yCPgQq9rVtYEHDCzlgkSbYlXw83A4=
X-Gm-Message-State: AOJu0YysB0NBaM7rjHzFda80ty7bTXpraYpuwh48jDdX01Ng+m/LB6Ox
	l2MCqBlrC3uYjdIG+ocBOzFULbN7GWJSO6spzD05HaEhVL5Ww/gsJ6P6eZYNl6I=
X-Google-Smtp-Source: AGHT+IH9B97vJJzsOXGbDxeBwSYmdjFCKkAP5u9ZfaHkMwzX7hS5sDkgQnnFWlmjFyfiLHYjwxqiEg==
X-Received: by 2002:a05:6a21:1a7:b0:19e:a6ed:9ba0 with SMTP id le39-20020a056a2101a700b0019ea6ed9ba0mr3553633pzb.6.1707361292855;
        Wed, 07 Feb 2024 19:01:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmQMffaAmxjCg/tmgr7LzXEYK/tba3b0UkpQv3tl6d9zU36PaxbGOMatcnMKXTCUbhyA6QPaMyGgUqn8haAcBmTroeOzAiEvrPZ1qT5v80QEOXHGTF1aM5y1LFqMpG7hD3eyZYUK+fmcmbB+buZ0BUpbURumhZmXKlPoEoNJowO4reS8lAN5cK6Q0Z9GA=
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090341cc00b001d9aa671b31sm2200768ple.40.2024.02.07.19.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 19:01:32 -0800 (PST)
Message-ID: <eeddc012-86d2-406b-a720-09b7ad6a731f@kernel.dk>
Date: Wed, 7 Feb 2024 20:01:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] watchdog: BUG: soft lockup - CPU#19 stuck for 26s!
 [poll-cancel-all:33473]
Content-Language: en-US
To: Guangwu Zhang <guazhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
 io-uring@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
 linux-block@vger.kernel.org
References: <CAGS2=YpH-wNutLAQQ+L7teJ1RrJsyAvVk8dbwtHiLhQhnqSkhw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGS2=YpH-wNutLAQQ+L7teJ1RrJsyAvVk8dbwtHiLhQhnqSkhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/24 7:32 PM, Guangwu Zhang wrote:
> Hi,
> 
> Found the kernel error with linux-block/for-next  branch.
> kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> last commit 69c95a16fe484e6de5f3cc616953cc31d67e7000
> Merge: d78544b06104 052618c71c66
> 
> reproducer : git://git.kernel.dk/liburing  poll-cancel-all.t
> 
> 
>  [ 1722.001827] Running test openat2.t:
> [ 1722.029366] Running test open-close.t:
> [ 1722.059368] Running test open-direct-link.t:
> [ 1722.090178] Running test open-direct-pick.t:
> [ 1722.122762] Running test personality.t:
> [ 1722.152628] Running test pipe-bug.t:
> [ 1722.510823] Running test pipe-eof.t:
> [ 1722.540346] Running test pipe-reuse.t:
> [ 1722.569774] Running test poll.t:
> [ 1722.643305] Running test poll-cancel.t:
> [ 1722.673582] Running test poll-cancel-all.t:
> [ 1732.010369] restraintd[1656]: *** Current Time: Wed Feb 07 10:20:49
> 2024  Localwatchdog at: Wed Feb 07 14:18:48 2024
> [ 1747.506670] watchdog: BUG: soft lockup - CPU#19 stuck for 26s!
> [poll-cancel-all:33473]
> [ 1747.514587] Modules linked in: tls rpcsec_gss_krb5 auth_rpcgss
> nfsv4 dns_resolver nfs lockd grace netfs rfkill sunrpc vfat fat
> dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency
> intel_uncore_frequency_common isst_if_common skx_edac nfit libnvdimm
> x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_intel kvm
> irqbypass acpi_ipmi rapl mgag200 ipmi_si iTCO_wdt i2c_algo_bit
> intel_cstate drm_shmem_helper iTCO_vendor_support dcdbas dell_smbios
> mei_me i2c_i801 ipmi_devintf drm_kms_helper intel_uncore mei
> dell_wmi_descriptor intel_pch_thermal i2c_smbus wmi_bmof lpc_ich
> pcspkr ipmi_msghandler acpi_power_meter drm fuse xfs libcrc32c sd_mod
> sg ahci nvme crct10dif_pclmul libahci crc32_pclmul crc32c_intel
> nvme_core libata megaraid_sas tg3 ghash_clmulni_intel t10_pi wmi
> dm_mirror dm_region_hash dm_log dm_mod
> [ 1747.587107] CPU: 19 PID: 33473 Comm: poll-cancel-all Kdump: loaded
> Not tainted 6.8.0-rc3+ #1
> [ 1747.595540] Hardware name: Dell Inc. PowerEdge R640/06DKY5, BIOS
> 2.15.1 06/15/2022
> [ 1747.603104] RIP: 0010:__io_poll_cancel.isra.0+0xa3/0x170
> [ 1747.608419] Code: ef 60 49 89 ff 74 73 48 89 ee e8 a8 0e 00 00 84
> c0 74 e2 4c 89 24 24 f0 41 81 8f a0 00 00 00 00 00 00 80 41 8b 87 a0
> 00 00 00 <83> f8 7f 0f 8f 92 00 00 00 b8 01 00 00 00 f0 41 0f c1 87 a0
> 00 00
> [ 1747.627161] RSP: 0018:ffffa16d64997cc8 EFLAGS: 00000282
> [ 1747.632387] RAX: 0000000093f4d23b RBX: ffff940d4839bbc0 RCX: 0000000000000000
> [ 1747.639521] RDX: 0000000000000001 RSI: ffffa16d64997da8 RDI: ffff940ee22c2e00
> [ 1747.646653] RBP: ffffa16d64997da8 R08: 0000000000000001 R09: ffff940d4c12b000
> [ 1747.653785] R10: 0000000000000008 R11: 0000000000002cc0 R12: ffff940ec15ed900
> [ 1747.660919] R13: 0000000000000000 R14: 0000000000000002 R15: ffff940ee22c2e00
> [ 1747.668052] FS:  00007f0758c28740(0000) GS:ffff9410bfa40000(0000)
> knlGS:0000000000000000
> [ 1747.676135] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1747.681882] CR2: 00000000004052b0 CR3: 00000002a2542004 CR4: 00000000007706f0
> [ 1747.689013] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1747.696147] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1747.703278] PKRU: 55555554
> [ 1747.705983] Call Trace:
> [ 1747.708436]  <IRQ>
> [ 1747.710456]  ? watchdog_timer_fn+0x1ec/0x270
> [ 1747.714726]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [ 1747.719347]  ? __hrtimer_run_queues+0x10f/0x2b0
> [ 1747.723880]  ? hrtimer_interrupt+0xfc/0x230
> [ 1747.728066]  ? __sysvec_apic_timer_interrupt+0x4b/0x140
> [ 1747.733289]  ? sysvec_apic_timer_interrupt+0x6d/0x90
> [ 1747.738257]  </IRQ>
> [ 1747.740363]  <TASK>
> [ 1747.742468]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [ 1747.747783]  ? __io_poll_cancel.isra.0+0xa3/0x170
> [ 1747.752487]  ? __io_poll_cancel.isra.0+0x88/0x170
> [ 1747.757194]  io_poll_cancel+0x24/0x80
> [ 1747.760859]  io_try_cancel+0x86/0x100
> [ 1747.764525]  __io_async_cancel+0x41/0xf0
> [ 1747.768451]  ? fget+0x7a/0xc0
> [ 1747.771423]  io_async_cancel+0xa5/0x110
> [ 1747.775261]  io_issue_sqe+0x5b/0x3f0
> [ 1747.778842]  io_submit_sqes+0x126/0x3d0
> [ 1747.782680]  __do_sys_io_uring_enter+0x2c8/0x480
> [ 1747.787301]  do_syscall_64+0x7f/0x160
> [ 1747.790965]  ? do_user_addr_fault+0x31f/0x690
> [ 1747.795325]  ? exc_page_fault+0x65/0x150
> [ 1747.799249]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [ 1747.804302] RIP: 0033:0x40402e
> [ 1747.807361] Code: 41 89 ca 8b ba cc 00 00 00 41 b9 08 00 00 00 b8
> aa 01 00 00 41 83 ca 10 f6 82 d0 00 00 00 01 44 0f 44 d1 45 31 c0 31
> d2 0f 05 <c3> 90 89 30 eb 99 0f 1f 40 00 8b 3f 45 31 c0 83 e7 06 41 0f
> 95 c0
> [ 1747.826106] RSP: 002b:00007fff5139edd8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000001aa
> [ 1747.833671] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000040402e
> [ 1747.840805] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000005
> [ 1747.847937] RBP: 00007fff5139ee40 R08: 0000000000000000 R09: 0000000000000008

Known issue in that sha, it's fixed in the current tree.

-- 
Jens Axboe


