Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238A6C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 11:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0230560EDF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 11:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhJYLEv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23788 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232642AbhJYLEv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 07:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635159749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MjJI6bDM3iRmEMdlONBCjtsFPqACzngocdFXYIGkepM=;
        b=d33umpFoqdoUG3BcChRXVMVnlSuEjnryZVQ1zavZE6zLNvYX+0p2l+A+y8CkQ6SFNOAo8y
        Cpx5oyxKL1+MBPl/ceBlMMJua2NVJcNYG+wmSZRwkV4KUs/AkFdRV7yG06867N+hftcvjg
        9DSsjgzSbM+qKNYpoHPLIB3AOXjSNa8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-q4hLtECmP_eufqOBt4Da8w-1; Mon, 25 Oct 2021 07:02:28 -0400
X-MC-Unique: q4hLtECmP_eufqOBt4Da8w-1
Received: by mail-yb1-f200.google.com with SMTP id w199-20020a25c7d0000000b005bea7566924so16925012ybe.20
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 04:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MjJI6bDM3iRmEMdlONBCjtsFPqACzngocdFXYIGkepM=;
        b=rg6cUfD0UCsuvRQbBI7R3rCM76rWmOOMqvlxP+CxvhtyQV6pqkrrDDoiCX8fDbVV4h
         dG7GUWlYdxyHv3f9jsKWuRajkhxYNcB53Ha/ebhSSjg/dmCkfdswsE/ZmVRlnnPR8vlr
         JjhuTEnT8her8bGG6PjrYl6WuUaBG2vqhFVARRdXyaT1oS5FGzfwdYurIvUjX/CdemiK
         x0RqHgNiLI/f7HtyOPziCYMYVmFgh/vILKYS3i2dD1W4gpiHQUK5H0evr+lCZpN3uFsc
         HpORsls+i4+Lwj344BzNi48wZSPPs+apXyeyOZ5TJsC+RSp5zuU6s5OM0au66LXDkePZ
         5bCA==
X-Gm-Message-State: AOAM532mRGqtHgpK+Im99lhK4tebaDmK6q9Qg7sG4xwVkzbqml6Vyi19
        056eCNRSsmSIkoWTukhYRXwKFjjjVi8pPF9IhN1BDfDoB5PoIgs9C0aqzLGtb4ehExbl8q22j6W
        K63WNujCSaxa0OrwtZEs+hak3Q/gjoVukTid8kjs=
X-Received: by 2002:a25:81c6:: with SMTP id n6mr16181595ybm.412.1635159746917;
        Mon, 25 Oct 2021 04:02:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi7J4Ux5j//0v2ufIZLoQmRh/M7B86/9iBogsPaaGcdvK5IR/TbNum4CkSrVx2LyTgwEiNEtT5FT+eqQZefiE=
X-Received: by 2002:a25:81c6:: with SMTP id n6mr16181544ybm.412.1635159746422;
 Mon, 25 Oct 2021 04:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9w7_thDw-DN11GaoA+HH9YVAMHmrAZhi_rA24xhbTYOA@mail.gmail.com>
 <CAHj4cs_CM7NzJtNmnD0CiPVOmr0jVEktNyD8d=UMZ0xEUArzow@mail.gmail.com>
In-Reply-To: <CAHj4cs_CM7NzJtNmnD0CiPVOmr0jVEktNyD8d=UMZ0xEUArzow@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 25 Oct 2021 19:02:14 +0800
Message-ID: <CAHj4cs-M0Pp7OxE6QXJkGrjHcoqz+bdBuVngjsTp07h8gzLHXQ@mail.gmail.com>
Subject: Re: [bug report][bisected] WARNING: CPU: 109 PID: 739473 at
 block/blk-stat.c:218 blk_free_queue_stats+0x3c/0x80
To:     linux-block <linux-block@vger.kernel.org>
Cc:     Bruno Goncalves <bgoncalv@redhat.com>,
        skt-results-master@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So bisecting shows it was introduced from this commit, and it's 100%
reproduced with blktests block/001 on the ppc64le.

