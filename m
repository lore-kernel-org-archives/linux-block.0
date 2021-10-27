Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972CBC433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 17:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A9160D07
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 17:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhJ0RWL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243231AbhJ0RWK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 13:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635355184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gj2tzvxx8FDQ0+eZTAehsVLlZpR6bGEyerZgsrSQpnE=;
        b=enaqLOD0aAwtYdz8YJctA4TaKH1eUxiXVEV0tOVASJLtbNDUAyI9U/4JZ3OKSlYStbjyUP
        QJAHm/q7oZTllCfyW2CETSfpkt0dyW3SaZE628q+1+8sc47PF60hcXu0Wd/aHOKqQeD+ki
        2C3ygIktZaBdmxdbdZmjCcvJy4+T2Ck=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-3LBxzYveNcucoMrmbdJMOQ-1; Wed, 27 Oct 2021 13:19:43 -0400
X-MC-Unique: 3LBxzYveNcucoMrmbdJMOQ-1
Received: by mail-yb1-f198.google.com with SMTP id a20-20020a25ae14000000b005c1961310aeso4772661ybj.3
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 10:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gj2tzvxx8FDQ0+eZTAehsVLlZpR6bGEyerZgsrSQpnE=;
        b=DZXdo3QV1FWEFnE+2VQ/B6M7jsxBiYiO3/Z8eF4QuRWjI49LT1XXU5+DSgb1qSPAjb
         i+h9+lV33VwDdKrAYozAnjWf7DUAVhS4aagjpaoONifU3w8r7L2o+eo7IuEIuASJco9L
         MXK773qqPbqYzBGFXMEP1m174useHjUU3OQJiY0SbuuE3XVkGbVCtjslyFH1gufAsCgF
         uIeuuvQa/H6WJ3pILDTHaaxuFxAK65Zf2Pb3aPYCYcP/lEqNEshCaNYLZRcKMwihBwU+
         xhc5GG+Rr+9q6YeTIQF6sDp9CcYZwqI6bqGeB47f2C6SOQ+gSAe11BPqEXiaqW47CxNp
         s3zA==
X-Gm-Message-State: AOAM5326nEmA4Gj0bnxhZOEFzL5iEGM+0Q6hhMWbmgFTs82CBg4vuuuI
        nbUwWN3GUYlI03FollSlGizbbPE6vcMvOBBxepzPQXdSnyNqx9COFwEypVwB8UBfZYWvvWo1E+b
        cOwvoAW89i4cV7ERf9Nplf70d8hebguyrRpqZIus=
X-Received: by 2002:a25:3104:: with SMTP id x4mr33596978ybx.512.1635355183002;
        Wed, 27 Oct 2021 10:19:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9aNBWTRdtJ72ILgowZ1wvT6nbOdty2/OWqQ0RJxbsDLX36cM1uCmqF7e4meu5ZXDg/rq62wY3PeZWj+46G0Q=
X-Received: by 2002:a25:3104:: with SMTP id x4mr33596950ybx.512.1635355182763;
 Wed, 27 Oct 2021 10:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-_vkTW=dAzbZYGxpEWSpzpcmaNeY1R=vH311+9vMUSdg@mail.gmail.com>
 <CAHj4cs_7WTL6eiD8Er=GO-FiFcfwbWxde08a4gDrFHw_Vqr09A@mail.gmail.com> <ce9aaafb-35da-6fa1-f2fe-4ab13bdb7ff0@kernel.dk>
