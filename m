Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E539C2B9F7
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 17:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BEF261163
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 17:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhE1REe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 May 2021 13:04:34 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:38687 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbhE1REa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 13:04:30 -0400
Received: by mail-oi1-f182.google.com with SMTP id z3so4880223oib.5
        for <linux-block@vger.kernel.org>; Fri, 28 May 2021 10:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C0OnxQ9UMCG6gDOrEew7RKm+/6XOO+U9x2k6XtZeuYQ=;
        b=RhsdCYI1qKwr/IcNHQPxbZGe7zSCLRLeJJkOpuCdr+VCgJnz/ZVBkOxthvm61Ej7qO
         on2+UPJVCN6MzraW+QClZY0QzlhGyd38ABiwVxoWOXlDNkHO3+V463XvOnx9r82U+xhc
         AA2Du6OG4EWLVNSvWB5iAbnIGBbzAXW4TFJSsMKdfdMsX2B9b8PhlbQqQTihyCco6LTT
         jtRTlYVR2dvUdTVpyEX2LtcYxY1XDyOiethwDiHo7ZX+oCP929SSvXfptAIKyk9+l758
         cR0myLkm6K5LFlmzBrnDR+xLaOUnDB+aamfmfW4oV5I35iBeE6nqb/3pnqa3t/h95xuZ
         jaBQ==
X-Gm-Message-State: AOAM532+nzeMCp6ZS8MWEVQ5fmxXuiLuBfj9ps1ZjdZ5vNqSxxvJjJ8d
        7OWqcaGHo8oWtcZSJLPjmSA=
X-Google-Smtp-Source: ABdhPJxKXluHuSHvMO7mYy0Da2nQ2NyN85VOk24lwX21FP3IB5NtX6KBoQEWDjmWy+LhmRGXVKF2Wg==
X-Received: by 2002:a54:4609:: with SMTP id p9mr6461094oip.107.1622221221914;
        Fri, 28 May 2021 10:00:21 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:1b52:8df9:ece7:ac3d? ([2600:1700:65a0:78e0:1b52:8df9:ece7:ac3d])
        by smtp.gmail.com with ESMTPSA id s4sm1288038otr.80.2021.05.28.10.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 10:00:21 -0700 (PDT)
Subject: Re: [bug report][regression] device node still exists after blktests
 nvme/011 finished
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
References: <CAHj4cs-NPs=xC6Q05M8Uf5K1v4GEUOY5e0=+PY4dQu+EstPJ3g@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <43d1b5d8-2be0-9219-e3dd-dcff0f57ea5d@grimberg.me>
Date:   Fri, 28 May 2021 10:00:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHj4cs-NPs=xC6Q05M8Uf5K1v4GEUOY5e0=+PY4dQu+EstPJ3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Hi
> I would like to report one regression issue we found recently, after
> blktests nvme/011 finished, the device node still exists and seems
> there is a lock issue from the log, let me know if you need any
> testing for it, thanks.

Hannes, this is a result of your patch most likely.

