Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2DE1DDC1B;
	Wed, 12 Aug 2026 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543667; cv=none; b=D2kyHVx6OXXhYnZjps8TyCHA/TDV3vPR2u9N2+vifHNeJSDPT2m3D983LNeRq3rt9NF5Qoi5OQbisS1drPmQBz1zXNMEqbn/LrhWyeQv5eM6p2+0tI2RVZPhhV5hw+OLQ9CSrf48hRuLdetD/1bTR+J6K7n6LnNH5zAKrjCVH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543667; c=relaxed/simple;
	bh=wIemVK06fnY461hoIzQ1/b8v0cE9rjeuZZSTkSmuPW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1UbIYhxejWAF/WgXqrSPXGM/7wzeauUHCZ4h3fF88MktkactCbn/1uWGLecjPjzb2E1u3Q5nQCK3rNvgmpB10X22N11Bw3fUchTg+z2HY6Rso8n4RddAeKzCYXdDYgQf615XxYqJML41SQaw9W0BtyIU1wVEEIKasxQSRIB8FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWMCipKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWMCipKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271671F00A3A;
	Wed, 12 Aug 2026 14:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786543666;
	bh=6wvqPUZV09YEWu6OC+X+pUdXitC3iJPIgcdLhA3zZ8Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=PWMCipKgALqakX1jRyxVPEmSUuLCAnFWXxRZ/MpxTP/UtI9UqzS8Jpa9Kny+FoYYq
	 Jkp3gCe1/oR+F8VhtKzvhseFRwbY8Dli3+K1vfxDqQjqvUjrsjoDxAvGBP4pMkw5T/
	 95jdJTcCjXuH8+wayLuaW9fMMSM+XZTkovXAWVi13EJDpjjWa2Ir3Ruj6FBP/fktTw
	 Gp2UwCBqKpfFRYLVX88BGdTulK81itEkSy91PpmSpYRlj0LOCeJBGZk6E1DoF7irgr
	 r1IDKVAp5vbDZXpUUupXAqbOwzSsc9lJuSy65ROpGdY+1k6jZ8wFbtynUz3/jMPzDS
	 6R9rFbyec/EKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F1667CE0EBE; Wed, 12 Aug 2026 07:07:45 -0700 (PDT)
Date: Wed, 12 Aug 2026 07:07:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] blk-mq: add missing call to srcu_barrier() in
 blk_mq_free_tag_set()
Message-ID: <2236bac8-f5a8-4a5c-a304-c74c52381a71@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CGME20260812060521eucas1p109a53a37ed0557d06aa7a68b613352aa@eucas1p1.samsung.com>
 <20260812060510.3220294-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812060510.3220294-1-m.szyprowski@samsung.com>

On Wed, Aug 12, 2026 at 08:05:08AM +0200, Marek Szyprowski wrote:
> Commit 05c3e88488ed ("srcu: Queue sdp->work when the delay timer is
> successfully deleted") added a check in cleanup_srcu_struct() if the
> call to srcu_barrier() has been made before calling it, which
> revealed a missing call to srcu_barrier() before calling
> cleanup_srcu_struct(set->srcu). Fix this.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> This fixes the following issue observed recently in linux-next:
> ------------[ cut here ]------------
>  WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x194/0x3d4, CPU#1: kworker/1:2/156
>  Modules linked in: s5p_mfc exynos_gsc s5p_jpeg videobuf2_dma_contig v4l2_mem2mem videobuf2_memops videobuf2_v4l2 videobuf2_common videodev mc
>  CPU: 1 UID: 0 PID: 156 Comm: kworker/1:2 Not tainted 7.2.0-rc3-00006-g05c3e88488ed-dirty #13430 PREEMPT
>  Hardware name: Samsung Exynos (Flattened Device Tree)
>  Workqueue: usb_hub_wq hub_event
>  Call trace:
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x6c/0x8c
>   dump_stack_lvl from __warn+0x90/0x204
>   __warn from warn_slowpath_fmt+0x1b4/0x1bc
>   warn_slowpath_fmt from cleanup_srcu_struct+0x194/0x3d4
>   cleanup_srcu_struct from blk_mq_free_tag_set+0x138/0x158
>   blk_mq_free_tag_set from scsi_mq_free_tags+0x10/0x1c
>   scsi_mq_free_tags from scsi_remove_host+0x14c/0x170
>   scsi_remove_host from uas_disconnect+0x70/0x84
>   uas_disconnect from usb_unbind_interface+0x78/0x2b4
>   usb_unbind_interface from device_release_driver_internal+0x194/0x208
>   device_release_driver_internal from bus_remove_device+0xf8/0x1c8
>   bus_remove_device from device_del+0x138/0x3b0
>   device_del from usb_disable_device+0xec/0x22c
>   usb_disable_device from usb_disconnect+0xf8/0x2bc
>   usb_disconnect from hub_event+0x9a8/0x1c3c
>   hub_event from process_one_work+0x258/0x798
>   process_one_work from worker_thread+0x1bc/0x3cc
>   worker_thread from kthread+0x138/0x16c
>   kthread from ret_from_fork+0x14/0x28
>  Exception stack(0xf0dfdfb0 to 0xf0dfdff8)
>  dfa0:                                     00000000 00000000 00000000 00000000
>  dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>  dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  irq event stamp: 23097
>  hardirqs last  enabled at (23109): [<c0100bf8>] __irq_svc+0xb8/0xd0
>  hardirqs last disabled at (23118): [<c0100b94>] __irq_svc+0x54/0xd0
>  softirqs last  enabled at (23094): [<c013ef54>] handle_softirqs+0x32c/0x58c
>  softirqs last disabled at (23065): [<c013f360>] __irq_exit_rcu+0x144/0x1f0
>  ---[ end trace 0000000000000000 ]---
> ---
>  block/blk-mq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2c850330a32b..a26a11c73ee3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4975,6 +4975,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
>  	srcu_barrier(&set->tags_srcu);
>  	cleanup_srcu_struct(&set->tags_srcu);
>  	if (set->flags & BLK_MQ_F_BLOCKING) {
> +		srcu_barrier(set->srcu);
>  		cleanup_srcu_struct(set->srcu);
>  		kfree(set->srcu);
>  	}
> -- 
> 2.43.0
> 
