Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8907275112
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464419; cv=none; b=V6cpavy1OWvKMOBT9VbUv1irnAtODktp0vC8FiKARR/PDDPVsB2fvBBD5/DouQoESBbfaLiMDUBgdhnU8OYP+Z1mO64jf6rTqUUAujbBG402zMrR/A4wUWd3AawAJ888EEswYpVqXC+BbfZ344Asd4uRjZ28VtRQepstqgZqADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464419; c=relaxed/simple;
	bh=h6nC9hc+L88GowqdIh1m3xzgDiX8ur9VAZXG8FUgJLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hj+q6FHCMPC+rXnsNBHgT493cl+8vT6oX1lieEuONDS6MRsegF7z6h4spaT3kYMKlw0+CalMwx1kggnmRwmOhFUC8QztCzuEzg67r0fwW8Z8YqcsjDOTe4GP8V43aT1m/UI06uhdsBA1iLvs12iS0fg18ZRkaFFsp2H6SpXhqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PerwNuG/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PerwNuG/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751464416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rI8GEYMzYVUGxid6w6NGpQUFqCEr530y7CBRtCc7Hs0=;
	b=PerwNuG/q4dW/X27Z3jmiRAJUgEqw2vaVtnEBKtyo95Tn4NADQ1zifVqkKJGxaHrRDb6DL
	vivFSlhFu3YXrAZR/MEWslFgh9Uiqaz8Xo1EaWPdbjbhuiv7NhMdD8ukKHefY8Qs1pwavD
	9Nmo9fDn3N71bqAV8KkU7JyLZbPJ2RM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-0fYcyCq4MQiHRgy-gQ4iHg-1; Wed, 02 Jul 2025 09:53:35 -0400
X-MC-Unique: 0fYcyCq4MQiHRgy-gQ4iHg-1
X-Mimecast-MFC-AGG-ID: 0fYcyCq4MQiHRgy-gQ4iHg_1751464414
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-32b5226e697so39608611fa.1
        for <linux-block@vger.kernel.org>; Wed, 02 Jul 2025 06:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751464413; x=1752069213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rI8GEYMzYVUGxid6w6NGpQUFqCEr530y7CBRtCc7Hs0=;
        b=DQEobkNU79sEwM2ccW0gatl4P1yBk3zcXotSXa3N9/ScZiDlr7n0/L6a4jR0dyuT3+
         O0dlyFkpIUdHP+RDBtpoCLaXfoMQ18knhyr2Wvfl/sCQdO2WIQE37uGzeuhw5VtDc4Cr
         vYi8fKWZA6Yan4XjhvvV9PLsHHMRrAhNOWLOw+iZD/Vc71UGZqD4yYFrxW1/iW3xNCiT
         B5dqlEZoSMRuh7X05jxpD/4exF4qrzMvCYwaXWZh7upY+OOgqBk1+/F+j7V3pEsZy5PN
         2P/Cz4BiINBkcHlu42h4M4BsmQiCtT43AjzmCH2kVmjqap/wtSlaaeJuM2utkx3YcF6e
         Y3KA==
X-Gm-Message-State: AOJu0Yyh9XSyxwjSlIO3AGMjuslXH26bbwL/oV7Av2q0imsJkjGMT+4i
	cz5m0kGMSEYyPfU9AH0rUcRWf8fVQsKZCTlIKSifFHbpQteUNM/7e9zgDgrMuV6s//bN+foAD48
	AsHX8VekE9hk7+9XLNy2mJFoJjKw1zlc8+GURpMFyjVoZLx3yUzk/w10VQeFaZa1o+3zexEjFzv
	IQAwGHRGrTXpvUE2kUMfMFFg+BNYl2YruCDBedpmA=
X-Gm-Gg: ASbGncuRSDFrY+cE+vUwmPeBX2Do2abpGTrRPMfz+yzJvIRGIC1UVdX5b+w7frUxmH7
	3qYSjCuU9sdICXQ/X1k5nO5H5cBSP/hd6QHrzRYyf1CYSJR/eqZeoToPoL4W9u9OQX8FJzL7ELo
	9RwMlR
X-Received: by 2002:a2e:a588:0:b0:329:1712:c38d with SMTP id 38308e7fff4ca-32e01a6b2d7mr9943011fa.5.1751464413088;
        Wed, 02 Jul 2025 06:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwDARLdlpE6qN1flhYx9vwSsSU4HBARJaLRfUT71/rvVryJtl3ln+EcoRV0rKFbczHg07UySKwZEADY4svZ3A=