> 
> # ./check nvme/011
> nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
>      runtime  71.350s  ...  77.131s
> # lsblk
> NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
> sda       8:0    0 465.8G  0 disk
> ├─sda1    8:1    0     1G  0 part /boot
> ├─sda2    8:2    0  31.5G  0 part [SWAP]
> ├─sda3    8:3    0    15G  0 part
> ├─sda4    8:4    0     1K  0 part
> ├─sda5    8:5    0    15G  0 part
> ├─sda6    8:6    0     5G  0 part
> └─sda7    8:7    0 398.3G  0 part /
> zram0   253:0    0     4G  0 disk [SWAP]
> nvme0n1 259:1    0     1G  0 disk
> 
> #dmesg
> [  793.719149] run blktests nvme/011 at 2021-05-28 05:45:49
> [  793.899062] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  793.950783] nvmet: creating controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:d39240f497c64fc8bf7ca767d256a394.
> [  793.964271] nvme nvme0: creating 48 I/O queues.
> [  793.973187] nvme nvme0: new ctrl: "blktests-subsystem-1"
> [  863.401172] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> [  863.656534] block nvme0n1: no available path - failing I/O
> [  863.662039] block nvme0n1: no available path - failing I/O
> [  863.667546] block nvme0n1: no available path - failing I/O
> [  863.673029] block nvme0n1: no available path - failing I/O
> [  863.678530] block nvme0n1: no available path - failing I/O
> [  863.684032] block nvme0n1: no available path - failing I/O
> [  863.689523] block nvme0n1: no available path - failing I/O
> [  863.695014] block nvme0n1: no available path - failing I/O
> [  863.700502] block nvme0n1: no available path - failing I/O
> [  863.705994] Buffer I/O error on dev nvme0n1, logical block 262016,
> async page read
> [ 1108.488647] INFO: task systemd-udevd:2400 blocked for more than 122 seconds.
> [ 1108.495699]       Not tainted 5.13.0-rc3+ #8
> [ 1108.499972] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 1108.507797] task:systemd-udevd   state:D stack:    0 pid: 2400
> ppid:  1134 flags:0x00004004
> [ 1108.516140] Call Trace:
> [ 1108.518589]  __schedule+0x247/0x6f0
> [ 1108.522088]  schedule+0x46/0xb0
> [ 1108.525233]  schedule_preempt_disabled+0xa/0x10
> [ 1108.529767]  __mutex_lock.constprop.0+0x2a4/0x470
> [ 1108.534472]  ? __kernfs_remove.part.0+0x174/0x1f0
> [ 1108.539178]  ? kernfs_remove_by_name_ns+0x5c/0x90
> [ 1108.543885]  del_gendisk+0x99/0x230
> [ 1108.547378]  nvme_mpath_remove_disk+0x97/0xb0 [nvme_core]
> [ 1108.552787]  nvme_put_ns_head+0x2a/0xb0 [nvme_core]
> [ 1108.557664]  __blkdev_put+0x115/0x160
> [ 1108.561339]  blkdev_put+0x4c/0x130
> [ 1108.564745]  blkdev_close+0x22/0x30
> [ 1108.568238]  __fput+0x94/0x240
> [ 1108.571307]  task_work_run+0x5f/0x90
> [ 1108.574885]  exit_to_user_mode_loop+0x119/0x120
> [ 1108.579428]  exit_to_user_mode_prepare+0x97/0xa0
> [ 1108.584047]  syscall_exit_to_user_mode+0x12/0x40
> [ 1108.588664]  do_syscall_64+0x4d/0x80
> [ 1108.592254]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1108.597314] RIP: 0033:0x7f222e799627
> [ 1108.600903] RSP: 002b:00007ffd07c2b518 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000003
> [ 1108.608477] RAX: 0000000000000000 RBX: 00007f222d801240 RCX: 00007f222e799627
> [ 1108.615620] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
> [ 1108.622762] RBP: 0000000000000006 R08: 000055badf77ba70 R09: 0000000000000000
> [ 1108.629901] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd07c2b5c0
> [ 1108.637026] R13: 0000000000000000 R14: 000055bae0be5820 R15: 000055bae0b8bec0
> [ 1231.370531] INFO: task systemd-udevd:2400 blocked for more than 245 seconds.
> [ 1231.377579]       Not tainted 5.13.0-rc3+ #8
> [ 1231.381853] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 1231.389679] task:systemd-udevd   state:D stack:    0 pid: 2400
> ppid:  1134 flags:0x00004004
> [ 1231.398024] Call Trace:
> [ 1231.400478]  __schedule+0x247/0x6f0
> [ 1231.403970]  schedule+0x46/0xb0
> [ 1231.407112]  schedule_preempt_disabled+0xa/0x10
> [ 1231.411638]  __mutex_lock.constprop.0+0x2a4/0x470
> [ 1231.416345]  ? __kernfs_remove.part.0+0x174/0x1f0
> [ 1231.421051]  ? kernfs_remove_by_name_ns+0x5c/0x90
> [ 1231.425765]  del_gendisk+0x99/0x230
> [ 1231.429268]  nvme_mpath_remove_disk+0x97/0xb0 [nvme_core]
> [ 1231.434692]  nvme_put_ns_head+0x2a/0xb0 [nvme_core]
> [ 1231.439581]  __blkdev_put+0x115/0x160
> [ 1231.443255]  blkdev_put+0x4c/0x130
> [ 1231.446668]  blkdev_close+0x22/0x30
> [ 1231.450171]  __fput+0x94/0x240
> [ 1231.453232]  task_work_run+0x5f/0x90
> [ 1231.456809]  exit_to_user_mode_loop+0x119/0x120
> [ 1231.461351]  exit_to_user_mode_prepare+0x97/0xa0
> [ 1231.465980]  syscall_exit_to_user_mode+0x12/0x40
> [ 1231.470608]  do_syscall_64+0x4d/0x80
> [ 1231.474187]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1231.479247] RIP: 0033:0x7f222e799627
> [ 1231.482835] RSP: 002b:00007ffd07c2b518 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000003
> [ 1231.490392] RAX: 0000000000000000 RBX: 00007f222d801240 RCX: 00007f222e799627
> [ 1231.497537] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
> [ 1231.504670] RBP: 0000000000000006 R08: 000055badf77ba70 R09: 0000000000000000
> [ 1231.511800] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd07c2b5c0
> [ 1231.518925] R13: 0000000000000000 R14: 000055bae0be5820 R15: 000055bae0b8bec0
> [ 1354.252532] INFO: task systemd-udevd:2400 blocked for more than 368 seconds.
> [ 1354.259581]       Not tainted 5.13.0-rc3+ #8
> [ 1354.263853] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 1354.271678] task:systemd-udevd   state:D stack:    0 pid: 2400
> ppid:  1134 flags:0x00004004
> [ 1354.280025] Call Trace:
> [ 1354.282469]  __schedule+0x247/0x6f0
> [ 1354.285962]  schedule+0x46/0xb0
> [ 1354.289105]  schedule_preempt_disabled+0xa/0x10
> [ 1354.293630]  __mutex_lock.constprop.0+0x2a4/0x470
> [ 1354.298327]  ? __kernfs_remove.part.0+0x174/0x1f0
> [ 1354.303027]  ? kernfs_remove_by_name_ns+0x5c/0x90
> [ 1354.307732]  del_gendisk+0x99/0x230
> [ 1354.311226]  nvme_mpath_remove_disk+0x97/0xb0 [nvme_core]
> [ 1354.316628]  nvme_put_ns_head+0x2a/0xb0 [nvme_core]
> [ 1354.321506]  __blkdev_put+0x115/0x160
> [ 1354.325171]  blkdev_put+0x4c/0x130
> [ 1354.328576]  blkdev_close+0x22/0x30
> [ 1354.332070]  __fput+0x94/0x240
> [ 1354.335127]  task_work_run+0x5f/0x90
> [ 1354.338717]  exit_to_user_mode_loop+0x119/0x120
> [ 1354.343249]  exit_to_user_mode_prepare+0x97/0xa0
> [ 1354.347860]  syscall_exit_to_user_mode+0x12/0x40
> [ 1354.352480]  do_syscall_64+0x4d/0x80
> [ 1354.356059]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1354.361111] RIP: 0033:0x7f222e799627
> [ 1354.364684] RSP: 002b:00007ffd07c2b518 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000003
> [ 1354.372247] RAX: 0000000000000000 RBX: 00007f222d801240 RCX: 00007f222e799627
> [ 1354.379371] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
> [ 1354.386501] RBP: 0000000000000006 R08: 000055badf77ba70 R09: 0000000000000000
> [ 1354.393629] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd07c2b5c0
> [ 1354.400754] R13: 0000000000000000 R14: 000055bae0be5820 R15: 000055bae0b8bec0
> 
> 
