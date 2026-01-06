Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665F218E91
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717375; cv=none; b=RIbU12iZlMmzJx1QC8OZV7c0vKgZetb7g79D7BXfousXjHgwJ1jvi7g4UyjVZi6R6PeJ2QS7S9aD+e6zhGth9LGDvDvPEJxn+M7MYrUY0I/+75G7JualJKgnD56DZrHHHvS6D34wQF8S1ouAVZ8uC9etn+GMCYlohCUwPZcq6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717375; c=relaxed/simple;
	bh=fbfnFXxPvdmihDUx6O1pUH15NA4z2Jq0GBIYnKOXeQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QkTEe567zm5iy7HgJKZivbV2h7BRHDlXEztRXVSTv/itc/+iMoBhLBVSVL5DCsO8JHKnf3GYENqlCBdV6rvWP318PJYXAH22srlDp2hE5UvQ4J340tc1GAezDpfbfoSMScNodfvxRGK/z3GpEIY717Wc6A/azxoRrHcuwXcKoSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijrpFfJS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijrpFfJS"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47755de027eso7105015e9.0
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 08:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767717371; x=1768322171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m05O6szv3ztLcdGBKw/XhCvY0Xp40lTIJVCQNLoUnGg=;
        b=ijrpFfJStMF/ymo8vgDtRJGkfeCZu5T06KEMsOMkaYYb+hGnR2LA2YNX7Pg4oizrKr
         GJI069gwnCeAx61RzcuIGzNuVTP4wUoO/NUyJBFxP1iPTn29cc47QoHAdSxzu/d2WnUS
         NDQanoCnGmwWhn+MDpaLHG8doa3zsHsuN4zOX98UAnuN30jbTksEh91MMgq2S3ZvsNvE
         X0x9Y4jGttKqZbLjmecAPDOOJ5p/Hgf/jsG4x3WfSYicERi1U4xofm+yBCfurBsGay5l
         +rrKSckAy3BwelO0CwMJTbvh8RrqCm1mQEORfNg5SZluhu1eq1sashZYqr5rCniaalCY
         X1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767717371; x=1768322171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m05O6szv3ztLcdGBKw/XhCvY0Xp40lTIJVCQNLoUnGg=;
        b=wy7wQZsVKSHNvI+d9Pn++StUeUmW2wUAzs+WzVh6bjcnkW6HKMfIxkGNCohLL1qBsx
         UrtCTNDUemY8GqpgFbxPPTq5UngmxGvBVYdpB5gpSMwffCX6E34Sg34ThRbxGIHmfquB
         ttiNAQ+w4ZkqKXb3LlvaJ9Vm/otoMOLhmE98uVV8WLNYCDYTQ02b0dwSwjeH2B6CA9kr
         2PRGX6rsPVJRBf98eby/c4hPeKtUTRAdQitSqTnuA6qDOJpsrUgJk4o1MPx05+ZHe/0e
         wjkk6gz9p0SeuSGRCt6UX4YcGl8wWh2W/zs62si8SjLtAyrHMsK+NuB9hzGn5QKoPUR8
         uFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl95hBcj8nJAiEGCaUqVEb4elPW6QMqDQQ1axJdBBYwdYtZnIL2REDeDnTzOsAIXTL9XhS2UN8R0Bzug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEE1GpU0EjPClr4AFHsguygg8vR2ywqzXPpH+r4+zZPSX+M69D
	jVZDaRDxuIvduynZMkHVpZ0J1M2Cjun5SDBr0k/bUMB0e7hgkNFRU6Cj
