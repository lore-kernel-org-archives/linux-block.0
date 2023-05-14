Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C73C7EE22
	for <linux-block@archiver.kernel.org>; Sun, 14 May 2023 12:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjENMLV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 May 2023 08:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjENMLU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 May 2023 08:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36BA1FC2
        for <linux-block@vger.kernel.org>; Sun, 14 May 2023 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684066231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkNSWAOghG7RGZ/X90k7lBM0/8SeYMpYgmMnxS708+8=;
        b=RlqjBMxh5Tav3b40QUzsAXI8V8hLEk9ReNZL+bEv431Btzcuz5kAiLOZXhI2WGorAghgBo
        zrYBPlTY4N5h+qCxbCKk4fpm96WzgJS/FYnPX7nKIcyqif4iHw2Om9GBxmzqVaIHiYv/kB
        PhuyEDcwFcys8WrkzDy/Xe6zJ38ST6c=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-zVO-iineMjucuRIQEbcl0A-1; Sun, 14 May 2023 08:10:30 -0400
X-MC-Unique: zVO-iineMjucuRIQEbcl0A-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-64378a8b332so6730993b3a.2
        for <linux-block@vger.kernel.org>; Sun, 14 May 2023 05:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684066229; x=1686658229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkNSWAOghG7RGZ/X90k7lBM0/8SeYMpYgmMnxS708+8=;
        b=TE7CLSzz48mHEZLbGa+VWOHKOuAXpRWb6Q68cBgOROfWJ0izzPP2ZIIFnej9REG/bc
         NkK+bVQaoi2sQc/l2BrOPyeELN0D3jsoqsTpShEoyIzKTPZ94fq7izvWA3SD8luSx4qU
         MK6C3bLrS7NFIf4t1/HbQ/tA4OYK8o/U2YvkK8F2mBVnVj8CbfEfNuaqD/QLTokozFN9
         jlMNgZD3FjSjMSYixVbvXmaC5DBy+SQsxmfdf5T3Bv5Jk3a5OxB0zQAOC82OTcgeI+1f
         I1f4hgOG99vUbpYAG2pB89wyd0y70eMZGrOCOKLjhqHc7sOHsX8XaX5GmQm56A1ZRTht
         m64w==
X-Gm-Message-State: AC+VfDycmcdtEf6ZTk7k4Tjcy++6DkQeDpZFtnf88IBxR6KerNf4pIFe
        6bmh46cDZvFdJxrIZG/0Dkt6rkbLkeI0LuEhfRHLtDB5nkWUcLlR1BCNLP1omNVNCuzlvOFq1bc
        Ur+TY/P/oG25IdIHT94WygID98Ak9tgWY7P1Fb6btIvZkdnSXLP3L
X-Received: by 2002:a05:6a00:248d:b0:63a:8f4c:8be1 with SMTP id c13-20020a056a00248d00b0063a8f4c8be1mr45255984pfv.10.1684066228807;
        Sun, 14 May 2023 05:10:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7YsGHquShTBEezS0voOneRPZfu311Ew2SNHihoqYXmMxFpym8geZ9h3YcJFKRTffFbawui1eR3o0isCZgUI3w=
X-Received: by 2002:a05:6a00:248d:b0:63a:8f4c:8be1 with SMTP id
 c13-20020a056a00248d00b0063a8f4c8be1mr45255960pfv.10.1684066228383; Sun, 14
 May 2023 05:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230512150328.192908-1-ming.lei@redhat.com>
In-Reply-To: <20230512150328.192908-1-ming.lei@redhat.com>
From:   Guangwu Zhang <guazhang@redhat.com>
Date:   Sun, 14 May 2023 20:11:34 +0800
Message-ID: <CAGS2=YqeDg5CEwFsaHfY84rCw_qhQ4=M0-v=rbdYX=6KvMmvDA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai1@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi.
Don't reproduce the issue with your patch, but hit other issue, please
have a look.

