Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C8F1FC0F3
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043633; cv=none; b=b3VBub1/pgbuouDUjY5K6aPt43Ful0lsxNIVCrt4VLYDQd5uolzCVlWCNohsMViw0kPrFYzISjdkC6oPpfM0xuAoHVtG03M9U8Bn7Cef9BIm7eX9YO/xCahqUC/UygQikTH1HkTuK+F+T7FaQBrLcsNygY8ZXiaBk/3Z2HIp7X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043633; c=relaxed/simple;
	bh=Ycs/LdLt9pIjnJP+ZUYjzwZzAu3aVjG6e47G3ZJFQGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlbO5rCIqYa6bjEh72xw0Twu6EYh6d9QE5WDcuT7N4ceJ+Wnux8BHnWVPaq9een82tvcby8UfqNeDQ4/T7aVwnPWxPTRNraEotQD1KtytfXiedp0zeY/Ur4oeCv9y9BuWqKmGIkWLp0bgrsMFKC+dMhdrz+7FTrMV1j6sU6t8wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyUZ2ppc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyUZ2ppc"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso1111340066b.2
        for <linux-block@vger.kernel.org>; Tue, 08 Jul 2025 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752043629; x=1752648429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMToQ0iAocdIAV7rRs7Yz+IQW4y93c34/s7OSSBdPqA=;
        b=kyUZ2ppcGgI+bOnK0i03HvH5niM7E1FQBYGeIpDegFRsrnCaD7CzhwOc/P0e4H/8J6
         r50Y9Q48j/WBHzOXn7/QSnHYk2yWOYoCsWHfeieEU+iZWLDezdBJpVqi8zWjddrtsVme
         Q3YPWrd5T5L3AgvKWk17gEXqs0HIwycMj2bER7J1pVFPbzCzzEkvzStwq1jrE+cBN0wm
         tbJhma3QF7DdZuGDpGhTkeD19tAbjBU5mEAus13M05bbgx2C8sXBy0gwz+i2OSCMLW7c
         McJBBAhFSs2uOMsQDVJck4gnzCDZQYS2ad7MRyu7o4a4cVn1K5ibPAWTUbDVHwZ3BRpF
         awTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752043629; x=1752648429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMToQ0iAocdIAV7rRs7Yz+IQW4y93c34/s7OSSBdPqA=;
        b=MGiDU9C3HtqEd9p9G2jZQHHg7XUMVGRHTXmET50gw3M7IclJ4LdN7c9EH+GBXRaZ7d
         Rtj2OA4/cjqSuA+mE4Ts7IMbLInZ/RHSdksuzK7JhR9VkOrmVxaoZ/dletRVyTwb1V0x
         UTX3XVruqqyhoLnhNkjuOMQUtfC3dE7z5fj3FZYd6eJ+oQTxJw32cAaHVkwbwT/NP8jS
         yGDK2gqejY0vlLMX9KvopCE6eQ4sRutOrBQyfXg3rx/jD2X9bxdqOJLdVeXFLYWeZpSN
         RHX8/JTubTWeuAha+787ZvpRBC8szU78eDGOlHG8Nx7OsLaeLAX8joNE8IPLdr1wctud
         drnw==
X-Forwarded-Encrypted: i=1; AJvYcCV63yfw7LsSwEMLtj89TIC7VBa5e1PGzCC6CG2HbguAOse3VUsh7OqOe3hYtfg3wlpxSHTNtstkk56K/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy0eYQ93Q3+swP2iDDLAeNMH8M6bAZrEGt9VYdGR5jQpy/aDbj
	3SSP9gwIAwbIP0cISD3Zs4nXtqffF4ycfosXecuJvAJhFt1RYPuababvbfqiML6kV/ntASLGOu4
	eZ5loA6jCy6sPX2Y7Soh+xL6odxwzgt4=