X-Gm-Gg: AY/fxX40m4/hFiwK9bqDAdkS7k2Zl2tS3AH/TH7A5XmeTCunyrZE5aAvMfJ1vtpOrwF
	QUFFZnXubQmBA0i5jVxSNcJAZbawMCap6XVxUtn/H9ynQ38L/KbI/MTcr3v7uP64HGhExlfMDjQ
	KUoAqnLegQRvsFyJDnI6fShRJblASKls1JJRHIzCSPuPL89HnuElgxKWjx9m75/8yYa8wmSNg6k
	eATBfpE4ENnfRZbg52NBVsQhWqViTERtFx3UCLtAxCxVcp3c2zmghPvO1txsx2iq/XCZtSTq3Jt
	aIqbdtzTWS08ZFqprpiqEzoMVwWlE4YOyb0172ZBICaHCBp4sg0T/j83ZwPCSTDRErScf+E2BCF
	5ffyZnF7qzJoBH6/27w+sD0eUKMIUWtMs2VfVQYIoo3OgZlNJC8cfjJu/IV9C19B/ney415DUYd
	ynbWgdD9cc4ORKUAj8uMZX8VtWpk5zKuuZRvI2VIgj1UVq
X-Google-Smtp-Source: AGHT+IFot2qjzVeWiBFgwlHh/92zvu6BeESvfCHb1Xh4NEVOw93szDJC3J99SMXWiI6L0J67PnZwFA==
X-Received: by 2002:a05:600c:8216:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-47d7f073134mr38820325e9.11.1767717370637;
        Tue, 06 Jan 2026 08:36:10 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:ca09:7000:33fc:5cce:3767:6b22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f686sm50967685e9.3.2026.01.06.08.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:36:09 -0800 (PST)
From: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Google-Original-From: "Ionut Nechita (WindRiver)" <ionut.nechita@windriver.com>
To: ming.lei@redhat.com
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	ionut.nechita@windriver.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] block: Fix WARN_ON in blk_mq_run_hw_queue when called from interrupt context
Date: Tue,  6 Jan 2026 18:35:13 +0200
Message-ID: <20260106163515.145571-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aV0kdKSvufPFflQ8@fedora>
References: <aV0kdKSvufPFflQ8@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Ming,

Thank you for the thorough review. You've identified critical issues with my analysis.

> There is so big change between 6.6.0-1-rt and 6.19, because Real-Time
> "PREEMPT_RT" Support Merged For Linux 6.12

You're absolutely right. I tested on Debian's 6.6.71-rt which uses the out-of-tree
RT patches. I will retest on Friday with both 6.12 (first kernel with merged RT
support) and linux-next to confirm whether this issue still exists in current upstream.

> Why is the above warning related with your patch?

After reviewing the complete dmesg log, I now see there are TWO separate errors
from the same process (PID 2041):

**Error #1** - Root cause (the one you highlighted):
```
BUG: scheduling while atomic: kworker/u385:1/2041/0x00000002
  mutex_lock
  → __cpuhp_state_add_instance
  → blk_mq_realloc_hw_ctxs
  → blk_mq_init_queue
  → scsi_alloc_sdev          ← Queue ALLOCATION
```

**Error #2** - Symptom (the one my patch addresses):
```
WARNING at blk_mq_run_hw_queue+0x1fa
  blk_mq_run_hw_queue
  → blk_mq_run_hw_queues
  → blk_queue_start_drain
  → blk_mq_destroy_queue
  → __scsi_remove_device
  → scsi_alloc_sdev          ← Queue DESTRUCTION (cleanup)
```

The sequence is:
1. Queue allocation in scsi_alloc_sdev() hits Error #1 (mutex in atomic context)
2. Allocation fails, enters cleanup path
3. Cleanup calls blk_mq_destroy_queue() while STILL in atomic context
4. blk_queue_start_drain() → blk_mq_run_hw_queues(q, false)
5. WARN_ON(!async && in_interrupt()) triggers → Error #2

> Or please share how preempt is disabled in the above blk_mq_run_hw_queues
> code path.

The atomic context (preempt_count = 0x00000002) is inherited from Error #1.
The code is already in atomic state when it enters the cleanup path.

> If you think the same issue exists on recent kernel, show the stack trace.

I don't have current data from upstream kernels. I will test on Friday and provide:
1. Results from 6.12-rt (first kernel with merged RT support)
2. Results from linux-next
3. Complete stack traces if the issue reproduces

If the issue still exists on current upstream, I need to address Error #1 (the
root cause) rather than Error #2 (the symptom). My current patch only suppresses
the warning during cleanup but doesn't fix the underlying atomic context problem.

I will report back with test results on Friday.

 - 

