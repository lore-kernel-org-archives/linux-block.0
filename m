Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2F8C47092
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 02:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84474610A6
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 02:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhEaC30 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 May 2021 22:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229963AbhEaC3Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 May 2021 22:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622428065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IX8NM5r3SrcKzWFQjzhZ/gE+quZasJ2850BrIZy1a9w=;
        b=GQEX0khKgTDQEGRT30K5DsXKyDcv/74+pdce3qfoS0wspd9wX58QZ6hx/LNbi6de9ZmqBg
        imEcxdSK/4W+ATfc/iqroi1YO+A+Q6ZvMVg1+SlTV6IBwipjOCoaFcl7q9kYbdQ2Ubvp05
        dmJq0MljEg8dfHehWnoAVUshKeZzPJQ=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-e4hb_W6NNo6ixuyNTvco8g-1; Sun, 30 May 2021 22:27:43 -0400
X-MC-Unique: e4hb_W6NNo6ixuyNTvco8g-1
Received: by mail-yb1-f198.google.com with SMTP id m205-20020a25d4d60000b029052a8de1fe41so12096234ybf.23
        for <linux-block@vger.kernel.org>; Sun, 30 May 2021 19:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IX8NM5r3SrcKzWFQjzhZ/gE+quZasJ2850BrIZy1a9w=;
        b=tbxnjM9vDYZUr+oyfpCfQYaWfbLVK4RIxWl4sWtWDNi3UniT2UYzQFmpTezjzuDCCG
         jIfqsVXUvWzqiCvyGJhHAYZFPur576wgUfEx8Fy8Qro6cXzBswx2O+8mPUC4icXm8qbU
         +KFkbAGsVg+j5mHOApS8eMuioQBVCXP3r6mUVGODFMldpYKObNdAlzG85eSBEKr/58eN
         hHZ+Qu78PHC6WYmOdnfcde+h2hGp8o7zBYxQNT+bqu6telRbKEAXax6uZojKapI+YOMU
         1zbYpL61O8KmP0uGTsQ/2UZdyWwEjsBCro6E6E1S3Nr6yotgRaJMisuh8bDuerD9m3tj
         6jug==
X-Gm-Message-State: AOAM532kU3aB8ROb8F2OZ1MVbR12xhCU+6gy3x4UPwvJjWpZcx3bcahQ
        7fs/UaVuCysIy4JraYq+INntd1YV4AgUQAn6uF7BQk59wGK1k4/1esCVAWkBBjZ1E1FUvKjt7op
        AfBccC1K9V+DlanCiVKkcVhJorotvSdomVP2xnmM=
X-Received: by 2002:a25:aa53:: with SMTP id s77mr11472191ybi.89.1622428063129;
        Sun, 30 May 2021 19:27:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvu18j8yM+FZZCtMFCgBpCwf+z5QiktEk6DoxATjxMCCoMGl0YQllaC//7uKieZ4y3SC4nb4qz71AfmGP4Mew=
X-Received: by 2002:a25:aa53:: with SMTP id s77mr11472171ybi.89.1622428062854;
 Sun, 30 May 2021 19:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-NPs=xC6Q05M8Uf5K1v4GEUOY5e0=+PY4dQu+EstPJ3g@mail.gmail.com>
 <43d1b5d8-2be0-9219-e3dd-dcff0f57ea5d@grimberg.me> <1e3e80b1-1314-6cd1-c696-774b94f639e5@suse.de>
In-Reply-To: <1e3e80b1-1314-6cd1-c696-774b94f639e5@suse.de>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 31 May 2021 10:27:31 +0800
Message-ID: <CAHj4cs_9ZPBMyPz7O2o_CBvgsFjLBRrqwOO-HGHpbT3Lkc_gEg@mail.gmail.com>
Subject: Re: [bug report][regression] device node still exists after blktests
 nvme/011 finished