X-Received: by 2002:a2e:a588:0:b0:329:1712:c38d with SMTP id
 38308e7fff4ca-32e01a6b2d7mr9942811fa.5.1751464412459; Wed, 02 Jul 2025
 06:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701081954.57381-1-nilay@linux.ibm.com>
In-Reply-To: <20250701081954.57381-1-nilay@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 2 Jul 2025 21:53:19 +0800
X-Gm-Features: Ac12FXyshE9czxVN1h_veHBYg2ws9sqgccbllQrM3o5wTiyqfMGO6TZzNV8pezQ
Message-ID: <CAHj4cs9ABpwaoywocFAHP+3k=oWsqBKbM5GFbCedgjEyxzpChA@mail.gmail.com>
Subject: Re: [PATCHv7 0/3] block: move sched_tags allocation/de-allocation
 outside of locking context
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com, hare@suse.de, 
	axboe@kernel.dk, sth@linux.ibm.com, gjoyce@ibm.com, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nilay

With the patch on the latest linux-block/for-next, I reproduced the
following WARNING with blktests block/005, here is the full log:

[  342.845331] run blktests block/005 at 2025-07-02 09:48:55

[  343.835605] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  343.841783] WARNING: possible circular locking dependency detected
[  343.847966] 6.16.0-rc4.fix+ #3 Not tainted
[  343.852073] ------------------------------------------------------
[  343.858250] check/1365 is trying to acquire lock:
[  343.862957] ffffffff98141db0 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
pcpu_alloc_noprof+0x8eb/0xd70
[  343.871587]
               but task is already holding lock:
[  343.877421] ffff888300cfb040 (&q->elevator_lock){+.+.}-{4:4}, at:
elevator_change+0x152/0x530
[  343.885958]
               which lock already depends on the new lock.

[  343.894131]
               the existing dependency chain (in reverse order) is:
[  343.901609]
               -> #3 (&q->elevator_lock){+.+.}-{4:4}:
[  343.907891]        __lock_acquire+0x6f1/0xc00
[  343.912259]        lock_acquire.part.0+0xb6/0x240
[  343.916966]        __mutex_lock+0x17b/0x1690
[  343.921247]        elevator_change+0x152/0x530
[  343.925692]        elv_iosched_store+0x205/0x2f0
[  343.930312]        queue_attr_store+0x23b/0x300
[  343.934853]        kernfs_fop_write_iter+0x357/0x530
[  343.939829]        vfs_write+0x9bc/0xf60
[  343.943763]        ksys_write+0xf3/0x1d0
[  343.947695]        do_syscall_64+0x8c/0x3d0
[  343.951883]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  343.957462]
               -> #2 (&q->q_usage_counter(io)#4){++++}-{0:0}:
[  343.964440]        __lock_acquire+0x6f1/0xc00
[  343.968799]        lock_acquire.part.0+0xb6/0x240
[  343.973507]        blk_alloc_queue+0x5c5/0x710
[  343.977959]        blk_mq_alloc_queue+0x14e/0x240
[  343.982666]        __blk_mq_alloc_disk+0x15/0xd0
[  343.987294]        nvme_alloc_ns+0x208/0x1690 [nvme_core]
[  343.992727]        nvme_scan_ns+0x362/0x4c0 [nvme_core]
[  343.997978]        async_run_entry_fn+0x96/0x4f0
[  344.002599]        process_one_work+0x8cd/0x1950
[  344.007226]        worker_thread+0x58d/0xcf0
[  344.011499]        kthread+0x3d8/0x7a0
[  344.015259]        ret_from_fork+0x406/0x510
[  344.019532]        ret_from_fork_asm+0x1a/0x30
[  344.023980]
               -> #1 (fs_reclaim){+.+.}-{0:0}:
[  344.029654]        __lock_acquire+0x6f1/0xc00
[  344.034015]        lock_acquire.part.0+0xb6/0x240
[  344.038727]        fs_reclaim_acquire+0x103/0x150
[  344.043433]        prepare_alloc_pages+0x15f/0x600
[  344.048230]        __alloc_frozen_pages_noprof+0x14a/0x3a0
[  344.053722]        __alloc_pages_noprof+0xd/0x1d0
[  344.058438]        pcpu_alloc_pages.constprop.0+0x104/0x420
[  344.064017]        pcpu_populate_chunk+0x38/0x80
[  344.068644]        pcpu_alloc_noprof+0x650/0xd70
[  344.073265]        iommu_dma_init_fq+0x183/0x730
[  344.077893]        iommu_dma_init_domain+0x566/0x990
[  344.082866]        iommu_setup_dma_ops+0xca/0x230
[  344.087571]        bus_iommu_probe+0x1f8/0x4a0
[  344.092020]        iommu_device_register+0x153/0x240
[  344.096993]        iommu_init_pci+0x53c/0x1040
[  344.101447]        amd_iommu_init_pci+0xb6/0x5c0
[  344.106066]        state_next+0xaf7/0xff0
[  344.110080]        iommu_go_to_state+0x21/0x80
[  344.114535]        amd_iommu_init+0x15/0x70
[  344.118728]        pci_iommu_init+0x29/0x70
[  344.122914]        do_one_initcall+0x100/0x5a0
[  344.127361]        do_initcalls+0x138/0x1d0
[  344.131556]        kernel_init_freeable+0x8b7/0xbd0
[  344.136442]        kernel_init+0x1b/0x1f0
[  344.140456]        ret_from_fork+0x406/0x510
[  344.144735]        ret_from_fork_asm+0x1a/0x30
[  344.149182]
               -> #0 (pcpu_alloc_mutex){+.+.}-{4:4}:
[  344.155379]        check_prev_add+0xf1/0xce0
[  344.159653]        validate_chain+0x470/0x580
[  344.164019]        __lock_acquire+0x6f1/0xc00
[  344.168378]        lock_acquire.part.0+0xb6/0x240
[  344.173085]        __mutex_lock+0x17b/0x1690
[  344.177365]        pcpu_alloc_noprof+0x8eb/0xd70
[  344.181984]        kyber_queue_data_alloc+0x16d/0x660
[  344.187047]        kyber_init_sched+0x14/0x90
[  344.191413]        blk_mq_init_sched+0x264/0x4e0
[  344.196033]        elevator_switch+0x186/0x6a0
[  344.200478]        elevator_change+0x305/0x530
[  344.204924]        elv_iosched_store+0x205/0x2f0
[  344.209545]        queue_attr_store+0x23b/0x300
[  344.214084]        kernfs_fop_write_iter+0x357/0x530
[  344.219051]        vfs_write+0x9bc/0xf60
[  344.222976]        ksys_write+0xf3/0x1d0
[  344.226902]        do_syscall_64+0x8c/0x3d0
[  344.231088]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  344.236660]
               other info that might help us debug this:

[  344.244662] Chain exists of:
                 pcpu_alloc_mutex --> &q->q_usage_counter(io)#4 -->
&q->elevator_lock

[  344.256587]  Possible unsafe locking scenario:

[  344.262504]        CPU0                    CPU1
[  344.267037]        ----                    ----
[  344.271570]   lock(&q->elevator_lock);
[  344.275330]                                lock(&q->q_usage_counter(io)#=
4);
[  344.282298]                                lock(&q->elevator_lock);
[  344.288573]   lock(pcpu_alloc_mutex);
[  344.292249]
                *** DEADLOCK ***