X-Gm-Gg: ASbGncvwFQDjOE+h6VxOYbRTLMp2vTlIGEO6+58poEsP1/ICR/U9Mu8Rrk+OO/L/3yR
	Qyv/+i9WYMgyPHz/rXYNfo3aWnZi9/upHfSQkz2lPuHS4faDREMVxyiEzORVrPuLyGJTA/doBI6
	l3cI6SSC0QUwRzYUC5FlALpS9YfvTFkXMT7rGFCeN5UhF9qZI4
X-Google-Smtp-Source: AGHT+IF4vecSUGYpMY96tD4hiQceFs98SZUAJIWC7HbviNefU3qoFuVAcUUySEn1C5z3YLDJpSSbXAyUe+7iwAb29rQ=
X-Received: by 2002:a17:907:d22:b0:ad8:e477:970c with SMTP id
 a640c23a62f3a-ae6cf69db80mr120031366b.23.1752043629281; Tue, 08 Jul 2025
 23:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709014109.2292837-1-ming.lei@redhat.com>
In-Reply-To: <20250709014109.2292837-1-ming.lei@redhat.com>
From: =?UTF-8?B?5L2Z5b+r?= <yukuai1994@gmail.com>
Date: Wed, 9 Jul 2025 14:46:57 +0800
X-Gm-Features: Ac12FXzKVbEFAUXCS7x0aHNh9flAgPLMgV9f_Hxigwol6tTtmZViKwy50WCxOLk
Message-ID: <CAHW3Dri2uVagQ8AYcUii_+qH-h1tv=ekjteLxHySADOvsn-VEg@mail.gmail.com>
Subject: Re: [PATCH] nbd: fix lockdep deadlock warning
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	syzbot+2bcecf3c38cb3e8fdc8d@syzkaller.appspotmail.com, 
	Yu Kuai <yukuai3@huawei.com>, Nilay Shroff <nilay@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Yu Kuai <yukuai3@huawei.com>


