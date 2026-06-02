Received: from va-2-35.ptr.blmpb.com (va-2-35.ptr.blmpb.com [209.127.231.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF493019C8
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417397; cv=none; b=FWbzSv+dTT8Ss9DVKbWDconMJqfW8F6maez6v1EWQZLcqRCMx5pmzczA0SxHLOf/MiwFLWxBExFd2c3m8b8ti51/p0JnIZICojkgtRf4erCsjYxC2MXmv9hlwNUaRnjEG+iofTepqNd2VqYTAsJ8zHdt65D0oHdR0HrJXT2QS6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417397; c=relaxed/simple;
	bh=oX0yRGIE2qAxCn12MK0f+HD53LeqSTXn/UmMQoo0Hi4=;
	h=Message-Id:To:Subject:Mime-Version:Cc:In-Reply-To:Content-Type:
	 From:Date:References; b=XgMDshq0PZ3xcKePmeG/EPAsZt7J1aE6V6jqRiCLgWhC4lfEktbd2BY4pL/3XyVa1sjS2/5AT3mxq3woupdt0tJ8AkxE8GvEmKhOV1Jv566MhZihV6zWkzpEdLAls3cXaML+5ZwGA+ubQqf/VU2/CqoAl3NZSgLfvsHwz5LPV8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=hASqciMR; arc=none smtp.client-ip=209.127.231.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="hASqciMR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1780417390;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=QBb/QEQoJ/jHe71jd5vSxoT7/0PysanIXlmpkf4nBvo=;
 b=hASqciMRb3PkMftQ9pwKWHVBH5pAhEvSb/44zl86SHz82wqD40N/NuqWqS6slT28P211tq
 pWeoufEAxQClYQ0rM3MPTbBrMccoQ1vfr0XThLnvotj2IJ8Zvw44adl2vFciP9VkpQ0TmV
 mRQQscqRJSe0kwo51qVLqf+KVGwu6q7h9t7nyFY6BqsDQXNft1NwHU8HZpvN9wrjPycU7T
 xDwB5eEWIhk9E9lcj+cvv61Lid02iG4WJPjemMb5FkM/b3Ce1+w3VSPNBzGRD1m8xbneEz
 5Ys3pPqL3H3i9/8+CsG/hMkSOwZpzu8MC6O4akGltKC16VfvneG3Ycnk+6hhWA==
Reply-To: yukuai@fygo.io
Message-Id: <ca3468e6-3b0b-409a-acea-367ea2f44fce@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.134]) by smtp.feishu.cn with ESMTPS; Wed, 03 Jun 2026 00:23:07 +0800
To: "Yu Kuai" <yukuai@fygo.io>, <tj@kernel.org>, <axboe@kernel.dk>
Subject: Re: [PATCH] blk-iolatency: fix child_lat lock irq state
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US
Cc: <linux-block@vger.kernel.org>
In-Reply-To: <20260601080235.980914-1-yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26a1f036c+f02817+vger.kernel.org+yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Wed, 3 Jun 2026 00:23:06 +0800
References: <20260601080235.980914-1-yukuai@fygo.io>
X-Original-From: Yu Kuai <yukuai@fnnas.com>

Hi,

=E5=9C=A8 2026/6/1 16:02, Yu Kuai =E5=86=99=E9=81=93:
> iolatency_clear_scaling() updates child_lat.lock with hardirqs enabled.
> The bio completion path can take the same lock from hardirq context.
>
> This triggers lockdep after io.latency is configured and I/O completes.
> Full lockdep report:
>
>    WARNING: inconsistent lock state
>    7.1.0-rc2-g6a04b2279273 #1 Not tainted
>    --------------------------------
>    inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
>    swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
>    ffff88810c682d10 (&iolat->child_lat.lock){?.+.}-{3:3}, at: blkcg_iolat=
ency_done_bio+0x6e7/0xb90
>    {HARDIRQ-ON-W} state was registered at:
>      lock_acquire+0xd4/0x290
>      _raw_spin_lock+0x3a/0x70
>      iolatency_set_limit+0x49b/0x590

Please ignore this patch, this trace is because I refactor locally to conve=
rt
protecting blkg from queue_lock to blkcg_mutex, and spin_lock_irq(&q->queue=
_lock)
is removed from blkg_conf_prep(), hence irq is no longer enabled.

I should have checked if this problem is introduced by myself. Sorry for
the noise.