[  344.298168] 7 locks held by check/1365:
[  344.302015]  #0: ffff888124330448 (sb_writers#4){.+.+}-{0:0}, at:
ksys_write+0xf3/0x1d0
[  344.310039]  #1: ffff8883285fc490 (&of->mutex#2){+.+.}-{4:4}, at:
kernfs_fop_write_iter+0x216/0x530
[  344.319104]  #2: ffff8882004b5f08 (kn->active#86){.+.+}-{0:0}, at:
kernfs_fop_write_iter+0x239/0x530
[  344.328258]  #3: ffff8883032d41a8
(&set->update_nr_hwq_lock){.+.+}-{4:4}, at:
elv_iosched_store+0x1c0/0x2f0
[  344.338014]  #4: ffff888300cfaab0
(&q->q_usage_counter(io)#4){++++}-{0:0}, at:
blk_mq_freeze_queue_nomemsave+0xe/0x20
[  344.348640]  #5: ffff888300cfaaf0
(&q->q_usage_counter(queue)#4){+.+.}-{0:0}, at:
blk_mq_freeze_queue_nomemsave+0xe/0x20
[  344.359525]  #6: ffff888300cfb040 (&q->elevator_lock){+.+.}-{4:4},
at: elevator_change+0x152/0x530
[  344.368502]
               stack backtrace:
[  344.372866] CPU: 8 UID: 0 PID: 1365 Comm: check Not tainted
6.16.0-rc4.fix+ #3 PREEMPT(voluntary)
[  344.372872] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.17.0 12/04/2024
[  344.372876] Call Trace:
[  344.372879]  <TASK>
[  344.372883]  dump_stack_lvl+0x7e/0xc0
[  344.372891]  print_circular_bug+0xdc/0xf0
[  344.372901]  check_noncircular+0x131/0x150
[  344.372905]  ? local_clock_noinstr+0x9/0xc0
[  344.372912]  ? srso_return_thunk+0x5/0x5f
[  344.372918]  ? srso_return_thunk+0x5/0x5f
[  344.372929]  check_prev_add+0xf1/0xce0
[  344.372934]  ? srso_return_thunk+0x5/0x5f
[  344.372938]  ? add_chain_cache+0x111/0x320
[  344.372948]  validate_chain+0x470/0x580
[  344.372953]  ? srso_return_thunk+0x5/0x5f
[  344.372963]  __lock_acquire+0x6f1/0xc00
[  344.372976]  lock_acquire.part.0+0xb6/0x240
[  344.372981]  ? pcpu_alloc_noprof+0x8eb/0xd70
[  344.372991]  ? srso_return_thunk+0x5/0x5f
[  344.372995]  ? rcu_is_watching+0x11/0xb0
[  344.373001]  ? srso_return_thunk+0x5/0x5f
[  344.373005]  ? lock_acquire+0x10e/0x160
[  344.373015]  __mutex_lock+0x17b/0x1690
[  344.373020]  ? pcpu_alloc_noprof+0x8eb/0xd70
[  344.373025]  ? __kasan_kmalloc+0x7b/0x90
[  344.373030]  ? kyber_queue_data_alloc+0x7e/0x660
[  344.373035]  ? kyber_init_sched+0x14/0x90
[  344.373041]  ? elevator_change+0x305/0x530
[  344.373045]  ? pcpu_alloc_noprof+0x8eb/0xd70
[  344.373050]  ? queue_attr_store+0x23b/0x300
[  344.373055]  ? kernfs_fop_write_iter+0x357/0x530
[  344.373059]  ? vfs_write+0x9bc/0xf60
[  344.373064]  ? ksys_write+0xf3/0x1d0
[  344.373068]  ? do_syscall_64+0x8c/0x3d0
[  344.373075]  ? __pfx___mutex_lock+0x10/0x10
[  344.373079]  ? srso_return_thunk+0x5/0x5f
[  344.373084]  ? lock_acquire.part.0+0xb6/0x240
[  344.373088]  ? srso_return_thunk+0x5/0x5f
[  344.373093]  ? srso_return_thunk+0x5/0x5f
[  344.373097]  ? find_held_lock+0x32/0x90
[  344.373101]  ? srso_return_thunk+0x5/0x5f
[  344.373105]  ? local_clock_noinstr+0x9/0xc0
[  344.373111]  ? srso_return_thunk+0x5/0x5f
[  344.373116]  ? __lock_release+0x1a2/0x2c0
[  344.373123]  ? srso_return_thunk+0x5/0x5f
[  344.373127]  ? mark_held_locks+0x50/0x80
[  344.373134]  ? _raw_spin_unlock_irqrestore+0x59/0x70
[  344.373139]  ? srso_return_thunk+0x5/0x5f
[  344.373143]  ? lockdep_hardirqs_on+0x78/0x100
[  344.373149]  ? srso_return_thunk+0x5/0x5f
[  344.373159]  ? pcpu_alloc_noprof+0x8eb/0xd70
[  344.373164]  pcpu_alloc_noprof+0x8eb/0xd70
[  344.373169]  ? __kmalloc_cache_node_noprof+0x3a7/0x4d0
[  344.373179]  ? xa_find_after+0x1ac/0x310
[  344.373187]  ? srso_return_thunk+0x5/0x5f
[  344.373192]  ? kasan_save_track+0x10/0x30
[  344.373200]  kyber_queue_data_alloc+0x16d/0x660
[  344.373207]  ? debug_mutex_init+0x33/0x70
[  344.373216]  kyber_init_sched+0x14/0x90
[  344.373223]  blk_mq_init_sched+0x264/0x4e0
[  344.373235]  ? __pfx_blk_mq_init_sched+0x10/0x10
[  344.373239]  ? srso_return_thunk+0x5/0x5f
[  344.373253]  elevator_switch+0x186/0x6a0
[  344.373262]  elevator_change+0x305/0x530
[  344.373272]  elv_iosched_store+0x205/0x2f0
[  344.373279]  ? __pfx_elv_iosched_store+0x10/0x10
[  344.373285]  ? srso_return_thunk+0x5/0x5f
[  344.373294]  ? srso_return_thunk+0x5/0x5f
[  344.373298]  ? __lock_acquired+0xda/0x250
[  344.373306]  ? srso_return_thunk+0x5/0x5f
[  344.373310]  ? rcu_is_watching+0x11/0xb0
[  344.373315]  ? srso_return_thunk+0x5/0x5f
[  344.373324]  queue_attr_store+0x23b/0x300
[  344.373333]  ? __pfx_queue_attr_store+0x10/0x10
[  344.373344]  ? srso_return_thunk+0x5/0x5f
[  344.373349]  ? srso_return_thunk+0x5/0x5f
[  344.373354]  ? find_held_lock+0x32/0x90
[  344.373358]  ? local_clock_noinstr+0x9/0xc0
[  344.373365]  ? srso_return_thunk+0x5/0x5f
[  344.373369]  ? __lock_release+0x1a2/0x2c0
[  344.373377]  ? sysfs_file_kobj+0xb5/0x1c0
[  344.373383]  ? srso_return_thunk+0x5/0x5f
[  344.373390]  ? srso_return_thunk+0x5/0x5f
[  344.373394]  ? sysfs_file_kobj+0xbf/0x1c0
[  344.373399]  ? srso_return_thunk+0x5/0x5f
[  344.373408]  ? __pfx_sysfs_kf_write+0x10/0x10
[  344.373412]  kernfs_fop_write_iter+0x357/0x530
[  344.373422]  vfs_write+0x9bc/0xf60
[  344.373433]  ? __pfx_vfs_write+0x10/0x10
[  344.373449]  ? find_held_lock+0x32/0x90
[  344.373454]  ? local_clock_noinstr+0x9/0xc0
[  344.373460]  ? srso_return_thunk+0x5/0x5f
[  344.373470]  ksys_write+0xf3/0x1d0
[  344.373478]  ? __pfx_ksys_write+0x10/0x10
[  344.373484]  ? srso_return_thunk+0x5/0x5f
[  344.373491]  ? srso_return_thunk+0x5/0x5f
[  344.373503]  do_syscall_64+0x8c/0x3d0
[  344.373508]  ? srso_return_thunk+0x5/0x5f
[  344.373512]  ? do_user_addr_fault+0x489/0xb10
[  344.373519]  ? srso_return_thunk+0x5/0x5f
[  344.373523]  ? rcu_is_watching+0x11/0xb0
[  344.373528]  ? srso_return_thunk+0x5/0x5f
[  344.373534]  ? srso_return_thunk+0x5/0x5f
[  344.373542]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  344.373547] RIP: 0033:0x7ff3e4afe377
[  344.373552] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89
74 24
[  344.373557] RSP: 002b:00007ffc83840088 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  344.373562] RAX: ffffffffffffffda RBX: 00007ff3e4bfa780 RCX: 00007ff3e4a=
fe377
[  344.373565] RDX: 0000000000000006 RSI: 00005555d2ec8240 RDI: 00000000000=
00001
[  344.373568] RBP: 0000000000000006 R08: 0000000000000000 R09: 00007ff3e4b=
b0d40
[  344.373571] R10: 00007ff3e4bb0c40 R11: 0000000000000246 R12: 00000000000=
00006
[  344.373574] R13: 00005555d2ec8240 R14: 0000000000000006 R15: 00007ff3e4b=
f59e0
[  344.373592]  </TASK>

