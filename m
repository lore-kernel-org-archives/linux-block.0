Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC40C433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 01:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhLFBmS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Dec 2021 20:42:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231303AbhLFBmR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 Dec 2021 20:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638754729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a4NbWKp1PZ15oHJdxO6LndqNftD4bDXpvskOlv73WYk=;
        b=DGBbDv69OdOtk+s/MdzMDvLYZA37s6TjuZ0IfJBe5FruBA9bJAE445BufALSDGKGdnd2+l
        cvyHOWR9DjgIX6hyD4yF8+usbE1373ews9X09sicH8xpg4Wh4KqwSMWjgqYs81ISfrd53L
        KYlPbZ31jKRcuKrbdVr+w6liTk386Ek=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-UJq2_ZD-N46Ih-0_VZD8LQ-1; Sun, 05 Dec 2021 20:38:48 -0500
X-MC-Unique: UJq2_ZD-N46Ih-0_VZD8LQ-1
Received: by mail-yb1-f198.google.com with SMTP id l75-20020a25254e000000b005f763be2fecso17360373ybl.7
        for <linux-block@vger.kernel.org>; Sun, 05 Dec 2021 17:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4NbWKp1PZ15oHJdxO6LndqNftD4bDXpvskOlv73WYk=;
        b=euexvaTG8TdqRV1cb52LqC1w3pnfyO+M35n+TAm2ljjM9GqU0cwnyf63/veMg+vGNb
         BYynfWZrCph+DzP/c0CjHnXld1FDVyiE8L58EHK8IR7VWYDUE0cRW79YlEVsN4iiYA7E
         j9m/kHMUQJAEONcpMDyWqW8YZWs4tUE+EynfWY6Rq0zFnG/0Q420WgOjXphUNCgSszU/
         Ik9BgkUG403Hl47FL3+o2sEvb5fiy/iIQrRmqU4v2O5ialMkmbyClrrzk9P7AgbaviTc
         poe4GfZ3xaMdbi0aKb452X6aubcnk578ZBHKnDg+5x7UIw1iHgv6zHFu+z6ZwTeAQcdz
         bOcA==
X-Gm-Message-State: AOAM532IBokejYhoSZZbgpSoX29AqAkParVwKtsIUypqDTSwlACMDPZl
        MUZNKrto0wXIaRN7IOg43lft0e7GaF3T6sDHJ+ETI9MkqRozXq1cQmoNdvGaDIXRHREG1BK0k+R
        JqrVTvt8hkcVqMXJb5g849Xkok/2UiGiuCca+R2w=
X-Received: by 2002:a25:516:: with SMTP id 22mr41298520ybf.294.1638754727300;
        Sun, 05 Dec 2021 17:38:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9bHUEKKKwTXTtM7GhZ9u3gMN6EcopxXcZfsp8nlVn84Lh/ai1PIRQjsg8nKdQEHixcrx9YcO16iCaeChpkpU=
X-Received: by 2002:a25:516:: with SMTP id 22mr41298494ybf.294.1638754726948;
 Sun, 05 Dec 2021 17:38:46 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs-w_ypfFdiR=YDYZptcBUDh4=Qrc3-+ATpuDOng4PFbQA@mail.gmail.com>
In-Reply-To: <CAHj4cs-w_ypfFdiR=YDYZptcBUDh4=Qrc3-+ATpuDOng4PFbQA@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 6 Dec 2021 09:38:35 +0800
Message-ID: <CAHj4cs85h_Cs-yf0U=5eckaBifvciX1FNPEterBnGRc8rbKmuA@mail.gmail.com>
Subject: Re: [bug report] BUG kernel BULL pointer at blk_mq_flush_plug_list+0x2c4/0x320
 observed with blktests on latest linux-block/for-next
To:     linux-block <linux-block@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the first commit that observed this issue.
       Kernel repo:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
            Commit: c7d61010b991 - Merge branch 'for-5.17/block' into for-next