BUG: scheduling while atomic: kworker/u385:1/2041/0x00000002
Modules linked in:
CPU: 190 PID: 2041 Comm: kworker/u385:1 Not tainted 6.6.0-1-rt-amd64 #1  Debian 6.6.71-1
Hardware name: Dell Inc. PowerEdge R7615/09K9WP, BIOS 1.11.2 12/19/2024
Workqueue: events_unbound async_run_entry_fn
Call Trace:
 <TASK>
 dump_stack_lvl+0x37/0x50
 __schedule_bug+0x52/0x60
 __schedule+0x87d/0xb10
 rt_mutex_schedule+0x21/0x40
 rt_mutex_slowlock_block.constprop.0+0x33/0x170
 __rt_mutex_slowlock_locked.constprop.0+0xc4/0x1e0
 mutex_lock+0x44/0x60
 __cpuhp_state_add_instance_cpuslocked+0x41/0x110
 __cpuhp_state_add_instance+0x48/0xd0
 blk_mq_realloc_hw_ctxs+0x405/0x420
 blk_mq_init_allocated_queue+0x10a/0x480
intel_rapl_common: Found RAPL domain package
 ? srso_alias_return_thunk+0x5/0xfbef5
intel_rapl_common: Found RAPL domain core
 ? percpu_ref_init+0x6e/0x130
 blk_mq_init_queue+0x3c/0x70
 scsi_alloc_sdev+0x225/0x360
 scsi_probe_and_add_lun+0x8ac/0xc00
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? dev_set_name+0x57/0x80
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? attribute_container_add_device+0x4d/0x130
 __scsi_scan_target+0xf0/0x520
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? sched_clock_cpu+0x64/0x190
 scsi_scan_channel+0x57/0x90
 scsi_scan_host_selected+0xd4/0x110
 do_scan_async+0x1c/0x190
 async_run_entry_fn+0x2f/0x130
 process_one_work+0x175/0x370
 worker_thread+0x280/0x390
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xdd/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x31/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
gnss: GNSS driver registered with major 241
------------[ cut here ]------------
WARNING: CPU: 190 PID: 2041 at block/blk-mq.c:2291 blk_mq_run_hw_queue+0x1fa/0x260
Modules linked in:
CPU: 190 PID: 2041 Comm: kworker/u385:1 Tainted: G        W          6.6.0-1-rt-amd64 #1  Debian 6.6.71-1
Hardware name: Dell Inc. PowerEdge R7615/09K9WP, BIOS 1.11.2 12/19/2024
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:blk_mq_run_hw_queue+0x1fa/0x260
Code: ff 75 68 44 89 f6 e8 e5 45 c0 ff e9 ac fe ff ff e8 2b 70 c0 ff 48 89 ef e8 b3 a0 00 00 5b 5d 41 5c 41 5d 41 5e e9 26 9e c0 ff <0f> 0b e9 43 fe ff ff e8 0a 70 c0 ff 48 8b 85 d0 00 00 00 48 8b 80
RSP: 0018:ff630f098528fb98 EFLAGS: 00010206
RAX: 0000000000ff0000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000ff0000 RSI: 0000000000000000 RDI: ff3edc0247159400
RBP: ff3edc0247159400 R08: ff3edc0247159400 R09: ff630f098528fb60
R10: 0000000000000000 R11: 0000000045069ed3 R12: 0000000000000000
R13: ff3edc024715a828 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ff3edc10fd380000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000073961a001 CR4: 0000000000771ee0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn+0x89/0x140
 ? blk_mq_run_hw_queue+0x1fa/0x260
 ? report_bug+0x198/0x1b0
 ? handle_bug+0x53/0x90
 ? exc_invalid_op+0x18/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? blk_mq_run_hw_queue+0x1fa/0x260
 blk_mq_run_hw_queues+0x6c/0x130
 blk_queue_start_drain+0x12/0x40
 blk_mq_destroy_queue+0x37/0x70
 __scsi_remove_device+0x6a/0x180
 scsi_alloc_sdev+0x357/0x360
 scsi_probe_and_add_lun+0x8ac/0xc00
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? dev_set_name+0x57/0x80
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? attribute_container_add_device+0x4d/0x130
 __scsi_scan_target+0xf0/0x520
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? sched_clock_cpu+0x64/0x190
 scsi_scan_channel+0x57/0x90
 scsi_scan_host_selected+0xd4/0x110
 do_scan_async+0x1c/0x190
 async_run_entry_fn+0x2f/0x130
 process_one_work+0x175/0x370
 worker_thread+0x280/0x390
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xdd/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x31/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 190 PID: 2041 at kernel/time/timer.c:1570 __timer_delete_sync+0x152/0x170
Modules linked in:
CPU: 190 PID: 2041 Comm: kworker/u385:1 Tainted: G        W          6.6.0-1-rt-amd64 #1  Debian 6.6.71-1
Hardware name: Dell Inc. PowerEdge R7615/09K9WP, BIOS 1.11.2 12/19/2024
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:__timer_delete_sync+0x152/0x170
Code: 8b 04 24 4c 89 c7 e8 ad 11 b9 00 f0 ff 4d 30 4c 8b 04 24 4c 89 c7 e8 8d 03 b9 00 be 00 02 00 00 4c 89 ff e8 e0 83 f3 ff eb 93 <0f> 0b e9 e8 fe ff ff 49 8d 2c 16 eb a8 e8 5c 49 b8 00 66 66 2e 0f
RSP: 0018:ff630f098528fba8 EFLAGS: 00010246
RAX: 000000007fffffff RBX: ff3edc02829426d0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff3edc02829426d0
RBP: ff3edc02829425b0 R08: ff3edc0282942938 R09: ff630f098528fba0
R10: 0000000000000000 R11: 0000000045069ed3 R12: 0000000000000000
R13: ff3edc024715a828 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ff3edc10fd380000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000073961a001 CR4: 0000000000771ee0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn+0x89/0x140
 ? __timer_delete_sync+0x152/0x170
 ? report_bug+0x198/0x1b0
 ? handle_bug+0x53/0x90
 ? exc_invalid_op+0x18/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? __timer_delete_sync+0x152/0x170
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? percpu_ref_is_zero+0x3b/0x50
 ? srso_alias_return_thunk+0x5/0xfbef5
 blk_sync_queue+0x19/0x30
 blk_mq_destroy_queue+0x47/0x70
 __scsi_remove_device+0x6a/0x180
 scsi_alloc_sdev+0x357/0x360
 scsi_probe_and_add_lun+0x8ac/0xc00
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? dev_set_name+0x57/0x80
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? attribute_container_add_device+0x4d/0x130
 __scsi_scan_target+0xf0/0x520
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? sched_clock_cpu+0x64/0x190
 scsi_scan_channel+0x57/0x90
 scsi_scan_host_selected+0xd4/0x110
 do_scan_async+0x1c/0x190
 async_run_entry_fn+0x2f/0x130
 process_one_work+0x175/0x370
 worker_thread+0x280/0x390
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xdd/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x31/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
---[ end trace 0000000000000000 ]---
drop_monitor: Initializing network drop monitor service
------------[ cut here ]------------
WARNING: CPU: 190 PID: 2041 at kernel/time/timer.c:1570 __timer_delete_sync+0x152/0x170
Modules linked in:
CPU: 190 PID: 2041 Comm: kworker/u385:1 Tainted: G        W          6.6.0-1-rt-amd64 #1  Debian 6.6.71-1
Hardware name: Dell Inc. PowerEdge R7615/09K9WP, BIOS 1.11.2 12/19/2024
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:__timer_delete_sync+0x152/0x170
Code: 8b 04 24 4c 89 c7 e8 ad 11 b9 00 f0 ff 4d 30 4c 8b 04 24 4c 89 c7 e8 8d 03 b9 00 be 00 02 00 00 4c 89 ff e8 e0 83 f3 ff eb 93 <0f> 0b e9 e8 fe ff ff 49 8d 2c 16 eb a8 e8 5c 49 b8 00 66 66 2e 0f
RSP: 0018:ff630f098528fba8 EFLAGS: 00010246
RAX: 000000007fffffff RBX: ff3edc0282943790 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff3edc0282943790
RBP: ff3edc0282943670 R08: ff3edc02829439f8 R09: ff630f098528fba0
R10: 0000000000000000 R11: 00000000b3b80e06 R12: 0000000000000000
R13: ff3edc02828dc428 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ff3edc10fd380000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000073961a001 CR4: 0000000000771ee0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn+0x89/0x140
 ? __timer_delete_sync+0x152/0x170
 ? report_bug+0x198/0x1b0
 ? handle_bug+0x53/0x90
 ? exc_invalid_op+0x18/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? __timer_delete_sync+0x152/0x170
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? percpu_ref_is_zero+0x3b/0x50
 ? srso_alias_return_thunk+0x5/0xfbef5
 blk_sync_queue+0x19/0x30
 blk_mq_destroy_queue+0x47/0x70
 __scsi_remove_device+0x6a/0x180
 scsi_alloc_sdev+0x357/0x360
 scsi_probe_and_add_lun+0x8ac/0xc00
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? dev_set_name+0x57/0x80
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? attribute_container_add_device+0x4d/0x130
 __scsi_scan_target+0xf0/0x520
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? sched_clock_cpu+0x64/0x190
 scsi_scan_channel+0x57/0x90
 scsi_scan_host_selected+0xd4/0x110
 do_scan_async+0x1c/0x190
 async_run_entry_fn+0x2f/0x130
 process_one_work+0x175/0x370
 worker_thread+0x280/0x390
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xdd/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x31/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 190 PID: 2041 at kernel/time/timer.c:1570 __timer_delete_sync+0x152/0x170
Modules linked in:
CPU: 190 PID: 2041 Comm: kworker/u385:1 Tainted: G        W          6.6.0-1-rt-amd64 #1  Debian 6.6.71-1
Hardware name: Dell Inc. PowerEdge R7615/09K9WP, BIOS 1.11.2 12/19/2024
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:__timer_delete_sync+0x152/0x170
Code: 8b 04 24 4c 89 c7 e8 ad 11 b9 00 f0 ff 4d 30 4c 8b 04 24 4c 89 c7 e8 8d 03 b9 00 be 00 02 00 00 4c 89 ff e8 e0 83 f3 ff eb 93 <0f> 0b e9 e8 fe ff ff 49 8d 2c 16 eb a8 e8 5c 49 b8 00 66 66 2e 0f
RSP: 0018:ff630f098528fba8 EFLAGS: 00010246
RAX: 000000007fffffff RBX: ff3edc0282944420 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff3edc0282944420
RBP: ff3edc0282944300 R08: ff3edc0282944688 R09: ff630f098528fba0
R10: 0000000000000000 R11: 0000000043ba156d R12: 0000000000000000
R13: ff3edc02829ec028 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ff3edc10fd380000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000073961a001 CR4: 0000000000771ee0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn+0x89/0x140
 ? __timer_delete_sync+0x152/0x170
 ? report_bug+0x198/0x1b0
 ? handle_bug+0x53/0x90
 ? exc_invalid_op+0x18/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? __timer_delete_sync+0x152/0x170
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? percpu_ref_is_zero+0x3b/0x50
 ? srso_alias_return_thunk+0x5/0xfbef5
 blk_sync_queue+0x19/0x30
 blk_mq_destroy_queue+0x47/0x70
 __scsi_remove_device+0x6a/0x180
 scsi_alloc_sdev+0x357/0x360
 scsi_probe_and_add_lun+0x8ac/0xc00
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? dev_set_name+0x57/0x80
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? attribute_container_add_device+0x4d/0x130
 __scsi_scan_target+0xf0/0x520
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? sched_clock_cpu+0x64/0x190
 scsi_scan_channel+0x57/0x90
 scsi_scan_host_selected+0xd4/0x110
 do_scan_async+0x1c/0x190
 async_run_entry_fn+0x2f/0x130
 process_one_work+0x175/0x370
 worker_thread+0x280/0x390
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xdd/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x31/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
---[ end trace 0000000000000000 ]---
Initializing XFRM netlink socket


Thank you for the careful review,
Ionut
