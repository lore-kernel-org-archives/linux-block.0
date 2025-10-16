Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E149318E1F
	for <linux-block@vger.kernel.org>; Thu, 16 Oct 2025 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760584700; cv=none; b=SW6bJ+w+Up6l7jf7cRzh3B+sG2E9vlxuJkowG+NqNeXh/zglnQZzwbii31uHqTrCo7Bbk6GDp2F8Lo7zzQF/W15q7N7AO6UJe1e1rKKFNdUPqBI0pIvLblxmHAt5zezoR4hJ/JKSKXWkfUQY2q0aiHj28/oU4XnlJSLH6Ei8GTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760584700; c=relaxed/simple;
	bh=h7nV2zyc4PJ21sNzbN+qMVxjJs31WVPwiVNu5PnGtyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wg3ySVvdvZFOwGRWObBGRsetXv9hnWcuuVJlW/Y0al1HDspnXqQzBv2zm3vAcld+NsrBaYHfJ5oMdG+nKXRKBk7oo3HLnFc/K80Y/pR+ygk5nskXDAQI1XbB/Bra9emAYA4VAZDGKT+3QtXJjeunF/usbgbK32Y0yoTJkdxIZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dw9dlqnB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dw9dlqnB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760584697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kyF+oheONqeIl4B6gEjw6GjFoHceuQtsr2EqrRZU+P8=;
	b=Dw9dlqnBj9KonDLT4EdE+gJZQ8Y7Z5xFJAdXPUxEm/OkUOENeDbwjE3MoHQ+liiS9ckCoq
	F/V0MITE7HTjJMC4vrhB5CQzDe77SomA0z2NZcZEZjdDdyESe0IU+0SYCaU1lru3lv3VaT
	VIQUokz3V9vwdqc0ODWnS/EPx5tlYsg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-cktAsdB9ORyR4qN24988mA-1; Wed, 15 Oct 2025 23:18:16 -0400
X-MC-Unique: cktAsdB9ORyR4qN24988mA-1
X-Mimecast-MFC-AGG-ID: cktAsdB9ORyR4qN24988mA_1760584695
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-35f62a3c170so994041fa.0
        for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 20:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760584694; x=1761189494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyF+oheONqeIl4B6gEjw6GjFoHceuQtsr2EqrRZU+P8=;
        b=Dj3o5BNt5QbRKzRfYIhpBSNEZWeO/CHMJkNXdsz8WNABDOIUOJ4knXRj167qH2b75M
         DRu/YZIn2xXO2un01xCd9tHO7hnDUJLd4tQFaE6hvFKF2CBJrsiIYCknRGWfrJNKrP6H
         TQvuRbRcUq/vxdWoB1WcLJ3zDMHMzC/eXA22LSC2LaJs1yt3q+Coz65520vrHSqjuyPc
         ctLBdCWYh6GPhV11Qrj6af94zzjJaS0OfEwGuJ7J9sBQYp3UqPbCTMhWLgRlmpEmuwQ3
         8PRj/MY4D7ghitxxuqjPxlhhgWvnBU2Q8ixJu8uh3nTz2zBLK7TleI8LEytsfmk2Suou
         PnAg==
X-Gm-Message-State: AOJu0YwQRC7GaLY7ZtTTiD8g5C5F3dIJO855HqSqK83BZT3xEV0vuk4q
	Pd/yJuxiveU2X6YA5kJYg1bV1uKzeIKxfXD3uWrCRcEoRO0ktClfbznVXcrHrI4ynrDYDFcG/zD
	hYYynV53ujl3fnF+B3s6IwbvbEhsxdBihY+lPt2wO7DH+g3QW0ezRJZQVGrIBA3ExqaY+V1NThE
	4AAMgJv4hCbLgepGZV1d9PE9JuRYQ/TcdlKIQNbJ9I99koijluvj9FI58=