In-Reply-To: <ce9aaafb-35da-6fa1-f2fe-4ab13bdb7ff0@kernel.dk>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 28 Oct 2021 01:19:31 +0800
Message-ID: <CAHj4cs_SuT2uR1=k-FGJ9gLWFvg=BvsLMu9d3UTjrQEt72cMVQ@mail.gmail.com>
Subject: Re: [bug report][bisected] WARNING: CPU: 4 PID: 10482 at
 block/mq-deadline.c:597 dd_exit_sched+0x198/0x1d0
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        skt-results-master@redhat.com,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Changhui Zhong <czhong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 27, 2021 at 11:48 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/26/21 11:45 PM, Yi Zhang wrote:
> > Bisecting shows it was introduced from below commit:
> >
> > commit 2ff0682da6e09c1e0db63a2d2abcd4efb531c8db
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Fri Oct 15 09:44:38 2021 -0600
> >
> >     block: store elevator state in request
> >
> >     Add an rq private RQF_ELV flag, which tells the block layer that this
> >     request was initialized on a queue that has an IO scheduler attached.
> >     This allows for faster checking in the fast path, rather than having to
> >     deference rq->q later on.
> >
> >     Elevator switching does full quiesce of the queue before detaching an
> >     IO scheduler, so it's safe to cache this in the request itself.
> >
> >
> >
> > Here is another log[2] triggered by scsi-debug fio tests[1]
> > [1]
> > https://gitlab.com/cki-project/kernel-tests/-/blob/main/storage/block/fs_fio/runtest.sh
> > [2]
> > [ 1112.348295] scsi_debug:sdebug_driver_probe: scsi_debug: trim
> > poll_queues to 0. poll_q/nr_hw = (0/1)
> > [ 1112.348339] scsi host1: scsi_debug: version 0190 [20200710]
> >                  dev_size_mb=6144, opts=0x0, submit_queues=1, statistics=0
> > [ 1112.349234] scsi 1:0:0:0: Direct-Access     Linux    scsi_debug
> >   0190 PQ: 0 ANSI: 7
> > [ 1112.349580] sd 1:0:0:0: Power-on or device reset occurred
> > [ 1112.349637] sd 1:0:0:0: Attached scsi generic sg2 type 0
> > [ 1112.369756] sd 1:0:0:0: [sdb] 12582912 512-byte logical blocks:
> > (6.44 GB/6.00 GiB)
> > [ 1112.379864] sd 1:0:0:0: [sdb] Write Protect is off
> > [ 1112.379880] sd 1:0:0:0: [sdb] Mode Sense: 73 00 10 08
> > [ 1112.400332] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:
> > enabled, supports DPO and FUA
> > [ 1112.430438] sd 1:0:0:0: [sdb] Optimal transfer size 524288 bytes
> > [ 1112.793383] sd 1:0:0:0: [sdb] Attached SCSI disk
> > [ 1120.056278] HOST:host1 ,DISK:/dev/sdb ,I/O SCHED:mq-deadline ,FSTYPE:ext2
> > [ 1121.916590] EXT4-fs (sdb): mounting ext2 file system using the ext4 subsystem
> > [ 1121.959726] EXT4-fs (sdb): mounted filesystem without journal.
> > Opts: (null). Quota mode: none.
> > [ 1122.174428] hrtimer: interrupt took 8900 ns
> > [ 1182.447526] HOST:host1 ,DISK:/dev/sdb ,I/O SCHED:mq-deadline ,FSTYPE:ext3
> > [ 1359.486446] EXT4-fs (sdb): mounting ext3 file system using the ext4 subsystem
> > [ 1359.712286] EXT4-fs (sdb): mounted filesystem with ordered data
> > mode. Opts: (null). Quota mode: none.
> > [ 1420.376102] HOST:host1 ,DISK:/dev/sdb ,I/O SCHED:mq-deadline ,FSTYPE:ext4
> > [ 1421.653574] EXT4-fs (sdb): mounted filesystem with ordered data
> > mode. Opts: (null). Quota mode: none.
> > [ 1482.381289] HOST:host1 ,DISK:/dev/sdb ,I/O SCHED:mq-deadline ,FSTYPE:xfs
> > [ 1483.717398] XFS (sdb): Mounting V5 Filesystem
> > [ 1484.082012] XFS (sdb): Ending clean mount
> > [ 1484.242791] xfs filesystem being mounted at /mnt/test supports
> > timestamps until 2038 (0x7fffffff)
> > [ 1544.757546] XFS (sdb): Unmounting Filesystem
> > [ 1545.121423] ------------[ cut here ]------------
> > [ 1545.121445] statistics for priority 1: i 67042 m 0 d 67048 c 67038
> > [ 1545.121497] WARNING: CPU: 44 PID: 110967 at block/mq-deadline.c:597
> > dd_exit_sched+0x198/0x1d0
> > [ 1545.121526] Modules linked in: scsi_debug loop rfkill sunrpc at24
> > ses enclosure scsi_transport_sas regmap_i2c joydev i40e ipmi_powernv
> > tpm_i2c_nuvoton ofpart ipmi_devintf crct10dif_vpmsum ipmi_msghandler
> > opal_prd rtc_opal powernv_flash mtd i2c_opal fuse zram ip_tables xfs
> > ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea
> > sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm
> > vmx_crypto crc32c_vpmsum i2c_core aacraid drm_panel_orientation_quirks
> > [last unloaded: nvme_core]
> > [ 1545.121668] CPU: 44 PID: 110967 Comm: bash Tainted: G        W
> >    5.15.0-rc6 #1
> > [ 1545.121687] NIP:  c000000000973ab8 LR: c000000000973ab4 CTR: c0000000000cd680
> > [ 1545.121705] REGS: c00000005a92f720 TRAP: 0700   Tainted: G        W
> >          (5.15.0-rc6)
> > [ 1545.121723] MSR:  900000000282b033
> > <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 48428282  XER: 20040006
> > [ 1545.121759] CFAR: c000000000152b34 IRQMASK: 0
> >                GPR00: c000000000973ab4 c00000005a92f9c0
> > c0000000028a9a00 0000000000000036
> >                GPR04: 00000000ffff7fff c00000005a92f678
> > c00000005a92f670 0000000000000027
> >                GPR08: 0000000000000001 c0000007fed87f90
> > 0000000000000023 0000000000000001
> >                GPR12: 0000000028428282 c0000007fffafe00
> > 0000000000000000 0000000000000000
> >                GPR16: 0000000131fb87b8 0000000131fb94d4
> > 0000000020000000 0000000131ecae80
> >                GPR20: c00020002178f0bc 00000000000105e2
> > 00000000000105de 0000000000000001
> >                GPR24: c00000000152b4a8 0000000000000000
> > c0000000027e2094 0000000000000000
> >                GPR28: c00020002178f148 c00020002178f000
> > 0000000000000001 c00020002178f080
> > [ 1545.121919] NIP [c000000000973ab8] dd_exit_sched+0x198/0x1d0
> > [ 1545.121937] LR [c000000000973ab4] dd_exit_sched+0x194/0x1d0
> > [ 1545.121953] Call Trace:
> > [ 1545.121961] [c00000005a92f9c0] [c000000000973ab4]
> > dd_exit_sched+0x194/0x1d0 (unreliable)
> > [ 1545.121983] [c00000005a92fa80] [c000000000947628]
> > blk_mq_exit_sched+0xe8/0x120
> > [ 1545.122005] [c00000005a92fad0] [c000000000925504]
> > elevator_switch_mq+0x84/0x210
> > [ 1545.122026] [c00000005a92fb50] [c000000000925d8c]
> > elv_iosched_store+0x47c/0x5d0
> > [ 1545.122046] [c00000005a92fbb0] [c00000000092ce78] queue_attr_store+0x78/0xc0
> > [ 1545.122068] [c00000005a92fc00] [c000000000644a44] sysfs_kf_write+0x64/0x80
> > [ 1545.122087] [c00000005a92fc20] [c000000000643f0c]
> > kernfs_fop_write_iter+0x1bc/0x2b0
> > [ 1545.122107] [c00000005a92fc70] [c000000000521494] new_sync_write+0x124/0x1b0
> > [ 1545.122129] [c00000005a92fd10] [c000000000524794] vfs_write+0x2c4/0x390
> > [ 1545.122148] [c00000005a92fd60] [c000000000524b08] ksys_write+0x78/0x130
> > [ 1545.122166] [c00000005a92fdb0] [c00000000002d648]
> > system_call_exception+0x188/0x360
> > [ 1545.122189] [c00000005a92fe10] [c00000000000c1e8]
> > system_call_vectored_common+0xe8/0x278
> > [ 1545.122212] --- interrupt: 3000 at 0x7fff8982fee4
> > [ 1545.122226] NIP:  00007fff8982fee4 LR: 0000000000000000 CTR: 0000000000000000
> > [ 1545.122243] REGS: c00000005a92fe80 TRAP: 3000   Tainted: G        W
> >          (5.15.0-rc6)
> > [ 1545.122261] MSR:  900000000280f033
> > <SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48422488  XER: 00000000
> > [ 1545.122296] IRQMASK: 0
> >                GPR00: 0000000000000004 00007fffca9f8230
> > 00007fff89927000 0000000000000001
> >                GPR04: 00000001719f58b0 0000000000000006
> > 0000000000000010 0000000171ce2863
> >                GPR08: 0000000000000000 0000000000000000
> > 0000000000000000 0000000000000000
> >                GPR12: 0000000000000000 00007fff89a6afa0
> > 0000000000000000 0000000000000000
> >                GPR16: 0000000131fb87b8 0000000131fb94d4
> > 0000000020000000 0000000131ecae80
> >                GPR20: 0000000000000000 00007fffca9f8454
> > 0000000131f63128 0000000131fb89bc
> >                GPR24: 0000000131fb8a50 0000000000000000
> > 00000001719f58b0 0000000000000006
> >                GPR28: 0000000000000006 00007fff899216d8
> > 00000001719f58b0 0000000000000006
> > [ 1545.124405] NIP [00007fff8982fee4] 0x7fff8982fee4
> > [ 1545.128567] LR [0000000000000000] 0x0
> > [ 1545.132725] --- interrupt: 3000
> > [ 1545.135501] Instruction dump:
> > [ 1545.138275] 2c090000 4082ff7c 9afa0000 81140000 80ff0038 80df0034
> > 80bf0030 7d0807b4
> > [ 1545.146594] 7fc4f378 7f03c378 4b7df01d 60000000 <0fe00000> 60420000
> > 0fe00000 60000000
> > [ 1545.154914] ---[ end trace a32220e1437afcc2 ]---
>
> What kernel are you running?

The linux-block/for-next, and it still can be reproduced with the latest update:
8cfa4097726f (HEAD -> for-next, origin/for-next) Merge branch
'for-5.16/block' into for-next

>
>
> --
> Jens Axboe
>


-- 
Best Regards,
  Yi Zhang

