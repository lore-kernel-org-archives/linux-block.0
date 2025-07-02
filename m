Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD483093A1
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467308; cv=none; b=ADKT72oBdE+FWpKjCKHBx6qjzgsA0MTbhILslbeg1Skhj/YbnpP7ka8kk6UZOZUX3odCU8qwm/B8zkMB80fCoJfUe5Z7lkKxj06fkpkNf5EQCXF4qI/N8uRofIQQ5Pe80iOJCf44xo3Ygqk6Bl1GRkjioEcRMgrLiE62BdGJDf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467308; c=relaxed/simple;
	bh=M7jCIRYczaFOaXM23DtjhcktJIp5EdraHBOGMh9h2YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grE/uRuit3zkVsOBjyQ7rtr1DXJGgTB+rMYwcn/BpOVHWmOrArWDEqt+0j+azyHrX1Ug2ydBx3jIRInPLwg8CVIHR+5feo+0+q+ZSWYD9YsDOm/+dZKJd7vhXGuiJY0tAsxNUucflslqj4v2a4ScKVUyCO35cDBucpfPP1ww9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-K9T_RG-CMWis0-B4u-84Xw-1; Wed, 02 Jul 2025 10:41:43 -0400
X-MC-Unique: K9T_RG-CMWis0-B4u-84Xw-1
X-Mimecast-MFC-AGG-ID: K9T_RG-CMWis0-B4u-84Xw_1751467302
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-32b3162348fso30225941fa.1
        for <linux-block@vger.kernel.org>; Wed, 02 Jul 2025 07:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751467302; x=1752072102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Sjp+VGJRfdJsaySE+tWmWQhRvpy4a+8EgJeJC46UJs=;
        b=NPL1i6y2slZFU0mQE75mBS9zQNMuyaB5XAj20I+vr40DCvemZ3hfOZ+/PQPdc4DTkk
         yzeGJjv2BgW66Mxbvx76lgcndAXToi5CRyZ0aM7O9bx6F9YSr5koiDPHC48JmP8EjEWA
         t1FfR4cfstTpP1zq1vvyBkoK6n/Gr95FqOAVDGcXGy7aEmosg+S9pRNweOwWnRvurLU5
         PZGfTev5SO9TtYrVpFg6CtHp6ES6X76741KE4Wy9CKUo3llPnjIQOut4W0/lyy9LfNSL
         +46zvurbH7eLZP48KQUSZwGDBdj2TlpX7QVaFt4aBhy2lGhqmFBU+aV4c8cHTytXeF4M
         +luw==
X-Gm-Message-State: AOJu0YxMoqaR/5BI4pbkccWnuyWEL8usNHjQKlC83A9Q4rL112wyAEmX
	+Il3FPaG0nAfzl5lf635bAiw6QYALA2qqxemz+FHn3DM4y6OCPK2HEdJgiSvtAXxQBd3ngOav/b
	h3UBtSLF001/TH6GKe+STWCm31RBwDykGKrWmXvGfQv1j2GxD1aYn3mH0TtmFef1FAH4jchYb+x
	Poi8mnFxkWGwxbSBqYbgAFIF9MIg34uIQAxsNDI3M=
X-Gm-Gg: ASbGncv0hgf20kVUcUl7fiqAwLcLZJ28ERxgEiJ0bC7vnK9CmkI31qPb+h1z1h9WOa7
	V+XTXR+VXoOmEZjXT/HmmU28pvpR7Y14VaIsQeWE8XPO2khrbiKj6tZHE31GPEhCeZDVJRTPRP3
	cNuoMS
X-Received: by 2002:a05:651c:410c:b0:32c:bc69:e938 with SMTP id 38308e7fff4ca-32e00044751mr8209701fa.20.1751467301571;
        Wed, 02 Jul 2025 07:41:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaUQzsyIsFjDqNlvcoIgVW7FtfdS/QGX2GSTsGf6mOVKZM0DzHcPwJ2B/bwOBGB83csiIJV75cBylnhn2jUog=
X-Received: by 2002:a05:651c:410c:b0:32c:bc69:e938 with SMTP id
 38308e7fff4ca-32e00044751mr8209591fa.20.1751467301106; Wed, 02 Jul 2025
 07:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701081954.57381-1-nilay@linux.ibm.com> <CAHj4cs9ABpwaoywocFAHP+3k=oWsqBKbM5GFbCedgjEyxzpChA@mail.gmail.com>
 <1b1b8767-2e08-496a-89db-385edf592d23@linux.ibm.com>
