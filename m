Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8991F8725
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 05:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631504; cv=none; b=ozAuDzWZNRLxlHcXV+KxdzNv2EYAB31cGRfpitPz+H+R+N3bIJlbutQfMytBeYbl5TyIdnTdcAEtVpXvlSNoHECzRbPjTEos9yO7OZUlndQm34OZEATzU7xwNoaf4CzlWmJTN3M7pUfBbipaZEWPJAXKVi5Xc8QBRGxuLQeYRfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631504; c=relaxed/simple;
	bh=BFQcpA/BUYHYb/NSbPsn3Uikm3qDa+v2EcuoCEcaacA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hTc0kvAdivmF38Jl6+vvph8Q5MSLZPjWYdai634V+w1iKnfvUdLW6Df4xy9H2NZgXmb79uRiL3f3caLShEWFSFtrdlf8GewnTGEuUL6TQE04PgS+nkv78hXJNJxhF/osY3zXE6jqLSiiwlglYOHr7at2qrSJadswTRmE4kzyS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZIpNe4P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZIpNe4P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754631501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gyeRs5e///j7ckLRS6SCy8v7D1cTWtkKp9rwIrlq5Fw=;
	b=aZIpNe4PzV+TLFt5DzR9bPavHH7VVd2Izky7OH0bkazCH1Gkiax37BtI2CwprZvQao3cmw
	DnvRAyAxyHeEkOH4c28wQqXzyKbJI4ekIcalYrF70lFuiUWrJAjfZwV5GdFjSmLWajx6Or
	hMYzh5TxRNZ7vBcjWeL9olM2GlCLa7s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-LpQcbr2MPiClvJmyDILA8w-1; Fri, 08 Aug 2025 01:38:19 -0400
X-MC-Unique: LpQcbr2MPiClvJmyDILA8w-1
X-Mimecast-MFC-AGG-ID: LpQcbr2MPiClvJmyDILA8w_1754631498
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31f322718faso1408615a91.0
        for <linux-block@vger.kernel.org>; Thu, 07 Aug 2025 22:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754631498; x=1755236298;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyeRs5e///j7ckLRS6SCy8v7D1cTWtkKp9rwIrlq5Fw=;
        b=jV/zVCaGBDeEnHVz5Ys9xhv1S4F2nno0cmXk0OtfKNJkOQUEg5EcGWcCI2MknL6diG
         nHh+zL3Oy8Qj8ADza5G+aIFuYKGWx6BuokRe8M6Pirnq3aCf0N97wZklhVczKqKd7sCM
         qLn/7xO5gk6UyBGtTqAkPbQzJKioaH6Svsft+p5uPmRrudqV9NUfX6aDGu73OkOZfJq9
         bkwTeMCHGijdUYWtaqnvX4qhp42W0s9dq3lXXKm7oQ7+2EAmZT+QuhrUpnrobNlK89AX
         RVbiBmT5Uffq2JovJhPe66654scFYDHOsw43EuDuLUArph1TBkyVTh2ACHAZ6vtUnOYp
         dnwQ==
X-Gm-Message-State: AOJu0Yw/F5PbCi9DKmpZyIByk2BRc/COTHEDfmgTUbrrwpjF9PLsq6Ga
	dS9DE9Bm+yKzN8XBGESpGtkKEHouugMFOALVcamoa81IziaUTT9TYxBgl74YEiekCfEzEpQZO0j
	8sVpCFP5Sarzq9cxplu/0Qk1cRclfHjVsYGYTDV3fOOcVISX+q/a028PMKKjov6tLHHFh+lFHF1
	lZTdt8g/Dx8fDgV84Fw2BZHqbXu3A5eOad8lcVWsmzPsP3sGv/bu2h
X-Gm-Gg: ASbGncv9kcIbAxBSxzeMq9PPq2VMEtCkDeFMvjoyzEbCM73klszAqos+3iz/5+l/7z1
	fKaOHs7Eb2m8TXwFaQ88VrEGKW6G1sEA/vv1YA/KNCUKMXB1hlNRx4Ht25KviLwfur9Npa952rs
	3q1tBmyfnjb74tmG0HCpTkIQ==
X-Received: by 2002:a17:90b:3ec5:b0:321:27d5:eaf1 with SMTP id 98e67ed59e1d1-32183c45f17mr2178155a91.25.1754631497546;
        Thu, 07 Aug 2025 22:38:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk0DNgiVsTFHcUohiYqFsEx7a7A+BydDRTXDsOavknogS39RbmMx56OJjOGo7f+xbLtmpwfYYP+kC2aMX3nLM=