X-Gm-Gg: ASbGnctknaCFtvNs3AdlF0lnSeUvJQhWDMvNVhqvUgiSR1obvBldSSq6ynVbNyVgtPC
	oTpcJ4GNxZzA3jSxolTXJmp7HLBdTjNgvXkOijkq91M9/0v1iUtxKQRHaPrqyXkrpmrOdxNn3zz
	SG2ULS/wKEVT+L7OIMKHGUkK5l/lyGocFj1BXGcF3zLaP8LAso4wucTdbh
X-Received: by 2002:a2e:bd14:0:b0:367:8b63:3364 with SMTP id 38308e7fff4ca-37609e934ccmr80937511fa.36.1760584693961;
        Wed, 15 Oct 2025 20:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy8Zro1YKF2ZNjOfG/+7gZ+WY5dJmvPckzjSPcMXG5IkMa6hs5z/uW69eJeM5/wso36OwYoBTRRGyNjQad9Zk=
X-Received: by 2002:a2e:bd14:0:b0:367:8b63:3364 with SMTP id
 38308e7fff4ca-37609e934ccmr80937481fa.36.1760584693466; Wed, 15 Oct 2025
 20:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015014827.2997591-1-yukuai3@huawei.com> <5c13a5e3f257ceccb70e3d63869d8a9b6d963f6242b23690cff9d9ca7b9dbdf8@mailrelay.wdc.com>
 <oeyzci6ffshpukpfqgztsdeke5ost5hzsuz4rrsjfmvpqcevax@5nhnwbkzbrpa>
In-Reply-To: <oeyzci6ffshpukpfqgztsdeke5ost5hzsuz4rrsjfmvpqcevax@5nhnwbkzbrpa>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 16 Oct 2025 11:18:01 +0800
X-Gm-Features: AS18NWAPOA47tTHJL7c0PLVyHB0zCN_kwT0D2NuDM2tN0JwoB72kjqoT1iQXd1o
Message-ID: <CAHj4cs-yh_k==QjqDDkW4XViUGhRo3oJVpqQGdb28tr_kUbcpA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix stale tag depth for shared sched tags in blk_mq_update_nr_requests()
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 9:11=E2=80=AFAM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Oct 15, 2025 / 12:15, shinichiro.kawasaki@wdc.com wrote:
> > Dear patch submitter,
> >
> > Blktests CI has tested the following submission:
> > Status:     FAILURE
> > Name:       blk-mq: fix stale tag depth for shared sched tags in blk_mq=
_update_nr_requests()
> > Patchwork:  https://patchwork.kernel.org/project/linux-block/list/?seri=
es=3D1011590&state=3D*
> > Run record: https://github.com/linux-blktests/linux-block/actions/runs/=
18524669753
> >
> >
> > Failed test cases: nvme/057
>
> Blktests CI tested this patch and observed that the test case nvme/057 fa=
iled
> with the loop transport due to the lockdep WARN below. However, the failu=
re
> symptom does not look releated to the patch.
>
> This failure looks new to me. Actions for fix will be appreciated. I will
> disable the test case for blktests CI.

From the log, it seems it was similar to this one:
https://lore.kernel.org/linux-block/CAHj4cs8mJ+R_GmQm9R8ebResKAWUE8kF5+_WVg=
0v8zndmqd6BQ@mail.gmail.com/


>
> [11280.536805] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [11280.537957] WARNING: possible circular locking dependency detected
> [11280.538987] 6.18.0-rc1 #1 Tainted: G            E
> [11280.539846] ------------------------------------------------------
> [11280.540751] (udev-worker)/45976 is trying to acquire lock:
> [11280.541614] ffff888100cc2148 ((wq_completion)kblockd){+.+.}-{0:0}, at:=
 touch_wq_lockdep_map+0x7a/0x180