commit 8e141f9eb803e209714a80aa6ec073893f94c526 (HEAD)
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Sep 29 09:12:40 2021 +0200

    block: drain file system I/O on del_gendisk

    Instead of delaying draining of file system I/O related items like the
    blk-qos queues, the integrity read workqueue and timeouts only when the
    request_queue is removed, do that when del_gendisk is called.  This is
    important for SCSI where the upper level drivers that control the gendisk
    are separate entities, and the disk can be freed much earlier than the
    request_queue, or can even be unbound without tearing down the queue.


On Fri, Oct 22, 2021 at 1:29 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hi
> This issue is still can be reproduced with the latest linux-block/for-next
>
>     Kernel repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>             Commit: 8131e5e445ac - Merge branch 'for-5.16/block' into for-next
>
> On Tue, Oct 19, 2021 at 12:13 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >
> > Hello
> > Below WARNING was triggered with blktests block/001 on ppc64le/aarch64
> > during CKI tests, pls help check it, thanks.
> >
> >   Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> >             Commit: b199567fe754 - Merge branch 'for-5.16/bdev-size'
> > into for-next
> >
> >
> > [ 2260.897475] run blktests block/001 at 2021-10-18 18:33:34
> > [ 2260.930028] alternatives: patching kernel code
> > [ 2260.938145] scsi_debug:sdebug_driver_probe: scsi_debug: trim
> > poll_queues to 0. poll_q/nr_hw = (0/1)
> > [ 2260.947251] scsi host7: scsi_debug: version 0190 [20200710]
> > [ 2260.947251]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> > [ 2260.959707] scsi_debug:sdebug_driver_probe: scsi_debug: trim
> > poll_queues to 0. poll_q/nr_hw = (0/1)
> > [ 2260.959828] scsi 7:0:0:0: Direct-Access     Linux    scsi_debug
> >   0190 PQ: 0 ANSI: 7
> > [ 2260.968770] scsi host8: scsi_debug: version 0190 [20200710]
> > [ 2260.968770]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> > [ 2260.977217] sd 7:0:0:0: Power-on or device reset occurred
> > [ 2260.977525] sd 7:0:0:0: Attached scsi generic sg14 type 0
> > [ 2260.989380] scsi_debug:sdebug_driver_probe: scsi_debug: trim
> > poll_queues to 0. poll_q/nr_hw = (0/1)
> > [ 2260.989440] scsi 8:0:0:0: Direct-Access     Linux    scsi_debug
> >   0190 PQ: 0 ANSI: 7
> > [ 2260.989683] sd 8:0:0:0: Attached scsi generic sg15 type 0
> > [ 2260.989738] sd 8:0:0:0: Power-on or device reset occurred
> > [ 2261.009878] sd 8:0:0:0: [sdl] 16384 512-byte logical blocks: (8.39
> > MB/8.00 MiB)
> > [ 2261.014263] sd 7:0:0:0: [sdk] 16384 512-byte logical blocks: (8.39
> > MB/8.00 MiB)
> > [ 2261.016650] scsi host9: scsi_debug: version 0190 [20200710]
> > [ 2261.016650]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> > [ 2261.017094] scsi_debug:sdebug_driver_probe: scsi_debug: trim
> > poll_queues to 0. poll_q/nr_hw = (0/1)
> > [ 2261.017109] scsi 9:0:0:0: Direct-Access     Linux    scsi_debug
> >   0190 PQ: 0 ANSI: 7
> > [ 2261.017407] sd 9:0:0:0: Attached scsi generic sg16 type 0
> > [ 2261.017413] sd 9:0:0:0: Power-on or device reset occurred
> > [ 2261.024287] sd 7:0:0:0: [sdk] Write Protect is off
> > [ 2261.027452] scsi host10: scsi_debug: version 0190 [20200710]
> > [ 2261.027452]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> > [ 2261.032073] sd 8:0:0:0: [sdl] Write Protect is off
> > [ 2261.037519] sd 9:0:0:0: [sdm] 16384 512-byte logical blocks: (8.39
> > MB/8.00 MiB)
> > [ 2261.042678] scsi 10:0:0:0: Direct-Access     Linux    scsi_debug
> >    0190 PQ: 0 ANSI: 7
> > [ 2261.052111] sd 8:0:0:0: [sdl] Write cache: enabled, read cache:
> > enabled, supports DPO and FUA
> > [ 2261.054769] sd 7:0:0:0: [sdk] Write cache: enabled, read cache:
> > enabled, supports DPO and FUA
> > [ 2261.063333] sd 10:0:0:0: Power-on or device reset occurred
> > [ 2261.063340] sd 10:0:0:0: Attached scsi generic sg17 type 0
> > [ 2261.064024] sd 9:0:0:0: [sdm] Write Protect is off
> > [ 2261.082156] sd 8:0:0:0: [sdl] Optimal transfer size 524288 bytes
> > [ 2261.084058] sd 9:0:0:0: [sdm] Write cache: enabled, read cache:
> > enabled, supports DPO and FUA
> > [ 2261.101158] sd 7:0:0:0: [sdk] Optimal transfer size 524288 bytes
> > [ 2261.106817] sd 10:0:0:0: [sdn] 16384 512-byte logical blocks: (8.39
> > MB/8.00 MiB)
> > [ 2261.114100] sd 9:0:0:0: [sdm] Optimal transfer size 524288 bytes
> > [ 2261.128948] sd 10:0:0:0: [sdn] Write Protect is off
> > [  2261.210521] sts DPO and FUA
> > [  2261.249185] s[ 2261.632507] sd 8:0:0:0: [sdl] Attached SCSI disk
> > [ 2261.672478] sd 7:0:0:0: [sdk] Attached SCSI disk
> > [ 2261.672489] sd 9:0:0:0: [sdm] Attached SCSI disk
> > [ 2261.802507] sd 10:0:0:0: [sdn] Attached SCSI disk
> > [ 2262.173663] sd 9:0:0:0: [sdm] Synchronizing SCSI cache
> > [ 2262.173676] sd 8:0:0:0: [sdl] Synchronizing SCSI cache
> > [ 2262.185405] scsi 9:0:0:0: Direct-Access     Linux    scsi_debug
> >   0190 PQ: 0 ANSI: 7
> > [ 2262.190384] scsi 8:0:0:0: Direct-Access     Linux    scsi_debug
> >   0190 PQ: 0 ANSI: 7
> > [ 2262.193772] sd 9:0:0:0: Attached scsi generic sg14 type 0
> > [ 2262.193848] sd 9:0:0:0: Power-on or device reset occurred
> > [ 2262.201866] sd 8:0:0:0: Power-on or device reset occurred
> > [ 2262.207047] sd 8:0:0:0: Attached scsi generic sg15 type 0
> > [ 2262.213925] sd 9:0:0:0: [sdl] 16384 512-byte logical blocks: (8.39
> > MB/8.00 MiB)
> > [ 2262.218506] sd 7:0:0:0: [sdk] Synchronizing SCSI cache
> > [ 2262.223159] sd 9:0:0:0: [sdl] Write Protect is off
> > [ 2262.223184] sd 8:0:0:0: [sdm] Read Capacity(16) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.223189] sd 8:0:0:0: [sdm] Sense not available.
> > [ 2262.223200] sd 8:0:0:0: [sdm] Read Capacity(10) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.223203] sd 8:0:0:0: [sdm] Sense not available.
> > [ 2262.223213] sd 8:0:0:0: [sdm] 0 512-byte logical blocks: (0 B/0 B)
> > [ 2262.223216] sd 8:0:0:0: [sdm] 0-byte physical blocks
> > [ 2262.223224] sd 8:0:0:0: [sdm] Write Protect is on
> > [ 2262.223233] sd 8:0:0:0: [sdm] Asking for cache data failed
> > [ 2262.223235] sd 8:0:0:0: [sdm] Assuming drive cache: write through
> > [ 2262.231018] sd 10:0:0:0: [sdn] Synchronizing SCSI cache
> > [ 2262.235604] sd 9:0:0:0: [sdl] Asking for cache data failed
> > [ 2262.236777] scsi 7:0:0:0: Direct-Access     Linux    scsi_debug
> >   0190 PQ: 0 ANSI: 7
> > [ 2262.237063] sd 7:0:0:0: Attached scsi generic sg14 type 0
> > [ 2262.237115] sd 7:0:0:0: Power-on or device reset occurred
> > [ 2262.246789] scsi 10:0:0:0: Direct-Access     Linux    scsi_debug
> >    0190 PQ: 0 ANSI: 7
> > [ 2262.247170] sd 7:0:0:0: [sdk] Read Capacity(16) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.247174] sd 7:0:0:0: [sdk] Sense not available.
> > [ 2262.247185] sd 7:0:0:0: [sdk] Read Capacity(10) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.247188] sd 7:0:0:0: [sdk] Sense not available.
> > [ 2262.247198] sd 7:0:0:0: [sdk] 0 512-byte logical blocks: (0 B/0 B)
> > [ 2262.247201] sd 7:0:0:0: [sdk] 0-byte physical blocks
> > [ 2262.247207] sd 7:0:0:0: [sdk] Write Protect is on
> > [ 2262.247216] sd 7:0:0:0: [sdk] Asking for cache data failed
> > [ 2262.247218] sd 7:0:0:0: [sdk] Assuming drive cache: write through
> > [ 2262.249761] sd 9:0:0:0: [sdl] Assuming drive cache: write through
> > [ 2262.254794] sd 10:0:0:0: Attached scsi generic sg14 type 0
> > [ 2262.254819] sd 10:0:0:0: Power-on or device reset occurred
> > [ 2262.274922] sd 10:0:0:0: [sdn] 16384 512-byte logical blocks: (8.39
> > MB/8.00 MiB)
> > [ 2262.295902] sd 8:0:0:0: [sdm] Read Capacity(16) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.296079] sd 10:0:0:0: [sdn] Write Protect is off
> > [ 2262.301282] sd 8:0:0:0: [sdm] Sense not available.
> > [ 2262.306770] sd 10:0:0:0: [sdn] Asking for cache data failed
> > [ 2262.438436] sd 10:0:0:0: [sdn] Assuming drive cache: write through
> > [ 2262.444621] sd 10:0:0:0: [sdn] Optimal transfer size 524288 bytes
> > [ 2262.475561] sd 7:0:0:0: [sdk] Read Capacity(16) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.484960] sd 7:0:0:0: [sdk] Sense not available.
> > [ 2262.485574] sd 9:0:0:0: [sdl] Read Capacity(16) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.495670] sd 10:0:0:0: [sdn] Read Capacity(16) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.499129] sd 9:0:0:0: [sdl] Sense not available.
> > [ 2262.508592] sd 10:0:0:0: [sdn] Sense not available.
> > [ 2262.552707] sd 8:0:0:0: [sdm] Read Capacity(10) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.562089] sd 8:0:0:0: [sdm] Sense not available.
> > [ 2262.566909] sd 8:0:0:0: [sdm] Write Protect is off
> > [ 2262.571702] sd 8:0:0:0: [sdm] Attached SCSI disk
> > [ 2262.592701] sd 7:0:0:0: [sdk] Read Capacity(10) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.602082] sd 7:0:0:0: [sdk] Sense not available.
> > [ 2262.606897] sd 7:0:0:0: [sdk] Write Protect is off
> > [ 2262.611691] sd 7:0:0:0: [sdk] Attached SCSI disk
> > [ 2262.632824] sd 9:0:0:0: [sdl] Read Capacity(10) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.632826] sd 10:0:0:0: [sdn] Read Capacity(10) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.639249] scsi 8:0:0:0: Direct-Access     Linux    scsi_debug
> >   0190 PQ: 0 ANSI: 7
> > [ 2262.639510] sd 8:0:0:0: Attached scsi generic sg14 type 0
> > [ 2262.639536] sd 8:0:0:0: Power-on or device reset occurred
> > [ 2262.642208] sd 9:0:0:0: [sdl] Sense not available.
> > [ 2262.649586] sd 8:0:0:0: [sdm] Read Capacity(16) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.649590] sd 8:0:0:0: [sdm] Sense not available.
> > [ 2262.649600] sd 8:0:0:0: [sdm] Read Capacity(10) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.649603] sd 8:0:0:0: [sdm] Sense not available.
> > [ 2262.649613] sd 8:0:0:0: [sdm] 0 512-byte logical blocks: (0 B/0 B)
> > [ 2262.649615] sd 8:0:0:0: [sdm] 0-byte physical blocks
> > [ 2262.649621] sd 8:0:0:0: [sdm] Write Protect is off
> > [ 2262.649629] sd 8:0:0:0: [sdm] Asking for cache data failed
> > [ 2262.649631] sd 8:0:0:0: [sdm] Assuming drive cache: write through
> > [ 2262.651678] sd 10:0:0:0: [sdn] Sense not available.
> > [ 2262.651691] sd 10:0:0:0: [sdn] 0 512-byte logical blocks: (0 B/0 B)
> > [ 2262.659778] sd 9:0:0:0: [sdl] 0 512-byte logical blocks: (0 B/0 B)
> > [ 2262.665171] sdn: detected capacity change from 16384 to 0
> > [ 2262.670559] sdl: detected capacity change from 16384 to 0
> > [ 2262.675330] sd 10:0:0:0: [sdn] Attached SCSI disk
> > [ 2262.684711] sd 9:0:0:0: [sdl] Attached SCSI disk
> > [ 2262.788917] scsi 7:0:0:0: Direct-Access     Linux    scsi_debug
> >   0190 PQ: 0 ANSI: 7
> > [ 2262.797259] sd 7:0:0:0: Attached scsi generic sg14 type 0
> > [ 2262.797288] sd 7:0:0:0: Power-on or device reset occurred
> > [ 2262.808090] sd 7:0:0:0: [sdk] Read Capacity(16) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.817481] sd 7:0:0:0: [sdk] Sense not available.
> > [ 2262.822271] sd 7:0:0:0: [sdk] Read Capacity(10) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.831669] sd 7:0:0:0: [sdk] Sense not available.
> > [ 2262.835596] sd 8:0:0:0: [sdm] Read Capacity(16) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.836469] sd 7:0:0:0: [sdk] 0 512-byte logical blocks: (0 B/0 B)
> > [ 2262.845838] sd 8:0:0:0: [sdm] Sense not available.
> > [ 2262.852000] sd 7:0:0:0: [sdk] 0-byte physical blocks
> > [ 2262.861765] sd 7:0:0:0: [sdk] Write Protect is off
> > [ 2262.863794] scsi 9:0:0:0: Direct-Access     Linux    scsi_debug
> >   0190 PQ: 0 ANSI: 7
> > [ 2262.868565] scsi 10:0:0:0: Direct-Access     Linux    scsi_debug
> >    0190 PQ: 0 ANSI: 7
> > [ 2262.868825] sd 10:0:0:0: Attached scsi generic sg14 type 0
> > [ 2262.868862] sd 10:0:0:0: Power-on or device reset occurred
> > [ 2262.874892] sd 9:0:0:0: Attached scsi generic sg14 type 0
> > [ 2262.874920] sd 9:0:0:0: Power-on or device reset occurred
> > [ 2262.878916] sd 10:0:0:0: [sdl] Read Capacity(16) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.878920] sd 10:0:0:0: [sdl] Sense not available.
> > [ 2262.878931] sd 10:0:0:0: [sdl] Read Capacity(10) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2262.878934] sd 10:0:0:0: [sdl] Sense not available.
> > [ 2262.878944] sd 10:0:0:0: [sdl] 0 512-byte logical blocks: (0 B/0 B)
> > [ 2262.878946] sd 10:0:0:0: [sdl] 0-byte physical blocks
> > [ 2262.878952] sd 10:0:0:0: [sdl] Write Protect is off
> > [ 2262.878960] sd 10:0:0:0: [sdl] Asking for cache data failed
> > [ 2262.878962] sd 10:0:0:0: [sdl] Assuming drive cache: write through
> > [ 2262.882813] sd 7:0:0:0: [sdk] Asking for cache data failed
> > [ 2262.894986] sd 9:0:0:0: [sdn] 16384 512-byte logical blocks: (8.39
> > MB/8.00 MiB)
> > [ 2262.899142] sd 7:0:0:0: [sdk] Assuming drive cache: write through
> > [ 2262.904537] sd 9:0:0:0: [sdn] Write Protect is off
> > [ 2262.984722] sd 9:0:0:0: [sdn] Asking for cache data failed
> > [ 2262.990195] sd 9:0:0:0: [sdn] Assuming drive cache: write through
> > [ 2263.015502] sd 10:0:0:0: [sdl] Read Capacity(16) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2263.024985] sd 10:0:0:0: [sdl] Sense not available.
> > [ 2263.052711] sd 8:0:0:0: [sdm] Read Capacity(10) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2263.055557] sd 9:0:0:0: [sdn] Read Capacity(16) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2263.062092] sd 8:0:0:0: [sdm] Sense not available.
> > [ 2263.066282] sd 7:0:0:0: [sdk] Read Capacity(16) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2263.066288] sd 7:0:0:0: [sdk] Sense not available.
> > [ 2263.066304] sd 7:0:0:0: [sdk] Read Capacity(10) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2263.066308] sd 7:0:0:0: [sdk] Sense not available.
> > [ 2263.066338] sd 7:0:0:0: [sdk] Attached SCSI disk
> > [ 2263.071479] sd 9:0:0:0: [sdn] Sense not available.
> > [ 2263.114031] sd 8:0:0:0: [sdm] Attached SCSI disk
> > [ 2263.178933] scsi 8:0:0:0: Direct-Access     Linux    scsi_debug
> >   0190 PQ: 0 ANSI: 7
> > [ 2263.187276] sd 8:0:0:0: Attached scsi generic sg14 type 0
> > [ 2263.187370] sd 8:0:0:0: Power-on or device reset occurred
> > [ 2263.198126] sd 8:0:0:0: [sdm] Read Capacity(16) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2263.207522] sd 8:0:0:0: [sdm] Sense not available.
> > [ 2263.212312] sd 8:0:0:0: [sdm] Read Capacity(10) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2263.212722] sd 10:0:0:0: [sdl] Read Capacity(10) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2263.221703] sd 8:0:0:0: [sdm] Sense not available.
> > [ 2263.231165] sd 10:0:0:0: [sdl] Sense not available.
> > [ 2263.235953] sd 8:0:0:0: [sdm] 0 512-byte logical blocks: (0 B/0 B)
> > [ 2263.240837] sd 10:0:0:0: [sdl] Attached SCSI disk
> > [ 2263.246992] sd 8:0:0:0: [sdm] 0-byte physical blocks
> > [ 2263.256637] sd 8:0:0:0: [sdm] Write Protect is off
> > [ 2263.261422] sd 8:0:0:0: [sdm] Asking for cache data failed
> > [ 2263.266903] sd 8:0:0:0: [sdm] Assuming drive cache: write through
> > [ 2263.293351] sd 9:0:0:0: [sdn] Read Capacity(10) failed: Result:
> > hostbyte=DID_ERROR driverbyte=DRIVER_OK
> > [ 2263.298586] ------------[ cut here ]------------
> > [ 2263.302739] sd 9:0:0:0: [sdn] Sense not available.
> > [ 2263.307335] WARNING: CPU: 109 PID: 739473 at block/blk-stat.c:218
> > blk_free_queue_stats+0x3c/0x80
> > [ 2263.312121] sd 9:0:0:0: [sdn] 0 512-byte logical blocks: (0 B/0 B)
> > [ 2263.320880] Modules linked in: scsi_debug dm_log_writes rfkill
> > mlx5_ib ib_uverbs ib_core sunrpc mlx5_core mlxfw psample acpi_ipmi
> > i2c_smbus tls joydev ipmi_ssif ipmi_devintf ipmi_msghandler vfat fat
> > thunderx2_pmu fuse
> > [ 2263.327074] sdn: detected capacity change from 16384 to 0
> > [ 2263.327076]  zram ip_tables
> > [ 2263.346360] sd 9:0:0:0: [sdn] Attached SCSI disk
> > [ 2263.351733]  xfs crct10dif_ce ast ghash_ce i2c_algo_bit
> > drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt
> > fb_sys_fops cec drm_ttm_helper ttm drm gpio_xlp i2c_xlp9xx uas
> > usb_storage aes_neon_bs
> > [ 2263.377547] CPU: 109 PID: 739473 Comm: check Not tainted 5.15.0-rc6 #1
> > [ 2263.384064] Hardware name: HPE Apollo 70             /C01_APACHE_MB
> >         , BIOS L50_5.13_1.11 06/18/2019
> > [ 2263.393790] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [ 2263.400741] pc : blk_free_queue_stats+0x3c/0x80
> > [ 2263.405259] lr : blk_release_queue+0x48/0x140
> > [ 2263.409604] sp : ffff80002c3c3aa0
> > [ 2263.412906] x29: ffff80002c3c3aa0 x28: ffff00089e500000 x27: 0000000000000000
> > [ 2263.420031] x26: ffff000815f5d428 x25: dead000000000100 x24: dead000000000122
> > [ 2263.427156] x23: ffff000815f56150 x22: 0000000000000000 x21: ffff0008a85a0860
> > [ 2263.434280] x20: ffff8000120351a8 x19: ffff0008a85a07e0 x18: ffffffffffffffff
> > [ 2263.441404] x17: 303a377465677261 x16: 742f3774736f682f x15: 0000000000000000
> > [ 2263.448528] x14: 0000000000000001 x13: 0000000000000040 x12: 0000000000000040
> > [ 2263.455652] x11: ffff000800400b68 x10: ffff000800400b6a x9 : ffff80001077604c
> > [ 2263.462776] x8 : ffff000800405ff8 x7 : 0000000000000000 x6 : ffff000800406160
> > [ 2263.469900] x5 : 0000000000000000 x4 : 0000000000000003 x3 : 0000000000000000
> > [ 2263.477024] x2 : 0000000000002710 x1 : ffff00088ab81b80 x0 : ffff0008a21cfa80
> > [ 2263.484149] Call trace:
> > [ 2263.486584]  blk_free_queue_stats+0x3c/0x80
> > [ 2263.490755]  blk_release_queue+0x48/0x140
> > [ 2263.494752]  kobject_cleanup+0x4c/0x180
> > [ 2263.498578]  kobject_put+0x50/0xd0
> > [ 2263.501968]  blk_put_queue+0x20/0x30
> > [ 2263.505535]  scsi_device_dev_release_usercontext+0x160/0x244
> > [ 2263.511188]  execute_in_process_context+0x50/0xa0
> > [ 2263.515883]  scsi_device_dev_release+0x28/0x3c
> > [ 2263.520316]  device_release+0x40/0xa0
> > [ 2263.523968]  kobject_cleanup+0x4c/0x180
> > [ 2263.527792]  kobject_put+0x50/0xd0
> > [ 2263.531182]  put_device+0x20/0x30
> > [ 2263.534485]  scsi_device_put+0x38/0x50
> > [ 2263.538224]  sdev_store_delete+0x90/0xf0
> > [ 2263.542136]  dev_attr_store+0x24/0x40
> > [ 2263.545786]  sysfs_kf_write+0x50/0x60
> > [ 2263.549436]  kernfs_fop_write_iter+0x134/0x1c4
> > [ 2263.553869]  new_sync_write+0xdc/0x15c
> > [ 2263.557609]  vfs_write+0x230/0x2d0
> > [ 2263.560998]  ksys_write+0x64/0xec
> > [ 2263.564301]  __arm64_sys_write+0x28/0x34
> > [ 2263.568212]  invoke_syscall+0x50/0x120
> > [ 2263.571953]  el0_svc_common.constprop.0+0x4c/0x100
> > [ 2263.576732]  do_el0_svc+0x34/0xa0
> > [ 2263.580035]  el0_svc+0x30/0xd0
> > [ 2263.583081]  el0t_64_sync_handler+0xa4/0x130
> > [ 2263.587340]  el0t_64_sync+0x1a4/0x1a8
> > [ 2263.590991] ---[ end trace 1631cb4f2dc87b68 ]---
> >
> >
> > --
> > Best Regards,
> >   Yi Zhang
>
>
>
> --
> Best Regards,
>   Yi Zhang



-- 
Best Regards,
  Yi Zhang