On Mon, Dec 6, 2021 at 9:12 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
>
> Pls help check below BUG which was observed with blktests
> nvmeof-mp/001 and nvme-tcp/004[2] on the latest linux-block/for-next,
> thanks.
>
> [1]
>        Kernel repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>             Commit: 779d83b81f10 - Merge branch 'for-5.17/io_uring'
> into for-next
>
> [2]
> blktests nvmeof-mp/001
> [  100.388217] run blktests nvmeof-mp/001 at 2021-12-05 18:51:31
> [  100.627004] alua: device handler registered
> [  100.635817] emc: device handler registered
> [  100.640664] rdac: device handler registered
> [  100.663307] null_blk: module loaded
> [  100.786784] rdma_rxe: loaded
> [  100.814890] enp0s1 speed is unknown, defaulting to 1000
> [  100.814982] enp0s1 speed is unknown, defaulting to 1000
> [  100.815073] enp0s1 speed is unknown, defaulting to 1000
> [  100.816861] infiniband enp0s1_rxe: set active
> [  100.816911] infiniband enp0s1_rxe: added enp0s1
> [  100.816959] enp0s1 speed is unknown, defaulting to 1000
> [  100.817750] enp0s1 speed is unknown, defaulting to 1000
> [  100.993731] nvmet: adding nsid 1 to subsystem nvme-test
> [  100.998621] enp0s1 speed is unknown, defaulting to 1000
> [  101.012647] nvmet_rdma: enabling port 1 (10.37.153.53:7777)
> [  101.101732] enp0s1 speed is unknown, defaulting to 1000
> [  101.138168] nvmet: creating nvm controller 1 for subsystem
> nvme-test for NQN
> nqn.2014-08.org.nvmexpress:uuid:1e166a91-9c9f-49cf-ad9e-3339ca552eff.
> [  101.138679] nvme nvme0: creating 8 I/O queues.
> [  101.171713] nvme nvme0: mapped 8/0/0 default/read/poll queues.
> [  101.173235] nvme nvme0: new ctrl: NQN "nvme-test", addr 10.37.153.53:7777
> [  101.174474] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [  101.174566] Faulting instruction address: 0xc000000000948114
> [  101.174622] Oops: Kernel access of bad area, sig: 11 [#1]
> [  101.174667] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
> [  101.174733] Modules linked in: nvme_rdma nvme_fabrics nvme
> nvmet_rdma rdma_cm iw_cm ib_cm nvmet crc32_generic rdma_rxe ib_uverbs
> ip6_udp_tunnel udp_tunnel null_blk scsi_dh_rdac scsi_dh_emc
> scsi_dh_alua dm_multipath ib_core nvme_core rfkill sunrpc joydev
> virtio_net net_failover failover virtio_balloon virtio_console
> crct10dif_vpmsum drm fuse drm_panel_orientation_quirks i2c_core zram
> ip_tables xfs vmx_crypto crc32c_vpmsum virtio_blk
> [  101.175072] CPU: 4 PID: 311 Comm: kworker/4:1H Not tainted 5.16.0-rc3 #1
> [  101.175128] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> [  101.175207] NIP:  c000000000948114 LR: c000000000948108 CTR: c000000000995d70
> [  101.175273] REGS: c00000000c853610 TRAP: 0380   Not tainted  (5.16.0-rc3)
> [  101.175328] MSR:  800000000280b033
> <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28008888  XER: 00000000
> [  101.175413] CFAR: c000000000947c4c IRQMASK: 0
> [  101.175413] GPR00: c000000000948108 c00000000c8538b0
> c0000000028ab700 c00000000f1e0000
> [  101.175413] GPR04: 0000000000000000 0000000000000004
> 0000000000000000 0000000000000000
> [  101.175413] GPR08: 000000023cfa0000 0000000000000000
> 0000000000000000 c008000003883ef8
> [  101.175413] GPR12: 0000000000000000 c00000003fff9d00
> c00000000018c6b8 c000000003bd65c0
> [  101.175413] GPR16: 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000
> [  101.175413] GPR20: 0000000000000000 0000000000000010
> c000000004c45848 0000000000000000
> [  101.175413] GPR24: 0000000000000001 c00000000c853a08
> c00000000c8539f0 c00000000c8538d0
> [  101.175413] GPR28: c0000000781c0350 0000000000000000
> c0000000781c0408 0000000000000000
> [  101.175982] NIP [c000000000948114] blk_mq_flush_plug_list+0x2c4/0x320
> [  101.176080] LR [c000000000948108] blk_mq_flush_plug_list+0x2b8/0x320
> [  101.176136] Call Trace:
> [  101.176159] [c00000000c8538b0] [c000000000948108]
> blk_mq_flush_plug_list+0x2b8/0x320 (unreliable)
> [  101.176240] [c00000000c853930] [c00000000093449c] blk_flush_plug+0x16c/0x1d0
> [  101.176309] [c00000000c8539a0] [c000000000934840] blk_finish_plug+0x50/0x70
> [  101.176365] [c00000000c8539d0] [c00800000387ffd0]
> nvmet_bdev_execute_rw+0x488/0x4a0 [nvmet]
> [  101.176443] [c00000000c853ab0] [c008000004000498]
> nvmet_rdma_execute_command+0xb0/0x1e0 [nvmet_rdma]
> [  101.176527] [c00000000c853b20] [c008000004002668]
> nvmet_rdma_handle_command+0x130/0x3c0 [nvmet_rdma]
> [  101.176606] [c00000000c853bb0] [c008000003056b68]
> __ib_process_cq+0xf0/0x220 [ib_core]
> [  101.176691] [c00000000c853c30] [c008000003056d18]
> ib_cq_poll_work+0x40/0x120 [ib_core]
> [  101.176776] [c00000000c853c70] [c000000000180298]
> process_one_work+0x2a8/0x5a0
> [  101.176852] [c00000000c853d10] [c000000000180c88] worker_thread+0xa8/0x630
> [  101.176908] [c00000000c853da0] [c00000000018c864] kthread+0x1b4/0x1c0
> [  101.176964] [c00000000c853e10] [c00000000000cf64]
> ret_from_kernel_thread+0x5c/0x64
> [  101.177033] Instruction dump:
> [  101.177067] 60000000 e93a0000 e8690000 38630578 4b8c80b5 60000000
> 7c7f1b78 7f43d378
> [  101.177137] 4bfffa55 e93a0000 57ea003c 2c0a0000 <e8690000> 38630578
> 4082002c 7fe4fb78
> [  101.177208] ---[ end trace 2812a3f381c2809e ]---
> [  101.178613]
> [  102.178643] Kernel panic - not syncing: Fatal exception
> [  102.186712] ------------[ cut here ]------------
> [  102.186766] WARNING: CPU: 4 PID: 311 at drivers/tty/vt/vt.c:4417
> do_unblank_screen+0x58/0x230
> [  102.186863] Modules linked in: nvme_rdma nvme_fabrics nvme
> nvmet_rdma rdma_cm iw_cm ib_cm nvmet crc32_generic rdma_rxe ib_uverbs
> ip6_udp_tunnel udp_tunnel null_blk scsi_dh_rdac scsi_dh_emc
> scsi_dh_alua dm_multipath ib_core nvme_core rfkill sunrpc joydev
> virtio_net net_failover failover virtio_balloon virtio_console
> crct10dif_vpmsum drm fuse drm_panel_orientation_quirks i2c_core zram
> ip_tables xfs vmx_crypto crc32c_vpmsum virtio_blk
> [  102.187191] CPU: 4 PID: 311 Comm: kworker/4:1H Tainted: G      D
>        5.16.0-rc3 #1
> [  102.187258] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> [  102.187321] NIP:  c000000000b72db8 LR: c000000000b72ed4 CTR: c000000000a71fd0
> [  102.187386] REGS: c00000000c8530d0 TRAP: 0700   Tainted: G      D
>          (5.16.0-rc3)
> [  102.187452] MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE>  CR:
> 28002828  XER: 20000000
> [  102.187523] CFAR: c000000000b72ee8 IRQMASK: 3
> [  102.187523] GPR00: c000000000b72ed4 c00000000c853370
> c0000000028ab700 0000000000000000
> [  102.187523] GPR04: 0000000000000001 0000000000000000
> 0000000000000000 0000000000000000
> [  102.187523] GPR08: 00000000000000ff 0000000000000001
> 0000000000000000 fffffffffffc85b8
> [  102.187523] GPR12: 0000000000002200 c00000003fff9d00
> c00000000018c6b8 c000000003bd65c0
> [  102.187523] GPR16: 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000
> [  102.187523] GPR20: 0000000000000000 0000000000000010
> c000000004c45848 0000000000000000
> [  102.187523] GPR24: 0000000000000001 c00000000c853a08
> c00000000c8539f0 c00000000c8538d0
> [  102.187523] GPR28: c0000000029a9a58 0000000000000000
> 0000000000000000 c0000000029f7e38
> [  102.188294] NIP [c000000000b72db8] do_unblank_screen+0x58/0x230
> [  102.188383] LR [c000000000b72ed4] do_unblank_screen+0x174/0x230
> [  102.188472] Call Trace:
> [  102.188506] [c00000000c853370] [c000000000b72ef4]
> do_unblank_screen+0x194/0x230 (unreliable)
> [  102.188662] [c00000000c8533f0] [c0000000001528f8] panic+0x1c0/0x3e8
> [  102.188793] [c00000000c853480] [c00000000002611c] oops_end+0x
>
> nvme-tcp nvme/004
> [ 9098.697744] run blktests nvme/004 at 2021-12-05 15:24:04
> [ 9098.739913] loop0: detected capacity change from 0 to 2097152
> [ 9098.827338] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 9098.885326] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [ 9098.891937] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0b6687646f514941b109de23af9a3810.
> [ 9098.892448] nvme nvme0: creating 128 I/O queues.
> [ 9098.903455] nvme nvme0: mapped 128/0/0 default/read/poll queues.
> [ 9098.936280] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420
> [ 9098.946707] Kernel attempted to read user page (0) - exploit
> attempt? (uid: 0)
> [ 9098.946730] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [ 9098.946750] Faulting instruction address: 0xc000000000948114
> [ 9098.946762] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 9098.946772] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
> [ 9098.946794] Modules linked in: nvme_tcp nvme_fabrics nvmet_tcp
> nvmet nvme nvme_core loop dm_log_writes rfkill sunrpc i40e joydev at24
> crct10dif_vpmsum tpm_i2c_nuvoton regmap_i2c opal_prd i2c_opal ses
> enclosure scsi_transport_sas ofpart ipmi_powernv ipmi_devintf
> ipmi_msghandler powernv_flash mtd rtc_opal fuse zram ip_tables xfs ast
> i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect
> sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm vmx_crypto
> crc32c_vpmsum i2c_core aacraid drm_panel_orientation_quirks [last
> unloaded: nvmet]
> [ 9098.946945] CPU: 8 PID: 901478 Comm: systemd-udevd Not tainted 5.16.0-rc3 #1
> [ 9098.946978] NIP:  c000000000948114 LR: c000000000948108 CTR: c000000001182010
> [ 9098.947000] REGS: c0000006220a74b0 TRAP: 0300   Not tainted  (5.16.0-rc3)
> [ 9098.947029] MSR:  900000000280b033
> <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24428488  XER: 20040000
> [ 9098.947073] CFAR: c000000000947c4c DAR: 0000000000000000 DSISR:
> 40000000 IRQMASK: 0
> [ 9098.947073] GPR00: c000000000948108 c0000006220a7750
> c0000000028ab700 c000000659186200
> [ 9098.947073] GPR04: 0000000000000000 c0000000028dae88
> 0001f86b8f5fb187 c000000678d96c80
> [ 9098.947073] GPR08: 0000000000000000 0000000000000000
> 0000000000000000 c008000014b95c10
> [ 9098.947073] GPR12: c000000001182010 c000000ffffd7400
> 0000000000000000 61c8864680b583eb
> [ 9098.947073] GPR16: 0000000000000001 c00000066c6ecc98
> 000000015509c3f0 c00000060297a158
> [ 9098.947073] GPR20: 0000000000000001 0000000000000000
> c000000678d96c80 0000000000000000
> [ 9098.947073] GPR24: 0000000000003fff c0000006220a78b0
> c0000006220a7898 c0000006220a7770
> [ 9098.947073] GPR28: c0000006220a7910 0000000000000000
> 0000000000000000 0000000000000000
> [ 9098.947274] NIP [c000000000948114] blk_mq_flush_plug_list+0x2c4/0x320
> [ 9098.947307] LR [c000000000948108] blk_mq_flush_plug_list+0x2b8/0x320
> [ 9098.947319] Call Trace:
> [ 9098.947334] [c0000006220a7750] [c000000000948108]
> blk_mq_flush_plug_list+0x2b8/0x320 (unreliable)
> [ 9098.947369] [c0000006220a77d0] [c00000000093449c] blk_flush_plug+0x16c/0x1d0
> [ 9098.947402] [c0000006220a7840] [c000000000934840] blk_finish_plug+0x50/0x70
> [ 9098.947434] [c0000006220a7870] [c0000000003f8838] read_pages+0x1e8/0x430
> [ 9098.947456] [c0000006220a78f0] [c0000000003f8cb8]
> page_cache_ra_unbounded+0x238/0x350
> [ 9098.947488] [c0000006220a79a0] [c0000000003f9498]
> force_page_cache_ra+0x108/0x190
> [ 9098.947521] [c0000006220a79e0] [c0000000003e6db0]
> filemap_get_pages+0x130/0xa30
> [ 9098.947554] [c0000006220a7b00] [c0000000003e77a8] filemap_read+0xf8/0x4b0
> [ 9098.947585] [c0000006220a7c30] [c000000000927c60]
> blkdev_read_iter+0x1a0/0x2b0
> [ 9098.947618] [c0000006220a7c70] [c000000000526434] new_sync_read+0x124/0x1b0
> [ 9098.947649] [c0000006220a7d10] [c0000000005294d0] vfs_read+0x1d0/0x240
> [ 9098.947670] [c0000006220a7d60] [c000000000529b08] ksys_read+0x78/0x130
> [ 9098.947692] [c0000006220a7db0] [c00000000002d488]
> system_call_exception+0x188/0x360
> [ 9098.947725] [c0000006220a7e10] [c00000000000c1e8]
> system_call_vectored_common+0xe8/0x278
> [ 9098.947758] --- interrupt: 3000 at 0x7fff85688d34
> [ 9098.947777] NIP:  00007fff85688d34 LR: 0000000000000000 CTR: 0000000000000000
> [ 9098.947808] REGS: c0000006220a7e80 TRAP: 3000   Not tainted  (5.16.0-rc3)
> [ 9098.947828] MSR:  900000000280f033
> <SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44424848  XER: 00000000
> [ 9098.947862] IRQMASK: 0
> [ 9098.947862] GPR00: 0000000000000003 00007fffd205ce20
> 00007fff856b7f00 0000000000000011
> [ 9098.947862] GPR04: 000000015509c7a8 0000000000000040
> 0000000000000003 0000000000000000
> [ 9098.947862] GPR08: 0000000000000008 0000000000000000
> 0000000000000000 0000000000000000
> [ 9098.947862] GPR12: 0000000000000000 00007fff84357ed0
> 0000000000000000 0000000000000000
> [ 9098.947862] GPR16: 00000001551055c4 00000001550f88e0
> 000000015509c3f0 ffffffffffffffff
> [ 9098.947862] GPR20: 00007fff85760394 00007fff857338e8
> 00007fff857338f8 00007fffd205d040
> [ 9098.947862] GPR24: 00007fffd205d038 0000000000000000
> 000000015509c6c0 000000015509c780
> [ 9098.947862] GPR28: 0000000000000040 000000003fff0000
> 000000015509c670 000000015509c798
> [ 9098.948044] NIP [00007fff85688d34] 0x7fff85688d34
> [ 9098.948062] LR [0000000000000000] 0x0
> [ 9098.948079] --- interrupt: 3000
> [ 9098.948096] Instruction dump:
> [ 9098.948112] 60000000 e93a0000 e8690000 38630578 4b8c80b5 60000000
> 7c7f1b78 7f43d378
> [ 9098.948149] 4bfffa55 e93a0000 57ea003c 2c0a0000 <e8690000> 38630578
> 4082002c 7fe4fb78
> [ 9098.948187] ---[ end trace da59439c4dde7675 ]---
> [ 9099.049806]
> [ 9099.959512] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> [ 9100.049823] Kernel panic - not syncing: Fatal exception
> [ 9102.065052] ---[ end Kernel panic - not syncing: Fatal exception ]---
> [ 9112.364479] watchdog: CPU 0 Hard LOCKUP
> [ 9112.364482] watchdog: CPU 0 TB:5517014335371, last heartbeat
> TB:5508822205614 (16000ms ago)
> [ 9112.364485] Modules linked in: nvme_tcp nvme_fabrics nvmet_tcp
> nvmet nvme nvme_core loop dm_log_writes rfkill sunrpc i40e joydev at24
> crct10dif_vpmsum tpm_i2c_nuvoton regmap_i2c opal_prd i2c_opal ses
> enclosure scsi_transport_sas ofpart ipmi_powernv ipmi_devintf
> ipmi_msghandler powernv_flash mtd rtc_opal fuse zram ip_tables xfs ast
> i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect
> sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm vmx_crypto
> crc32c_vpmsum i2c_core aacraid drm_panel_orientation_quirks [last
> unloaded: nvmet]
> [ 9112.364541] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D
>   5.16.0-rc3 #1
> [ 9112.364545] NIP:  c000000000059420 LR: c000000000059418 CTR: c0000000000593f0
> [ 9112.364548] REGS: c000000fffd03d60 TRAP: 0100   Tainted: G      D
>          (5.16.0-rc3)
> [ 9112.364551] MSR:  9000000000081033 <SF,HV,ME,IR,DR,RI,LE>  CR:
> 24000484  XER: 20040000
> [ 9112.364562] CFAR: c000000000059420 IRQMASK: 3
> [ 9112.364562] GPR00: c000000000059418 c0000000028a7a30
> c0000000028ab700 c0000000028e71b8
> [ 9112.364562] GPR04: 0000000000000000 c000200fff7fc000
> 0000000000000000 fffffffffffffffe
> [ 9112.364562] GPR08: c0000000028eb700 000000000000009f
> c0000000028e75b8 0000000000000000
> [ 9112.364562] GPR12: c0000000000593f0 c000000002b20000
> 0000000000000000 0000000000000000
> [ 9112.364562] GPR16: 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000
> [ 9112.364562] GPR20: 0000000000000000 0000000000000001
> 0000000000000000 c0000000027c21a0
> [ 9112.364562] GPR24: c000000ffc70f4c8 0000000000080000
> 0000000000000000 0000000000000001
> [ 9112.364562] GPR28: c0000000002387a0 c0000000028a7b40
> c0000000000593f0 0000000000000001
> [ 9112.364609] NIP [c000000000059420] nmi_stop_this_cpu+0x30/0x40
> [ 9112.364615] LR [c000000000059418] nmi_stop_this_cpu+0x28/0x40
> [ 9112.364619] Call Trace:
> [ 9112.364620] [c0000000028a7a50] [c00000000005ae4c]
> smp_handle_nmi_ipi+0xac/0x110
> [ 9112.364626] [c0000000028a7aa0] [c0000000000d7380]
> pnv_system_reset_exception+0x20/0x40
> [ 9112.364632] [c0000000028a7ac0] [c00000000002a170]
> system_reset_exception+0x90/0x280
> [ 9112.364638] [c0000000028a7b20] [c000000000015630]
> replay_system_reset+0x40/0x60
> [ 9112.364643] [c0000000028a7cc0] [c0000000000d11bc] arch300_idle_type+0xac/0xe0
> [ 9112.364647] [c0000000028a7d00] [c000000000e0e990] stop_loop+0x40/0x60
> [ 9112.364652] [c0000000028a7d30] [c000000000e0aef0]
> cpuidle_enter_state+0x230/0x540
> [ 9112.364658] [c0000000028a7d90] [c000000000e0b29c] cpuidle_enter+0x4c/0x70
> [ 9112.364664] [c0000000028a7dd0] [c0000000001aeaa8] do_idle+0x2f8/0x3f0
> [ 9112.364669] [c0000000028a7e60] [c0000000001aedc8] cpu_startup_entry+0x38/0x50
> [ 9112.364674] [c0000000028a7e90] [c00000000001288c] rest_init+0xec/0x110
> [ 9112.364679] [c0000000028a7ec0] [c000000002004c48] start_kernel+0xc54/0xc8c
> [ 9112.364684] [c0000000028a7f90] [c00000000000d970] start_here_common+0x1c/0x2c
> [ 9112.364689] Instruction dump:
> [ 9112.364690] 3c4c0285 38422310 7c0802a6 60000000 7c0802a6 38800000
> f8010010 f821ffe1
> [ 9112.364699] a06d0008 480fef95 60000000 7c210b78 <48000000> 60000000
> 60000000 60420000
> [ 9112.364709] Oops: Unrecoverable nested System Reset, sig: 6 [#2]
> [ 9112.364712] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
> [ 9112.364715] Modules linked in: nvme_tcp nvme_fabrics nvmet_tcp
> nvmet nvme nvme_core loop dm_log_writes rfkill sunrpc i40e joydev at24
> crct10dif_vpmsum tpm_i2c_nuvoton regmap_i2c opal_prd i2c_opal ses
> enclosure scsi_transport_sas ofpart ipmi_powernv ipmi_devintf
> ipmi_msghandler powernv_flash mtd rtc_opal fuse zram ip_tables xfs ast
> i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect
> sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm vmx_crypto
> crc32c_vpmsum i2c_core aacraid drm_panel_orientation_quirks [last
> unloaded: nvmet]
> [ 9112.364764] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D
>   5.16.0-rc3 #1
> [ 9112.364768] NIP:  c000000000059420 LR: c000000000059418 CTR: c0000000000593f0
> [ 9112.364770] REGS: c000000fffd03d60 TRAP: 0100   Tainted: G      D
>          (5.16.0-rc3)
> [ 9112.364773] MSR:  9000000000081033 <SF,HV,ME,IR,DR,RI,LE>  CR:
> 24000484  XER: 20040000
> [ 9112.364783] CFAR: c000000000059420 IRQMASK: 3
> [ 9112.364783] GPR00: c000000000059418 c0000000028a7a30
> c0000000028ab700 c0000000028e71b8
> [ 9112.364783] GPR04: 0000000000000000 c000200fff7fc000
> 0000000000000000 fffffffffffffffe
> [ 9112.364783] GPR08: c0000000028eb700 000000000000009f
> c0000000028e75b8 0000000000000000
> [ 9112.364783] GPR12: c0000000000593f0 c000000002b20000
> 0000000000000000 0000000000000000
> [ 9112.364783] GPR16: 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000
> [ 9112.364783] GPR20: 0000000000000000 0000000000000001
> 0000000000000000 c0000000027c21a0
> [ 9112.364783] GPR24: c000000ffc70f4c8 0000000000080000
> 0000000000000000 0000000000000001
> [ 9112.364783] GPR28: c0000000002387a0 c0000000028a7b40
> c0000000000593f0 0000000000000001
> [ 9112.364827] NIP [c000000000059420] nmi_stop_this_cpu+0x30/0x40
> [ 9112.364832] LR [c000000000059418] nmi_stop_this_cpu+0x28/0x40
> [ 9112.364836] Call Trace:
> [ 9112.364837] [c0000000028a7a50] [c00000000005ae4c]
> smp_handle_nmi_ipi+0xac/0x110
> [ 9112.364842] [c0000000028a7aa0] [c0000000000d7380]
> pnv_system_reset_exception+0x20/0x40
> [ 9112.364848] [c0000000028a7ac0] [c00000000002a170]
> system_reset_exception+0x90/0x280
> [ 9112.364852] [c0000000028a7b20] [c000000000015630]
> replay_system_reset+0x40/0x60
> [ 9112.364857] [c0000000028a7cc0] [c0000000000d11bc] arch300_idle_type+0xac/0xe0
> [ 9112.364862] [c0000000028a7d00] [c000000000e0e990] stop_loop+0x40/0x60
> [ 9112.364866] [c0000000028a7d30] [c000000000e0aef0]
> cpuidle_enter_state+0x230/0x540
> [ 9112.364872] [c0000000028a7d90] [c000000000e0b29c] cpuidle_enter+0x4c/0x70
> [ 9112.364877] [c0000000028a7dd0] [c0000000001aeaa8] do_idle+0x2f8/0x3f0
> [ 9112.364882] [c0000000028a7e60] [c0000000001aedc8] cpu_startup_entry+0x38/0x50
> [ 9112.364887] [c0000000028a7e90] [c00000000001288c] rest_init+0xec/0x110
> [ 9112.364891] [c0000000028a7ec0] [c000000002004c48] start_kernel+0xc54/0xc8c
> [ 9112.364896] [c0000000028a7f90] [c00000000000d970] start_here_common+0x1c/0x2c
> [ 9112.364900] Instruction dump:
> [ 9112.364902] 3c4c0285 38422310 7c0802a6 60000000 7c0802a6 38800000
> f8010010 f821ffe1
> [ 9112.364911] a06d0008 480fef95 60000000 7c210b78 <48000000> 60000000
> 60000000 60420000
> [ 9112.364921] ---[ end trace da59439c4dde7676 ]---
>
>
> --
> Best Regards,
>   Yi Zhang



-- 
Best Regards,
  Yi Zhang

