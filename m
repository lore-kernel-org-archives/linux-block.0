Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD907DA66
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888832; cv=none; b=YNciLgqAhfIWWX9FQcfJlCvvSYJLGXaqh5fzd/L1k1r2nOydUUCrcge1cvYZNiklRnCBYf/1nu2xl+NsEe2BZq0OA+mIUrvtlgtiwXrJAjh9p4K0ATLkCBGvPC/h9XH2PAfKPm9USYSXem+7gDOvCb7QdjYthnQ6WhebQL/DROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888832; c=relaxed/simple;
	bh=Gj/6bD68ex8NW8ZJA4XPomfwIZfg27qU0a/L83nSkv4=;
	h=Cc:Date:In-Reply-To:To:Content-Type:From:Mime-Version:References:
	 Subject:Message-Id; b=tXvDPLOqngpIWUT8c5LWoeVqNI1nJNM45WeQRXOWo9VSKkkdYNMK0XSdp+zcs+BnlIQRlHDZEZdat2Gn85J1EwIodwQK2RHSMFAuhxSz29CJ9uupMpostGz+mumf7FCrUM1Krc2gSH9npislPRhwUsshkVM+v5iIDji0UgRpfQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=w35Fw3Mq; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="w35Fw3Mq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1767888704;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=u7H+eb8jf11iBjaQZM8Eb+t8KUvsf+FCT/Mc2weuYLs=;
 b=w35Fw3Mqwy5L13YW6BgpBkCo5EnuBCQIPueL4dfmM+67d1awW2rifr7shK9pAdiRnjFThh
 gR08Cpln2fclBXPzhwXYXwbaWgYot53HkW768P4fhM7I4cHoVLL2I1vSsxhCdLi+oJUpJr
 wFtyMFA7gunY3CB+5ep4gD2EwgU4wo2VRUwyp8th55muZHFEFvOCNqHWENc24Cs9eordLl
 AdMvokRZUNHhmltsE2QCzqB7ElW7yuFyDmxTMvRJ3ezkurQk5sQJsL71/FpK7AVj0nsc6D
 Z43eNXa77GCzgHEOPOwZGxM3iSHE9T1JNtMOzsMwZZDNSynh/gSWnIzNrI0PPg==
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>, 
	<yangerkun@huawei.com>, <houtao1@huawei.com>, <zhengqixing@huawei.com>, 
	<yukuai@fnnas.com>
Date: Fri, 9 Jan 2026 00:11:40 +0800
In-Reply-To: <20260108014416.3656493-3-zhengqixing@huaweicloud.com>
X-Lms-Return-Path: <lba+2695fd73e+1d29fd+vger.kernel.org+yukuai@fnnas.com>
To: "Zheng Qixing" <zhengqixing@huaweicloud.com>, <tj@kernel.org>, 
	<josef@toxicpanda.com>, <axboe@kernel.dk>
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.185]) by smtp.feishu.cn with ESMTPS; Fri, 09 Jan 2026 00:11:41 +0800
From: "Yu Kuai" <yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108014416.3656493-1-zhengqixing@huaweicloud.com> <20260108014416.3656493-3-zhengqixing@huaweicloud.com>
Content-Language: en-US
Subject: Re: [PATCH 2/3] blk-cgroup: fix uaf in blkcg_activate_policy() racing with blkg_free_workfn()
Message-Id: <72dc0ed6-1ba9-46b8-a43f-d11c32e2f341@fnnas.com>
Reply-To: yukuai@fnnas.com

Hi,

