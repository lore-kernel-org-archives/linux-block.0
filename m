Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66741C282C4
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 02:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3477620835
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 02:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uz157ZNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbfBMC5y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:57:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32858 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732568AbfBMCg6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id h22so770910wmb.0;
        Tue, 12 Feb 2019 18:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4J/JVQ7t1M3Tmj1Fx+slCbFMC4ywy0iXC6y5v96C9Gg=;
        b=uz157ZNyhHjYBvLQ1ioG6EU4GGlxMNAqT+HFQdujlRH+KMWaFFEqkGJPW8FfK/j3Fx
         lmyFQpUCC7ZUSulPUHZPlwhreQaYo3OC+gg7x079DnsKsY34qi9JKfdtd7enn/YEw112
         1l/iiMMWclkJcTzmtLtiHSTkiHPYJYiXNrd5OJujI/rDR63e1ugpMzdbWjnRDuh7L3ut
         b8vEb43IKC5qWE3XPXHfxB6VInwl0NKum/LTM4koy9V8EZbo1Xp7VBDA5mWhyyQQzD/E
         4qWbzKqcAttszbpFJ4ozXiMa6PGKVwZCLfKQI2+Dr0B+F5psBB08pmFtERUzoYJQfVd/
         07TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4J/JVQ7t1M3Tmj1Fx+slCbFMC4ywy0iXC6y5v96C9Gg=;
        b=YpGcHJ4R4ibYmv302UJPrOJUaIVofbzS0X/IGVzoBMbBdjogS/SlF6CvFeaQnl4AF0
         kw1gTxigU5V2hzzV+a0DDm7xl9OMokY3tLy0UF7AUXNnrZ3o20iId9ofMwQiEsPgVdEv
         P/NBsAZ1woBIGnVJBX/b0PuSccTjDphiKowSgk0Z5iHG0MAa+IhthaKjwOU+NeajpRsE
         HkNIlzM/m0AGMD51awEAnFTIWYsPIEoa9DQo7ZCTskjLWLkvSRFusyjtey7YzxBuTU5F
         BYtvHv0dnvjr+sVn5D2sstmMWt+nrpCNhgECuuCF3ehPKMwCZQoA2UjJo4l8tStor5dA
         b1/w==
X-Gm-Message-State: AHQUAuZ0YpFyvWW2mz3m2v4x4WIau5Pggz0QEsU9/DMFey6Bl9yfwmQJ
        YlRHGW0f2CzNNcB24XAoNhJbgfw8nNcx1j6vRbg=
X-Google-Smtp-Source: AHgI3IZZw/qC7iTg+Q2qwGibGwtbEnM+7In2fPZGTBwjTpB4nNevDyq5E/biSVA/o9zYgCBoVgM/IKDc7ZkDWKf/kVI=
X-Received: by 2002:a7b:c7c1:: with SMTP id z1mr1222280wmk.77.1550025415744;
 Tue, 12 Feb 2019 18:36:55 -0800 (PST)
MIME-Version: 1.0
References: <c58b0ffc-434b-9db4-9ed5-07650368f336@linux.ee>
 <9D8CA1BB-21B3-42AD-B2A7-7986A40C06EB@marvell.com> <59ea474f-347e-185b-73c7-7fa7e6cfa7b4@linux.ee>
In-Reply-To: <59ea474f-347e-185b-73c7-7fa7e6cfa7b4@linux.ee>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 13 Feb 2019 10:36:44 +0800
Message-ID: <CACVXFVM04AW1vVcX4KCsi7eS1EWZcWkhUGYY5db=LJdmPGE4yw@mail.gmail.com>
Subject: Re: qla2xxx init warning with blk_mq at drivers/pci/msi.c:1273 pci_irq_get_affinity+0xf4/0x120
To:     Meelis Roos <mroos@linux.ee>
Cc:     Giridhar Malavali <gmalavali@marvell.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "qla2xxx-upstream@qlogic.com" <qla2xxx-upstream@qlogic.com>,
        Himanshu Madhani <hmadhani@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 5:36 AM Meelis Roos <mroos@linux.ee> wrote:
