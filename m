Received: from mta1.migadu.com (out-245.mta1.migadu.com [95.215.58.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244E17C211
	for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 01:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786757698; cv=none; b=RLflR4GKUFiAya/58CwNl6DlYMthzW3Ely2Z0Nh5d6GV43xEit8XSl496VdQ/h4mUvBVh3HZoOhjWL3w7+a5r9/FVS5jiYOjUrwseLrEeGAb0XO/sGKEJELfh0k10qpEujQqvwOQyiMl7DywTvrDz3gY17ivxSzWprfLxKZPBfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786757698; c=relaxed/simple;
	bh=bXzYXqAwDt6NcJ9pH2iZ8/QNGUAGYd3uyGql2MW9As8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ex8J6upQbUnNHLY/FbppgdQ+gbhVTTIgGDuQrIE7zMz+NUysPTTGPYA4OfewcKO+jK/lwSBmhEsUfA7G73ty/DTdP3XhQp7N3qPDq/6Gs2Fp0mlBMW7ukqzXNyLSc62vMwRkJ0HEEMcQkJ79nG4EXdgYsgJU0qY5Qp/XR7XuETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KZZ0CDPs; arc=none smtp.client-ip=95.215.58.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KZZ0CDPs"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bXzYXqAwDt6NcJ9pH2iZ8/QNGUAGYd3uyGql2MW9As8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786757694; v=1; x=1787362494;
 b=KZZ0CDPs8/laydvyQ37LIXfDCn4Ema3+EInkUuoOBKK64JgdN5t4iDrSXXdORXRJdOJzznx3
 UKz9WOw6ntX0H0YxpM1Bz7Y5G7Xk59Rz/JNjyLAoKFuatJ6A+B2Lg+akLoKiIPV1JCkCWTByGLC
 jNlsHe8bUiCHMdSUL/O8UogQ=
X-Envelope-To: linux-block@vger.kernel.org
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by mta12.migadu.com with ESMTPS id 77aa92b518a4d0d3;
	Sat, 15 Aug 2026 01:34:43 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 15 Aug 2026 01:34:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <8978485679799d4b17fca7505ff27e2fad7fae0c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] blk-mq: add missing call to srcu_barrier() in
 blk_mq_free_tag_set()
To: "Marek Szyprowski" <m.szyprowski@samsung.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Marek Szyprowski" <m.szyprowski@samsung.com>, "Jens Axboe"
 <axboe@kernel.dk>, "Paul E . McKenney" <paulmck@kernel.org>
In-Reply-To: <20260812060510.3220294-1-m.szyprowski@samsung.com>
References: <CGME20260812060521eucas1p109a53a37ed0557d06aa7a68b613352aa@eucas1p1.samsung.com>
 <20260812060510.3220294-1-m.szyprowski@samsung.com>

>=20
>=20Commit 05c3e88488ed ("srcu: Queue sdp->work when the delay timer is
> successfully deleted") added a check in cleanup_srcu_struct() if the
> call to srcu_barrier() has been made before calling it, which
> revealed a missing call to srcu_barrier() before calling
> cleanup_srcu_struct(set->srcu). Fix this.


This warnings should be fix in cleanup_srcu_struct().
https://lore.kernel.org/oe-lkp/202608060833.bce92909-lkp@intel.com/

and the set->srcu only be used by synchronize_srcu(), there are no
call_srcu(), so the srcu_barrier() should not be invoke before cleanup

Thanks
Zqiang



>=20
>=20Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This fixes the following issue observed recently in linux-next:
> ------------[ cut here ]------------
>  WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x194/0x3d4,=
 CPU#1: kworker/1:2/156
>  Modules linked in: s5p_mfc exynos_gsc s5p_jpeg videobuf2_dma_contig v4=
l2_mem2mem videobuf2_memops videobuf2_v4l2 videobuf2_common videodev mc
>  CPU: 1 UID: 0 PID: 156 Comm: kworker/1:2 Not tainted 7.2.0-rc3-00006-g=
05c3e88488ed-dirty #13430 PREEMPT
>  Hardware name: Samsung Exynos (Flattened Device Tree)
>  Workqueue: usb_hub_wq hub_event
>  Call trace:
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x6c/0x8c
>  dump_stack_lvl from __warn+0x90/0x204
>  __warn from warn_slowpath_fmt+0x1b4/0x1bc
>  warn_slowpath_fmt from cleanup_srcu_struct+0x194/0x3d4
>  cleanup_srcu_struct from blk_mq_free_tag_set+0x138/0x158
>  blk_mq_free_tag_set from scsi_mq_free_tags+0x10/0x1c
>  scsi_mq_free_tags from scsi_remove_host+0x14c/0x170
>  scsi_remove_host from uas_disconnect+0x70/0x84
>  uas_disconnect from usb_unbind_interface+0x78/0x2b4
>  usb_unbind_interface from device_release_driver_internal+0x194/0x208
>  device_release_driver_internal from bus_remove_device+0xf8/0x1c8
>  bus_remove_device from device_del+0x138/0x3b0
>  device_del from usb_disable_device+0xec/0x22c
>  usb_disable_device from usb_disconnect+0xf8/0x2bc
>  usb_disconnect from hub_event+0x9a8/0x1c3c
>  hub_event from process_one_work+0x258/0x798
>  process_one_work from worker_thread+0x1bc/0x3cc
>  worker_thread from kthread+0x138/0x16c
>  kthread from ret_from_fork+0x14/0x28
>  Exception stack(0xf0dfdfb0 to 0xf0dfdff8)
>  dfa0: 00000000 00000000 00000000 00000000
>  dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0=
0000000
>  dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  irq event stamp: 23097
>  hardirqs last enabled at (23109): [<c0100bf8>] __irq_svc+0xb8/0xd0
>  hardirqs last disabled at (23118): [<c0100b94>] __irq_svc+0x54/0xd0
>  softirqs last enabled at (23094): [<c013ef54>] handle_softirqs+0x32c/0=
x58c
>  softirqs last disabled at (23065): [<c013f360>] __irq_exit_rcu+0x144/0=
x1f0
>  ---[ end trace 0000000000000000 ]---
> ---
>  block/blk-mq.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
>=20diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2c850330a32b..a26a11c73ee3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4975,6 +4975,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *s=
et)
>  srcu_barrier(&set->tags_srcu);
>  cleanup_srcu_struct(&set->tags_srcu);
>  if (set->flags & BLK_MQ_F_BLOCKING) {
> + srcu_barrier(set->srcu);
>  cleanup_srcu_struct(set->srcu);
>  kfree(set->srcu);
>  }
> --=20
>=202.43.0
>
