Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C84BAA8
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010105; cv=none; b=b/pHExmMM6YfdTqT9wTtrW2p95iOl19oWjYdA/Q4pazdH/M5FSeBc5LuRkkE8ptXMXTdHYuYER9QzID4ZDjyR+MIXoS5n7F3ypKLij9Lu0T173shuGW6sP/XOhhzn9fL+zGCPCYg0vxBsZgHDKmzxgsEfJA9tiVE7xlgDGUnDG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010105; c=relaxed/simple;
	bh=rdY6o5KnzP2e1/vhxVI3SZd9vxfpL/4bNcumfI2Y3Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiXaLqIHv63O1hRNkpiq5cX9wKRyGc++iQ8YOHzYAaQ1j+ebaYJ6e5CztcD2upy6COkRizBhz6ID6pKwwOBKT8VEpBM4jv8xXPCNTQmQntEDRFgHmM7mF9iE188bOqwpUfqV1zUNV1kBrZe8iz/F7dIyXFBscRt7vt0t3121zwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.Ch9wL_1706010091;
Received: from 30.178.83.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.Ch9wL_1706010091)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 19:41:32 +0800
Message-ID: <2aabf106-d9e8-4e6f-a156-dc6b0fc62db4@linux.alibaba.com>
Date: Tue, 23 Jan 2024 19:41:30 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] test/nvme/050: test the reservation feature
Content-Language: en-GB
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240117081742.93941-1-kanie@linux.alibaba.com>
 <20240117081742.93941-3-kanie@linux.alibaba.com>
 <rfxc3j4jscw4jiivibr5mxdhn65yyh4f5g3gykypvpbcswpud6@gtpyfwidf7af>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <rfxc3j4jscw4jiivibr5mxdhn65yyh4f5g3gykypvpbcswpud6@gtpyfwidf7af>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/1/23 19:21, Shinichiro Kawasaki 写道:
> On Jan 17, 2024 / 16:17, Guixin Liu wrote:
>> Test the reservation feature, includes register, acquire, release
>> and report.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Thanks for this v2. I ran it with kernel side v4 patch [1], enabling lockdep.
> And I observed lockdep WARN [2]. For your reference, I attached the WARN at
> the end of this e-mail.
>
> [1] https://lore.kernel.org/linux-nvme/20240118125057.56200-2-kanie@linux.alibaba.com/
>
> This blktests patch looks almost good for me. Please find minor nit comments
> in line.
>
>> ---
>>   tests/nvme/050     |  96 ++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/050.out | 108 +++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 204 insertions(+)
>>   create mode 100644 tests/nvme/050
>>   create mode 100644 tests/nvme/050.out
>>
>> diff --git a/tests/nvme/050 b/tests/nvme/050
>> new file mode 100644
>> index 0000000..7e59de4
>> --- /dev/null
>> +++ b/tests/nvme/050
>> @@ -0,0 +1,96 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Guixin Liu
>> +# Copyright (C) 2024 Alibaba Group.
>> +#
>> +# Test the NVMe reservation feature
>> +#
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="test the reservation feature"
>> +QUICK=1
>> +
>> +requires() {
>> +	_nvme_requires
>> +}
>> +
>> +resv_report() {
>> +	local nvmedev=$1
>> +
>> +	if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
> It feels costly to call "resv-report --help" multiple times. I suggest to call
> it only once at the beginning of test_resv(). Based on the check result, a local
> variable can be set up and passed to resv_report().
OK, I will change it in v3.
>> +		nvme resv-report "/dev/${nvmedev}n1" --eds | grep -v "hostid"
>> +	else
>> +		nvme resv-report "/dev/${nvmedev}n1" --cdw11=1 | grep -v "hostid"
> The two lines above are almost same. I think they can be unified with the
> variable passed from the caller.
OK, I will change it in v3.
>
>> +	fi
>> +}
>> +
> [...]
>
> [2]
>
> run blktests nvme/050 at 2024-01-23 19:05:08
> nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
> nvme nvme1: creating 4 I/O queues.
> nvme nvme1: new ctrl: "blktests-subsystem-1"
> nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.7.0+ #142 Not tainted
> ------------------------------------------------------
> check/1061 is trying to acquire lock:
> ffff888139743a78 (&ns->pr.pr_lock){+.+.}-{3:3}, at: nvmet_pr_exit_ns+0x2e/0x230 [nvmet]
>
> but task is already holding lock:
> ffff888110cf7070 (&subsys->lock#2){+.+.}-{3:3}, at: nvmet_ns_disable+0x2a2/0x4a0 [nvmet]
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&subsys->lock#2){+.+.}-{3:3}:
>         __mutex_lock+0x185/0x18c0
>         nvmet_pr_send_resv_released+0x57/0x220 [nvmet]
>         nvmet_pr_preempt+0x651/0xc80 [nvmet]
>         nvmet_execute_pr_acquire+0x26f/0x5c0 [nvmet]
>         process_one_work+0x74c/0x1260
>         worker_thread+0x723/0x1300
>         kthread+0x2f1/0x3d0
>         ret_from_fork+0x30/0x70
>         ret_from_fork_asm+0x1b/0x30
>
> -> #0 (&ns->pr.pr_lock){+.+.}-{3:3}:
>         __lock_acquire+0x2e96/0x5f40
>         lock_acquire+0x1a9/0x4e0
>         __mutex_lock+0x185/0x18c0
>         nvmet_pr_exit_ns+0x2e/0x230 [nvmet]
>         nvmet_ns_disable+0x313/0x4a0 [nvmet]
>         nvmet_ns_enable_store+0x8a/0xe0 [nvmet]
>         configfs_write_iter+0x2ae/0x460
>         vfs_write+0x540/0xd90
>         ksys_write+0xf7/0x1d0
>         do_syscall_64+0x60/0xe0
>         entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> other info that might help us debug this:
>
> Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(&subsys->lock#2);
>                                 lock(&ns->pr.pr_lock);
>                                 lock(&subsys->lock#2);
>    lock(&ns->pr.pr_lock);
>
>   *** DEADLOCK ***
>
> 4 locks held by check/1061:
>   #0: ffff88813a8e8418 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0xf7/0x1d0
>   #1: ffff88811e893a88 (&buffer->mutex){+.+.}-{3:3}, at: configfs_write_iter+0x73/0x460
>   #2: ffff88812e673978 (&p->frag_sem){++++}-{3:3}, at: configfs_write_iter+0x1db/0x460
>   #3: ffff888110cf7070 (&subsys->lock#2){+.+.}-{3:3}, at: nvmet_ns_disable+0x2a2/0x4a0 [nvmet]
>
> stack backtrace:
> CPU: 0 PID: 1061 Comm: check Not tainted 6.7.0+ #142
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x57/0x90
>   check_noncircular+0x309/0x3f0
>   ? __pfx_check_noncircular+0x10/0x10
>   ? lockdep_lock+0xca/0x1c0
>   ? __pfx_lockdep_lock+0x10/0x10
>   ? lock_release+0x378/0x650
>   ? __stack_depot_save+0x246/0x470
>   __lock_acquire+0x2e96/0x5f40
>   ? __pfx___lock_acquire+0x10/0x10
>   lock_acquire+0x1a9/0x4e0
>   ? nvmet_pr_exit_ns+0x2e/0x230 [nvmet]
>   ? __pfx_lock_acquire+0x10/0x10
>   ? lock_is_held_type+0xce/0x120
>   ? __pfx_lock_acquire+0x10/0x10
>   ? __pfx___might_resched+0x10/0x10
>   __mutex_lock+0x185/0x18c0
>   ? nvmet_pr_exit_ns+0x2e/0x230 [nvmet]
>   ? nvmet_pr_exit_ns+0x2e/0x230 [nvmet]
>   ? rcu_is_watching+0x11/0xb0
>   ? __mutex_lock+0x2a2/0x18c0
>   ? __pfx___mutex_lock+0x10/0x10
>   ? nvmet_pr_exit_ns+0x2e/0x230 [nvmet]
>   nvmet_pr_exit_ns+0x2e/0x230 [nvmet]
>   nvmet_ns_disable+0x313/0x4a0 [nvmet]
>   ? __pfx_nvmet_ns_disable+0x10/0x10 [nvmet]
>   nvmet_ns_enable_store+0x8a/0xe0 [nvmet]
>   ? __pfx_nvmet_ns_enable_store+0x10/0x10 [nvmet]
>   configfs_write_iter+0x2ae/0x460
>   vfs_write+0x540/0xd90
>   ? __pfx_vfs_write+0x10/0x10
>   ? __pfx___lock_acquire+0x10/0x10
>   ? __handle_mm_fault+0x12c5/0x1870
>   ? __fget_light+0x51/0x220
>   ksys_write+0xf7/0x1d0
>   ? __pfx_ksys_write+0x10/0x10
>   ? syscall_enter_from_user_mode+0x22/0x90
>   do_syscall_64+0x60/0xe0
>   ? __pfx_lock_release+0x10/0x10
>   ? count_memcg_events.constprop.0+0x4a/0x60
>   ? handle_mm_fault+0x1b1/0x9d0
>   ? exc_page_fault+0xc0/0x100
>   ? rcu_is_watching+0x11/0xb0
>   ? asm_exc_page_fault+0x22/0x30
>   ? lockdep_hardirqs_on+0x7d/0x100
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
> RIP: 0033:0x7f604525ac34
> Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 35 77 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
> RSP: 002b:00007ffec7fd6ce8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f604525ac34
> RDX: 0000000000000002 RSI: 0000562b0cd805a0 RDI: 0000000000000001
> RBP: 00007ffec7fd6d10 R08: 0000000000001428 R09: 0000000100000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> R13: 0000562b0cd805a0 R14: 00007f604532b5c0 R15: 00007f6045328f20
>   </TASK>

Thanks a lot, I will fix this in my reservation patch set v5.

Best regards,

Guixin Liu

