Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685E4C433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 10:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F4F60FBF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 10:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhJZKJH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 06:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235113AbhJZKJH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 06:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635242803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQaA/e8gnyYL+gcFoIxwI/pnJZTh0WltUrt5KerQtT0=;
        b=jVl58EXJI18EUHdznC1Nt0DU2NCLbxyBLjxtKMfEKiiTvKEuxEgSeQRUZPPuZXwSHgPAHY
        oS8nDBFZeW7thKIyHSMvQmG6jPEuqE4t7bM3HlPR7XuWBpAmsaucEFzpWGu6pQ4l3Pn6r+
        UNDIv9TlO5y+Je/xHD4Ml1ZNNLzRR+c=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-t75eSlpZNGaVEkSi9yxsgQ-1; Tue, 26 Oct 2021 06:06:42 -0400
X-MC-Unique: t75eSlpZNGaVEkSi9yxsgQ-1
Received: by mail-yb1-f198.google.com with SMTP id i128-20020a252286000000b005beea522aa8so21813111ybi.17
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 03:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQaA/e8gnyYL+gcFoIxwI/pnJZTh0WltUrt5KerQtT0=;
        b=gJUvQnPdWIjsglpGjYhX1UNDeuQ2asmdX6nVHgjgjjNaLWOlf8dGVR1rRi7uzmr8Dx
         tRZ632rXQ8vntazABu/60jDyuah+cIRT8UJoy4u1ZWIe3u4TO84lHKqMBXC/Eckiy5RB
         rhTF084tlX5A+5uWw2Flhn6cf4eNCS5pI/H9L4c7i633izeVc1UBDpkJ8lx435xCN5nO
         632+ZI1dUdVJqhUSjgGrabP7YPsXaVlXYMuPSDf9HCL8eH8EIOOX6ovDeUL4i3ZYn7pM
         L9voACgF5JhrCCul8e+7dtXB1yrU203/Hep0TAWGypL5aD4L99NhWJsKRPzeUWG4X9HX
         Qpkg==
X-Gm-Message-State: AOAM531Yosr+O3j+7AFgRyg9ghRbGXwRepzkzKodYjXQQgWaWe8AXDMs
        Ap78MYV5gqmV/VeeF3vRfRCT9uN5PUZZj7lldoO8Yz+2mMtLuMsyY5B+DXCS3xkjqDv1G1TWtYG
        izWqx8LRVolYZ7LB72d1CifPiZdxVRqJBAbsbw7o=
X-Received: by 2002:a25:ad03:: with SMTP id y3mr22836688ybi.522.1635242801478;
        Tue, 26 Oct 2021 03:06:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz45JoRGqFEhLrCgCJIX4vltMT4ON45oF3hS39Vjs20k/c0BHHsFoKoJyz8mN+teDnwMWG3yUYdil/SgdNnAoo=
X-Received: by 2002:a25:ad03:: with SMTP id y3mr22836668ybi.522.1635242801269;
 Tue, 26 Oct 2021 03:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9w7_thDw-DN11GaoA+HH9YVAMHmrAZhi_rA24xhbTYOA@mail.gmail.com>
 <CAHj4cs_CM7NzJtNmnD0CiPVOmr0jVEktNyD8d=UMZ0xEUArzow@mail.gmail.com>
 <CAHj4cs-M0Pp7OxE6QXJkGrjHcoqz+bdBuVngjsTp07h8gzLHXQ@mail.gmail.com>
 <9350ac53-84c0-b102-16ba-68fee6bcdbca@kernel.dk> <20211026083553.GB4494@lst.de>
In-Reply-To: <20211026083553.GB4494@lst.de>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 26 Oct 2021 18:06:30 +0800
Message-ID: <CAHj4cs8svrCYMajbVXToKSAB+ZuE1kKBFpm_-OWXw3OdU4qngg@mail.gmail.com>
Subject: Re: [bug report][bisected] WARNING: CPU: 109 PID: 739473 at
 block/blk-stat.c:218 blk_free_queue_stats+0x3c/0x80
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        skt-results-master@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph

It still can be reproduced with the patch, here is the log:
[   60.427575] run blktests block/001 at 2021-10-26 05:46:07
[   60.449111] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[   60.458422] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[   60.467694] sd 0:0:0:0: Power-on or device reset occurred
[   60.467719] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[   60.467958] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[   60.491409] sd 1:0:0:0: Power-on or device reset occurred
[   60.491596] sd 2:0:0:0: Power-on or device reset occurred
[   60.491893] sd 3:0:0:0: Power-on or device reset occurred
[   61.493843] sd 3:0:0:0: Power-on or device reset occurred
[   61.499283] sd 3:0:0:0: [sdd] Asking for cache data failed
[   61.504765] sd 3:0:0:0: [sdd] Assuming drive cache: write through
[   61.513449] sd 1:0:0:0: Power-on or device reset occurred
[   61.513608] sd 0:0:0:0: Power-on or device reset occurred
[   61.524250] sd 1:0:0:0: [sda] Asking for cache data failed
[   61.529722] sd 1:0:0:0: [sda] Assuming drive cache: write through
[   61.535811] sd 0:0:0:0: [sdb] Asking for cache data failed
[   61.541287] sd 0:0:0:0: [sdb] Assuming drive cache: write through
[   61.547537] sd 2:0:0:0: Power-on or device reset occurred
[   61.773630] ------------[ cut here ]------------
[   61.778238] WARNING: CPU: 77 PID: 1673 at block/blk-stat.c:218
blk_free_queue_stats+0x3c/0x80
[   61.786755] Modules linked in: scsi_debug rfkill sunrpc vfat fat
dm_service_time dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua
sbsa_gwdt acpi_ipmi ipmi_ssif igb ipmi_devintf ipmi_msghandler arm_cmn
cppc_cpufreq arm_dsu_pmu fuse zram ip_tables xfs ast i2c_algo_bit
drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops cec crct10dif_ce drm_ttm_helper ttm ghash_ce nvme drm
nvme_core xgene_hwmon aes_neon_bs
[   61.824812] CPU: 77 PID: 1673 Comm: check Not tainted 5.15.0-rc6.rc6.hch+ #4
[   61.831848] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS
F07 03/22/2021
[   61.839231] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   61.846181] pc : blk_free_queue_stats+0x3c/0x80
[   61.850699] lr : blk_release_queue+0x48/0x140
[   61.855045] sp : ffff800015cdbaa0
[   61.858346] x29: ffff800015cdbaa0 x28: ffff07ff84bfc200 x27: 0000000000000000
[   61.865470] x26: ffff07ff8f9d4428 x25: dead000000000100 x24: dead000000000122
[   61.872593] x23: ffff07ff8f9ec150 x22: 0000000000000000 x21: ffff07ff8c5f74e0
[   61.879716] x20: ffffc5e925264cd8 x19: ffff07ff8c5f7460 x18: ffffffffffffffff
[   61.886839] x17: 303a327465677261 x16: 742f3274736f682f x15: 0000000000000000
[   61.893962] x14: 0000000000000001 x13: 0000000000000040 x12: 0000000000000040
[   61.901085] x11: ffff07ff80407d78 x10: ffff07ff80407d7a x9 : ffffc5e92399b55c
[   61.908208] x8 : ffff07ff80403dc0 x7 : 0000000000000000 x6 : ffff07ff80403dd8
[   61.915331] x5 : 0000000000000000 x4 : 0000000000000003 x3 : 0000000000000000
[   61.922454] x2 : 0000000000002710 x1 : ffff07ffcfd60100 x0 : ffff07ff83732b00
[   61.929577] Call trace:
[   61.932011]  blk_free_queue_stats+0x3c/0x80
[   61.936182]  blk_release_queue+0x48/0x140
[   61.940179]  kobject_cleanup+0x4c/0x180
[   61.944004]  kobject_put+0x50/0xd0
[   61.947393]  blk_put_queue+0x20/0x30
[   61.950957]  scsi_device_dev_release_usercontext+0x160/0x244
[   61.956605]  execute_in_process_context+0x50/0xa0
[   61.961298]  scsi_device_dev_release+0x28/0x3c
[   61.965732]  device_release+0x40/0xa0
[   61.969384]  kobject_cleanup+0x4c/0x180
[   61.973207]  kobject_put+0x50/0xd0
[   61.976596]  put_device+0x20/0x30
[   61.979900]  scsi_device_put+0x38/0x50
[   61.983638]  sdev_store_delete+0x90/0xf0
[   61.987549]  dev_attr_store+0x24/0x40
[   61.991199]  sysfs_kf_write+0x50/0x60
[   61.994850]  kernfs_fop_write_iter+0x134/0x1c4
[   61.999282]  new_sync_write+0xdc/0x15c
[   62.003020]  vfs_write+0x230/0x2d0
[   62.006410]  ksys_write+0x64/0xec
[   62.009713]  __arm64_sys_write+0x28/0x34
[   62.013623]  invoke_syscall+0x50/0x120
[   62.017362]  el0_svc_common.constprop.0+0x4c/0x100
[   62.022142]  do_el0_svc+0x34/0xa0
[   62.025446]  el0_svc+0x30/0xd0
[   62.028490]  el0t_64_sync_handler+0xa4/0x130
[   62.032748]  el0t_64_sync+0x1a4/0x1a8
[   62.036399] ---[ end trace ecf3f33db601e65a ]---
[   62.041567] sd 2:0:0:0: Power-on or device reset occurred
[   62.045090] ------------[ cut here ]------------
[   62.045549] ------------[ cut here ]------------
[   62.045552] WARNING: CPU: 60 PID: 1672 at block/blk-stat.c:218
blk_free_queue_stats+0x3c/0x80



On Tue, Oct 26, 2021 at 4:36 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Yi,
>
> can you try the patch below?  This changes the teardown code to not
> re-enable writeback tracking when we're shutting the queue down, which
> is what I suspect is on the ->callbacks list.
>
> diff --git a/block/elevator.c b/block/elevator.c
> index ff45d8388f487..bb5c6ee4546cd 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -523,8 +523,6 @@ void elv_unregister_queue(struct request_queue *q)
>                 kobject_del(&e->kobj);
>
>                 e->registered = 0;
> -               /* Re-enable throttling in case elevator disabled it */
> -               wbt_enable_default(q);
>         }
>  }
>
> @@ -591,8 +589,11 @@ int elevator_switch_mq(struct request_queue *q,
>         lockdep_assert_held(&q->sysfs_lock);
>
>         if (q->elevator) {
> -               if (q->elevator->registered)
> +               if (q->elevator->registered) {
>                         elv_unregister_queue(q);
> +                       /* Re-enable throttling in case elevator disabled it */
> +                       wbt_enable_default(q);
> +               }
>
>                 ioc_clear_queue(q);
>                 elevator_exit(q, q->elevator);
>


-- 
Best Regards,
  Yi Zhang