X-Received: by 2002:a17:90b:3ec5:b0:321:27d5:eaf1 with SMTP id
 98e67ed59e1d1-32183c45f17mr2178114a91.25.1754631496864; Thu, 07 Aug 2025
 22:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Fri, 8 Aug 2025 13:38:05 +0800
X-Gm-Features: Ac12FXzGOhsCx_uuh5HkvU1DRJs4jjGNGc5nohbQJ8_XFBV9_FwL1DY9kgPwgpk
Message-ID: <CAGVVp+UogrEM9msnhEr0qDo6vex=yA8QGN_q13SPBFZDLv6gCw@mail.gmail.com>
Subject: [bug report] WARNING: possible circular locking dependency detected
 at pcpu_alloc_noprof+0x8a3/0xd50 and __blk_mq_update_nr_hw_queues+0x30d/0xc50
To: Linux Block Devices <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

the following warning was triggered,
please help check and let me know if you need any info/test, thanks.

repo=EF=BC=9Ahttps://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-bl=
ock.git
branch=EF=BC=9Afor-next
INFO: HEAD of cloned kernel=EF=BC=9A
commit 20c74c07321713217b2f84c55dfd717729aa6111
Merge: f1815afd0877 407728da41cd
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Aug 4 09:23:02 2025 -0600

    Merge branch 'block-6.17' into for-next

    * block-6.17:
      block, bfq: Reorder struct bfq_iocq_bfqq_data

Test script:
modprobe null_blk nr_devices=3D0
mkdir -p /sys/kernel/config/nullb/nullb0
while true; do echo 1 > submit_queues; echo 4 > submit_queues; done &
while true; do echo 1 > power; echo 0 > power; done