To:     Hannes Reinecke <hare@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        linux-block <linux-block@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Bruno Goncalves <bgoncalv@redhat.com>,
        skt-results-master@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Hannes
The issue was fixed by this patch, feel free to add

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Sat, May 29, 2021 at 7:59 PM Hannes Reinecke <hare@suse.de> wrote:
>
> On 5/28/21 7:00 PM, Sagi Grimberg wrote:
> >> Hi
> >> I would like to report one regression issue we found recently, after
> >> blktests nvme/011 finished, the device node still exists and seems
> >> there is a lock issue from the log, let me know if you need any
> >> testing for it, thanks.
> >
> > Hannes, this is a result of your patch most likely.
> >
> >>
> >> # ./check nvme/011
> >> nvme/011 (run data verification fio job on NVMeOF file-backed ns)
> >> [passed]
> >>      runtime  71.350s  ...  77.131s
> >> # lsblk
> >> NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
> >> sda       8:0    0 465.8G  0 disk
> >> =E2=94=9C=E2=94=80sda1    8:1    0     1G  0 part /boot
> >> =E2=94=9C=E2=94=80sda2    8:2    0  31.5G  0 part [SWAP]
> >> =E2=94=9C=E2=94=80sda3    8:3    0    15G  0 part
> >> =E2=94=9C=E2=94=80sda4    8:4    0     1K  0 part
> >> =E2=94=9C=E2=94=80sda5    8:5    0    15G  0 part
> >> =E2=94=9C=E2=94=80sda6    8:6    0     5G  0 part
> >> =E2=94=94=E2=94=80sda7    8:7    0 398.3G  0 part /
> >> zram0   253:0    0     4G  0 disk [SWAP]
> >> nvme0n1 259:1    0     1G  0 disk
> >>
> >> #dmesg
> >> [  793.719149] run blktests nvme/011 at 2021-05-28 05:45:49
> >> [  793.899062] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> >> [  793.950783] nvmet: creating controller 1 for subsystem
> >> blktests-subsystem-1 for NQN
> >> nqn.2014-08.org.nvmexpress:uuid:d39240f497c64fc8bf7ca767d256a394.
> >> [  793.964271] nvme nvme0: creating 48 I/O queues.
> >> [  793.973187] nvme nvme0: new ctrl: "blktests-subsystem-1"
> >> [  863.401172] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> >> [  863.656534] block nvme0n1: no available path - failing I/O
> >> [  863.662039] block nvme0n1: no available path - failing I/O
> >> [  863.667546] block nvme0n1: no available path - failing I/O
> >> [  863.673029] block nvme0n1: no available path - failing I/O
> >> [  863.678530] block nvme0n1: no available path - failing I/O
> >> [  863.684032] block nvme0n1: no available path - failing I/O
> >> [  863.689523] block nvme0n1: no available path - failing I/O
> >> [  863.695014] block nvme0n1: no available path - failing I/O
> >> [  863.700502] block nvme0n1: no available path - failing I/O
> >> [  863.705994] Buffer I/O error on dev nvme0n1, logical block 262016,
> >> async page read
> >> [ 1108.488647] INFO: task systemd-udevd:2400 blocked for more than 122
> >> seconds.
> >> [ 1108.495699]       Not tainted 5.13.0-rc3+ #8
> >> [ 1108.499972] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >> disables this message.
> >> [ 1108.507797] task:systemd-udevd   state:D stack:    0 pid: 2400
> >> ppid:  1134 flags:0x00004004
> >> [ 1108.516140] Call Trace:
> >> [ 1108.518589]  __schedule+0x247/0x6f0
> >> [ 1108.522088]  schedule+0x46/0xb0
> >> [ 1108.525233]  schedule_preempt_disabled+0xa/0x10
> >> [ 1108.529767]  __mutex_lock.constprop.0+0x2a4/0x470
> >> [ 1108.534472]  ? __kernfs_remove.part.0+0x174/0x1f0
> >> [ 1108.539178]  ? kernfs_remove_by_name_ns+0x5c/0x90
> >> [ 1108.543885]  del_gendisk+0x99/0x230
> >> [ 1108.547378]  nvme_mpath_remove_disk+0x97/0xb0 [nvme_core]
> >> [ 1108.552787]  nvme_put_ns_head+0x2a/0xb0 [nvme_core]
> >> [ 1108.557664]  __blkdev_put+0x115/0x160
> >> [ 1108.561339]  blkdev_put+0x4c/0x130
> >> [ 1108.564745]  blkdev_close+0x22/0x30
> >> [ 1108.568238]  __fput+0x94/0x240
> >> [ 1108.571307]  task_work_run+0x5f/0x90
> >> [ 1108.574885]  exit_to_user_mode_loop+0x119/0x120
> >> [ 1108.579428]  exit_to_user_mode_prepare+0x97/0xa0
> >> [ 1108.584047]  syscall_exit_to_user_mode+0x12/0x40
> >> [ 1108.588664]  do_syscall_64+0x4d/0x80
> >> [ 1108.592254]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >> [ 1108.597314] RIP: 0033:0x7f222e799627
> >> [ 1108.600903] RSP: 002b:00007ffd07c2b518 EFLAGS: 00000246 ORIG_RAX:
> >> 0000000000000003
> >> [ 1108.608477] RAX: 0000000000000000 RBX: 00007f222d801240 RCX:
> >> 00007f222e799627
> >> [ 1108.615620] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> >> 0000000000000006
> >> [ 1108.622762] RBP: 0000000000000006 R08: 000055badf77ba70 R09:
> >> 0000000000000000
> >> [ 1108.629901] R10: 0000000000000000 R11: 0000000000000246 R12:
> >> 00007ffd07c2b5c0
> >> [ 1108.637026] R13: 0000000000000000 R14: 000055bae0be5820 R15:
> >> 000055bae0b8bec0
> >> [ 1231.370531] INFO: task systemd-udevd:2400 blocked for more than 245
> >> seconds.
> >> [ 1231.377579]       Not tainted 5.13.0-rc3+ #8
> >> [ 1231.381853] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >> disables this message.
> >> [ 1231.389679] task:systemd-udevd   state:D stack:    0 pid: 2400
> >> ppid:  1134 flags:0x00004004
> >> [ 1231.398024] Call Trace:
> >> [ 1231.400478]  __schedule+0x247/0x6f0
> >> [ 1231.403970]  schedule+0x46/0xb0
> >> [ 1231.407112]  schedule_preempt_disabled+0xa/0x10
> >> [ 1231.411638]  __mutex_lock.constprop.0+0x2a4/0x470
> >> [ 1231.416345]  ? __kernfs_remove.part.0+0x174/0x1f0
> >> [ 1231.421051]  ? kernfs_remove_by_name_ns+0x5c/0x90
> >> [ 1231.425765]  del_gendisk+0x99/0x230
> >> [ 1231.429268]  nvme_mpath_remove_disk+0x97/0xb0 [nvme_core]
> >> [ 1231.434692]  nvme_put_ns_head+0x2a/0xb0 [nvme_core]
> >> [ 1231.439581]  __blkdev_put+0x115/0x160
> >> [ 1231.443255]  blkdev_put+0x4c/0x130
> >> [ 1231.446668]  blkdev_close+0x22/0x30
> >> [ 1231.450171]  __fput+0x94/0x240
> >> [ 1231.453232]  task_work_run+0x5f/0x90
> >> [ 1231.456809]  exit_to_user_mode_loop+0x119/0x120
> >> [ 1231.461351]  exit_to_user_mode_prepare+0x97/0xa0
> >> [ 1231.465980]  syscall_exit_to_user_mode+0x12/0x40
> >> [ 1231.470608]  do_syscall_64+0x4d/0x80
> >> [ 1231.474187]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >> [ 1231.479247] RIP: 0033:0x7f222e799627
> >> [ 1231.482835] RSP: 002b:00007ffd07c2b518 EFLAGS: 00000246 ORIG_RAX:
> >> 0000000000000003
> >> [ 1231.490392] RAX: 0000000000000000 RBX: 00007f222d801240 RCX:
> >> 00007f222e799627
> >> [ 1231.497537] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> >> 0000000000000006
> >> [ 1231.504670] RBP: 0000000000000006 R08: 000055badf77ba70 R09:
> >> 0000000000000000
> >> [ 1231.511800] R10: 0000000000000000 R11: 0000000000000246 R12:
> >> 00007ffd07c2b5c0
> >> [ 1231.518925] R13: 0000000000000000 R14: 000055bae0be5820 R15:
> >> 000055bae0b8bec0
> >> [ 1354.252532] INFO: task systemd-udevd:2400 blocked for more than 368
> >> seconds.
> >> [ 1354.259581]       Not tainted 5.13.0-rc3+ #8
> >> [ 1354.263853] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >> disables this message.
> >> [ 1354.271678] task:systemd-udevd   state:D stack:    0 pid: 2400
> >> ppid:  1134 flags:0x00004004
> >> [ 1354.280025] Call Trace:
> >> [ 1354.282469]  __schedule+0x247/0x6f0
> >> [ 1354.285962]  schedule+0x46/0xb0
> >> [ 1354.289105]  schedule_preempt_disabled+0xa/0x10
> >> [ 1354.293630]  __mutex_lock.constprop.0+0x2a4/0x470
> >> [ 1354.298327]  ? __kernfs_remove.part.0+0x174/0x1f0
> >> [ 1354.303027]  ? kernfs_remove_by_name_ns+0x5c/0x90
> >> [ 1354.307732]  del_gendisk+0x99/0x230
> >> [ 1354.311226]  nvme_mpath_remove_disk+0x97/0xb0 [nvme_core]
> >> [ 1354.316628]  nvme_put_ns_head+0x2a/0xb0 [nvme_core]
> >> [ 1354.321506]  __blkdev_put+0x115/0x160
> >> [ 1354.325171]  blkdev_put+0x4c/0x130
> >> [ 1354.328576]  blkdev_close+0x22/0x30
> >> [ 1354.332070]  __fput+0x94/0x240
> >> [ 1354.335127]  task_work_run+0x5f/0x90
> >> [ 1354.338717]  exit_to_user_mode_loop+0x119/0x120
> >> [ 1354.343249]  exit_to_user_mode_prepare+0x97/0xa0
> >> [ 1354.347860]  syscall_exit_to_user_mode+0x12/0x40
> >> [ 1354.352480]  do_syscall_64+0x4d/0x80
> >> [ 1354.356059]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >> [ 1354.361111] RIP: 0033:0x7f222e799627
> >> [ 1354.364684] RSP: 002b:00007ffd07c2b518 EFLAGS: 00000246 ORIG_RAX:
> >> 0000000000000003
> >> [ 1354.372247] RAX: 0000000000000000 RBX: 00007f222d801240 RCX:
> >> 00007f222e799627
> >> [ 1354.379371] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> >> 0000000000000006
> >> [ 1354.386501] RBP: 0000000000000006 R08: 000055badf77ba70 R09:
> >> 0000000000000000
> >> [ 1354.393629] R10: 0000000000000000 R11: 0000000000000246 R12:
> >> 00007ffd07c2b5c0
> >> [ 1354.400754] R13: 0000000000000000 R14: 000055bae0be5820 R15:
> >> 000055bae0b8bec0
> >>
> >>
> Ah. Deadlock on bd_mutex.
> Can you check if the attached patch fixes this issue?
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=
=B6rffer



--=20
Best Regards,
  Yi Zhang