=E5=9C=A8 2026/1/8 9:44, Zheng Qixing =E5=86=99=E9=81=93:
> From: Zheng Qixing <zhengqixing@huawei.com>
>
> When switching IO schedulers on a block device (e.g., loop0),
> blkcg_activate_policy() is called to allocate blkg_policy_data (pd)
> for all blkgs associated with that device's request queue.
>
> However, a race condition exists between blkcg_activate_policy() and
> concurrent blkcg deletion that leads to a use-after-free:
>
> T1 (blkcg_activate_policy):
>    - Successfully allocates pd for blkg1 (loop0->queue, blkcgA)
>    - Fails to allocate pd for blkg2 (loop0->queue, blkcgB)
>    - Goes to enomem error path to rollback blkg1's resources
>
> T2 (blkcg deletion):
>    - blkcgA is being deleted concurrently
>    - blkg1 is freed via blkg_free_workfn()
>    - blkg1->pd is freed
>
> T1 (continued):
>    - In the rollback path, accesses pd->online after blkg1->pd
>      has been freed
>    - Triggers use-after-free
>
> The issue occurs because blkcg_activate_policy() doesn't hold
> adequate protection against concurrent blkg freeing during the
> error rollback path. The call trace is as follows:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in blkcg_activate_policy+0x516/0x5f0
> Read of size 1 at addr ffff88802e1bc00c by task sh/7357
> CPU: 1 PID: 7357 Comm: sh Tainted: G           OE       6.6.0+ #1
> Call Trace:
>   <TASK>
>   blkcg_activate_policy+0x516/0x5f0
>   bfq_create_group_hierarchy+0x31/0x90
>   bfq_init_queue+0x6df/0x8e0
>   blk_mq_init_sched+0x290/0x3a0
>   elevator_switch+0x8a/0x190
>   elv_iosched_store+0x1f7/0x2a0
>   queue_attr_store+0xad/0xf0
>   kernfs_fop_write_iter+0x1ee/0x2e0
>   new_sync_write+0x154/0x260
>   vfs_write+0x313/0x3c0
>   ksys_write+0xbd/0x160
>   do_syscall_64+0x55/0x100
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
>
> Allocated by task 7357:
>   bfq_pd_alloc+0x6e/0x120
>   blkcg_activate_policy+0x141/0x5f0
>   bfq_create_group_hierarchy+0x31/0x90
>   bfq_init_queue+0x6df/0x8e0
>   blk_mq_init_sched+0x290/0x3a0
>   elevator_switch+0x8a/0x190
>   elv_iosched_store+0x1f7/0x2a0
>   queue_attr_store+0xad/0xf0
>   kernfs_fop_write_iter+0x1ee/0x2e0
>   new_sync_write+0x154/0x260
>   vfs_write+0x313/0x3c0
>   ksys_write+0xbd/0x160
>   do_syscall_64+0x55/0x100
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
>
> Freed by task 14318:
>   blkg_free_workfn+0x7f/0x200
>   process_one_work+0x2ef/0x5d0
>   worker_thread+0x38d/0x4f0
>   kthread+0x156/0x190
>   ret_from_fork+0x2d/0x50
>   ret_from_fork_asm+0x1b/0x30
>
> Fix this bug by adding q->blkcg_mutex in the enomem branch of
> blkcg_activate_policy().
>
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free=
_workfn() and blkcg_deactivate_policy()")
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
> ---
>   block/blk-cgroup.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 5e1a724a799a..af468676cad1 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1693,9 +1693,11 @@ int blkcg_activate_policy(struct gendisk *disk, co=
nst struct blkcg_policy *pol)
>  =20
>   enomem:
>   	/* alloc failed, take down everything */
> +	mutex_lock(&q->blkcg_mutex);
>   	spin_lock_irq(&q->queue_lock);
>   	blkcg_policy_teardown_pds(q, pol);
>   	spin_unlock_irq(&q->queue_lock);
> +	mutex_unlock(&q->blkcg_mutex);

This looks correct, however, I think it's better also to protect q->blkg_li=
st iteration from
blkcg_activate_policy() and blkg_destroys_all() as well. This way all the q=
->blkg_list access
will be protected by blkcg_mutex, and it'll be easier to convert protecting=
 blkg from queue_lock
to blkcg_mutex.

>   	ret =3D -ENOMEM;
>   	goto out;
>   }

--=20
Thansk,
Kuai
