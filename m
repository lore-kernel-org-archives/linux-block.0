Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B630DEB2
	for <linux-block@vger.kernel.org>; Tue,  7 Jul 2026 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783391319; cv=pass; b=W6L2O6laqoPUEpXRRNwaaqm5EQcYOb2lTAtJ8tBIJ3S/SxBBipxc7z4YGm+oYtbKy0bGbWh5/hoNwqO+XR2+ZU1Oi380q+pk6HrSVF2R1bJV2HfaiUq+B6J25YCZLfxOoObGWl3RZo3mYpcnX9XyJhI2hHBQQEZoKzBvHSbX/sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783391319; c=relaxed/simple;
	bh=6W8O92UiA79DWd1L2UFfMr/QL8xVI13/QY5YPPSzdiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnRYntTEf1sbKJ7ZuB2ARNr5HJKFwPmNnsLa2cM63TO2qnAB2q1payk3tc50r9ZRFyxqinWjm0Kae5SpyQxEHY9/TW+ME1I/lixOEbdvVSeJdOu+et+je0NuCvcwrQ4tMy4HSBNj+9kZJ/fvflDmzZ45Ia8VK4ULUUHIiHApn0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOeWT/f8; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOeWT/f8"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7dbcb505578so31638947b3.3
        for <linux-block@vger.kernel.org>; Mon, 06 Jul 2026 19:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783391314; cv=none;
        d=google.com; s=arc-20260327;
        b=Sm7Do/pVO07YcNLEZ+8P3E9lOB4fcNqTEnK3X7t4b+JHq2PC3K9fpHl/JnXblwZZUG
         kyjluxV4kGtUVUJjTvR04eLpljhJ33o3E2+Qu1Z8akDxrPv3QhLdbjGDtDwjhQHbllJa
         5ovIuPfgMMpplmuGQGIUT5zZcJzjEYYn3oGme//XtUEGE9tfjy5EB+vbwkwQjgAo/1Pz
         QYdp0AbZBtnzpf4XrHTrHz23QZpMdQG5Zq1dHX3rBCCr+Xk0JCLmYB3LgYILWGB2mUU+
         JtMxgTXsvtBbXQGwD6YUuNhYkekILltGzIb4DuA5hnrSzPGksNXnVLzILV+gfmgRhCeb
         Bskw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2xZAidflWm8ydGc55RaFAxsXLvMNZAbWlrn3C16+oXQ=;
        fh=5f+YklkDNofi3jn7fPZUxQQVjXZH03z3uaQLaopkyZU=;
        b=j8aOu7IUC8duBUJtJ8ea4ZmtLmSmlm22vhMzjvLlzIce1JNu+j3zpj9CkQFXb2B+Gc
         EhJmX3dQsw7OY474p9beVoL7dsYlTkpBRq3Ne6x6R3qXJqcXGN+gf3DI/39hgkr0OYFu
         k0NluHqGH8UYddloCSenLPNdRJ5/Db36l6NuwHEMszLtgFrCbO/riwbRMhGPhCxrmuXQ
         6Rc/qcwQRTmMqAPVkng26/I3KY4EhxHYQEpGQ/I26UQg1I1GrBKAnjJLMSXPnIwKoTZh
         c/t8wOE/fgFo4lvVMH/n/y9IAh78vNbOe7NYNdofLQCNUpXFFgD0meIS/jJMNqJ9mMHv
         KWkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783391314; x=1783996114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2xZAidflWm8ydGc55RaFAxsXLvMNZAbWlrn3C16+oXQ=;
        b=IOeWT/f8GEFbMfcWusWMefPMt1/nVvrMP4n9sg5AybZ1n/G7MzNHgGKqFbIIooUAjX
         xwc/6YXzD44WDrG3u0OtWNnrLsQgXgWJZG4TQ0VulQ1u9EtSsMPYvkzzdlXqRbHaLQzz
         x+VVGCP5M+Zm6Obm/kc/477lK8ePeLVy9wOvoo+nCM8NTUAnzmBFGqG0V+NzB5ospjCP
         +ORVr2E27TguVMmmG1nHoTljaJ8YL5lINg6vLncMof2209zrWNkgoFwXhlJggefiMDxo
         oXcyo1YeZjsfvFSx66/BPYsfmgPqnpyZu/tTZUOAHHZFr4VrxmRwLGd5kjg8yicqtsfm
         hjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783391314; x=1783996114;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2xZAidflWm8ydGc55RaFAxsXLvMNZAbWlrn3C16+oXQ=;
        b=jeM7iDaJqndgto1CkSTGFv2VXRZPi5/mEuD6dpRQ1ZNg6srCeLCTknNl/DPD30Q+ux
         aFS2kg3g6AHoZgvlIMZ2b575epVlibW3b5/nY9CjS6qcvM/JxGjvQlzaPtuMcetfqPrE
         mvAhGbPBfazXYK8kVcNx8gVkfZz0ATg4g84lklvE0iA00H1pF2sFc7o2YFWaT3VLQ2Hy
         gl6JFfP+PyoIg8xR+zc4E6qa+Ep8AfJNWejhkafpREYWtRnCr0J4IypIMHVCrf3Yh/gb
         A3ysRGJ8AtsYjzA9PTy+yCSZqygcHdGfCndWp2Mw7RfZ0CTW+/qbHWhyiIHWR4Ov5D9O
         wLgw==