>
> >      I tested todays 5.0.0-rc5-00358-gdf3865f on my sparcs and a couple of servers that have qla2xxx
> >      FC adapter gave me this warning:
>
> Now I got a very similar one on an x86-64 server:
>
>
> [   18.472568] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.00.00.12-k.
> [   18.474272] PCI Interrupt Link [LNKD] enabled at IRQ 19
> [   18.474272] qla2xxx [0000:04:00.0]-001d: : Found an ISP2432 irq 19 iobase 0x(____ptrval____).
> [   18.917293] scsi host3: qla2xxx
> [   18.917412] WARNING: CPU: 0 PID: 1650 at drivers/pci/msi.c:1273 pci_irq_get_affinity+0x35/0x80
> [   18.917554] Modules linked in: qla2xxx(+) scsi_transport_fc i2c_nforce2 e1000 pata_amd k8temp libata i2c_core hwmon forcedeth(+) powernow_k8 pcspkr autofs4
> [   18.917708] CPU: 0 PID: 1650 Comm: kworker/0:3 Not tainted 5.0.0-rc6-00013-gaa0c38cf39de #14
> [   18.917848] Hardware name: Sun Microsystems Sun Fire X4200 M2/Sun Fire X4200 M2                        , BIOS 0ABJX104 04/09/2009
> [   18.918002] Workqueue: events work_for_cpu_fn
> [   18.918082] RIP: 0010:pci_irq_get_affinity+0x35/0x80
> [   18.918164] Code: 2e 48 8b 87 b8 02 00 00 48 8d 8f b8 02 00 00 48 39 c1 74 16 85 f6 74 4e 31 d2 eb 04 39 d6 74 46 48 8b 00 ff c2 48 39 c8 75 f2 <0f> 0b 31 c0 c3 83 e2 02 48 c7 c0 c0 46 d5 b8 74 29 48 8b 97 b8 02
> [   18.918374] RSP: 0018:ffffa15f4108fcb0 EFLAGS: 00010246
> [   18.918460] RAX: ffff95e7995f52b8 RBX: 0000000000000000 RCX: ffff95e7995f52b8
> [   18.918547] RDX: 0000000000000002 RSI: 0000000000000002 RDI: ffff95e7995f5000
> [   18.918629] RBP: 0000000000000000 R08: ffffffffffffff80 R09: ffff95e799008e60
> [   18.918712] R10: 00000000b90b0f01 R11: ffffa15f4108fa90 R12: 0000000000000002
> [   18.918795] R13: ffff95e7995f5000 R14: 00000000ffffffff R15: ffff95e7969890a8
> [   18.918878] FS:  0000000000000000(0000) GS:ffff95e79b400000(0000) knlGS:0000000000000000
> [   18.919013] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   18.919103] CR2: 00007f213fb62000 CR3: 0000000217dc0000 CR4: 00000000000006f0
> [   18.919185] Call Trace:
> [   18.919269]  blk_mq_pci_map_queues+0x32/0xc0
> [   18.919354]  blk_mq_alloc_tag_set+0x12e/0x340
> [   18.919437]  scsi_add_host_with_dma+0xa1/0x310
> [   18.919549]  qla2x00_probe_one+0x1272/0x2400 [qla2xxx]
> [   18.919632]  ? try_to_wake_up+0x2c8/0x6f0
> [   18.919710]  local_pci_probe+0x4b/0xb0
> [   18.919787]  work_for_cpu_fn+0x11/0x20
> [   18.919866]  process_one_work+0x1d1/0x360
> [   18.919943]  worker_thread+0x20e/0x3f0
> [   18.920020]  ? wq_calc_node_cpumask+0x110/0x110
> [   18.920100]  kthread+0x109/0x120
> [   18.920176]  ? kthread_create_on_node+0x60/0x60
> [   18.920256]  ret_from_fork+0x35/0x40
> [   18.920334] ---[ end trace 56ed281ce2c61e69 ]---
> [   18.926988] qla2xxx [0000:04:00.0]-00fb:3: QLogic QLE2460 - SG-(X)PCIE1FC-QF4, Sun StorageTek 4 Gb FC Enterprise PCI-Express Single Channel.
> [   18.927148] qla2xxx [0000:04:00.0]-00fc:3: ISP2432: PCIe (2.5GT/s x4) @ 0000:04:00.0 hdma+ host#=3 fw=8.07.00 (9496).
> [   18.927757] qla2xxx [0000:83:00.0]-001d: : Found an ISP2432 irq 30 iobase 0x(____ptrval____).
> [   19.350303] qla2xxx [0000:83:00.0]-00fb:4: QLogic QLE2460 - SG-(X)PCIE1FC-QF4, Sun StorageTek 4 Gb FC Enterprise PCI-Express Single Channel.
> [   19.350474] qla2xxx [0000:83:00.0]-00fc:4: ISP2432: PCIe (2.5GT/s x4) @ 0000:83:00.0 hdma+ host#=4 fw=8.07.00 (9496).
> [   40.421151] qla2xxx [0000:04:00.0]-8038:3: Cable is unplugged...
> [   40.837159] qla2xxx [0000:83:00.0]-8038:4: Cable is unplugged...

We saw such issue too in which .msix_count is too small, and equal to
.pre_vectors, and Himanshu is working on it.

Thanks,
Ming Lei