>      cgroup_file_write+0x1c5/0x4b0
>      kernfs_fop_write_iter+0x1d7/0x280
>      vfs_write+0x580/0x630
>      ksys_write+0xec/0x190
>      do_syscall_64+0x156/0x490
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    irq event stamp: 328476
>    hardirqs last  enabled at (328475): [<ffffffffa4dd93b1>] do_idle+0x261=
/0x400
>    hardirqs last disabled at (328476): [<ffffffffa68347f3>] common_interr=
upt+0x13/0x90
>    softirqs last  enabled at (328398): [<ffffffffa4d508ac>] __irq_exit_rc=
u+0x8c/0x150
>    softirqs last disabled at (328387): [<ffffffffa4d508ac>] __irq_exit_rc=
u+0x8c/0x150
>
>                              other info that might help us debug this:
>     Possible unsafe locking scenario:
>
>           CPU0
>           ----
>      lock(&iolat->child_lat.lock);
>      <Interrupt>
>        lock(&iolat->child_lat.lock);
>
>                               *** DEADLOCK ***
>
>    1 lock held by swapper/0/0:
>     #0: ffff888103365450 (&virtscsi_vq->vq_lock){-.-.}-{3:3}, at: virtscs=
i_vq_done+0x9f/0x130
>
>                              stack backtrace:
>    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.1.0-rc2-g6a04b22792=
73 #1 PREEMPT  1c49bdb9e32f352d2b66a5ca23d36d656c610458
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.f=
c42 04/01/2014
>    Call Trace:
>     <IRQ>
>     dump_stack_lvl+0x54/0x70
>     print_usage_bug+0x26d/0x280
>     mark_lock_irq+0x3ef/0x400
>     ? save_trace+0x3d/0x2f0
>     ? __pfx_stack_trace_consume_entry+0x10/0x10
>     mark_lock+0x117/0x190
>     __lock_acquire+0x570/0x2850
>     ? stack_trace_save+0xa1/0xe0
>     ? __pfx_stack_trace_save+0x10/0x10
>     ? filter_irq_stacks+0x27/0x80
>     ? stack_depot_save_flags+0x32/0x7f0
>     lock_acquire+0xd4/0x290
>     ? blkcg_iolatency_done_bio+0x6e7/0xb90
>     ? kvm_sched_clock_read+0x11/0x20
>     ? local_clock_noinstr+0xc/0xc0
>     ? local_clock+0x15/0x30
>     ? lock_release+0x111/0x470
>     ? blkcg_iolatency_done_bio+0x6e7/0xb90
>     _raw_spin_lock_irqsave+0x4c/0x90
>     ? blkcg_iolatency_done_bio+0x6e7/0xb90
>     blkcg_iolatency_done_bio+0x6e7/0xb90
>     ? __pfx_blkcg_iolatency_done_bio+0x10/0x10
>     __rq_qos_done_bio+0x51/0x60
>     bio_endio+0x135/0x320
>     blk_update_request+0x1e6/0x570
>     scsi_end_request+0x4b/0x410
>     scsi_io_completion+0x83/0x170
>     ? __pfx_virtscsi_complete_cmd+0x10/0x10
>     virtscsi_vq_done+0xd7/0x130
>     ? lock_acquire+0xd4/0x290
>     ? __pfx_virtscsi_vq_done+0x10/0x10
>     ? local_clock_noinstr+0xc/0xc0
>     ? local_clock+0x15/0x30
>     vring_interrupt+0x13b/0x150
>     ? __pfx_vring_interrupt+0x10/0x10
>     __handle_irq_event_percpu+0x145/0x4b0
>     handle_irq_event+0x54/0xb0
>     handle_edge_irq+0x111/0x320
>     __common_interrupt+0x97/0xf0
>     common_interrupt+0x7e/0x90
>     </IRQ>
>     <TASK>
>     asm_common_interrupt+0x26/0x40
>    RIP: 0010:pv_native_safe_halt+0x13/0x20
>    Code: d3 a5 01 00 cc 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90 f3 0f 1e fa 66 90 0f 00 2d 2f 39 21 00 f3 0f 1e fa fb f4 <c3> cc cc cc=
 cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90
>    RSP: 0018:ffffffffa7607e00 EFLAGS: 00000246
>    RAX: 000000000005031b RBX: ffffffffa4dd93b1 RCX: ffffffffa683884b
>    RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffffa4dd93b1
>    RBP: ffffffffa7607ed0 R08: ffff888117bf408b R09: 1ffff11022f7e811
>    R10: dffffc0000000000 R11: ffffed1022f7e812 R12: 0000000000000000
>    R13: 0000000000000000 R14: 0000000000000000 R15: ffffffffa7f6cff0
>     ? do_idle+0x261/0x400
>     ? ct_kernel_exit+0xcb/0x110
>     ? do_idle+0x261/0x400
>     default_idle+0x9/0x20
>     default_idle_call+0x73/0xb0
>     do_idle+0x261/0x400
>     ? __pfx_do_idle+0x10/0x10
>     ? local_clock_noinstr+0x30/0xc0
>     ? local_clock+0x15/0x30
>     cpu_startup_entry+0x36/0x40
>     rest_init+0x207/0x210
>     start_kernel+0x321/0x370
>     x86_64_start_reservations+0x24/0x30
>     x86_64_start_kernel+0x13a/0x140
>     common_startup_64+0x13e/0x147
>     </TASK>
>
> Fix it by using spin_lock_irqsave() in iolatency_clear_scaling().
> Use irqsave rather than spin_lock_irq() because the same helper is also
> called from pd_offline_fn paths where hardirqs can already be disabled
> by blkcg teardown/deactivation locks. spin_unlock_irq() would wrongly
> enable hardirqs in those paths.
>
> Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
> Signed-off-by: Yu Kuai <yukuai@fygo.io>
> ---
>   block/blk-iolatency.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index 53e8dd2dfa8a..9152dc86b08b 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -811,16 +811,18 @@ static void iolatency_clear_scaling(struct blkcg_gq=
 *blkg)
>   	if (blkg->parent) {
>   		struct iolatency_grp *iolat =3D blkg_to_lat(blkg->parent);
>   		struct child_latency_info *lat_info;
> +		unsigned long flags;
> +
>   		if (!iolat)
>   			return;
>  =20
>   		lat_info =3D &iolat->child_lat;
> -		spin_lock(&lat_info->lock);
> +		spin_lock_irqsave(&lat_info->lock, flags);
>   		atomic_set(&lat_info->scale_cookie, DEFAULT_SCALE_COOKIE);
>   		lat_info->last_scale_event =3D 0;
>   		lat_info->scale_grp =3D NULL;
>   		lat_info->scale_lat =3D 0;
> -		spin_unlock(&lat_info->lock);
> +		spin_unlock_irqrestore(&lat_info->lock, flags);
>   	}
>   }
>  =20

--=20
Thansk,
Kuai