X-Forwarded-Encrypted: i=1; AHgh+RoGNGNfn+rJ9qixrFosn0ltUhbZpcB5dh87yMyjVIJoBe+UiPSDV17j7AOBtiJjKxZRKq/MWbKe9YFV9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZxs7NxSoHMG/lit/qxjmLMeTHuisRFLxtxR+rFBoXpeM3RQCC
	OMTmhB60neo789NBkJCePMJojmiP9nsaVixfnX6JLbC0vWZrHSu7YKwhvLK+f26LRAVeKedda93
	Qd1s2MbQ5T5xOAnPx3d51kGG97gxrH6Y=
X-Gm-Gg: AfdE7ckBqGniEihCGshE9JXVHvs3KpBxJxyZ9bXEO3WXZmC+50srwWPecOkbhG9Ef9M
	G/V7rj8/AbCY2bwlRxBZ828t2G+U+AI+niy8t8L6VA9RCmJTSn3i3BDxMlHpDNMag2/0H0SVEVJ
	fr7zkESr7uRM+/vCTptYwNmEz6ZodtUcM49ADBKRarffryNhY5aQxrDAgk5BUpbHqsaLQnsSJzn
	oBKz0fFra15Oiru5xV1o7I3Vbh/X811oFrnuUxWciTxmI4cCrnIhNBKuRrEhIJAJmeUjqTUwxY=
X-Received: by 2002:a05:690c:4a02:b0:80c:85b6:764b with SMTP id
 00721157ae682-81be3dd5f38mr24315517b3.64.1783391313848; Mon, 06 Jul 2026
 19:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621135916.2657247-1-zzzccc427@gmail.com>
In-Reply-To: <20260621135916.2657247-1-zzzccc427@gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Tue, 7 Jul 2026 10:28:20 +0800
X-Gm-Features: AVVi8CfnnNKkDInUTXgjVMLCp7oBm7r0SraFmHbJ_HK7RJmtNGneYk1TwT5pq4U
Message-ID: <CAFRLqsWb=_LVBKfYR0Y5=ym8M5Fddy3EmWj54PYFcuYA+fK_fw@mail.gmail.com>
Subject: Re: [PATCH] blk-iolatency: flush enable work after policy deactivation
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Sorry for the noise, but I wanted to gently follow up on this patch in
case it got buried.

I would really appreciate any feedback when you have a chance. Please
let me know if I should make any changes or provide more testing
results.

Thanks a lot.

Best regards,
Cen Zhang

