Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E86C433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 05:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D4760FBF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 05:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbhJ0Fse (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 01:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238201AbhJ0Fsd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 01:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635313568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VIe7PddaFb80aASYqdjY8BNSY06jB/G5YQFcYYiYIRg=;
        b=fWVL8nbQfUJfleWA+QO3jTiQR2LE6l+Xa4cqjuOjGOp9+2ffQ41rE0LLYYOID22RwqbjpT
        h8wDPzNK9f4YXCe7IOGA4/hthijzYq3Aa6jjA8SsO8JoiAkTOYGalPJl9DhXo4G0MyzMyT
        f+ShnbKpcmhr/dJ+9Bge7rph2vQWmeY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-0t-AdjEiPciyOFdQK__RqQ-1; Wed, 27 Oct 2021 01:46:06 -0400
X-MC-Unique: 0t-AdjEiPciyOFdQK__RqQ-1
Received: by mail-yb1-f200.google.com with SMTP id m81-20020a252654000000b005c135d4efdeso2200449ybm.22
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 22:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VIe7PddaFb80aASYqdjY8BNSY06jB/G5YQFcYYiYIRg=;
        b=rfitzO5kDT2S9IFozpYFKCPVL9yvLL4+18YDlDqPdzWwul+HlwUHEpW+ezREvIkwaQ
         XIY6y40olI9tgkUU+AvbZrIwGFFmqctQ6QlXXlz2LiKm+fp+Z4hhiu4Ad8oqAKvTEyN+
         VhfZuRXJqSaMZa44BZjpr3NuP9kq/qvA4lR6fc1VfgP/3SYdveI9qe33gWOijOXmHbw2
         HaJp3DJAsOv+B7sR3PWL87qwbB0/eWVHmD5ivo+n4a3mGcw9DxzSqPCnL6H20vunakb2
         wSpt/Ycl/Kvs/jHLrIRLBVaE+TqZ0d5l/HkM9FCmD6uq4A43D9PBenZ+dp9o8CqJvL42
         OawA==
X-Gm-Message-State: AOAM532dznc1zOWVHzy/T6VWCu7GaVE6g/usfZDgLBUvf4fJ0R+RDB/I
        IUzAQDINOzEzPX5nCyTkKLFLPJPi1O60+U8ldku3RVd/yygcwWrjFIo4EgfJdlF4Lv8g6PHECIo
        AYJj1u//NH7oEvmFONvDtPmHMiLK712gfv/CXZ58=
X-Received: by 2002:a25:ad03:: with SMTP id y3mr28543475ybi.522.1635313565617;
        Tue, 26 Oct 2021 22:46:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNdZtzfMpNzsK5MWTv85NUo0+Q2vzCy+Tgj8/Miyrqw4bUB0TNGgyYKdZZTKGdznnR6BiLvEFQVixfF1kwvvY=
X-Received: by 2002:a25:ad03:: with SMTP id y3mr28543451ybi.522.1635313565323;
 Tue, 26 Oct 2021 22:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-_vkTW=dAzbZYGxpEWSpzpcmaNeY1R=vH311+9vMUSdg@mail.gmail.com>
In-Reply-To: <CAHj4cs-_vkTW=dAzbZYGxpEWSpzpcmaNeY1R=vH311+9vMUSdg@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 27 Oct 2021 13:45:53 +0800
Message-ID: <CAHj4cs_7WTL6eiD8Er=GO-FiFcfwbWxde08a4gDrFHw_Vqr09A@mail.gmail.com>
Subject: Re: [bug report][bisected] WARNING: CPU: 4 PID: 10482 at
 block/mq-deadline.c:597 dd_exit_sched+0x198/0x1d0
To:     linux-block <linux-block@vger.kernel.org>
Cc:     skt-results-master@redhat.com,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Changhui Zhong <czhong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bisecting shows it was introduced from below commit:

commit 2ff0682da6e09c1e0db63a2d2abcd4efb531c8db
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Oct 15 09:44:38 2021 -0600

    block: store elevator state in request

    Add an rq private RQF_ELV flag, which tells the block layer that this
    request was initialized on a queue that has an IO scheduler attached.
    This allows for faster checking in the fast path, rather than having to
    deference rq->q later on.

    Elevator switching does full quiesce of the queue before detaching an
    IO scheduler, so it's safe to cache this in the request itself.



Here is another log[2] triggered by scsi-debug fio tests[1]
[1]
https://gitlab.com/cki-project/kernel-tests/-/blob/main/storage/block/fs_fio/runtest.sh
[2]
[ 1112.348295] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[ 1112.348339] scsi host1: scsi_debug: version 0190 [20200710]
                 dev_size_mb=6144, opts=0x0, submit_queues=1, statistics=0
[ 1112.349234] scsi 1:0:0:0: Direct-Access     Linux    scsi_debug
  0190 PQ: 0 ANSI: 7
[ 1112.349580] sd 1:0:0:0: Power-on or device reset occurred
[ 1112.349637] sd 1:0:0:0: Attached scsi generic sg2 type 0
[ 1112.369756] sd 1:0:0:0: [sdb] 12582912 512-byte logical blocks:
(6.44 GB/6.00 GiB)
[ 1112.379864] sd 1:0:0:0: [sdb] Write Protect is off
[ 1112.379880] sd 1:0:0:0: [sdb] Mode Sense: 73 00 10 08
[ 1112.400332] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[ 1112.430438] sd 1:0:0:0: [sdb] Optimal transfer size 524288 bytes
[ 1112.793383] sd 1:0:0:0: [sdb] Attached SCSI disk
[ 1120.056278] HOST:host1 ,DISK:/dev/sdb ,I/O SCHED:mq-deadline ,FSTYPE:ext2
[ 1121.916590] EXT4-fs (sdb): mounting ext2 file system using the ext4 subsystem
[ 1121.959726] EXT4-fs (sdb): mounted filesystem without journal.
Opts: (null). Quota mode: none.
[ 1122.174428] hrtimer: interrupt took 8900 ns
[ 1182.447526] HOST:host1 ,DISK:/dev/sdb ,I/O SCHED:mq-deadline ,FSTYPE:ext3
[ 1359.486446] EXT4-fs (sdb): mounting ext3 file system using the ext4 subsystem
[ 1359.712286] EXT4-fs (sdb): mounted filesystem with ordered data
mode. Opts: (null). Quota mode: none.
[ 1420.376102] HOST:host1 ,DISK:/dev/sdb ,I/O SCHED:mq-deadline ,FSTYPE:ext4
[ 1421.653574] EXT4-fs (sdb): mounted filesystem with ordered data
mode. Opts: (null). Quota mode: none.
[ 1482.381289] HOST:host1 ,DISK:/dev/sdb ,I/O SCHED:mq-deadline ,FSTYPE:xfs
[ 1483.717398] XFS (sdb): Mounting V5 Filesystem
[ 1484.082012] XFS (sdb): Ending clean mount
[ 1484.242791] xfs filesystem being mounted at /mnt/test supports
timestamps until 2038 (0x7fffffff)
[ 1544.757546] XFS (sdb): Unmounting Filesystem
[ 1545.121423] ------------[ cut here ]------------
[ 1545.121445] statistics for priority 1: i 67042 m 0 d 67048 c 67038
[ 1545.121497] WARNING: CPU: 44 PID: 110967 at block/mq-deadline.c:597
dd_exit_sched+0x198/0x1d0
[ 1545.121526] Modules linked in: scsi_debug loop rfkill sunrpc at24
ses enclosure scsi_transport_sas regmap_i2c joydev i40e ipmi_powernv
tpm_i2c_nuvoton ofpart ipmi_devintf crct10dif_vpmsum ipmi_msghandler
opal_prd rtc_opal powernv_flash mtd i2c_opal fuse zram ip_tables xfs
ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm
vmx_crypto crc32c_vpmsum i2c_core aacraid drm_panel_orientation_quirks
[last unloaded: nvme_core]
[ 1545.121668] CPU: 44 PID: 110967 Comm: bash Tainted: G        W
   5.15.0-rc6 #1
[ 1545.121687] NIP:  c000000000973ab8 LR: c000000000973ab4 CTR: c0000000000cd680
[ 1545.121705] REGS: c00000005a92f720 TRAP: 0700   Tainted: G        W
         (5.15.0-rc6)
[ 1545.121723] MSR:  900000000282b033
<SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 48428282  XER: 20040006
[ 1545.121759] CFAR: c000000000152b34 IRQMASK: 0
               GPR00: c000000000973ab4 c00000005a92f9c0
c0000000028a9a00 0000000000000036
               GPR04: 00000000ffff7fff c00000005a92f678
c00000005a92f670 0000000000000027
               GPR08: 0000000000000001 c0000007fed87f90
0000000000000023 0000000000000001
               GPR12: 0000000028428282 c0000007fffafe00
0000000000000000 0000000000000000
               GPR16: 0000000131fb87b8 0000000131fb94d4
0000000020000000 0000000131ecae80
               GPR20: c00020002178f0bc 00000000000105e2
00000000000105de 0000000000000001
               GPR24: c00000000152b4a8 0000000000000000
c0000000027e2094 0000000000000000
               GPR28: c00020002178f148 c00020002178f000
0000000000000001 c00020002178f080
[ 1545.121919] NIP [c000000000973ab8] dd_exit_sched+0x198/0x1d0
[ 1545.121937] LR [c000000000973ab4] dd_exit_sched+0x194/0x1d0
[ 1545.121953] Call Trace:
[ 1545.121961] [c00000005a92f9c0] [c000000000973ab4]
dd_exit_sched+0x194/0x1d0 (unreliable)
[ 1545.121983] [c00000005a92fa80] [c000000000947628]
blk_mq_exit_sched+0xe8/0x120
[ 1545.122005] [c00000005a92fad0] [c000000000925504]
elevator_switch_mq+0x84/0x210
[ 1545.122026] [c00000005a92fb50] [c000000000925d8c]
elv_iosched_store+0x47c/0x5d0
[ 1545.122046] [c00000005a92fbb0] [c00000000092ce78] queue_attr_store+0x78/0xc0
[ 1545.122068] [c00000005a92fc00] [c000000000644a44] sysfs_kf_write+0x64/0x80
[ 1545.122087] [c00000005a92fc20] [c000000000643f0c]
kernfs_fop_write_iter+0x1bc/0x2b0
[ 1545.122107] [c00000005a92fc70] [c000000000521494] new_sync_write+0x124/0x1b0
[ 1545.122129] [c00000005a92fd10] [c000000000524794] vfs_write+0x2c4/0x390
[ 1545.122148] [c00000005a92fd60] [c000000000524b08] ksys_write+0x78/0x130
[ 1545.122166] [c00000005a92fdb0] [c00000000002d648]
system_call_exception+0x188/0x360
[ 1545.122189] [c00000005a92fe10] [c00000000000c1e8]
system_call_vectored_common+0xe8/0x278
[ 1545.122212] --- interrupt: 3000 at 0x7fff8982fee4
[ 1545.122226] NIP:  00007fff8982fee4 LR: 0000000000000000 CTR: 0000000000000000
[ 1545.122243] REGS: c00000005a92fe80 TRAP: 3000   Tainted: G        W
         (5.15.0-rc6)
[ 1545.122261] MSR:  900000000280f033
<SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48422488  XER: 00000000
[ 1545.122296] IRQMASK: 0
               GPR00: 0000000000000004 00007fffca9f8230
00007fff89927000 0000000000000001
               GPR04: 00000001719f58b0 0000000000000006
0000000000000010 0000000171ce2863
               GPR08: 0000000000000000 0000000000000000
0000000000000000 0000000000000000
               GPR12: 0000000000000000 00007fff89a6afa0
0000000000000000 0000000000000000
               GPR16: 0000000131fb87b8 0000000131fb94d4
0000000020000000 0000000131ecae80
               GPR20: 0000000000000000 00007fffca9f8454
0000000131f63128 0000000131fb89bc
               GPR24: 0000000131fb8a50 0000000000000000
00000001719f58b0 0000000000000006
               GPR28: 0000000000000006 00007fff899216d8
00000001719f58b0 0000000000000006
[ 1545.124405] NIP [00007fff8982fee4] 0x7fff8982fee4
[ 1545.128567] LR [0000000000000000] 0x0
[ 1545.132725] --- interrupt: 3000
[ 1545.135501] Instruction dump:
[ 1545.138275] 2c090000 4082ff7c 9afa0000 81140000 80ff0038 80df0034
80bf0030 7d0807b4
[ 1545.146594] 7fc4f378 7f03c378 4b7df01d 60000000 <0fe00000> 60420000
0fe00000 60000000
[ 1545.154914] ---[ end trace a32220e1437afcc2 ]---


On Tue, Oct 19, 2021 at 11:27 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
>
> Here is another issue triggered with blktests nvmeof-mp/012 on ppc64le
>
> >        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> >             Commit: 1983520d28d8 - Merge branch 'for-5.16/io_uring' into for-next
>
>
> [  198.810575] run blktests nvmeof-mp/012 at 2021-10-18 14:04:34
> [  198.880348] null_blk: module loaded
> [  198.952441] device-mapper: table: 253:1: multipath: error getting device
> [  198.952458] device-mapper: ioctl: error adding target to table
> [  198.952642] SoftiWARP attached
> [  199.070415] nvmet: adding nsid 1 to subsystem nvme-test
> [  199.079054] nvmet_rdma: enabling port 1 (10.0.2.177:7777)
> [  199.172211] nvmet: creating controller 1 for subsystem nvme-test
> for NQN nqn.2014-08.org.nvmexpress:uuid:548b1456-be56-4e3b-b887-a93e4557c960.
> [  199.172631] nvme nvme0: creating 8 I/O queues.
> [  199.176935] nvme nvme0: mapped 8/0/0 default/read/poll queues.
> [  199.177528] nvme nvme0: new ctrl: NQN "nvme-test", addr 10.0.2.177:7777
> [  199.191054] device-mapper: table: 253:1: multipath: error getting device
> [  199.191065] device-mapper: ioctl: error adding target to table
> [  199.302695] device-mapper: table: 253:2: multipath: error getting device
> [  199.302703] device-mapper: ioctl: error adding target to table
> [  201.342136] ------------[ cut here ]------------
> [  201.342149] statistics for priority 1: i 5803 m 0 d 5803 c 6467
> [  201.342163] WARNING: CPU: 4 PID: 10482 at block/mq-deadline.c:597
> dd_exit_sched+0x198/0x1d0
> [  201.342171] Modules linked in: nvme nvmet_rdma nvmet siw null_blk
> nvme_rdma nvme_fabrics rdma_cm iw_cm ib_cm dm_service_time
> scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath ib_core nvme_core
> bonding tls rfkill sunrpc ibmveth crct10dif_vpmsum pseries_rng drm
> drm_panel_orientation_quirks i2c_core fuse zram ip_tables xfs ibmvscsi
> nx_compress_pseries scsi_transport_srp nx_compress vmx_crypto
> crc32c_vpmsum [last unloaded: siw]
> [  201.342213] CPU: 4 PID: 10482 Comm: check Not tainted 5.15.0-rc6 #1
> [  201.342218] NIP:  c0000000009733d8 LR: c0000000009733d4 CTR: 00000000006db41c
> [  201.342223] REGS: c00000002134b720 TRAP: 0700   Not tainted  (5.15.0-rc6)
> [  201.342227] MSR:  800000000282b033
> <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 4842828f  XER: 00000004
> [  201.342239] CFAR: c000000000152b34 IRQMASK: 0
> [  201.342239] GPR00: c0000000009733d4 c00000002134b9c0
> c0000000028a9a00 0000000000000033
> [  201.342239] GPR04: 00000000ffffdfff c00000002134b678
> c00000002134b670 0000000000000027
> [  201.342239] GPR08: 0000000000000001 c0000001ffa07f90
> 0000000000000023 0000000000000001
> [  201.342239] GPR12: 000000002842828f c00000001eca9d00
> 0000000000000000 0000000000000000
> [  201.342239] GPR16: 00000001334d87b8 00000001334d94d4
> 0000000020000000 00000001333eae80
> [  201.342239] GPR20: c00000000ece5ebc 00000000000016ab
> 0000000000001943 0000000000000001
> [  201.342239] GPR24: c00000000152b440 0000000000000000
> c0000000027e2094 0000000000000000
> [  201.342239] GPR28: c00000000ece5f48 c00000000ece5e00
> 0000000000000001 c00000000ece5e80
> [  201.342289] NIP [c0000000009733d8] dd_exit_sched+0x198/0x1d0
> [  201.342294] LR [c0000000009733d4] dd_exit_sched+0x194/0x1d0
> [  201.342298] Call Trace:
> [  201.342301] [c00000002134b9c0] [c0000000009733d4]
> dd_exit_sched+0x194/0x1d0 (unreliable)
> [  201.342308] [c00000002134ba80] [c000000000946f98]
> blk_mq_exit_sched+0xe8/0x120
> [  201.342314] [c00000002134bad0] [c0000000009251c4]
> elevator_switch_mq+0x84/0x210
> [  201.342319] [c00000002134bb50] [c000000000925a4c]
> elv_iosched_store+0x47c/0x5d0
> [  201.342325] [c00000002134bbb0] [c00000000092cb58] queue_attr_store+0x78/0xc0
> [  201.342330] [c00000002134bc00] [c000000000644984] sysfs_kf_write+0x64/0x80
> [  201.342336] [c00000002134bc20] [c000000000643e4c]
> kernfs_fop_write_iter+0x1bc/0x2b0
> [  201.342342] [c00000002134bc70] [c000000000521314] new_sync_write+0x124/0x1b0
> [  201.342348] [c00000002134bd10] [c000000000524614] vfs_write+0x2c4/0x390
> [  201.342353] [c00000002134bd60] [c000000000524988] ksys_write+0x78/0x130
> [  201.342359] [c00000002134bdb0] [c00000000002d648]
> system_call_exception+0x188/0x360
> [  201.342365] [c00000002134be10] [c00000000000c1e8]
> system_call_vectored_common+0xe8/0x278
> [  201.342371] --- interrupt: 3000 at 0x7fffb664fee4
> [  201.342375] NIP:  00007fffb664fee4 LR: 0000000000000000 CTR: 0000000000000000
> [  201.342379] REGS: c00000002134be80 TRAP: 3000   Not tainted  (5.15.0-rc6)
> [  201.342383] MSR:  800000000280f033
> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48422488  XER: 00000000
> [  201.342395] IRQMASK: 0
> [  201.342395] GPR00: 0000000000000004 00007fffdfc43400
> 00007fffb6747000 0000000000000001
> [  201.342395] GPR04: 0000010010ac2b20 0000000000000006
> 0000000000000010 0000010010acdec3
> [  201.342395] GPR08: 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000
> [  201.342395] GPR12: 0000000000000000 00007fffb688afa0
> 0000000000000000 0000000000000000
> [  201.342395] GPR16: 00000001334d87b8 00000001334d94d4
> 0000000020000000 00000001333eae80
> [  201.342395] GPR20: 0000000000000000 00007fffdfc43624
> 0000000133483128 00000001334d89bc
> [  201.342395] GPR24: 00000001334d8a50 0000000000000000
> 0000010010ac2b20 0000000000000006
> [  201.342395] GPR28: 0000000000000006 00007fffb67416d8
> 0000010010ac2b20 0000000000000006
> [  201.342441] NIP [00007fffb664fee4] 0x7fffb664fee4
> [  201.342445] LR [0000000000000000] 0x0
> [  201.342447] --- interrupt: 3000
> [  201.342450] Instruction dump:
> [  201.342452] 2c090000 4082ff7c 9afa0000 81140000 80ff0038 80df0034
> 80bf0030 7d0807b4
> [  201.342461] 7fc4f378 7f03c378 4b7df6fd 60000000 <0fe00000> 60420000
> 0fe00000 60000000
> [  201.342470] ---[ end trace 108cf85114306689 ]---
> [  202.926082] nvme nvme0: Removing ctrl: NQN "nvme-test"
> [  203.272436] nvmet: creating controller 1 for subsystem nvme-test
> for NQN nqn.2014-08.org.nvmexpress:uuid:548b1456-be56-4e3b-b887-a93e4557c960.
> [  203.272975] nvme nvme0: creating 8 I/O queues.
> [  203.277569] nvme nvme0: mapped 8/0/0 default/read/poll queues.
> [  203.278187] nvme nvme0: new ctrl: NQN "nvme-test", addr 10.0.2.177:7777
> [  203.290859] device-mapper: table: 253:1: multipath: error getting device
> [  203.290866] device-mapper: ioctl: error adding target to table
> [  203.401606] device-mapper: table: 253:1: multipath: error getting device
> [  203.401614] device-mapper: ioctl: error adding target to table
> [  207.146139] nvme nvme0: Removing ctrl: NQN "nvme-test"
> [  207.927071] SoftiWARP detached
>
> --
> Best Regards,
>   Yi Zhang



--
Best Regards,
  Yi Zhang

