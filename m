Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B3677105
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717464775; cv=none; b=IKMCBIg74bc+C9QNKoTzWGaBqcQr6xx7p0VqNkCk480sMYo/2fdo2uqJ3D011ebSAUHkZk9Txn14YSOzQiLtxUeJyTfGGHlIGUruaaaJ56uyxuaCTA8roP9TVBKldC5G70DeNsYbK2A0oX9Xew4zjbhha/d6iM77MhwzulKqp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717464775; c=relaxed/simple;
	bh=vryDY3ytVLC+sGikOQXWAZN+Xf3KlLscyguHBWCZjQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOTdvwODWSVrt5R9+6DN7lsNjB/v16mA+DHtDwAd4FOqi0WAZCz/EIpazV3I4FTcMuxwCrDp0nxP1IzWKk1JE9rThMWrgrvAnFvI7mmkGt/3+uwWCoWbRY28YQvH9Ydf/8aVrgJNhHZ5aU18vIstdcGouS7kG7PT1lxfopDBY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jdhi9DfU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jdhi9DfU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717464772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hS7MoMwLGfxzIIaXcshKkdRzcS5wR6g5g6pARKgvY1Q=;
	b=Jdhi9DfU7r8p0MCLRYK/JmvCQaVHmmmgGLB09wqpcwO7I+RKcND6QnZmqbxEWhhrp1iKrD
	AQ19EozORz4j6LxHHU5zWrvpyo4Qk/Yg26SpmJi++JrjZEFBSzH5+irKL3ehBF1/p0Y6fs
	oiKMVAvVRt14LMnD6R4219qrAIlRRBg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-ms_oKT4XOAyoNeeyNIaFXg-1; Mon, 03 Jun 2024 21:32:51 -0400
X-MC-Unique: ms_oKT4XOAyoNeeyNIaFXg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c1afd956a6so4192756a91.1
        for <linux-block@vger.kernel.org>; Mon, 03 Jun 2024 18:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717464770; x=1718069570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hS7MoMwLGfxzIIaXcshKkdRzcS5wR6g5g6pARKgvY1Q=;
        b=Y/fpRWlYkrk5qG9JvdQNJ10r7zCEitvUVqBDJjWLQqMevlHNxBgRzdCfc/BTy2x3hc
         ebqI7F8WX0b7qWIY/4IZTNusuwmNJfn6wRXOB9c9c65STcamrgjhYOZTEnfI0FwHat3d
         N/J/AhVKfksu/UPFurFJr4fb2GvQ+Sc/Ii6tMeLDldCEB59MJh4dIvyG9PM+xB5SOyn2
         IFhEboDE2Dc6TBDal7X3p6A4JDn99huHR3gArrhv3Ci8T/sSnjSLOrEL2AW/WdS6GFbm
         FFFMfkE+TLT0qj6jngdtvxUnShxV9+amY4oMRj+RLC85MUyS1pLpQ/sdM+aLi+O6G/Xa
         6w3w==
X-Forwarded-Encrypted: i=1; AJvYcCXAs+OpgA5UpikG3miXa25aZ40zIdZzE9om+VfnnQKgBkPoFa09/1cCNoY2lpT/c13rRAdit4EjPHQS3hlnaTMzB/LAY/UdaU6y/GU=
X-Gm-Message-State: AOJu0Yw8ELhwBCeYbwtuHIcmy/Gal0y/dS4vS75efAjjrv2i3OQx6smr
	Rqr7V+lt93omrqHixjY6nREQF8zvdyR+1haiHy+NDNhnaXc0EjpOWSGwxH8sdF+GD+QfYSEODe9
	PBSTp+pLGj7txGo3SHXamc1zJBinQn8SUM781j8peY+oPtiVS2iUKoh5lBTi41BfstKuW0vU8LK
	hN8Fb2daJu6Q5WVV9dVHmV1MHgRrQ6ChrfHkg=
