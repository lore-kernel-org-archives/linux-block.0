Received: from server.eikel.org (server.eikel.org [178.77.101.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47E36E46D;
	Thu,  2 Apr 2026 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.77.101.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115348; cv=none; b=XzaLNFNL9AmLZTgnHSqBF/bR+XCfxf18u2vAL+aOg6yhFjMq72Pf05soBxH2wpZzQSicIYS3SXHjfgQ0kcMBluymUrI4MnQLnoqryLPyMb1IDKeu2SJ5gwdzW0qrUj42mKRCPGPUQ76OA1c3lJSsTq83OHoWwBv5G04XFRO9Cfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115348; c=relaxed/simple;
	bh=nYSAM2Lnu7FC6QuM/PLeRVuEp7nXU1kzgI4FP6N3wpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wm+z2NA0XT9iGAJqn2iG8b70AZ5KWFjjPd4VIB5s22jfOx/53LRz+GaiFayrunZ7tTDciPLf+G3Ada0kv60sTROSw6d+y3Tm2dmMwajATCyIl3Uu/qs+31Tp3lMFItt5mw8HkK74VeiTCFYlh5YlDWV/psLkYGyYmQqfyx+Ba7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eikel.org; spf=fail smtp.mailfrom=eikel.org; dkim=pass (1024-bit key) header.d=eikel.org header.i=@eikel.org header.b=cnkmK14W; arc=none smtp.client-ip=178.77.101.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eikel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=eikel.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eikel.org header.i=@eikel.org header.b="cnkmK14W"
Received: from thinkpad-benjamin.localnet (p200300fd1f05f100447f61f950b53eb3.dip0.t-ipconnect.de [IPv6:2003:fd:1f05:f100:447f:61f9:50b5:3eb3])
	by server.eikel.org (Postfix) with ESMTPSA id 6D78B1F631;
	Thu,  2 Apr 2026 09:35:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eikel.org;
	s=default; t=1775115336;
	bh=Eg2xsA2S2/jK9mgFSfOI1p5EFNHsaOXxfZPgvuVWqTk=; h=From:To:Subject;
	b=cnkmK14W6S/hou5wBZrfiIJx9bt0vDCahJ7yVSM3aw+ecgpuF9vLjTrk3Eau0W2Kr
	 Smeays2VP5Pkl/O23LXGdRO8mFpozRcG3+GB+yfpsI1DKgHZwP51RuYh/QNM6s4ZUb
	 42Q6B9tJux7RA1rwlHbRJRA49BOr8XD2DkKUwBm0=
Authentication-Results: server.eikel.org;
        spf=pass (sender IP is 2003:fd:1f05:f100:447f:61f9:50b5:3eb3) smtp.mailfrom=debian@eikel.org smtp.helo=thinkpad-benjamin.localnet
Received-SPF: pass (server.eikel.org: connection is authenticated)
From: Benjamin Eikel <debian@eikel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
Subject: 
 Re: [BUG] RCU stall in blk_mq_timeout_work (potentially a regression in
 6.19.7 or 6.19.8)
Date: Thu, 02 Apr 2026 09:33:42 +0200
Message-ID: <5090885.31r3eYUQgx@thinkpad-benjamin>
In-Reply-To: <b9262818-14e7-4902-af6c-6c7d3560ac4c@leemhuis.info>
References: 
 <21608811.f9utdCOAlc@thinkpad-benjamin>
 <b9262818-14e7-4902-af6c-6c7d3560ac4c@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Thorsten and others,

Am Dienstag, 31. M=C3=A4rz 2026, 10:32:30 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Thorsten Leemhuis:
> [CCing the regressions list and Jens, the Block layer maintainer, who
> might have an idea what's wrong here and/or how to best debug it]
>=20
> On 3/27/26 20:28, Benjamin Eikel wrote:
> > Dear Linux kernel developers,
> >=20
> > I experience repeated RCU stalls in blk_mq_timeout_work causing system
> > freezes. The NVMe drive (more info at the end) shows no errors or
> > controller resets in the kernel log: the hardware appears healthy. No I=
/O
> > timeout messages precede the stalls.
> >=20
> > The stall cascades: khugepaged blocks on __lru_add_drain_all waiting fo=
r a
> > workqueue flush that cannot complete, and additional kworkers block on a
> > mutex held by the kblockd rescuer thread. The system becomes noticeably
> > unresponsive and then I notice it in the logs.
> >=20
> > In case the logs are too condensed, please tell me and I can provide th=
em
> > fully. If you have pointers on how this could be reproduced and a commit
> > range,>=20
> >  I could try to bisect the problem.
>=20
> A bisection with mainline would help a lot. Maybe doing it between
> 6.19.6 and 6.19.8 (which would be quicker) might work out, too (but
> normally it's best to focus on mainline).

I have not yet done this because I do not have a reliable way to reproduce =
it.

>=20
> And this is not my area of expertise, but I noticed that some RCU fixes
> went into -rc6, so might be wise to try that first.

I encountered this issue with -rc6 (see log below, same config). I suspect =
that
this only happens after the notebook has previously been suspended.

Kind regards
Benjamin

=3D=3D Trace from Linux version 7.0.0-rc6 (1=E2=80=932 April) =3D=3D

Apr 01 20:36:59 thinkpad-benjamin kernel: Linux version 7.0.0-rc6-70-rc6 (b=
enjamin@thinkpad-benjamin) (gcc (Debian 15.2.0-16) 15.2.0, GNU ld (GNU Binu=
tils for Debian) 2.46) #24 SMP PREEMPT_DYNAMIC Tue Mar 31 14:36:43 CEST 2026
Apr 01 20:36:59 thinkpad-benjamin kernel: Command line: BOOT_IMAGE=3D/vmlin=
uz-7.0.0-rc6-70-rc6 root=3D/dev/mapper/thinkpad--benjamin--vg-root ro quiet
[=E2=80=A6]
Apr 01 21:06:54 thinkpad-benjamin kernel: PM: suspend entry (s2idle)
[=E2=80=A6]
Apr 02 08:44:55 thinkpad-benjamin kernel: PM: suspend exit
[=E2=80=A6]
Apr 02 08:50:59 thinkpad-benjamin kernel: INFO: task khugepaged:138 blocked=
 for more than 120 seconds.
Apr 02 08:50:59 thinkpad-benjamin kernel:       Not tainted 7.0.0-rc6-70-rc=
6 #24
Apr 02 08:50:59 thinkpad-benjamin kernel: "echo 0 > /proc/sys/kernel/hung_t=
ask_timeout_secs" disables this message.
Apr 02 08:50:59 thinkpad-benjamin kernel: task:khugepaged      state:D stac=
k:0     pid:138   tgid:138   ppid:2      task_flags:0x200040 flags:0x000800=
00
Apr 02 08:50:59 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:50:59 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:50:59 thinkpad-benjamin kernel:  __schedule+0x47c/0x1000
Apr 02 08:50:59 thinkpad-benjamin kernel:  schedule+0x27/0xd0
Apr 02 08:50:59 thinkpad-benjamin kernel:  schedule_timeout+0xbd/0x100
Apr 02 08:50:59 thinkpad-benjamin kernel:  wait_for_completion+0x8a/0x140
Apr 02 08:50:59 thinkpad-benjamin kernel:  __flush_work+0x276/0x3b0
Apr 02 08:50:59 thinkpad-benjamin kernel:  ? __pfx_wq_barrier_func+0x10/0x10
Apr 02 08:50:59 thinkpad-benjamin kernel:  __lru_add_drain_all+0x198/0x2b0
Apr 02 08:50:59 thinkpad-benjamin kernel:  khugepaged+0x65/0x950
Apr 02 08:50:59 thinkpad-benjamin kernel:  ? __pfx_autoremove_wake_function=
+0x10/0x10
Apr 02 08:50:59 thinkpad-benjamin kernel:  ? __pfx_khugepaged+0x10/0x10
Apr 02 08:50:59 thinkpad-benjamin kernel:  kthread+0xe3/0x120
Apr 02 08:50:59 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:50:59 thinkpad-benjamin kernel:  ret_from_fork+0x2c9/0x360
Apr 02 08:50:59 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:50:59 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 08:50:59 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:53:00 thinkpad-benjamin kernel: INFO: task khugepaged:138 blocked=
 for more than 241 seconds.
Apr 02 08:53:00 thinkpad-benjamin kernel:       Not tainted 7.0.0-rc6-70-rc=
6 #24
Apr 02 08:53:00 thinkpad-benjamin kernel: "echo 0 > /proc/sys/kernel/hung_t=
ask_timeout_secs" disables this message.
Apr 02 08:53:00 thinkpad-benjamin kernel: task:khugepaged      state:D stac=
k:0     pid:138   tgid:138   ppid:2      task_flags:0x200040 flags:0x000800=
00
Apr 02 08:53:00 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:53:00 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:53:00 thinkpad-benjamin kernel:  __schedule+0x47c/0x1000
Apr 02 08:53:00 thinkpad-benjamin kernel:  schedule+0x27/0xd0
Apr 02 08:53:00 thinkpad-benjamin kernel:  schedule_timeout+0xbd/0x100
Apr 02 08:53:00 thinkpad-benjamin kernel:  wait_for_completion+0x8a/0x140
Apr 02 08:53:00 thinkpad-benjamin kernel:  __flush_work+0x276/0x3b0
Apr 02 08:53:00 thinkpad-benjamin kernel:  ? __pfx_wq_barrier_func+0x10/0x10
Apr 02 08:53:00 thinkpad-benjamin kernel:  __lru_add_drain_all+0x198/0x2b0
Apr 02 08:53:00 thinkpad-benjamin kernel:  khugepaged+0x65/0x950
Apr 02 08:53:00 thinkpad-benjamin kernel:  ? __pfx_autoremove_wake_function=
+0x10/0x10
Apr 02 08:53:00 thinkpad-benjamin kernel:  ? __pfx_khugepaged+0x10/0x10
Apr 02 08:53:00 thinkpad-benjamin kernel:  kthread+0xe3/0x120
Apr 02 08:53:00 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:53:00 thinkpad-benjamin kernel:  ret_from_fork+0x2c9/0x360
Apr 02 08:53:00 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:53:00 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 08:53:00 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:55:00 thinkpad-benjamin kernel: INFO: task khugepaged:138 blocked=
 for more than 362 seconds.
Apr 02 08:55:00 thinkpad-benjamin kernel:       Not tainted 7.0.0-rc6-70-rc=
6 #24
Apr 02 08:55:00 thinkpad-benjamin kernel: "echo 0 > /proc/sys/kernel/hung_t=
ask_timeout_secs" disables this message.
Apr 02 08:55:00 thinkpad-benjamin kernel: task:khugepaged      state:D stac=
k:0     pid:138   tgid:138   ppid:2      task_flags:0x200040 flags:0x000800=
00
Apr 02 08:55:00 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:55:00 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:55:00 thinkpad-benjamin kernel:  __schedule+0x47c/0x1000
Apr 02 08:55:00 thinkpad-benjamin kernel:  schedule+0x27/0xd0
Apr 02 08:55:00 thinkpad-benjamin kernel:  schedule_timeout+0xbd/0x100
Apr 02 08:55:00 thinkpad-benjamin kernel:  wait_for_completion+0x8a/0x140
Apr 02 08:55:00 thinkpad-benjamin kernel:  __flush_work+0x276/0x3b0
Apr 02 08:55:00 thinkpad-benjamin kernel:  ? __pfx_wq_barrier_func+0x10/0x10
Apr 02 08:55:00 thinkpad-benjamin kernel:  __lru_add_drain_all+0x198/0x2b0
Apr 02 08:55:00 thinkpad-benjamin kernel:  khugepaged+0x65/0x950
Apr 02 08:55:00 thinkpad-benjamin kernel:  ? __pfx_autoremove_wake_function=
+0x10/0x10
Apr 02 08:55:00 thinkpad-benjamin kernel:  ? __pfx_khugepaged+0x10/0x10
Apr 02 08:55:00 thinkpad-benjamin kernel:  kthread+0xe3/0x120
Apr 02 08:55:00 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:55:00 thinkpad-benjamin kernel:  ret_from_fork+0x2c9/0x360
Apr 02 08:55:00 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:55:00 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 08:55:00 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:57:01 thinkpad-benjamin kernel: INFO: task khugepaged:138 blocked=
 for more than 483 seconds.
Apr 02 08:57:01 thinkpad-benjamin kernel:       Not tainted 7.0.0-rc6-70-rc=
6 #24
Apr 02 08:57:01 thinkpad-benjamin kernel: "echo 0 > /proc/sys/kernel/hung_t=
ask_timeout_secs" disables this message.
Apr 02 08:57:01 thinkpad-benjamin kernel: task:khugepaged      state:D stac=
k:0     pid:138   tgid:138   ppid:2      task_flags:0x200040 flags:0x000800=
00
Apr 02 08:57:01 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:57:01 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:57:01 thinkpad-benjamin kernel:  __schedule+0x47c/0x1000
Apr 02 08:57:01 thinkpad-benjamin kernel:  schedule+0x27/0xd0
Apr 02 08:57:01 thinkpad-benjamin kernel:  schedule_timeout+0xbd/0x100
Apr 02 08:57:01 thinkpad-benjamin kernel:  wait_for_completion+0x8a/0x140
Apr 02 08:57:01 thinkpad-benjamin kernel:  __flush_work+0x276/0x3b0
Apr 02 08:57:01 thinkpad-benjamin kernel:  ? __pfx_wq_barrier_func+0x10/0x10
Apr 02 08:57:01 thinkpad-benjamin kernel:  __lru_add_drain_all+0x198/0x2b0
Apr 02 08:57:01 thinkpad-benjamin kernel:  khugepaged+0x65/0x950
Apr 02 08:57:01 thinkpad-benjamin kernel:  ? __pfx_autoremove_wake_function=
+0x10/0x10
Apr 02 08:57:01 thinkpad-benjamin kernel:  ? __pfx_khugepaged+0x10/0x10
Apr 02 08:57:01 thinkpad-benjamin kernel:  kthread+0xe3/0x120
Apr 02 08:57:01 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:57:01 thinkpad-benjamin kernel:  ret_from_fork+0x2c9/0x360
Apr 02 08:57:01 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:57:01 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 08:57:01 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel: INFO: task kworker/u64:14:126 blo=
cked for more than 120 seconds.
Apr 02 08:59:02 thinkpad-benjamin kernel:       Not tainted 7.0.0-rc6-70-rc=
6 #24
Apr 02 08:59:02 thinkpad-benjamin kernel: "echo 0 > /proc/sys/kernel/hung_t=
ask_timeout_secs" disables this message.
Apr 02 08:59:02 thinkpad-benjamin kernel: task:kworker/u64:14  state:D stac=
k:0     pid:126   tgid:126   ppid:2      task_flags:0x4208060 flags:0x00080=
000
Apr 02 08:59:02 thinkpad-benjamin kernel: Workqueue: events_unbound idle_cu=
ll_fn
Apr 02 08:59:02 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:59:02 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel:  __schedule+0x47c/0x1000
Apr 02 08:59:02 thinkpad-benjamin kernel:  schedule+0x27/0xd0
Apr 02 08:59:02 thinkpad-benjamin kernel:  schedule_preempt_disabled+0x15/0=
x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  __mutex_lock.constprop.0+0x54b/0=
xac0
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? ttwu_queue_wakelist+0x13c/0x230
Apr 02 08:59:02 thinkpad-benjamin kernel:  idle_cull_fn+0x3e/0x170
Apr 02 08:59:02 thinkpad-benjamin kernel:  process_one_work+0x19d/0x3a0
Apr 02 08:59:02 thinkpad-benjamin kernel:  worker_thread+0x1af/0x320
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_worker_thread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  kthread+0xe3/0x120
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork+0x2c9/0x360
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel: INFO: task kworker/u64:14:126 is =
blocked on a mutex likely owned by task kworker/R-kbloc:139.
Apr 02 08:59:02 thinkpad-benjamin kernel: task:kworker/R-kbloc state:R  run=
ning task     stack:0     pid:139   tgid:139   ppid:2      task_flags:0x420=
8060 flags:0x00080000
Apr 02 08:59:02 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:59:02 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel:  __schedule+0x47c/0x1000
Apr 02 08:59:02 thinkpad-benjamin kernel:  preempt_schedule_irq+0x38/0x60
Apr 02 08:59:02 thinkpad-benjamin kernel:  asm_common_interrupt+0x26/0x40
Apr 02 08:59:02 thinkpad-benjamin kernel: RIP: 0010:affine_move_task+0x198/=
0x580
Apr 02 08:59:02 thinkpad-benjamin kernel: Code: 00 49 8b 36 48 8d bb ec 0d =
00 00 e8 22 8a d9 00 45 85 ff 44 8b 04 24 0f 84 21 02 00 00 65 ff 0d 4e 73 =
8b 02 0f 84 6f 03 00 00 <41> 83 e0 04 49 8d 7c 24 08 75 3e e8 18 09 d9 00 b=
8 ff ff ff ff f0
Apr 02 08:59:02 thinkpad-benjamin kernel: RSP: 0018:ffffcc5f4063fcd8 EFLAGS=
: 00000246
Apr 02 08:59:02 thinkpad-benjamin kernel: RAX: 0000000000000001 RBX: ffff8a=
f641ab2180 RCX: 0000000000000004
Apr 02 08:59:02 thinkpad-benjamin kernel: RDX: 0000000000000000 RSI: 000000=
0000000283 RDI: ffff8af640c08dec
Apr 02 08:59:02 thinkpad-benjamin kernel: RBP: ffff8b04a1eb2100 R08: 000000=
0000000000 R09: 0000000000000283
Apr 02 08:59:02 thinkpad-benjamin kernel: R10: 0000000000000002 R11: 000000=
0000000000 R12: ffffcc5f4063fd28
Apr 02 08:59:02 thinkpad-benjamin kernel: R13: ffffcc5f4063fd28 R14: ffffcc=
5f4063fde0 R15: 0000000000000000
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? affine_move_task+0x50c/0x580
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? srso_alias_return_thunk+0x5/0x=
fbef5
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? set_next_entity+0xe7/0x270
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_migration_cpu_stop+0x10/=
0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? affine_move_task+0x3c8/0x580
Apr 02 08:59:02 thinkpad-benjamin kernel:  __set_cpus_allowed_ptr+0x66/0xc0
Apr 02 08:59:02 thinkpad-benjamin kernel:  set_cpus_allowed_ptr+0x3a/0x60
Apr 02 08:59:02 thinkpad-benjamin kernel:  worker_attach_to_pool+0x5f/0xd0
Apr 02 08:59:02 thinkpad-benjamin kernel:  rescuer_thread+0x12d/0x5d0
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_rescuer_thread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  kthread+0xe3/0x120
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork+0x2c9/0x360
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel: INFO: task khugepaged:138 blocked=
 for more than 604 seconds.
Apr 02 08:59:02 thinkpad-benjamin kernel:       Not tainted 7.0.0-rc6-70-rc=
6 #24
Apr 02 08:59:02 thinkpad-benjamin kernel: "echo 0 > /proc/sys/kernel/hung_t=
ask_timeout_secs" disables this message.
Apr 02 08:59:02 thinkpad-benjamin kernel: task:khugepaged      state:D stac=
k:0     pid:138   tgid:138   ppid:2      task_flags:0x200040 flags:0x000800=
00
Apr 02 08:59:02 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:59:02 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel:  __schedule+0x47c/0x1000
Apr 02 08:59:02 thinkpad-benjamin kernel:  schedule+0x27/0xd0
Apr 02 08:59:02 thinkpad-benjamin kernel:  schedule_timeout+0xbd/0x100
Apr 02 08:59:02 thinkpad-benjamin kernel:  wait_for_completion+0x8a/0x140
Apr 02 08:59:02 thinkpad-benjamin kernel:  __flush_work+0x276/0x3b0
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_wq_barrier_func+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  __lru_add_drain_all+0x198/0x2b0
Apr 02 08:59:02 thinkpad-benjamin kernel:  khugepaged+0x65/0x950
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_autoremove_wake_function=
+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_khugepaged+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  kthread+0xe3/0x120
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork+0x2c9/0x360
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel: INFO: task kworker/u64:16:5369 bl=
ocked for more than 120 seconds.
Apr 02 08:59:02 thinkpad-benjamin kernel:       Not tainted 7.0.0-rc6-70-rc=
6 #24
Apr 02 08:59:02 thinkpad-benjamin kernel: "echo 0 > /proc/sys/kernel/hung_t=
ask_timeout_secs" disables this message.
Apr 02 08:59:02 thinkpad-benjamin kernel: task:kworker/u64:16  state:D stac=
k:0     pid:5369  tgid:5369  ppid:2      task_flags:0x4208060 flags:0x00080=
000
Apr 02 08:59:02 thinkpad-benjamin kernel: Workqueue: events_unbound idle_cu=
ll_fn
Apr 02 08:59:02 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:59:02 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel:  __schedule+0x47c/0x1000
Apr 02 08:59:02 thinkpad-benjamin kernel:  schedule+0x27/0xd0
Apr 02 08:59:02 thinkpad-benjamin kernel:  schedule_preempt_disabled+0x15/0=
x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  __mutex_lock.constprop.0+0x54b/0=
xac0
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? finish_task_switch.isra.0+0x96=
/0x2c0
Apr 02 08:59:02 thinkpad-benjamin kernel:  idle_cull_fn+0x3e/0x170
Apr 02 08:59:02 thinkpad-benjamin kernel:  process_one_work+0x19d/0x3a0
Apr 02 08:59:02 thinkpad-benjamin kernel:  worker_thread+0x1af/0x320
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_worker_thread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  kthread+0xe3/0x120
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork+0x2c9/0x360
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel: INFO: task kworker/u64:16:5369 is=
 blocked on a mutex likely owned by task kworker/R-kbloc:139.
Apr 02 08:59:02 thinkpad-benjamin kernel: task:kworker/R-kbloc state:R  run=
ning task     stack:0     pid:139   tgid:139   ppid:2      task_flags:0x420=
8060 flags:0x00080000
Apr 02 08:59:02 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:59:02 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __schedule+0x484/0x1000
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? preempt_schedule_irq+0x38/0x60
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? asm_common_interrupt+0x26/0x40
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? affine_move_task+0x198/0x580
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? affine_move_task+0x50c/0x580
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? srso_alias_return_thunk+0x5/0x=
fbef5
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? set_next_entity+0xe7/0x270
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_migration_cpu_stop+0x10/=
0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? affine_move_task+0x3c8/0x580
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __set_cpus_allowed_ptr+0x66/0x=
c0
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? set_cpus_allowed_ptr+0x3a/0x60
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? worker_attach_to_pool+0x5f/0xd0
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? rescuer_thread+0x12d/0x5d0
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_rescuer_thread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? kthread+0xe3/0x120
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? ret_from_fork+0x2c9/0x360
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? ret_from_fork_asm+0x1a/0x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel: INFO: task kworker/u64:12:9088 bl=
ocked for more than 120 seconds.
Apr 02 08:59:02 thinkpad-benjamin kernel:       Not tainted 7.0.0-rc6-70-rc=
6 #24
Apr 02 08:59:02 thinkpad-benjamin kernel: "echo 0 > /proc/sys/kernel/hung_t=
ask_timeout_secs" disables this message.
Apr 02 08:59:02 thinkpad-benjamin kernel: task:kworker/u64:12  state:D stac=
k:0     pid:9088  tgid:9088  ppid:2      task_flags:0x4208060 flags:0x00080=
000
Apr 02 08:59:02 thinkpad-benjamin kernel: Workqueue: events_unbound idle_cu=
ll_fn
Apr 02 08:59:02 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:59:02 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel:  __schedule+0x47c/0x1000
Apr 02 08:59:02 thinkpad-benjamin kernel:  schedule+0x27/0xd0
Apr 02 08:59:02 thinkpad-benjamin kernel:  schedule_preempt_disabled+0x15/0=
x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  __mutex_lock.constprop.0+0x54b/0=
xac0
Apr 02 08:59:02 thinkpad-benjamin kernel:  idle_cull_fn+0x3e/0x170
Apr 02 08:59:02 thinkpad-benjamin kernel:  process_one_work+0x19d/0x3a0
Apr 02 08:59:02 thinkpad-benjamin kernel:  worker_thread+0x1af/0x320
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_worker_thread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  kthread+0xe3/0x120
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork+0x2c9/0x360
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel: INFO: task kworker/u64:12:9088 is=
 blocked on a mutex likely owned by task kworker/R-kbloc:139.
Apr 02 08:59:02 thinkpad-benjamin kernel: task:kworker/R-kbloc state:R  run=
ning task     stack:0     pid:139   tgid:139   ppid:2      task_flags:0x420=
8060 flags:0x00080000
Apr 02 08:59:02 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:59:02 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel:  __schedule+0x47c/0x1000
Apr 02 08:59:02 thinkpad-benjamin kernel:  preempt_schedule_irq+0x38/0x60
Apr 02 08:59:02 thinkpad-benjamin kernel:  asm_common_interrupt+0x26/0x40
Apr 02 08:59:02 thinkpad-benjamin kernel: RIP: 0010:affine_move_task+0x198/=
0x580
Apr 02 08:59:02 thinkpad-benjamin kernel: Code: 00 49 8b 36 48 8d bb ec 0d =
00 00 e8 22 8a d9 00 45 85 ff 44 8b 04 24 0f 84 21 02 00 00 65 ff 0d 4e 73 =
8b 02 0f 84 6f 03 00 00 <41> 83 e0 04 49 8d 7c 24 08 75 3e e8 18 09 d9 00 b=
8 ff ff ff ff f0
Apr 02 08:59:02 thinkpad-benjamin kernel: RSP: 0018:ffffcc5f4063fcd8 EFLAGS=
: 00000246
Apr 02 08:59:02 thinkpad-benjamin kernel: RAX: 0000000000000001 RBX: ffff8a=
f641ab2180 RCX: 0000000000000004
Apr 02 08:59:02 thinkpad-benjamin kernel: RDX: 0000000000000000 RSI: 000000=
0000000283 RDI: ffff8af640c08dec
Apr 02 08:59:02 thinkpad-benjamin kernel: RBP: ffff8b04a1eb2100 R08: 000000=
0000000000 R09: 0000000000000283
Apr 02 08:59:02 thinkpad-benjamin kernel: R10: 0000000000000002 R11: 000000=
0000000000 R12: ffffcc5f4063fd28
Apr 02 08:59:02 thinkpad-benjamin kernel: R13: ffffcc5f4063fd28 R14: ffffcc=
5f4063fde0 R15: 0000000000000000
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? affine_move_task+0x50c/0x580
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? srso_alias_return_thunk+0x5/0x=
fbef5
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? set_next_entity+0xe7/0x270
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_migration_cpu_stop+0x10/=
0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? affine_move_task+0x3c8/0x580
Apr 02 08:59:02 thinkpad-benjamin kernel:  __set_cpus_allowed_ptr+0x66/0xc0
Apr 02 08:59:02 thinkpad-benjamin kernel:  set_cpus_allowed_ptr+0x3a/0x60
Apr 02 08:59:02 thinkpad-benjamin kernel:  worker_attach_to_pool+0x5f/0xd0
Apr 02 08:59:02 thinkpad-benjamin kernel:  rescuer_thread+0x12d/0x5d0
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_rescuer_thread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  kthread+0xe3/0x120
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork+0x2c9/0x360
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel: INFO: task kworker/u64:22:10249 b=
locked for more than 120 seconds.
Apr 02 08:59:02 thinkpad-benjamin kernel:       Not tainted 7.0.0-rc6-70-rc=
6 #24
Apr 02 08:59:02 thinkpad-benjamin kernel: "echo 0 > /proc/sys/kernel/hung_t=
ask_timeout_secs" disables this message.
Apr 02 08:59:02 thinkpad-benjamin kernel: task:kworker/u64:22  state:D stac=
k:0     pid:10249 tgid:10249 ppid:2      task_flags:0x4208060 flags:0x00080=
000
Apr 02 08:59:02 thinkpad-benjamin kernel: Workqueue: events_unbound idle_cu=
ll_fn
Apr 02 08:59:02 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:59:02 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel:  __schedule+0x47c/0x1000
Apr 02 08:59:02 thinkpad-benjamin kernel:  schedule+0x27/0xd0
Apr 02 08:59:02 thinkpad-benjamin kernel:  schedule_preempt_disabled+0x15/0=
x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  __mutex_lock.constprop.0+0x54b/0=
xac0
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? finish_task_switch.isra.0+0x96=
/0x2c0
Apr 02 08:59:02 thinkpad-benjamin kernel:  idle_cull_fn+0x3e/0x170
Apr 02 08:59:02 thinkpad-benjamin kernel:  process_one_work+0x19d/0x3a0
Apr 02 08:59:02 thinkpad-benjamin kernel:  worker_thread+0x1af/0x320
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_worker_thread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  kthread+0xe3/0x120
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork+0x2c9/0x360
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel: INFO: task kworker/u64:22:10249 i=
s blocked on a mutex likely owned by task kworker/R-kbloc:139.
Apr 02 08:59:02 thinkpad-benjamin kernel: task:kworker/R-kbloc state:R  run=
ning task     stack:0     pid:139   tgid:139   ppid:2      task_flags:0x420=
8060 flags:0x00080000
Apr 02 08:59:02 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:59:02 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel:  __schedule+0x47c/0x1000
Apr 02 08:59:02 thinkpad-benjamin kernel:  preempt_schedule_irq+0x38/0x60
Apr 02 08:59:02 thinkpad-benjamin kernel:  asm_common_interrupt+0x26/0x40
Apr 02 08:59:02 thinkpad-benjamin kernel: RIP: 0010:affine_move_task+0x198/=
0x580
Apr 02 08:59:02 thinkpad-benjamin kernel: Code: 00 49 8b 36 48 8d bb ec 0d =
00 00 e8 22 8a d9 00 45 85 ff 44 8b 04 24 0f 84 21 02 00 00 65 ff 0d 4e 73 =
8b 02 0f 84 6f 03 00 00 <41> 83 e0 04 49 8d 7c 24 08 75 3e e8 18 09 d9 00 b=
8 ff ff ff ff f0
Apr 02 08:59:02 thinkpad-benjamin kernel: RSP: 0018:ffffcc5f4063fcd8 EFLAGS=
: 00000246
Apr 02 08:59:02 thinkpad-benjamin kernel: RAX: 0000000000000001 RBX: ffff8a=
f641ab2180 RCX: 0000000000000004
Apr 02 08:59:02 thinkpad-benjamin kernel: RDX: 0000000000000000 RSI: 000000=
0000000283 RDI: ffff8af640c08dec
Apr 02 08:59:02 thinkpad-benjamin kernel: RBP: ffff8b04a1eb2100 R08: 000000=
0000000000 R09: 0000000000000283
Apr 02 08:59:02 thinkpad-benjamin kernel: R10: 0000000000000002 R11: 000000=
0000000000 R12: ffffcc5f4063fd28
Apr 02 08:59:02 thinkpad-benjamin kernel: R13: ffffcc5f4063fd28 R14: ffffcc=
5f4063fde0 R15: 0000000000000000
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? affine_move_task+0x50c/0x580
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? srso_alias_return_thunk+0x5/0x=
fbef5
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? set_next_entity+0xe7/0x270
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_migration_cpu_stop+0x10/=
0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? affine_move_task+0x3c8/0x580
Apr 02 08:59:02 thinkpad-benjamin kernel:  __set_cpus_allowed_ptr+0x66/0xc0
Apr 02 08:59:02 thinkpad-benjamin kernel:  set_cpus_allowed_ptr+0x3a/0x60
Apr 02 08:59:02 thinkpad-benjamin kernel:  worker_attach_to_pool+0x5f/0xd0
Apr 02 08:59:02 thinkpad-benjamin kernel:  rescuer_thread+0x12d/0x5d0
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_rescuer_thread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  kthread+0xe3/0x120
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork+0x2c9/0x360
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel: INFO: task kworker/u64:31:10258 b=
locked for more than 120 seconds.
Apr 02 08:59:02 thinkpad-benjamin kernel:       Not tainted 7.0.0-rc6-70-rc=
6 #24
Apr 02 08:59:02 thinkpad-benjamin kernel: "echo 0 > /proc/sys/kernel/hung_t=
ask_timeout_secs" disables this message.
Apr 02 08:59:02 thinkpad-benjamin kernel: task:kworker/u64:31  state:D stac=
k:0     pid:10258 tgid:10258 ppid:2      task_flags:0x4208060 flags:0x00080=
000
Apr 02 08:59:02 thinkpad-benjamin kernel: Workqueue: events_unbound idle_cu=
ll_fn
Apr 02 08:59:02 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:59:02 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel:  __schedule+0x47c/0x1000
Apr 02 08:59:02 thinkpad-benjamin kernel:  schedule+0x27/0xd0
Apr 02 08:59:02 thinkpad-benjamin kernel:  schedule_preempt_disabled+0x15/0=
x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  __mutex_lock.constprop.0+0x54b/0=
xac0
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? ttwu_queue_wakelist+0x13c/0x230
Apr 02 08:59:02 thinkpad-benjamin kernel:  idle_cull_fn+0x3e/0x170
Apr 02 08:59:02 thinkpad-benjamin kernel:  process_one_work+0x19d/0x3a0
Apr 02 08:59:02 thinkpad-benjamin kernel:  worker_thread+0x1af/0x320
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_worker_thread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  kthread+0xe3/0x120
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork+0x2c9/0x360
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel: INFO: task kworker/u64:31:10258 i=
s blocked on a mutex likely owned by task kworker/R-kbloc:139.
Apr 02 08:59:02 thinkpad-benjamin kernel: task:kworker/R-kbloc state:R  run=
ning task     stack:0     pid:139   tgid:139   ppid:2      task_flags:0x420=
8060 flags:0x00080000
Apr 02 08:59:02 thinkpad-benjamin kernel: Call Trace:
Apr 02 08:59:02 thinkpad-benjamin kernel:  <TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __schedule+0x484/0x1000
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? preempt_schedule_irq+0x38/0x60
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? asm_common_interrupt+0x26/0x40
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? affine_move_task+0x198/0x580
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? affine_move_task+0x50c/0x580
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? srso_alias_return_thunk+0x5/0x=
fbef5
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? set_next_entity+0xe7/0x270
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_migration_cpu_stop+0x10/=
0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? affine_move_task+0x3c8/0x580
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __set_cpus_allowed_ptr+0x66/0x=
c0
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? set_cpus_allowed_ptr+0x3a/0x60
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? worker_attach_to_pool+0x5f/0xd0
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? rescuer_thread+0x12d/0x5d0
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_rescuer_thread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? kthread+0xe3/0x120
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? ret_from_fork+0x2c9/0x360
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? __pfx_kthread+0x10/0x10
Apr 02 08:59:02 thinkpad-benjamin kernel:  ? ret_from_fork_asm+0x1a/0x30
Apr 02 08:59:02 thinkpad-benjamin kernel:  </TASK>
Apr 02 08:59:02 thinkpad-benjamin kernel: Future hung task reports are supp=
ressed, see sysctl kernel.hung_task_warnings
[=E2=80=A6]
Apr 02 09:05:10 thinkpad-benjamin kernel: rcu_tasks_wait_gp: rcu_tasks grac=
e period number 9 (since boot) is 2583 jiffies old.
Apr 02 09:05:40 thinkpad-benjamin kernel: rcu_tasks_wait_gp: rcu_tasks grac=
e period number 9 (since boot) is 10136 jiffies old.
[=E2=80=A6]
Apr 02 09:07:11 thinkpad-benjamin kernel: rcu_tasks_wait_gp: rcu_tasks grac=
e period number 9 (since boot) is 32832 jiffies old.
[=E2=80=A6]
Apr 02 09:08:09 thinkpad-benjamin kernel: sysrq: Emergency Sync
Apr 02 09:08:09 thinkpad-benjamin kernel: Emergency Sync complete
Apr 02 09:08:09 thinkpad-benjamin kernel: sysrq: Emergency Remount R/O



