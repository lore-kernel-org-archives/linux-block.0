Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ED21BC5C
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531452; cv=none; b=JW1EUjEToJwQsGQILfZ5UmRcrjUiAcsYrg898Zyqp0z9BzUqHlcE6MHLfmQmR1jm7LmYngMgecHLNgzbgtbYNqK0NsFa1ZZiiXhBMjO9dQNC1Xviue0KnxNqcBz10N+O5DT1gWy3swkJbNH1foNV2/wcJ9TUOUojFnqw6WZXDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531452; c=relaxed/simple;
	bh=rtr5z/Bp77d9kWvgtyhhsS8LPP8L1Z6BO/gkHK93mUo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uZroI2Y1tMR4DGgphXgDkoAL2zo0sIaAVs+QIJG9RwcWmYZzAG4JnkjKMaIudb/NQrlAZyFTjcyYVDCJdpHThZeNTvm/yYAXLhlARLQdOdzL2ad7nlHS4gexUJY5A56o6wxvOALMWnxCQ/OwnS9xX2zv8eXyRsL082cM24tvuZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jP/2Vv9W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jP/2Vv9W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760531448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Eobw1JDIJOdHkXZ2QI6gIzufiDZxM/erp3ttoxwR2dc=;
	b=jP/2Vv9WsmGs+nmdAvpOgHa4u16hh4RV00TWrsPoMbwzeN+yeD71SSflcG9VNWztQi8m3l
	1p+cKZSQH3z++/EAvzmOtLZjwHrqIs+0gDMf6L0fCH6dnjnFsmMPZGLrGJlxwUDXZg8ede
	QUNUf03k1HvKzm9Qx0eWPB1hVZQPPdc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-4pM_MWPWPKGnoCb5i9-s3Q-1; Wed, 15 Oct 2025 08:30:47 -0400
X-MC-Unique: 4pM_MWPWPKGnoCb5i9-s3Q-1
X-Mimecast-MFC-AGG-ID: 4pM_MWPWPKGnoCb5i9-s3Q_1760531446
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-37773b477c6so11389201fa.2
        for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 05:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760531445; x=1761136245;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eobw1JDIJOdHkXZ2QI6gIzufiDZxM/erp3ttoxwR2dc=;
        b=e8aegiHELFhAHPUL24w/96MCE47dIylg3J2V6ZQRxu2qpxzpk41kAvlxzGwhsU7ngc
         sutbUTHvOj8w6Y2XOF8I2i6eq3IjrG9u8UM7Ol/VEKnKEgsFr5v/Cut67kiYIZ+GtpUW
         +UPM0L75v9xS3CYNVDJJ58kYHZnJtIuVfiF3h6QClS9PIORg7zZn70o39ubjeUGhmbs6
         Lq3hnubrLaMaD8uGoTHlCqi8yO0mXkCmr3drnCNSnl2ijmgy0a3o50kWaA2CqOeCkq+j
         NOa28NfVfV3RL+Cdqlr9IrcP80spFF3ODgef+3+e9KdQN2c1No8RMKzZwTZ93NWEmWW3
         9u2w==
X-Gm-Message-State: AOJu0YynN71BU4qUgBc7GbaGKrcYqgPl3vz90Nl+w/Sih/eFeZU7hnd/
	yaBLk8oRgp0NnwQXeZ+z3XOj/S/EBbFqsRHN6DKmzw/TUV1EihV8BU2w4/tF4T9wlGUQVnx3gKH
	2fSXAStPpz9RSgal/xa9Dt/5Bk3cn+XaIMdnyoaK0g1Ak2U+CjMJ3YPRdTKn+mCEXq3hdsxm2o9
	8NKvA2TXbdbIEwYLL+LD9+RXhUCfbKw2DtKCblvmpO6020sRLTaBl6yFI=