> [11280.542862]
>                but task is already holding lock:
> [11280.544086] ffff88812bc63358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev=
_release+0x133/0x610
> [11280.545176]
>                which lock already depends on the new lock.
>
> [11280.546881]
>                the existing dependency chain (in reverse order) is:
> [11280.548140]
>                -> #2 (&disk->open_mutex){+.+.}-{4:4}:
> [11280.549314]        __lock_acquire+0x56d/0xc20
> [11280.550023]        lock_acquire.part.0+0xb7/0x220
> [11280.550746]        __mutex_lock+0x1a6/0x2110
> [11280.551469]        nvme_partition_scan_work+0x8a/0x120 [nvme_core]
> [11280.552362]        process_one_work+0x854/0x1460
> [11280.553087]        worker_thread+0x5f3/0xfe0
> [11280.553785]        kthread+0x3a5/0x760
> [11280.554463]        ret_from_fork+0x2d3/0x3d0
> [11280.555191]        ret_from_fork_asm+0x1a/0x30
> [11280.555918]
>                -> #1 ((work_completion)(&head->partition_scan_work)){+.+.=
}-{0:0}:
> [11280.557334]        __lock_acquire+0x56d/0xc20
> [11280.558061]        lock_acquire.part.0+0xb7/0x220
> [11280.558818]        process_one_work+0x7ed/0x1460
> [11280.559600]        worker_thread+0x5f3/0xfe0
> [11280.560339]        kthread+0x3a5/0x760
> [11280.561024]        ret_from_fork+0x2d3/0x3d0
> [11280.561753]        ret_from_fork_asm+0x1a/0x30
> [11280.562504]
>                -> #0 ((wq_completion)kblockd){+.+.}-{0:0}:
> [11280.563805]        check_prev_add+0xeb/0xca0
> [11280.564547]        validate_chain+0x46e/0x560
> [11280.565302]        __lock_acquire+0x56d/0xc20
> [11280.566084]        lock_acquire.part.0+0xb7/0x220
> [11280.566885]        touch_wq_lockdep_map+0x93/0x180
> [11280.567674]        start_flush_work+0x67d/0xc10
> [11280.568446]        __flush_work+0xc6/0x1a0
> [11280.569175]        nvme_mpath_put_disk+0x4f/0xa0 [nvme_core]
> [11280.570040]        nvme_free_ns_head+0x23/0x160 [nvme_core]
> [11280.570907]        bdev_release+0x3be/0x610
> [11280.571652]        blkdev_release+0x11/0x20
> [11280.572397]        __fput+0x372/0xaa0
> [11280.573118]        fput_close_sync+0xe5/0x190
> [11280.573869]        __x64_sys_close+0x7d/0xd0
> [11280.574617]        do_syscall_64+0x97/0x800
> [11280.575355]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [11280.576194]
>                other info that might help us debug this:
>
> [11280.577944] Chain exists of:
>                  (wq_completion)kblockd --> (work_completion)(&head->part=
ition_scan_work) --> &disk->open_mutex
>
> [11280.580191]  Possible unsafe locking scenario:
>
> [11280.581402]        CPU0                    CPU1
> [11280.582143]        ----                    ----
> [11280.582892]   lock(&disk->open_mutex);
> [11280.583583]                                lock((work_completion)(&hea=
d->partition_scan_work));
> [11280.584656]                                lock(&disk->open_mutex);
> [11280.585537]   lock((wq_completion)kblockd);
> [11280.586260]
>                 *** DEADLOCK ***
>
> [11280.587885] 2 locks held by (udev-worker)/45976:
> [11280.588645]  #0: ffff88812bc63358 (&disk->open_mutex){+.+.}-{4:4}, at:=
 bdev_release+0x133/0x610
> [11280.589732]  #1: ffffffff9f31f100 (rcu_read_lock){....}-{1:3}, at: sta=
rt_flush_work+0x34/0xc10
> [11280.590827]
>                stack backtrace:
> [11280.591935] CPU: 3 UID: 0 PID: 45976 Comm: (udev-worker) Tainted: G   =
         E       6.18.0-rc1 #1 PREEMPT(lazy)