On Tue, Jul 1, 2025 at 4:20=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> w=
rote:
>
> Hi,
>
> There have been a few reports[1] indicating potential lockdep warnings du=
e
> to a lock dependency from the percpu allocator to the elevator lock. This
> patch series aims to eliminate that dependency.
>
> The series consists of three patches:
> The first patch is preparatory patch and just move elevator queue
> allocation logic from ->init_sched into blk_mq_init_sched.
>
> The second patch in the series restructures sched_tags allocation and
> deallocation during elevator update/switch operations to ensure these
> actions are performed entirely outside the ->freeze_lock and ->elevator_
> lock. This eliminates the percpu allocator=E2=80=99s lock dependency on t=
he
> elevator and freeze lock during scheduler transitions.
>
> The third patch introduces batch allocation and deallocation helpers for
> sched_tags. These helpers are used during __blk_mq_update_nr_hw_queues()
> to decouple sched_tags memory management from both the elevator and freez=
e
> locks, addressing the lockdep concerns in the nr_hw_queues update path.
>
> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linu=
x.ibm.com/
>
> Changes since v6:
>     - Add warning when loading elevator tags from an xarray yields nothin=
g
>       (Hannes Reinecke)
>     - Use elevator tags instead of xarray table as a function argument to
>       elv_update_nr_hw_queues (Ming Lei)
> Link to v6: https://lore.kernel.org/all/20250630054756.54532-1-nilay@linu=
x.ibm.com/
>
> Changes since v5:
>     - Fixed smatch warning reported by kernel test robot here:
>       https://lore.kernel.org/all/202506300509.2S1tygch-lkp@intel.com/
> Link to v5: https://lore.kernel.org/all/20250627175544.1063910-1-nilay@li=
nux.ibm.com/
>
> Changes since v4:
>     - Define a local Xarray variable in __blk_mq_update_nr_hw_queues to s=
tore
>       sched_tags, instead of storing it in an Xarray defined in 'struct e=
levator_tags'
>       (Ming Lei)
> Link to v4: https://lore.kernel.org/all/20250624131716.630465-1-nilay@lin=
ux.ibm.com/
>
> Changes since v3:
>     - Further split the patchset into three patch series so that we can
>       have a separate patch for sched_tags batch allocation/deallocation
>       (Ming Lei)
>     - Use Xarray to store and load the sched_tags (Ming Lei)
>     - Unexport elevator_alloc() as we no longer need to use it outside
>       of block layer core (hch)
>     - unwind the sched_tags allocation and free tags when we it fails in
>       the middle of allocation (hch)
>     - Move struct elevator_queue header from commin header to elevator.c
>       as there's no user of it outside elevator.c (Ming Lei, hch)
> Link to v3: https://lore.kernel.org/all/20250616173233.3803824-1-nilay@li=
nux.ibm.com/
>
> Change since v2:
>     - Split the patch into a two patch series. The first patch updates
>       ->init_sched elevator API change and second patch handles the sched
>       tags allocation/de-allocation logic (Ming Lei)
>     - Address sched tags allocation/deallocation logic while running in t=
he
>       context of nr_hw_queue update so that we can handle all possible
>       scenarios in a single patchest (Ming Lei)
> Link to v2: https://lore.kernel.org/all/20250528123638.1029700-1-nilay@li=
nux.ibm.com/
>
> Changes since v1:
>     - As the lifetime of elevator queue and sched tags are same, allocate
>       and move sched tags under struct elevator_queue (Ming Lei)
> Link to v1: https://lore.kernel.org/all/20250520103425.1259712-1-nilay@li=
nux.ibm.com/
>
> Nilay Shroff (3):
>   block: move elevator queue allocation logic into blk_mq_init_sched
>   block: fix lockdep warning caused by lock dependency in
>     elv_iosched_store
>   block: fix potential deadlock while running nr_hw_queue update
>
>  block/bfq-iosched.c   |  13 +--
>  block/blk-mq-sched.c  | 223 ++++++++++++++++++++++++++++--------------
>  block/blk-mq-sched.h  |  12 ++-
>  block/blk-mq.c        |  16 ++-
>  block/blk.h           |   2 +-
>  block/elevator.c      |  50 ++++++++--
>  block/elevator.h      |  16 ++-
>  block/kyber-iosched.c |  11 +--
>  block/mq-deadline.c   |  14 +--
>  9 files changed, 241 insertions(+), 116 deletions(-)
>
> --
> 2.50.0
>
>


--=20
Best Regards,
  Yi Zhang