X-Gm-Gg: ASbGncuoLrjcuo46AOIU/PqzvY7L9JCAqRZgFhsZAMKUConsHJEkiVeu25BpiUPWDtu
	tpkIArytX8+95bM5oNb4p1r8QMBiIl44ACCqayUKho20GfjWPh83GL18qvA7FdDTVZZE5myN/Rt
	SXKGdNNJdacSi/GOl1eNpzHw==
X-Received: by 2002:a05:651c:1991:b0:375:ffc2:1b38 with SMTP id 38308e7fff4ca-37609d68d65mr73169071fa.11.1760531444113;
        Wed, 15 Oct 2025 05:30:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfVhB/8z04MwpFsQsW6NbaTvOim2INKvQvHuAnC/VcXfNE/A2aqTGH8w3j58mJhYOfWuxhW0nlPTiRfGjJMng=
X-Received: by 2002:a05:651c:1991:b0:375:ffc2:1b38 with SMTP id
 38308e7fff4ca-37609d68d65mr73168971fa.11.1760531443594; Wed, 15 Oct 2025
 05:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 15 Oct 2025 20:30:31 +0800
X-Gm-Features: AS18NWDqJUk6ykIvD7YjUHwXwDjsXiCNSbq9SBEQEkqb_Vov6-4kis1jvJePFzQ
Message-ID: <CAHj4cs8F=OV9s3La2kEQ34YndgfZP-B5PHS4Z8_b9euKG6J4mw@mail.gmail.com>
Subject: [bug report] WARNING: possible circular locking dependency detected
 at pcpu_alloc_noprof+0x8a3/0xd90 and __blk_mq_update_nr_hw_queues+0x76c/0xca0
To: linux-block <linux-block@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Nilay Shroff <nilay@linux.ibm.com>, 
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

Hi
I reproduced the issue below with blktests block/040 on the latest
linux-block/for-next, please help check it, and let me know if you
need any info/test for it. Thanks.

dmesg:
[  283.273904] run blktests block/040 at 2025-10-15 08:23:18
[  283.607382] null_blk: disk nullb1 created

[  284.828241] ======================================================
[  284.834421] WARNING: possible circular locking dependency detected
[  284.840599] 6.18.0-rc1+ #4 Not tainted
[  284.844360] ------------------------------------------------------
[  284.850539] check/1726 is trying to acquire lock:
[  284.855245] ffffffffb3d47210 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
pcpu_alloc_noprof+0x8a3/0xd90
[  284.863876]
               but task is already holding lock:
[  284.869710] ffff88821320ca68
(&q->q_usage_counter(io)#30){++++}-{0:0}, at:
__blk_mq_update_nr_hw_queues+0x76c/0xca0
[  284.880160]
               which lock already depends on the new lock.

[  284.888332]
               the existing dependency chain (in reverse order) is:
[  284.895812]
               -> #2 (&q->q_usage_counter(io)#30){++++}-{0:0}:
[  284.902875]        __lock_acquire+0x57c/0xbd0
[  284.907243]        lock_acquire.part.0+0xbd/0x260
[  284.911950]        blk_alloc_queue+0x5ca/0x710
[  284.916402]        blk_mq_alloc_queue+0x14b/0x230
[  284.921109]        __blk_mq_alloc_disk+0x18/0xd0
[  284.925728]        null_add_dev+0x7b6/0x1410 [null_blk]
[  284.930973]        nullb_device_power_store+0x1e6/0x280 [null_blk]
[  284.937159]        configfs_write_iter+0x2ac/0x460
[  284.941959]        vfs_write+0x525/0xfd0
[  284.945888]        ksys_write+0xf9/0x1d0
[  284.949822]        do_syscall_64+0x94/0x760
[  284.954015]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  284.959588]
               -> #1 (fs_reclaim){+.+.}-{0:0}:
[  284.965266]        __lock_acquire+0x57c/0xbd0
[  284.969632]        lock_acquire.part.0+0xbd/0x260
[  284.974340]        fs_reclaim_acquire+0xc9/0x110
[  284.978965]        prepare_alloc_pages+0x159/0x5a0
[  284.983761]        __alloc_frozen_pages_noprof+0x151/0x3b0
[  284.989253]        __alloc_pages_noprof+0x10/0x1b0
[  284.994045]        pcpu_alloc_pages.isra.0+0xcf/0x3d0
[  284.999109]        pcpu_populate_chunk+0x35/0x70
[  285.003735]        pcpu_alloc_noprof+0x775/0xd90
[  285.008353]        iommu_dma_init_fq+0x197/0x750
[  285.012973]        iommu_dma_init_domain+0x553/0x990
[  285.017939]        iommu_setup_dma_ops+0xd2/0x1a0
[  285.022645]        bus_iommu_probe+0x1ee/0x4b0
[  285.027099]        iommu_device_register+0x186/0x270
[  285.032064]        iommu_init_pci+0xb8f/0xc20
[  285.036426]        amd_iommu_init_pci+0x80/0x4e0
[  285.041051]        state_next+0x297/0x5d0
[  285.045064]        iommu_go_to_state+0x2b/0x60
[  285.049512]        pci_iommu_init+0x3b/0x70
[  285.053707]        do_one_initcall+0xa7/0x260
[  285.058072]        do_initcalls+0x1b4/0x1f0
[  285.062259]        kernel_init_freeable+0x4ae/0x540
[  285.067139]        kernel_init+0x1c/0x150
[  285.071160]        ret_from_fork+0x393/0x480
[  285.075441]        ret_from_fork_asm+0x1a/0x30
[  285.079895]
               -> #0 (pcpu_alloc_mutex){+.+.}-{4:4}:
[  285.086091]        check_prev_add+0xf1/0xcd0
[  285.090364]        validate_chain+0x487/0x570
[  285.094725]        __lock_acquire+0x57c/0xbd0
[  285.099092]        lock_acquire.part.0+0xbd/0x260
[  285.103797]        __mutex_lock+0x1a7/0x1ae0
[  285.108079]        pcpu_alloc_noprof+0x8a3/0xd90
[  285.112699]        sbitmap_init_node+0x287/0x730
[  285.117325]        sbitmap_queue_init_node+0x2e/0x3e0
[  285.122379]        blk_mq_init_tags+0x15f/0x2c0
[  285.126921]        blk_mq_alloc_map_and_rqs+0xa6/0x310
[  285.132067]        __blk_mq_alloc_map_and_rqs+0x104/0x1f0
[  285.137467]        blk_mq_realloc_tag_set_tags+0x1e8/0x300
[  285.142952]        __blk_mq_update_nr_hw_queues+0x7b4/0xca0
[  285.148526]        blk_mq_update_nr_hw_queues+0x3b/0x60
[  285.153759]        nullb_update_nr_hw_queues+0x1a9/0x370 [null_blk]
[  285.160032]        nullb_device_submit_queues_store+0xdb/0x170 [null_blk]
[  285.166827]        configfs_write_iter+0x2ac/0x460
[  285.171621]        vfs_write+0x525/0xfd0
[  285.175555]        ksys_write+0xf9/0x1d0
[  285.179481]        do_syscall_64+0x94/0x760
[  285.183674]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  285.189250]
               other info that might help us debug this:

[  285.197248] Chain exists of:
                 pcpu_alloc_mutex --> fs_reclaim --> &q->q_usage_counter(io)#30

[  285.208654]  Possible unsafe locking scenario:

[  285.214573]        CPU0                    CPU1
[  285.219104]        ----                    ----
[  285.223637]   lock(&q->q_usage_counter(io)#30);
[  285.228177]                                lock(fs_reclaim);
[  285.233846]                                lock(&q->q_usage_counter(io)#30);
[  285.240900]   lock(pcpu_alloc_mutex);
[  285.244576]
                *** DEADLOCK ***

[  285.250494] 8 locks held by check/1726:
[  285.254334]  #0: ffff88823b828440 (sb_writers#16){.+.+}-{0:0}, at:
ksys_write+0xf9/0x1d0
[  285.262447]  #1: ffff8881250a2490 (&buffer->mutex){+.+.}-{4:4}, at:
configfs_write_iter+0x71/0x460
[  285.271424]  #2: ffff88810cc7ac80 (&p->frag_sem){.+.+}-{4:4}, at:
configfs_write_iter+0x1d9/0x460
[  285.280315]  #3: ffffffffc2245170 (&lock){+.+.}-{4:4}, at:
nullb_device_submit_queues_store+0xab/0x170 [null_blk]
[  285.290603]  #4: ffff88823410e220
(&set->update_nr_hwq_lock){++++}-{4:4}, at:
blk_mq_update_nr_hw_queues+0x27/0x60
[  285.300968]  #5: ffff88823410e118
(&set->tag_list_lock){+.+.}-{4:4}, at:
blk_mq_update_nr_hw_queues+0x31/0x60
[  285.310898]  #6: ffff88821320ca68
(&q->q_usage_counter(io)#30){++++}-{0:0}, at:
__blk_mq_update_nr_hw_queues+0x76c/0xca0
[  285.321783]  #7: ffff88821320caa8
(&q->q_usage_counter(queue)#21){+.+.}-{0:0}, at:
__blk_mq_update_nr_hw_queues+0x76c/0xca0
[  285.332928]
               stack backtrace:
[  285.337292] CPU: 10 UID: 0 PID: 1726 Comm: check Not tainted
6.18.0-rc1+ #4 PREEMPT(voluntary)
[  285.337299] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.17.0 12/04/2024
[  285.337302] Call Trace:
[  285.337306]  <TASK>
[  285.337312]  dump_stack_lvl+0x6f/0xb0
[  285.337322]  print_circular_bug.cold+0x38/0x45
[  285.337331]  check_noncircular+0x148/0x160
[  285.337348]  check_prev_add+0xf1/0xcd0
[  285.337352]  ? alloc_chain_hlocks+0x13e/0x1d0
[  285.337357]  ? srso_return_thunk+0x5/0x5f
[  285.337363]  ? add_chain_cache+0x12c/0x310
[  285.337371]  validate_chain+0x487/0x570
[  285.337382]  __lock_acquire+0x57c/0xbd0
[  285.337394]  lock_acquire.part.0+0xbd/0x260
[  285.337399]  ? pcpu_alloc_noprof+0x8a3/0xd90
[  285.337408]  ? srso_return_thunk+0x5/0x5f
[  285.337413]  ? rcu_is_watching+0x15/0xb0
[  285.337419]  ? srso_return_thunk+0x5/0x5f
[  285.337423]  ? srso_return_thunk+0x5/0x5f
[  285.337428]  ? lock_acquire+0x10b/0x150
[  285.337437]  __mutex_lock+0x1a7/0x1ae0
[  285.337442]  ? pcpu_alloc_noprof+0x8a3/0xd90
[  285.337448]  ? pcpu_alloc_noprof+0x8a3/0xd90
[  285.337453]  ? srso_return_thunk+0x5/0x5f
[  285.337458]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  285.337464]  ? srso_return_thunk+0x5/0x5f
[  285.337468]  ? stack_depot_save_flags+0x3db/0x680
[  285.337478]  ? __pfx___mutex_lock+0x10/0x10
[  285.337483]  ? srso_return_thunk+0x5/0x5f
[  285.337488]  ? kasan_save_stack+0x3f/0x50
[  285.337493]  ? kasan_save_stack+0x30/0x50
[  285.337498]  ? kasan_save_track+0x14/0x30
[  285.337502]  ? __kasan_kmalloc+0x8f/0xa0
[  285.337508]  ? __blk_mq_alloc_map_and_rqs+0x104/0x1f0
[  285.337513]  ? blk_mq_realloc_tag_set_tags+0x1e8/0x300
[  285.337520]  ? vfs_write+0x525/0xfd0
[  285.337525]  ? ksys_write+0xf9/0x1d0
[  285.337530]  ? do_syscall_64+0x94/0x760
[  285.337535]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  285.337548]  ? pcpu_alloc_noprof+0x8a3/0xd90
[  285.337552]  pcpu_alloc_noprof+0x8a3/0xd90
[  285.337571]  sbitmap_init_node+0x287/0x730
[  285.337584]  sbitmap_queue_init_node+0x2e/0x3e0
[  285.337590]  ? srso_return_thunk+0x5/0x5f
[  285.337598]  blk_mq_init_tags+0x15f/0x2c0
[  285.337607]  blk_mq_alloc_map_and_rqs+0xa6/0x310
[  285.337612]  ? __pfx_blk_mq_freeze_queue_wait+0x10/0x10
[  285.337617]  ? blk_mq_realloc_tag_set_tags+0xd0/0x300
[  285.337625]  __blk_mq_alloc_map_and_rqs+0x104/0x1f0
[  285.337633]  blk_mq_realloc_tag_set_tags+0x1e8/0x300
[  285.337642]  __blk_mq_update_nr_hw_queues+0x7b4/0xca0
[  285.337655]  ? __pfx___blk_mq_update_nr_hw_queues+0x10/0x10
[  285.337668]  ? __lock_acquired+0xe0/0x280
[  285.337683]  ? __pfx_down_write+0x10/0x10
[  285.337696]  blk_mq_update_nr_hw_queues+0x3b/0x60
[  285.337704]  nullb_update_nr_hw_queues+0x1a9/0x370 [null_blk]
[  285.337723]  nullb_device_submit_queues_store+0xdb/0x170 [null_blk]
[  285.337737]  ? __pfx_nullb_device_submit_queues_store+0x10/0x10 [null_blk]
[  285.337750]  ? srso_return_thunk+0x5/0x5f
[  285.337766]  configfs_write_iter+0x2ac/0x460
[  285.337777]  vfs_write+0x525/0xfd0
[  285.337784]  ? srso_return_thunk+0x5/0x5f
[  285.337791]  ? __pfx_vfs_write+0x10/0x10
[  285.337800]  ? srso_return_thunk+0x5/0x5f
[  285.337811]  ? local_clock_noinstr+0xd/0xe0
[  285.337818]  ? srso_return_thunk+0x5/0x5f
[  285.337822]  ? __lock_release.isra.0+0x1a4/0x2c0
[  285.337832]  ksys_write+0xf9/0x1d0
[  285.337839]  ? __pfx_ksys_write+0x10/0x10
[  285.337853]  do_syscall_64+0x94/0x760
[  285.337860]  ? srso_return_thunk+0x5/0x5f
[  285.337864]  ? __lock_release.isra.0+0x1a4/0x2c0
[  285.337873]  ? exc_page_fault+0x78/0xf0
[  285.337878]  ? srso_return_thunk+0x5/0x5f
[  285.337886]  ? srso_return_thunk+0x5/0x5f
[  285.337891]  ? rcu_is_watching+0x15/0xb0
[  285.337896]  ? srso_return_thunk+0x5/0x5f
[  285.337902]  ? srso_return_thunk+0x5/0x5f
[  285.337911]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  285.337916] RIP: 0033:0x7f0be6d2bcd4
[  285.337922] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d 15 c4 0d 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24
18 48
[  285.337926] RSP: 002b:00007ffcaeaaae28 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[  285.337932] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0be6d2bcd4
[  285.337936] RDX: 0000000000000003 RSI: 00005614ff1b6980 RDI: 0000000000000001
[  285.337939] RBP: 00005614ff1b6980 R08: 0000000000000073 R09: 00000000ffffffff
[  285.337942] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
[  285.337945] R13: 00007f0be6e015c0 R14: 0000000000000003 R15: 00007f0be6dfef00
[  285.337964]  </TASK>

-- 
Best Regards,
  Yi Zhang