Cen Zhang <zzzccc427@gmail.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8821=E6=97=A5=
=E5=91=A8=E6=97=A5 21:59=E5=86=99=E9=81=93=EF=BC=9A
>
> A blk-iolatency rq-qos teardown can free struct blk_iolatency while a
> freshly queued enable_work callback still references it. The observed
> failure is:
>
> blkcg_iolatency_exit() flushes enable_work before deactivating the
> iolatency policy. However, blkcg_deactivate_policy() calls
> iolatency_pd_offline() for online policy data, and iolatency_pd_offline()
> clears min_lat_nsec through iolatency_set_min_lat_nsec(). If this clears
> the last nonzero latency target, enable_cnt reaches zero and schedules
> enable_work again after the flush has already returned.
>
> The buggy scenario involves two paths, with each column showing the order
> within that path:
>
> blkcg_iolatency_exit() path:          system_wq worker path:
> 1. Flush old enable_work.             1. enable_work is idle.
> 2. Deactivate the policy.             2. no worker owns it.
> 3. Offline queues new enable_work.    3. work item becomes pending.
> 4. Free blkiolat.                     4. worker later runs the item.
> 5. Owner storage is gone.             5. worker dereferences blkiolat.
>
> Flush enable_work again after blkcg_deactivate_policy() returns and befor=
e
> freeing blkiolat. Policy offline callbacks have completed at that point,
> so the second drain covers the late queueing path without changing the
> normal enable/disable accounting rules.
>
> Validation reproduced this kernel report:
> BUG: KASAN: slab-use-after-free in assign_work+0x2a/0x150
>
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x53/0x70
>  print_report+0xd0/0x630
>  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __virt_addr_valid+0xea/0x1a0
>  ? assign_work+0x2a/0x150
>  kasan_report+0xce/0x100
>  ? assign_work+0x2a/0x150
>  assign_work+0x2a/0x150
>  worker_thread+0x1b7/0x500
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x192/0x1d0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2ac/0x3c0
>  ? __pfx_ret_from_fork+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __switch_to+0x2d5/0x6e0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
>
> Allocated by task 470:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  __kasan_kmalloc+0x8f/0xa0
>  iolatency_set_limit+0x301/0x450
>  cgroup_file_write+0x178/0x2e0
>  kernfs_fop_write_iter+0x1ef/0x290
>  vfs_write+0x446/0x6f0
>  ksys_write+0xc7/0x160
>  do_syscall_64+0xf9/0x540
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 611:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x43/0x70
>  kfree+0x131/0x390
>  rq_qos_exit+0x5d/0x90
>  __del_gendisk+0x394/0x490
>  del_gendisk+0xa1/0xe0
>  virtblk_remove+0x41/0xd0
>  virtio_dev_remove+0x63/0xe0
>  device_release_driver_internal+0x246/0x2e0
>  unbind_store+0xa9/0xb0
>  kernfs_fop_write_iter+0x1ef/0x290
>  vfs_write+0x446/0x6f0
>  ksys_write+0xc7/0x160
>  do_syscall_64+0xf9/0x540
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Last potentially related work creation:
>  kasan_save_stack+0x33/0x60
>  kasan_record_aux_stack+0x8c/0xa0
>  __queue_work+0x42a/0x800
>  queue_work_on+0x5d/0x70
>  iolatency_set_min_lat_nsec+0x196/0x230
>  iolatency_pd_offline+0x1f/0x40
>  blkcg_deactivate_policy+0x194/0x270
>  blkcg_iolatency_exit+0x33/0x40
>  rq_qos_exit+0x5d/0x90
>  __del_gendisk+0x394/0x490
>  del_gendisk+0xa1/0xe0
>  virtblk_remove+0x41/0xd0
>  virtio_dev_remove+0x63/0xe0
>  device_release_driver_internal+0x246/0x2e0
>  unbind_store+0xa9/0xb0
>  kernfs_fop_write_iter+0x1ef/0x290
>  vfs_write+0x446/0x6f0
>  ksys_write+0xc7/0x160
>  do_syscall_64+0xf9/0x540
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Second to last potentially related work creation:
>  kasan_save_stack+0x33/0x60
>  kasan_record_aux_stack+0x8c/0xa0
>  __queue_work+0x42a/0x800
>  queue_work_on+0x5d/0x70
>  iolatency_set_min_lat_nsec+0x196/0x230
>  iolatency_set_limit+0x3f1/0x450
>  cgroup_file_write+0x178/0x2e0
>  kernfs_fop_write_iter+0x1ef/0x290
>  vfs_write+0x446/0x6f0
>  ksys_write+0xc7/0x160
>  do_syscall_64+0xf9/0x540
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: 8a177a36da6c ("blk-iolatency: Fix inflight count imbalances and IO=
 hangs on offline")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  block/blk-iolatency.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index 1aaee6fb0f59..a0bdd8a5c94c 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -639,6 +639,11 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos=
)
>         timer_shutdown_sync(&blkiolat->timer);
>         flush_work(&blkiolat->enable_work);
>         blkcg_deactivate_policy(rqos->disk, &blkcg_policy_iolatency);
> +       /*
> +        * blkcg_deactivate_policy() invokes iolatency_pd_offline(), whic=
h may
> +        * queue enable_work again when it clears the last latency target=
.
> +        */
> +       flush_work(&blkiolat->enable_work);
>         kfree(blkiolat);
>  }
>
> --
> 2.43.0
>