Ming Lei <ming.lei@redhat.com> =E4=BA=8E2025=E5=B9=B47=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=B8=89 09:41=E5=86=99=E9=81=93=EF=BC=9A
>
> nbd grabs device lock nbd->config_lock for updating nr_hw_queues, this
> ways cause the following lock dependency:
>
> -> #2 (&disk->open_mutex){+.+.}-{4:4}:
>        lock_acquire kernel/locking/lockdep.c:5871 [inline]
>        lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
>        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>        __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
>        mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
>        __del_gendisk+0x132/0xac6 block/genhd.c:706
>        del_gendisk+0xf6/0x19a block/genhd.c:819
>        nbd_dev_remove+0x3c/0xf2 drivers/block/nbd.c:268
>        nbd_dev_remove_work+0x1c/0x26 drivers/block/nbd.c:284
>        process_one_work+0x96a/0x1f32 kernel/workqueue.c:3238
>        process_scheduled_works kernel/workqueue.c:3321 [inline]
>        worker_thread+0x5ce/0xde8 kernel/workqueue.c:3402
>        kthread+0x39c/0x7d4 kernel/kthread.c:464
>        ret_from_fork_kernel+0x2a/0xbb2 arch/riscv/kernel/process.c:214
>        ret_from_fork_kernel_asm+0x16/0x18 arch/riscv/kernel/entry.S:327
>
> -> #1 (&set->update_nr_hwq_lock){++++}-{4:4}:
>        lock_acquire kernel/locking/lockdep.c:5871 [inline]
>        lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
>        down_write+0x9c/0x19a kernel/locking/rwsem.c:1577
>        blk_mq_update_nr_hw_queues+0x3e/0xb86 block/blk-mq.c:5041
>        nbd_start_device+0x140/0xb2c drivers/block/nbd.c:1476
>        nbd_genl_connect+0xae0/0x1b24 drivers/block/nbd.c:2201
>        genl_family_rcv_msg_doit+0x206/0x2e6 net/netlink/genetlink.c:1115
>        genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>        genl_rcv_msg+0x514/0x78e net/netlink/genetlink.c:1210
>        netlink_rcv_skb+0x206/0x3be net/netlink/af_netlink.c:2534
>        genl_rcv+0x36/0x4c net/netlink/genetlink.c:1219
>        netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>        netlink_unicast+0x4f0/0x82c net/netlink/af_netlink.c:1339
>        netlink_sendmsg+0x85e/0xdd6 net/netlink/af_netlink.c:1883
>        sock_sendmsg_nosec net/socket.c:712 [inline]
>        __sock_sendmsg+0xcc/0x160 net/socket.c:727
>        ____sys_sendmsg+0x63e/0x79c net/socket.c:2566
>        ___sys_sendmsg+0x144/0x1e6 net/socket.c:2620
>        __sys_sendmsg+0x188/0x246 net/socket.c:2652
>        __do_sys_sendmsg net/socket.c:2657 [inline]
>        __se_sys_sendmsg net/socket.c:2655 [inline]
>        __riscv_sys_sendmsg+0x70/0xa2 net/socket.c:2655
>        syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
>        do_trap_ecall_u+0x396/0x530 arch/riscv/kernel/traps.c:341
>        handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197
>
> -> #0 (&nbd->config_lock){+.+.}-{4:4}:
>        check_noncircular+0x132/0x146 kernel/locking/lockdep.c:2178
>        check_prev_add kernel/locking/lockdep.c:3168 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3287 [inline]
>        validate_chain kernel/locking/lockdep.c:3911 [inline]
>        __lock_acquire+0x12b2/0x24ea kernel/locking/lockdep.c:5240
>        lock_acquire kernel/locking/lockdep.c:5871 [inline]
>        lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
>        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>        __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
>        mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
>        refcount_dec_and_mutex_lock+0x60/0xd8 lib/refcount.c:118
>        nbd_config_put+0x3a/0x610 drivers/block/nbd.c:1423
>        nbd_release+0x94/0x15c drivers/block/nbd.c:1735
>        blkdev_put_whole+0xac/0xee block/bdev.c:721
>        bdev_release+0x3fe/0x600 block/bdev.c:1144
>        blkdev_release+0x1a/0x26 block/fops.c:684
>        __fput+0x382/0xa8c fs/file_table.c:465
>        ____fput+0x1c/0x26 fs/file_table.c:493
>        task_work_run+0x16a/0x25e kernel/task_work.c:227
>        resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>        exit_to_user_mode_loop+0x118/0x134 kernel/entry/common.c:114
>        exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline=
]
>        syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [i=
nline]
>        syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline=
]
>        do_trap_ecall_u+0x3f0/0x530 arch/riscv/kernel/traps.c:355
>        handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197
>
> Also it isn't necessary to require nbd->config_lock, because
> blk_mq_update_nr_hw_queues() does grab tagset lock for sync everything.
>
> Fixes the issue by releasing ->config_lock & retry in case of concurrent
> updating nr_hw_queues.
>
> Fixes: 98e68f67020c ("block: prevent adding/deleting disk during updating=
 nr_hw_queues")
> Reported-by: syzbot+2bcecf3c38cb3e8fdc8d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6855034f.a00a0220.137b3.0031.GAE@goog=
le.com
> Cc: Yu Kuai <yukuai3@huawei.com>
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/nbd.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 7bdc7eb808ea..136640e4c866 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1473,7 +1473,15 @@ static int nbd_start_device(struct nbd_device *nbd=
)
>                 return -EINVAL;
>         }
>
> -       blk_mq_update_nr_hw_queues(&nbd->tag_set, config->num_connections=
);
> +retry:
> +       mutex_unlock(&nbd->config_lock);
> +       blk_mq_update_nr_hw_queues(&nbd->tag_set, num_connections);
> +       mutex_lock(&nbd->config_lock);
> +
> +       /* if another code path updated nr_hw_queues, retry until succeed=
 */
> +       if (num_connections !=3D config->num_connections)
> +               goto retry;
> +
>         nbd->pid =3D task_pid_nr(current);
>
>         nbd_parse_flags(nbd);
> --
> 2.47.0
>
>