> [11280.591943] Tainted: [E]=3DUNSIGNED_MODULE
> [11280.591946] Hardware name: KubeVirt None/RHEL, BIOS 1.16.3-2.el9 04/01=
/2014
> [11280.591955] Call Trace:
> [11280.591968]  <TASK>
> [11280.591973]  dump_stack_lvl+0x6e/0xa0
> [11280.591982]  print_circular_bug.cold+0x38/0x45
> [11280.591994]  check_noncircular+0x146/0x160
> [11280.592005]  check_prev_add+0xeb/0xca0
> [11280.592013]  validate_chain+0x46e/0x560
> [11280.592022]  __lock_acquire+0x56d/0xc20
> [11280.592030]  lock_acquire.part.0+0xb7/0x220
> [11280.592035]  ? touch_wq_lockdep_map+0x7a/0x180
> [11280.592042]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592046]  ? find_held_lock+0x2b/0x80
> [11280.592050]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592054]  ? lock_acquire+0xee/0x130
> [11280.592060]  ? touch_wq_lockdep_map+0x7a/0x180
> [11280.592064]  touch_wq_lockdep_map+0x93/0x180
> [11280.592069]  ? touch_wq_lockdep_map+0x7a/0x180
> [11280.592072]  ? start_flush_work+0x5ae/0xc10
> [11280.592078]  start_flush_work+0x67d/0xc10
> [11280.592087]  __flush_work+0xc6/0x1a0
> [11280.592091]  ? __pfx___flush_work+0x10/0x10
> [11280.592096]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592099]  ? find_held_lock+0x2b/0x80
> [11280.592104]  ? __pfx_wq_barrier_func+0x10/0x10
> [11280.592118]  ? __pfx___might_resched+0x10/0x10
> [11280.592126]  ? queue_work_on+0x8e/0xc0
> [11280.592130]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592134]  ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x150
> [11280.592138]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592147]  nvme_mpath_put_disk+0x4f/0xa0 [nvme_core]
> [11280.592166]  nvme_free_ns_head+0x23/0x160 [nvme_core]
> [11280.592183]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592188]  bdev_release+0x3be/0x610
> [11280.592197]  blkdev_release+0x11/0x20
> [11280.592202]  __fput+0x372/0xaa0
> [11280.592211]  fput_close_sync+0xe5/0x190
> [11280.592217]  ? __pfx_fput_close_sync+0x10/0x10
> [11280.592227]  __x64_sys_close+0x7d/0xd0
> [11280.592233]  do_syscall_64+0x97/0x800
> [11280.592237]  ? __fput+0x504/0xaa0
> [11280.592242]  ? fput_close_sync+0xe5/0x190
> [11280.592250]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592254]  ? fput_close_sync+0xe5/0x190
> [11280.592259]  ? __pfx_fput_close_sync+0x10/0x10
> [11280.592264]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592268]  ? do_raw_spin_unlock+0x14a/0x1f0
> [11280.592275]  ? do_syscall_64+0x11b/0x800
> [11280.592278]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592282]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592286]  ? do_syscall_64+0x139/0x800
> [11280.592290]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592294]  ? do_syscall_64+0x11b/0x800
> [11280.592297]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592302]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592306]  ? do_syscall_64+0x139/0x800
> [11280.592310]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592313]  ? __x64_sys_symlinkat+0x165/0x1f0
> [11280.592322]  ? do_syscall_64+0x11b/0x800
> [11280.592325]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592330]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592333]  ? do_syscall_64+0x139/0x800
> [11280.592338]  ? srso_alias_return_thunk+0x5/0xfbef5
> [11280.592341]  ? do_syscall_64+0x139/0x800
> [11280.592345]  ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x150
> [11280.592351]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [11280.592355] RIP: 0033:0x7fe0e347aae6
> [11280.592361] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 19 8=
3 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45 10 0f 05 <=
48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
> [11280.592365] RSP: 002b:00007ffe6ca41920 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000003
> [11280.592378] RAX: ffffffffffffffda RBX: 00005640c8945570 RCX: 00007fe0e=
347aae6
> [11280.592382] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000012
> [11280.592387] RBP: 00007ffe6ca41940 R08: 0000000000000000 R09: 000000000=
0000000
> [11280.592389] R10: 0000000000000000 R11: 0000000000000202 R12: 00005640c=
8f5f920
> [11280.592392] R13: 00007ffe6ca41ca0 R14: 0000000000000000 R15: 000000000=
0000011
> [11280.592405]  </TASK>
>


--=20
Best Regards,
  Yi Zhang