[  136.002469] qla2xxx [0000:af:00.6]-800e:2: DEVICE RESET SUCCEEDED
nexus:2:0:0 cmd=3D000000008d9455f0.
[  136.011591] qla2xxx [0000:af:00.6]-8009:2: TARGET RESET ISSUED
nexus=3D2:0 cmd=3D000000008d9455f0.
[  136.206701] qla2xxx [0000:af:00.6]-800e:2: TARGET RESET SUCCEEDED
nexus:2:0 cmd=3D000000008d9455f0.
[  168.768518] qla2xxx [0000:af:00.7]-801c:4: Abort command issued
nexus=3D4:0:0 -- 2003.
[  168.776324] qla2xxx [0000:af:00.7]-8009:4: DEVICE RESET ISSUED
nexus=3D4:0:0 cmd=3D000000005642c8ad.
[  168.836726] qla2xxx [0000:af:00.7]-5032:4: ABT_IOCB: Invalid
completion handle (21) -- timed-out.
[  168.845758] qla2xxx [0000:af:00.7]-800e:4: DEVICE RESET SUCCEEDED
nexus:4:0:0 cmd=3D000000005642c8ad.
[  168.854881] qla2xxx [0000:af:00.7]-8018:4: ADAPTER RESET ISSUED nexus=3D=
4:0:0.
[  168.861994] qla2xxx [0000:af:00.7]-00af:4: Performing ISP error
recovery - ha=3D00000000f7f90a13.
[  170.944477] qla2xxx [0000:af:00.7]-00b4:4: Done chip reset cleanup.
[  170.960311] qla2xxx [0000:af:00.7]-00d2:4: Init Firmware **** FAILED ***=
*.
[  170.967241] qla2xxx [0000:af:00.7]-8016:4: qla82xx_restart_isp ****
FAILED ****.
[  170.974693] qla2xxx [0000:af:00.7]-b02f:4: HW State: NEED RESET
[  170.980671] qla2xxx [0000:af:00.7]-009b:4: Device state is 0x4 =3D Need =
Reset.
[  170.987784] qla2xxx [0000:af:00.7]-009d:4: Device state is 0x4 =3D Need =
Reset.
[  171.968416] qla2xxx [0000:af:00.6]-6001:2: Adapter reset needed.
[  171.974549] qla2xxx [0000:af:00.6]-b031:2: Device state is 0x4 =3D Need =
Reset.
[  171.981680] qla2xxx [0000:af:00.6]-009b:2: Device state is 0x4 =3D Need =
Reset.
[  171.988776] qla2xxx [0000:af:00.6]-009d:2: Device state is 0x4 =3D Need =
Reset.
[  171.995872] qla2xxx [0000:af:00.6]-00af:2: Performing ISP error
recovery - ha=3D0000000071956e30.
[  174.080409] qla2xxx [0000:af:00.6]-00b4:2: Done chip reset cleanup.
[  174.086822] qla2xxx [0000:af:00.6]-801c:2: Abort command issued
nexus=3D2:0:0 -- 2002.
[  174.094635] qla2xxx [0000:af:00.6]-8018:2: ADAPTER RESET ISSUED nexus=3D=
2:0:0.
[  174.101728] qla2xxx [0000:af:00.6]-8017:2: ADAPTER RESET FAILED nexus=3D=
2:0:0.
[  174.108910] scsi 2:0:0:0: rejecting I/O to offline device
[  175.104377] qla2xxx [0000:af:00.7]-00b6:4: Device state is 0x4 =3D Need =
Reset.
[  175.111480] qla2xxx [0000:af:00.7]-00b7:4: HW State: COLD/RE-INIT.
[  177.184324] ------------[ cut here ]------------
[  177.188972] WARNING: CPU: 7 PID: 813 at
drivers/scsi/qla2xxx/qla_nx.c:507
qla82xx_need_reset_handler+0x1a4/0x470 [qla2xxx]
[  177.200131] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
dns_resolver nfs lockd grace fscache netfs rfkill sunrpc vfat fat
dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common isst_if_common nfit libnvdimm mgag200
x86_pkg_temp_thermal i2c_algo_bit intel_powerclamp ipmi_ssif coretemp
drm_shmem_helper drm_kms_helper rapl syscopyarea mei_me sysfillrect
ses sysimgblt intel_cstate enclosure acpi_ipmi ioatdma acpi_tad
ipmi_si lpc_ich intel_pch_thermal intel_uncore acpi_power_meter mei
ipmi_devintf pcspkr dca hpilo ipmi_msghandler drm fuse xfs sd_mod sg
qla2xxx qla4xxx bnx2x nvme_fc nvme nvme_fabrics crct10dif_pclmul
crc32_pclmul nvme_core libiscsi smartpqi ghash_clmulni_intel
scsi_transport_iscsi nvme_common uas scsi_transport_fc t10_pi mdio
iscsi_boot_sysfs libcrc32c usb_storage scsi_transport_sas crc32c_intel
tg3 hpwdt wmi dm_mirror dm_region_hash dm_log dm_mod
[  177.281274] CPU: 7 PID: 813 Comm: qla2xxx_2_dpc Kdump: loaded Not
tainted 6.4.0-rc1+ #1
[  177.289328] Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380
Gen10, BIOS U30 03/09/2020
[  177.297903] RIP: 0010:qla82xx_need_reset_handler+0x1a4/0x470 [qla2xxx]
[  177.304513] Code: a6 cd e8 8f 49 4f ce eb 0a bf 64 00 00 00 e8 63
0d a6 cd be 28 c0 11 06 48 89 ef e8 16 a9 ff ff 83 f8 01 74 07 83 eb
01 75 df <0f> 0b be 44 21 20 08 48 89 ef e8 fd a8 ff ff be 38 21 20 08
48 89
[  177.323398] RSP: 0018:ffffaf0b0508be48 EFLAGS: 00010246
[  177.328656] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000001=
30000
[  177.335834] RDX: ffffaf0b0508be00 RSI: ffffaf0b0593c028 RDI: ffff9b24200=
22000
[  177.343013] RBP: ffff9b2420022000 R08: 0000000000120000 R09: ffff9b272ff=
f2878
[  177.350193] R10: 0000000000000162 R11: 0000000003c23c49 R12: 00000000fff=
e3bdb
[  177.357373] R13: 0000000000000000 R14: ffff9b274fca6840 R15: 00000000010=
00000
[  177.364554] FS:  0000000000000000(0000) GS:ffff9b272ffc0000(0000)
knlGS:0000000000000000
[  177.372695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  177.378476] CR2: 000055b7803d43d8 CR3: 000000079c220001 CR4: 00000000007=
706e0
[  177.385656] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  177.392836] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  177.400015] PKRU: 55555554
[  177.402738] Call Trace:
[  177.405201]  <TASK>
[  177.407316]  qla82xx_device_state_handler+0x285/0x4a0 [qla2xxx]
[  177.413303]  ? __pfx_qla2x00_do_dpc+0x10/0x10 [qla2xxx]
[  177.418588]  qla82xx_abort_isp+0x190/0x290 [qla2xxx]
[  177.423613]  qla2x00_do_dpc+0x743/0xa60 [qla2xxx]
[  177.428374]  ? __pfx_qla2x00_do_dpc+0x10/0x10 [qla2xxx]
[  177.433655]  kthread+0xdf/0x110
[  177.436821]  ? __pfx_kthread+0x10/0x10
[  177.440595]  ret_from_fork+0x29/0x50
[  177.444201]  </TASK>
[  177.446402] ---[ end trace 0000000000000000 ]---
[  177.451052] qla2xxx [0000:af:00.6]-00b6:2: Device state is 0x1 =3D
Cold/Re-init.
[  177.458319] qla2xxx [0000:af:00.6]-009d:2: Device state is 0x1 =3D
Cold/Re-init.
[  177.465588] qla2xxx [0000:af:00.6]-009e:2: HW State: INITIALIZING.
[    0.020959] APIC: Disabling requested cpu. Processor 0/0x0 ignored.

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=BA=94 23:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Passthrough(pt) request shouldn't be queued to scheduler, especially some
> schedulers(such as bfq) supposes that req->bio is always available and
> blk-cgroup can be retrieved via bio.
>
> Sometimes pt request could be part of error handling, so it is better to =
always
> queue it into hctx->dispatch directly.
>
> Fix this issue by queuing pt request from plug list to hctx->dispatch
> directly.
>
> Reported-by: Guangwu Zhang <guazhang@redhat.com>
> Investigated-by: Yu Kuai <yukuai1@huaweicloud.com>
> Fixes: 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> Guang Wu, please test this patch and provide us the result.
>
>  block/blk-mq.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f6dad0886a2f..11efaefa26c3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2711,6 +2711,7 @@ static void blk_mq_dispatch_plug_list(struct blk_pl=
ug *plug, bool from_sched)
>         struct request *requeue_list =3D NULL;
>         struct request **requeue_lastp =3D &requeue_list;
>         unsigned int depth =3D 0;
> +       bool pt =3D false;
>         LIST_HEAD(list);
>
>         do {
> @@ -2719,7 +2720,9 @@ static void blk_mq_dispatch_plug_list(struct blk_pl=
ug *plug, bool from_sched)
>                 if (!this_hctx) {
>                         this_hctx =3D rq->mq_hctx;
>                         this_ctx =3D rq->mq_ctx;
> -               } else if (this_hctx !=3D rq->mq_hctx || this_ctx !=3D rq=
->mq_ctx) {
> +                       pt =3D blk_rq_is_passthrough(rq);
> +               } else if (this_hctx !=3D rq->mq_hctx || this_ctx !=3D rq=
->mq_ctx ||
> +                               pt !=3D blk_rq_is_passthrough(rq)) {
>                         rq_list_add_tail(&requeue_lastp, rq);
>                         continue;
>                 }
> @@ -2731,10 +2734,15 @@ static void blk_mq_dispatch_plug_list(struct blk_=
plug *plug, bool from_sched)
>         trace_block_unplug(this_hctx->queue, depth, !from_sched);
>
>         percpu_ref_get(&this_hctx->queue->q_usage_counter);
> -       if (this_hctx->queue->elevator) {
> +       if (this_hctx->queue->elevator && !pt) {
>                 this_hctx->queue->elevator->type->ops.insert_requests(thi=
s_hctx,
>                                 &list, 0);
>                 blk_mq_run_hw_queue(this_hctx, from_sched);
> +       } else if (pt) {
> +               spin_lock(&this_hctx->lock);
> +               list_splice_tail_init(&list, &this_hctx->dispatch);
> +               spin_unlock(&this_hctx->lock);
> +               blk_mq_run_hw_queue(this_hctx, from_sched);
>         } else {
>                 blk_mq_insert_requests(this_hctx, this_ctx, &list, from_s=
ched);
>         }
> --
> 2.38.1
>


--=20

Guangwu Zhang, RHCE, ISTQB, ITIL

Quality Engineer, Kernel Storage QE

Red Hat