dmesg log:
[  239.231772] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  239.238678] WARNING: possible circular locking dependency detected
[  239.245581] 6.16.0+ #1 Tainted: G S
[  239.251128] ------------------------------------------------------
[  239.258029] bash/2944 is trying to acquire lock:
[  239.263186] ffffffffaab45790 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
pcpu_alloc_noprof+0x8a3/0xd50
[  239.272823]
[  239.272823] but task is already holding lock:
[  239.279336] ff11000160064a68
(&q->q_usage_counter(io)#10){++++}-{0:0}, at:
__blk_mq_update_nr_hw_queues+0x30d/0xc50
[  239.291006]
[  239.291006] which lock already depends on the new lock.
[  239.291006]
[  239.300137]
[  239.300137] the existing dependency chain (in reverse order) is:
[  239.308494]
[  239.308494] -> #2 (&q->q_usage_counter(io)#10){++++}-{0:0}:
[  239.316376]        __lock_acquire+0x57c/0xbd0
[  239.321246]        lock_acquire.part.0+0xbd/0x260
[  239.326500]        blk_alloc_queue+0x5ca/0x710
[  239.331464]        blk_mq_alloc_queue+0x14b/0x230
[  239.336720]        __blk_mq_alloc_disk+0x18/0xd0
[  239.341878]        null_add_dev+0x7b6/0x1410 [null_blk]
[  239.347727]        nullb_device_power_store+0x1e6/0x280 [null_blk]
[  239.354638]        configfs_write_iter+0x2ac/0x460
[  239.359990]        vfs_write+0x525/0xfd0
[  239.364373]        ksys_write+0xf9/0x1d0
[  239.368755]        do_syscall_64+0x94/0x8d0
[  239.373429]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  239.379655]
[  239.379655] -> #1 (fs_reclaim){+.+.}-{0:0}:
[  239.385982]        __lock_acquire+0x57c/0xbd0
[  239.390847]        lock_acquire.part.0+0xbd/0x260
[  239.396103]        fs_reclaim_acquire+0xc9/0x110
[  239.401260]        __kmalloc_noprof+0xba/0x5e0
[  239.406225]        pcpu_alloc_chunk+0x24/0x3e0
[  239.411190]        pcpu_create_chunk+0x12/0x350
[  239.416251]        pcpu_alloc_noprof+0xaa8/0xd50
[  239.421410]        bts_init+0x139/0x1e0
[  239.425697]        do_one_initcall+0xa4/0x260
[  239.430564]        do_initcalls+0x1b4/0x1f0
[  239.435238]        kernel_init_freeable+0x4a8/0x520
[  239.440686]        kernel_init+0x1c/0x150
[  239.445164]        ret_from_fork+0x390/0x480
[  239.449936]        ret_from_fork_asm+0x1a/0x30
[  239.454900]
[  239.454900] -> #0 (pcpu_alloc_mutex){+.+.}-{4:4}:
[  239.461810]        check_prev_add+0xf1/0xcd0
[  239.466578]        validate_chain+0x487/0x570
[  239.471444]        __lock_acquire+0x57c/0xbd0
[  239.476311]        lock_acquire.part.0+0xbd/0x260
[  239.481565]        __mutex_lock+0x1a9/0x1b20
[  239.486337]        pcpu_alloc_noprof+0x8a3/0xd50
[  239.491497]        sbitmap_init_node+0x281/0x730
[  239.496656]        sbitmap_queue_init_node+0x2d/0x440
[  239.502298]        blk_mq_init_tags+0x10d/0x250
[  239.507358]        blk_mq_alloc_map_and_rqs+0xa6/0x310
[  239.513099]        __blk_mq_alloc_map_and_rqs+0x104/0x1f0
[  239.519132]        blk_mq_realloc_tag_set_tags+0x1e8/0x300
[  239.525261]        __blk_mq_update_nr_hw_queues+0x562/0xc50
[  239.531488]        blk_mq_update_nr_hw_queues+0x3b/0x60
[  239.537325]        nullb_update_nr_hw_queues+0x1a9/0x370 [null_blk]
[  239.544331]        nullb_device_submit_queues_store+0xdb/0x170 [null_blk=
]
[  239.551911]        configfs_write_iter+0x2ac/0x460
[  239.557265]        vfs_write+0x525/0xfd0
[  239.561647]        ksys_write+0xf9/0x1d0
[  239.566027]        do_syscall_64+0x94/0x8d0
[  239.570699]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  239.576924]
[  239.576924] other info that might help us debug this:
[  239.576924]
[  239.585861] Chain exists of:
[  239.585861]   pcpu_alloc_mutex --> fs_reclaim --> &q->q_usage_counter(io=
)#10
[  239.585861]
[  239.598594]  Possible unsafe locking scenario:
[  239.598594]
[  239.605205]        CPU0                    CPU1
[  239.610263]        ----                    ----
[  239.615311]   lock(&q->q_usage_counter(io)#10);
[  239.620375]                                lock(fs_reclaim);
[  239.626696]                                lock(&q->q_usage_counter(io)#=
10);
[  239.634573]   lock(pcpu_alloc_mutex);
[  239.638667]
[  239.638667]  *** DEADLOCK ***
[  239.638667]
[  239.645276] 8 locks held by bash/2944:
[  239.649462]  #0: ff11000111862448 (sb_writers#12){.+.+}-{0:0}, at:
ksys_write+0xf9/0x1d0
[  239.658512]  #1: ff11000195e25c90 (&buffer->mutex){+.+.}-{4:4}, at:
configfs_write_iter+0x71/0x460
[  239.668528]  #2: ff110001a805ba80 (&p->frag_sem){.+.+}-{4:4}, at:
configfs_write_iter+0x1d9/0x460
[  239.678447]  #3: ffffffffc2079130 (&lock){+.+.}-{4:4}, at:
nullb_device_submit_queues_store+0xab/0x170 [null_blk]
[  239.689924]  #4: ff1100016800e1d8
(&set->update_nr_hwq_lock){++++}-{4:4}, at:
blk_mq_update_nr_hw_queues+0x27/0x60
[  239.701493]  #5: ff1100016800e118
(&set->tag_list_lock){+.+.}-{4:4}, at:
blk_mq_update_nr_hw_queues+0x31/0x60
[  239.712577]  #6: ff11000160064a68
(&q->q_usage_counter(io)#10){++++}-{0:0}, at:
__blk_mq_update_nr_hw_queues+0x30d/0xc50
[  239.724729]  #7: ff11000160064aa8
(&q->q_usage_counter(queue)#7){+.+.}-{0:0}, at:
__blk_mq_update_nr_hw_queues+0x30d/0xc50
[  239.737077]
[  239.737077] stack backtrace:
[  239.741945] CPU: 1 UID: 0 PID: 2944 Comm: bash Kdump: loaded
Tainted: G S                  6.16.0+ #1 PREEMPT(voluntary)
[  239.741952] Tainted: [S]=3DCPU_OUT_OF_SPEC
[  239.741954] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
BIOS AFE120G-1.40 09/20/2022
[  239.741957] Call Trace:
[  239.741960]  <TASK>
[  239.741963]  dump_stack_lvl+0x6f/0xb0
[  239.741971]  print_circular_bug.cold+0x38/0x45
[  239.741978]  check_noncircular+0x148/0x160
[  239.741985]  check_prev_add+0xf1/0xcd0
[  239.741989]  ? alloc_chain_hlocks+0x13e/0x1d0
[  239.741994]  ? add_chain_cache+0x12c/0x310
[  239.742001]  validate_chain+0x487/0x570
[  239.742007]  __lock_acquire+0x57c/0xbd0
[  239.742013]  lock_acquire.part.0+0xbd/0x260
[  239.742017]  ? pcpu_alloc_noprof+0x8a3/0xd50
[  239.742023]  ? rcu_is_watching+0x15/0xb0
[  239.742029]  ? lock_acquire+0x10b/0x150
[  239.742035]  __mutex_lock+0x1a9/0x1b20
[  239.742040]  ? pcpu_alloc_noprof+0x8a3/0xd50
[  239.742045]  ? pcpu_alloc_noprof+0x8a3/0xd50
[  239.742050]  ? stack_depot_save_flags+0x3cb/0x670
[  239.742056]  ? __pfx___mutex_lock+0x10/0x10
[  239.742061]  ? kasan_save_stack+0x3f/0x50
[  239.742065]  ? kasan_save_stack+0x30/0x50
[  239.742069]  ? kasan_save_track+0x14/0x30
[  239.742072]  ? __kasan_kmalloc+0x8f/0xa0
[  239.742075]  ? blk_mq_init_tags+0x6c/0x250
[  239.742078]  ? blk_mq_alloc_map_and_rqs+0xa6/0x310
[  239.742084]  ? __blk_mq_update_nr_hw_queues+0x562/0xc50
[  239.742089]  ? blk_mq_update_nr_hw_queues+0x3b/0x60
[  239.742095]  ? do_syscall_64+0x94/0x8d0
[  239.742099]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  239.742106]  ? pcpu_alloc_noprof+0x8a3/0xd50
[  239.742110]  pcpu_alloc_noprof+0x8a3/0xd50
[  239.742120]  sbitmap_init_node+0x281/0x730
[  239.742128]  sbitmap_queue_init_node+0x2d/0x440
[  239.742133]  ? __raw_spin_lock_init+0x3f/0x110
[  239.742139]  blk_mq_init_tags+0x10d/0x250
[  239.742144]  blk_mq_alloc_map_and_rqs+0xa6/0x310
[  239.742151]  __blk_mq_alloc_map_and_rqs+0x104/0x1f0
[  239.742158]  blk_mq_realloc_tag_set_tags+0x1e8/0x300
[  239.742164]  __blk_mq_update_nr_hw_queues+0x562/0xc50
[  239.742170]  ? trace_contention_end+0x97/0x1b0
[  239.742176]  ? __pfx___blk_mq_update_nr_hw_queues+0x10/0x10
[  239.742185]  ? __lock_acquired+0xe0/0x280
[  239.742194]  ? __pfx_down_write+0x10/0x10
[  239.742203]  blk_mq_update_nr_hw_queues+0x3b/0x60
[  239.742209]  nullb_update_nr_hw_queues+0x1a9/0x370 [null_blk]
[  239.742223]  nullb_device_submit_queues_store+0xdb/0x170 [null_blk]
[  239.742235]  ? __pfx_nullb_device_submit_queues_store+0x10/0x10 [null_bl=
k]
[  239.742249]  configfs_write_iter+0x2ac/0x460
[  239.742255]  vfs_write+0x525/0xfd0
[  239.742262]  ? __pfx_vfs_write+0x10/0x10
[  239.742272]  ? local_clock_noinstr+0xd/0xe0
[  239.742278]  ? __lock_release.isra.0+0x1a4/0x2c0
[  239.742283]  ksys_write+0xf9/0x1d0
[  239.742287]  ? __pfx_ksys_write+0x10/0x10
[  239.742294]  do_syscall_64+0x94/0x8d0
[  239.742299]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  239.742303]  ? lockdep_hardirqs_on+0x78/0x100
[  239.742308]  ? do_syscall_64+0x139/0x8d0
[  239.742312]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  239.742315]  ? lockdep_hardirqs_on+0x78/0x100
[  239.742320]  ? do_syscall_64+0x139/0x8d0
[  239.742324]  ? clear_bhb_loop+0x50/0xa0
[  239.742329]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  239.742333] RIP: 0033:0x7fc035fc0894
[  239.742339] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d 35 d8 0d 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24
18 48
[  239.742343] RSP: 002b:00007fffc2e7a108 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[  239.742348] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fc035f=
c0894
[  239.742351] RDX: 0000000000000002 RSI: 000055ce35bef050 RDI: 00000000000=
00001
[  239.742354] RBP: 000055ce35bef050 R08: 0000000000000073 R09: 00000000fff=
fffff
[  239.742356] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00002
[  239.742359] R13: 00007fc0360975c0 R14: 0000000000000002 R15: 00007fc0360=
94f00
[  239.742367]  </TASK>

Best Regards,
Changhui