X-Received: by 2002:a17:90a:c78f:b0:2c0:3467:6c89 with SMTP id 98e67ed59e1d1-2c1dc590c2bmr8133624a91.27.1717464770003;
        Mon, 03 Jun 2024 18:32:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZvVSzVX8Lmmqpq5k6i5O4qLAVbBMIr+jFe3Zq3AuBYhl69BSSoRLGbdjAhqcSyFqUV18L3B6xQ4HhV5nXrW4=
X-Received: by 2002:a17:90a:c78f:b0:2c0:3467:6c89 with SMTP id
 98e67ed59e1d1-2c1dc590c2bmr8133609a91.27.1717464769587; Mon, 03 Jun 2024
 18:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529095313.2568595-1-linan666@huaweicloud.com>
 <Zl0QpCbYVHIkKa/H@fedora> <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
In-Reply-To: <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Tue, 4 Jun 2024 09:32:38 +0800
Message-ID: <CAGVVp+XD5MbYOWL4pbLMxXL0yNKO5NJ84--=KVnW6w5-GF7Drw@mail.gmail.com>
Subject: Re: [PATCH] ublk_drv: fix NULL pointer dereference in ublk_ctrl_start_recovery()
To: Li Nan <linan666@huaweicloud.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, ZiyangZhang@linux.alibaba.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 10:20=E2=80=AFAM Li Nan <linan666@huaweicloud.com> w=
rote:
>
>
>
> =E5=9C=A8 2024/6/3 8:39, Ming Lei =E5=86=99=E9=81=93:
>
> [...]
>
> >> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >> index 4e159948c912..99b621b2d40f 100644
> >> --- a/drivers/block/ublk_drv.c
> >> +++ b/drivers/block/ublk_drv.c
> >> @@ -2630,7 +2630,8 @@ static void ublk_queue_reinit(struct ublk_device=
 *ub, struct ublk_queue *ubq)
> >>   {
> >>      int i;
> >>
> >> -    WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
> >> +    if (WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq))))
> >> +            return;
> >
> > Yeah, it is one bug. However, it could be addressed by adding the check=
 in
