Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCA5C04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC2A2083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC2A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeLGDAm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:00:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGDAm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 22:00:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EFB1290C7B;
        Fri,  7 Dec 2018 03:00:41 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8F535C1A1;
        Fri,  7 Dec 2018 03:00:35 +0000 (UTC)
Date:   Fri, 7 Dec 2018 11:00:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH] blk-mq: re-build queue map in case of kdump kernel
Message-ID: <20181207030028.GA22188@ming.t460p>
References: <20181207025523.22703-1-ming.lei@redhat.com>
 <d1062c50-5488-2f61-185b-402efd0c54e5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1062c50-5488-2f61-185b-402efd0c54e5@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 07 Dec 2018 03:00:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06, 2018 at 07:57:34PM -0700, Jens Axboe wrote:
> On 12/6/18 7:55 PM, Ming Lei wrote:
> > Now almost all .map_queues() implementation based on managed irq
> > affinity doesn't update queue mapping and it just retrieves the
> > old built mapping, so if nr_hw_queues is changed, the mapping talbe
> > includes stale mapping. And only blk_mq_map_queues() may rebuild
> > the mapping talbe.
> > 
> > One case is that we limit .nr_hw_queues as 1 in case of kdump kernel.
> > However, drivers often builds queue mapping before allocating tagset
> > via pci_alloc_irq_vectors_affinity(), but set->nr_hw_queues can be set
> > as 1 in case of kdump kernel, so wrong queue mapping is used, and
> > kernel panic[1] is observed during booting.
> > 
> > This patch fixes the kernel panic triggerd on nvme by rebulding the
> > mapping table via blk_mq_map_queues().
> > 
> > [1] kernel panic log
> > [    4.438371] nvme nvme0: 16/0/0 default/read/poll queues
> > [    4.443277] BUG: unable to handle kernel NULL pointer dereference at 0000000000000098
> > [    4.444681] PGD 0 P4D 0
> > [    4.445367] Oops: 0000 [#1] SMP NOPTI
> > [    4.446342] CPU: 3 PID: 201 Comm: kworker/u33:10 Not tainted 4.20.0-rc5-00664-g5eb02f7ee1eb-dirty #459
> > [    4.447630] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
> > [    4.448689] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> > [    4.449368] RIP: 0010:blk_mq_map_swqueue+0xfb/0x222
> > [    4.450596] Code: 04 f5 20 28 ef 81 48 89 c6 39 55 30 76 93 89 d0 48 c1 e0 04 48 03 83 f8 05 00 00 48 8b 00 42 8b 3c 28 48 8b 43 58 48 8b 04 f8 <48> 8b b8 98 00 00 00 4c 0f a3 37 72 42 f0 4c 0f ab 37 66 8b b8 f6
> > [    4.453132] RSP: 0018:ffffc900023b3cd8 EFLAGS: 00010286
> > [    4.454061] RAX: 0000000000000000 RBX: ffff888174448000 RCX: 0000000000000001
> > [    4.456480] RDX: 0000000000000001 RSI: ffffe8feffc506c0 RDI: 0000000000000001
> > [    4.458750] RBP: ffff88810722d008 R08: ffff88817647a880 R09: 0000000000000002
> > [    4.464580] R10: ffffc900023b3c10 R11: 0000000000000004 R12: ffff888174448538
> > [    4.467803] R13: 0000000000000004 R14: 0000000000000001 R15: 0000000000000001
> > [    4.469220] FS:  0000000000000000(0000) GS:ffff88817bac0000(0000) knlGS:0000000000000000
> > [    4.471554] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    4.472464] CR2: 0000000000000098 CR3: 0000000174e4e001 CR4: 0000000000760ee0
> > [    4.474264] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [    4.476007] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [    4.477061] PKRU: 55555554
> > [    4.477464] Call Trace:
> > [    4.478731]  blk_mq_init_allocated_queue+0x36a/0x3ad
> > [    4.479595]  blk_mq_init_queue+0x32/0x4e
> > [    4.480178]  nvme_validate_ns+0x98/0x623 [nvme_core]
> > [    4.480963]  ? nvme_submit_sync_cmd+0x1b/0x20 [nvme_core]
> > [    4.481685]  ? nvme_identify_ctrl.isra.8+0x70/0xa0 [nvme_core]
> > [    4.482601]  nvme_scan_work+0x23a/0x29b [nvme_core]
> > [    4.483269]  ? _raw_spin_unlock_irqrestore+0x25/0x38
> > [    4.483930]  ? try_to_wake_up+0x38d/0x3b3
> > [    4.484478]  ? process_one_work+0x179/0x2fc
> > [    4.485118]  process_one_work+0x1d3/0x2fc
> > [    4.485655]  ? rescuer_thread+0x2ae/0x2ae
> > [    4.486196]  worker_thread+0x1e9/0x2be
> > [    4.486841]  kthread+0x115/0x11d
> > [    4.487294]  ? kthread_park+0x76/0x76
> > [    4.487784]  ret_from_fork+0x3a/0x50
> > [    4.488322] Modules linked in: nvme nvme_core qemu_fw_cfg virtio_scsi ip_tables
> > [    4.489428] Dumping ftrace buffer:
> > [    4.489939]    (ftrace buffer empty)
> > [    4.490492] CR2: 0000000000000098
> > [    4.491052] ---[ end trace 03cd268ad5a86ff7 ]---
> > 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: linux-nvme@lists.infradead.org
> > Cc: David Milburn <dmilburn@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 900550594651..a3e463a726a6 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -38,6 +38,11 @@
> >  #include "blk-mq-sched.h"
> >  #include "blk-rq-qos.h"
> >  
> > +static inline bool blk_mq_kdump_kernel(void)
> > +{
> > +	return !!is_kdump_kernel();
> > +}
> 
> Let's drop the redundant !! here, and the wrapper? I would imagine the
> wrapper is handy for testing outside of kdump, but I don't think we
> should include it in the final.

OK.


Thanks,
Ming
