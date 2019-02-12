Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D49C282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 18:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E446C2190B
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 18:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbfBLSia (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:38:30 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:50165 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfBLSia (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 13:38:30 -0500
Subject: Re: qla2xxx init warning with blk_mq at drivers/pci/msi.c:1273
 pci_irq_get_affinity+0xf4/0x120
To:     Giridhar Malavali <gmalavali@marvell.com>,
        Meelis Roos <mroos@linux.ee>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "qla2xxx-upstream@qlogic.com" <qla2xxx-upstream@qlogic.com>
References: <c58b0ffc-434b-9db4-9ed5-07650368f336@linux.ee>
 <9D8CA1BB-21B3-42AD-B2A7-7986A40C06EB@marvell.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <59ea474f-347e-185b-73c7-7fa7e6cfa7b4@linux.ee>
Date:   Tue, 12 Feb 2019 20:38:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <9D8CA1BB-21B3-42AD-B2A7-7986A40C06EB@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>      I tested todays 5.0.0-rc5-00358-gdf3865f on my sparcs and a couple of servers that have qla2xxx
>      FC adapter gave me this warning:

Now I got a very similar one on an x86-64 server:


[   18.472568] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.00.00.12-k.
[   18.474272] PCI Interrupt Link [LNKD] enabled at IRQ 19
[   18.474272] qla2xxx [0000:04:00.0]-001d: : Found an ISP2432 irq 19 iobase 0x(____ptrval____).
[   18.917293] scsi host3: qla2xxx
[   18.917412] WARNING: CPU: 0 PID: 1650 at drivers/pci/msi.c:1273 pci_irq_get_affinity+0x35/0x80
[   18.917554] Modules linked in: qla2xxx(+) scsi_transport_fc i2c_nforce2 e1000 pata_amd k8temp libata i2c_core hwmon forcedeth(+) powernow_k8 pcspkr autofs4
[   18.917708] CPU: 0 PID: 1650 Comm: kworker/0:3 Not tainted 5.0.0-rc6-00013-gaa0c38cf39de #14
[   18.917848] Hardware name: Sun Microsystems Sun Fire X4200 M2/Sun Fire X4200 M2                        , BIOS 0ABJX104 04/09/2009
[   18.918002] Workqueue: events work_for_cpu_fn
[   18.918082] RIP: 0010:pci_irq_get_affinity+0x35/0x80
[   18.918164] Code: 2e 48 8b 87 b8 02 00 00 48 8d 8f b8 02 00 00 48 39 c1 74 16 85 f6 74 4e 31 d2 eb 04 39 d6 74 46 48 8b 00 ff c2 48 39 c8 75 f2 <0f> 0b 31 c0 c3 83 e2 02 48 c7 c0 c0 46 d5 b8 74 29 48 8b 97 b8 02
[   18.918374] RSP: 0018:ffffa15f4108fcb0 EFLAGS: 00010246
[   18.918460] RAX: ffff95e7995f52b8 RBX: 0000000000000000 RCX: ffff95e7995f52b8
[   18.918547] RDX: 0000000000000002 RSI: 0000000000000002 RDI: ffff95e7995f5000
[   18.918629] RBP: 0000000000000000 R08: ffffffffffffff80 R09: ffff95e799008e60
[   18.918712] R10: 00000000b90b0f01 R11: ffffa15f4108fa90 R12: 0000000000000002
[   18.918795] R13: ffff95e7995f5000 R14: 00000000ffffffff R15: ffff95e7969890a8
[   18.918878] FS:  0000000000000000(0000) GS:ffff95e79b400000(0000) knlGS:0000000000000000
[   18.919013] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.919103] CR2: 00007f213fb62000 CR3: 0000000217dc0000 CR4: 00000000000006f0
[   18.919185] Call Trace:
[   18.919269]  blk_mq_pci_map_queues+0x32/0xc0
[   18.919354]  blk_mq_alloc_tag_set+0x12e/0x340
[   18.919437]  scsi_add_host_with_dma+0xa1/0x310
[   18.919549]  qla2x00_probe_one+0x1272/0x2400 [qla2xxx]
[   18.919632]  ? try_to_wake_up+0x2c8/0x6f0
[   18.919710]  local_pci_probe+0x4b/0xb0
[   18.919787]  work_for_cpu_fn+0x11/0x20
[   18.919866]  process_one_work+0x1d1/0x360
[   18.919943]  worker_thread+0x20e/0x3f0
[   18.920020]  ? wq_calc_node_cpumask+0x110/0x110
[   18.920100]  kthread+0x109/0x120
[   18.920176]  ? kthread_create_on_node+0x60/0x60
[   18.920256]  ret_from_fork+0x35/0x40
[   18.920334] ---[ end trace 56ed281ce2c61e69 ]---
[   18.926988] qla2xxx [0000:04:00.0]-00fb:3: QLogic QLE2460 - SG-(X)PCIE1FC-QF4, Sun StorageTek 4 Gb FC Enterprise PCI-Express Single Channel.
[   18.927148] qla2xxx [0000:04:00.0]-00fc:3: ISP2432: PCIe (2.5GT/s x4) @ 0000:04:00.0 hdma+ host#=3 fw=8.07.00 (9496).
[   18.927757] qla2xxx [0000:83:00.0]-001d: : Found an ISP2432 irq 30 iobase 0x(____ptrval____).
[   19.350303] qla2xxx [0000:83:00.0]-00fb:4: QLogic QLE2460 - SG-(X)PCIE1FC-QF4, Sun StorageTek 4 Gb FC Enterprise PCI-Express Single Channel.
[   19.350474] qla2xxx [0000:83:00.0]-00fc:4: ISP2432: PCIe (2.5GT/s x4) @ 0000:83:00.0 hdma+ host#=4 fw=8.07.00 (9496).
[   40.421151] qla2xxx [0000:04:00.0]-8038:3: Cable is unplugged...
[   40.837159] qla2xxx [0000:83:00.0]-8038:4: Cable is unplugged...

-- 
Meelis Roos