> > ublk_ctrl_start_recovery() and return immediately in case of NULL ubq->=
ubq_daemon,
> > what do you think about this way?
> >
>
> Check ub->nr_queues_ready seems better. How about:
>
> @@ -2662,6 +2662,8 @@ static int ublk_ctrl_start_recovery(struct
> ublk_device *ub,
>          mutex_lock(&ub->mutex);
>          if (!ublk_can_use_recovery(ub))
>                  goto out_unlock;
> +       if (!ub->nr_queues_ready)
> +               goto out_unlock;
>          /*
>           * START_RECOVERY is only allowd after:
>           *
>
> >
> > Thanks,
> > Ming
>
> --
> Thanks,
> Nan
>


Hi,Nan

After applying your new patch, I did not trigger "NULL pointer
dereference" and "Warning",
but hit task hung "Call Trace" info, please check

[13617.812306] running generic/004
[13622.293674] blk_print_req_error: 91 callbacks suppressed
[13622.293681] I/O error, dev ublkb4, sector 233256 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[13622.308145] I/O error, dev ublkb4, sector 233256 op 0x0:(READ)
flags 0x0 phys_seg 2 prio class 0
[13622.316923] I/O error, dev ublkb4, sector 233264 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[13622.326048] I/O error, dev ublkb4, sector 233272 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[13622.334828] I/O error, dev ublkb4, sector 233272 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[13622.343954] I/O error, dev ublkb4, sector 233312 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[13622.352733] I/O error, dev ublkb4, sector 233008 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[13622.361514] I/O error, dev ublkb4, sector 233112 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[13622.370292] I/O error, dev ublkb4, sector 233192 op 0x1:(WRITE)
flags 0x8800 phys_seg 1 prio class 0
[13622.379419] I/O error, dev ublkb4, sector 233120 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[13641.069695] INFO: task fio:174413 blocked for more than 122 seconds.
[13641.076061]       Not tainted 6.10.0-rc1+ #1
[13641.080338] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[13641.088164] task:fio             state:D stack:0     pid:174413
tgid:174413 ppid:174386 flags:0x00004002
[13641.088168] Call Trace:
[13641.088170]  <TASK>
[13641.088171]  __schedule+0x221/0x670
[13641.088177]  schedule+0x23/0xa0
[13641.088179]  io_schedule+0x42/0x70
[13641.088181]  blk_mq_get_tag+0x118/0x2b0
[13641.088185]  ? gup_fast_pgd_range+0x280/0x370
[13641.088188]  ? __pfx_autoremove_wake_function+0x10/0x10
[13641.088192]  __blk_mq_alloc_requests+0x194/0x3a0
[13641.088194]  blk_mq_submit_bio+0x241/0x6c0
[13641.088196]  __submit_bio+0x8a/0x1f0
[13641.088199]  submit_bio_noacct_nocheck+0x168/0x250
[13641.088201]  ? submit_bio_noacct+0x45/0x560
[13641.088203]  __blkdev_direct_IO_async+0x167/0x1a0
[13641.088206]  blkdev_write_iter+0x1c8/0x270
[13641.088208]  aio_write+0x11c/0x240
[13641.088212]  ? __rq_qos_issue+0x21/0x40
[13641.088214]  ? blk_mq_start_request+0x34/0x1a0
[13641.088216]  ? io_submit_one+0x68/0x380
[13641.088218]  ? kmem_cache_alloc_noprof+0x4e/0x320
[13641.088221]  ? fget+0x7c/0xc0
[13641.088224]  ? io_submit_one+0xde/0x380
[13641.088226]  io_submit_one+0xde/0x380
[13641.088228]  __x64_sys_io_submit+0x80/0x160
[13641.088229]  do_syscall_64+0x79/0x150
[13641.088233]  ? syscall_exit_to_user_mode+0x6c/0x1f0
[13641.088237]  ? do_io_getevents+0x8b/0xe0
[13641.088238]  ? syscall_exit_work+0xf3/0x120
[13641.088241]  ? syscall_exit_to_user_mode+0x6c/0x1f0
[13641.088243]  ? do_syscall_64+0x85/0x150
[13641.088245]  ? do_syscall_64+0x85/0x150
[13641.088247]  ? blk_mq_flush_plug_list.part.0+0x108/0x160
[13641.088249]  ? rseq_get_rseq_cs+0x1d/0x220
[13641.088252]  ? rseq_ip_fixup+0x6d/0x1d0
[13641.088254]  ? blk_finish_plug+0x24/0x40
[13641.088256]  ? syscall_exit_to_user_mode+0x6c/0x1f0
[13641.088258]  ? do_syscall_64+0x85/0x150
[13641.088260]  ? syscall_exit_to_user_mode+0x6c/0x1f0
[13641.088262]  ? do_syscall_64+0x85/0x150
[13641.088264]  ? syscall_exit_to_user_mode+0x6c/0x1f0
[13641.088266]  ? do_syscall_64+0x85/0x150
[13641.088268]  ? do_syscall_64+0x85/0x150
[13641.088270]  ? do_syscall_64+0x85/0x150
[13641.088272]  ? clear_bhb_loop+0x45/0xa0
[13641.088275]  ? clear_bhb_loop+0x45/0xa0
[13641.088277]  ? clear_bhb_loop+0x45/0xa0
[13641.088279]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[13641.088281] RIP: 0033:0x7ff92150713d
[13641.088283] RSP: 002b:00007ffca1ef81f8 EFLAGS: 00000246 ORIG_RAX:
00000000000000d1
[13641.088285] RAX: ffffffffffffffda RBX: 00007ff9217e2f70 RCX: 00007ff9215=
0713d
[13641.088286] RDX: 000055863b694fe0 RSI: 0000000000000010 RDI: 00007ff9216=
4d000
[13641.088287] RBP: 00007ff92164d000 R08: 00007ff91936d000 R09: 00000000000=
00180
[13641.088288] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00010
[13641.088289] R13: 0000000000000000 R14: 000055863b694fe0 R15: 000055863b6=
970c0
[13641.088291]  </TASK>

Thanks=EF=BC=8C
Changhui