In-Reply-To: <1b1b8767-2e08-496a-89db-385edf592d23@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 2 Jul 2025 22:41:28 +0800
X-Gm-Features: Ac12FXzgsfz8qSLhAR10ZN_z2GDfzL7fLp0DNujfa1D6WFw65NNEgLo97deAuyg
Message-ID: <CAHj4cs8MeaF6g5aMSm+URWssZ-HNj4wPbG9bEpW=kQ5pdgxkAg@mail.gmail.com>
Subject: Re: [PATCHv7 0/3] block: move sched_tags allocation/de-allocation
 outside of locking context
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com, hare@suse.de, 
	axboe@kernel.dk, sth@linux.ibm.com, gjoyce@ibm.com, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 10:17=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
>
>
> On 7/2/25 7:23 PM, Yi Zhang wrote:
> > Hi Nilay
> >
> > With the patch on the latest linux-block/for-next, I reproduced the
> > following WARNING with blktests block/005, here is the full log:
> >
> > [  342.845331] run blktests block/005 at 2025-07-02 09:48:55
> >
> > [  343.835605] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [  343.841783] WARNING: possible circular locking dependency detected
> > [  343.847966] 6.16.0-rc4.fix+ #3 Not tainted
> > [  343.852073] ------------------------------------------------------
> > [  343.858250] check/1365 is trying to acquire lock:
> > [  343.862957] ffffffff98141db0 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
> > pcpu_alloc_noprof+0x8eb/0xd70
> > [  343.871587]
> >                but task is already holding lock:
> > [  343.877421] ffff888300cfb040 (&q->elevator_lock){+.+.}-{4:4}, at:
> > elevator_change+0x152/0x530
> > [  343.885958]
> >                which lock already depends on the new lock.
> >
> > [  343.894131]
> >                the existing dependency chain (in reverse order) is:
> > [  343.901609]
> >                -> #3 (&q->elevator_lock){+.+.}-{4:4}:
> > [  343.907891]        __lock_acquire+0x6f1/0xc00
> > [  343.912259]        lock_acquire.part.0+0xb6/0x240
> > [  343.916966]        __mutex_lock+0x17b/0x1690
> > [  343.921247]        elevator_change+0x152/0x530
> > [  343.925692]        elv_iosched_store+0x205/0x2f0
> > [  343.930312]        queue_attr_store+0x23b/0x300
> > [  343.934853]        kernfs_fop_write_iter+0x357/0x530
> > [  343.939829]        vfs_write+0x9bc/0xf60
> > [  343.943763]        ksys_write+0xf3/0x1d0
> > [  343.947695]        do_syscall_64+0x8c/0x3d0
> > [  343.951883]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  343.957462]
> >                -> #2 (&q->q_usage_counter(io)#4){++++}-{0:0}:
> > [  343.964440]        __lock_acquire+0x6f1/0xc00
> > [  343.968799]        lock_acquire.part.0+0xb6/0x240
> > [  343.973507]        blk_alloc_queue+0x5c5/0x710
> > [  343.977959]        blk_mq_alloc_queue+0x14e/0x240
> > [  343.982666]        __blk_mq_alloc_disk+0x15/0xd0
> > [  343.987294]        nvme_alloc_ns+0x208/0x1690 [nvme_core]
> > [  343.992727]        nvme_scan_ns+0x362/0x4c0 [nvme_core]
> > [  343.997978]        async_run_entry_fn+0x96/0x4f0
> > [  344.002599]        process_one_work+0x8cd/0x1950
> > [  344.007226]        worker_thread+0x58d/0xcf0
> > [  344.011499]        kthread+0x3d8/0x7a0
> > [  344.015259]        ret_from_fork+0x406/0x510
> > [  344.019532]        ret_from_fork_asm+0x1a/0x30
> > [  344.023980]
> >                -> #1 (fs_reclaim){+.+.}-{0:0}:
> > [  344.029654]        __lock_acquire+0x6f1/0xc00
> > [  344.034015]        lock_acquire.part.0+0xb6/0x240
> > [  344.038727]        fs_reclaim_acquire+0x103/0x150
> > [  344.043433]        prepare_alloc_pages+0x15f/0x600
> > [  344.048230]        __alloc_frozen_pages_noprof+0x14a/0x3a0
> > [  344.053722]        __alloc_pages_noprof+0xd/0x1d0
> > [  344.058438]        pcpu_alloc_pages.constprop.0+0x104/0x420
> > [  344.064017]        pcpu_populate_chunk+0x38/0x80
> > [  344.068644]        pcpu_alloc_noprof+0x650/0xd70
> > [  344.073265]        iommu_dma_init_fq+0x183/0x730
> > [  344.077893]        iommu_dma_init_domain+0x566/0x990
> > [  344.082866]        iommu_setup_dma_ops+0xca/0x230
> > [  344.087571]        bus_iommu_probe+0x1f8/0x4a0
> > [  344.092020]        iommu_device_register+0x153/0x240
> > [  344.096993]        iommu_init_pci+0x53c/0x1040
> > [  344.101447]        amd_iommu_init_pci+0xb6/0x5c0
> > [  344.106066]        state_next+0xaf7/0xff0
> > [  344.110080]        iommu_go_to_state+0x21/0x80
> > [  344.114535]        amd_iommu_init+0x15/0x70
> > [  344.118728]        pci_iommu_init+0x29/0x70
> > [  344.122914]        do_one_initcall+0x100/0x5a0
> > [  344.127361]        do_initcalls+0x138/0x1d0
> > [  344.131556]        kernel_init_freeable+0x8b7/0xbd0
> > [  344.136442]        kernel_init+0x1b/0x1f0
> > [  344.140456]        ret_from_fork+0x406/0x510
> > [  344.144735]        ret_from_fork_asm+0x1a/0x30
> > [  344.149182]
> >                -> #0 (pcpu_alloc_mutex){+.+.}-{4:4}:
> > [  344.155379]        check_prev_add+0xf1/0xce0
> > [  344.159653]        validate_chain+0x470/0x580
> > [  344.164019]        __lock_acquire+0x6f1/0xc00
> > [  344.168378]        lock_acquire.part.0+0xb6/0x240
> > [  344.173085]        __mutex_lock+0x17b/0x1690
> > [  344.177365]        pcpu_alloc_noprof+0x8eb/0xd70
> > [  344.181984]        kyber_queue_data_alloc+0x16d/0x660
> > [  344.187047]        kyber_init_sched+0x14/0x90
> > [  344.191413]        blk_mq_init_sched+0x264/0x4e0
> > [  344.196033]        elevator_switch+0x186/0x6a0
> > [  344.200478]        elevator_change+0x305/0x530
> > [  344.204924]        elv_iosched_store+0x205/0x2f0
> > [  344.209545]        queue_attr_store+0x23b/0x300
> > [  344.214084]        kernfs_fop_write_iter+0x357/0x530
> > [  344.219051]        vfs_write+0x9bc/0xf60
> > [  344.222976]        ksys_write+0xf3/0x1d0
> > [  344.226902]        do_syscall_64+0x8c/0x3d0
> > [  344.231088]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  344.236660]
>
> Thanks for the report!
>
> I see that the above warning is different from the one addressed by the
> current patchset. In the warning you've reported, the kyber elevator
> allocates per-CPU data after acquiring ->elevator_lock, which introduces
> a per-CPU lock dependency on the ->elevator_lock.
>
> In contrast, the current patchset addresses a separate issue [1] that ari=
ses
> due to elevator tag allocation. This allocation occurs after both ->freez=
e_lock
> and ->elevator_lock are held. Internally, elevator tags allocation sets u=
p
> per-CPU sbitmap->alloc_hint, which also introduces a similar per-CPU lock
> dependency on ->elevator_lock.
>
> That said, I'll plan to address the issue you've just reported in a separ=
ate
> patch, once the current patchset is merged.

OK, the issue[1] was easy to reproduce by blktests block/005 on my
environment, that's why I re-run the test on this patchset, and now
this one new WARNING triggered, anyway, thanks for the info and will
test your new patch later, thanks.

>
> Thanks,
> --Nilay
>
> [1]https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux=
.ibm.com/
>
>
>


--=20
Best Regards,
  Yi Zhang

