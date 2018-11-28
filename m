Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB906C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 02:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD74620851
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 02:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD74620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbeK1NUL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 08:20:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbeK1NUL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 08:20:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4895B58E39;
        Wed, 28 Nov 2018 02:20:16 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6951860BE8;
        Wed, 28 Nov 2018 02:20:05 +0000 (UTC)
Date:   Wed, 28 Nov 2018 10:20:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv4 0/3] scsi timeout handling updates
Message-ID: <20181128021959.GG11128@ming.t460p>
References: <20181126165430.4519-1-keith.busch@intel.com>
 <b9813c10-776f-46fc-15d4-bbd675edc402@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9813c10-776f-46fc-15d4-bbd675edc402@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 28 Nov 2018 02:20:16 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 10:33:32AM -0700, Jens Axboe wrote:
> On 11/26/18 9:54 AM, Keith Busch wrote:
> > The iterative update to the previous version taking into account review
> > comments.
> > 
> > Background:
> > 
> > The main objective is to remove the generic block layer's lock prefix
> > currently required to transition a request to its completed state by
> > shifting that expense to lower level drivers that actually need it,
> > and removing the software layering violation that was required to use
> > that mechnaism.
> 
> Thanks Keith, added for 4.21.

Hi Jens & Keith,

Seems this patchset causes the following kernel panic, since not see
this issue with commit 4ab32bf3305e

[ 1478.366776] nvmet: adding nsid 1 to subsystem testnqn
[ 1478.385104] nvmet: creating controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:8786b40e-ed54-4f9e-b1b0-6507377ffa97.
[ 1478.386975] nvme nvme1: creating 4 I/O queues.
[ 1478.388784] nvme nvme1: new ctrl: "testnqn"
[ 1479.396523] nvme io: runtime 40
[ 1575.259358] nvme reset: runtime 40
[ 1575.263920] nvme nvme0: resetting controller
[ 1575.288473] nvme nvme0: 4/0/0 read/write/poll queues
[ 1575.291531] nvme nvme1: resetting controller
[ 1575.298338] print_req_error: I/O error, dev nvme1n1, sector 524287272
[ 1575.299169] print_req_error: I/O error, dev nvme1n1, sector 524287328
[ 1575.299950] BUG: unable to handle kernel NULL pointer dereference at 0000000000000198
[ 1575.299951] PGD 0 P4D 0 
[ 1575.299954] Oops: 0002 [#1] PREEMPT SMP PTI
[ 1575.299972] CPU: 0 PID: 12014 Comm: kworker/u8:0 Not tainted 4.20.0-rc3_5f0ed774ed29_for-next+ #1
[ 1575.299973] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
[ 1575.299978] Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work [nvme_loop]
[ 1575.299985] RIP: 0010:blk_mq_free_request+0x7e/0xe4
[ 1575.299987] Code: 00 00 00 00 00 8b 53 18 b8 01 00 00 00 84 d2 74 0b 31 c0 81 e2 00 08 06 00 0f 95 c0 49 ff 84 c5 80 00 00 00 f6 43 1c 40 74 09 <f0> 41 ff 8c 24 98 01 00 00 83 3d 0b c6 52 01 00 74 15 0f b6 43 18
[ 1575.299988] RSP: 0018:ffff888277a03e48 EFLAGS: 00010002
[ 1575.299989] RAX: 0000000000000001 RBX: ffff88823aa04e00 RCX: ffff888265e71dc0
[ 1575.299990] RDX: 0000000000080700 RSI: ffff888265e71c00 RDI: ffff88821d822808
[ 1575.299991] RBP: ffff888267a3d750 R08: 00000000ffffffff R09: ffff888265e71dd0
[ 1575.299992] R10: ffff888265e71dd0 R11: 0000000000000020 R12: 0000000000000000
[ 1575.299993] R13: ffffe8ffffc0be40 R14: 0000000000000000 R15: 0000000000006000
[ 1575.299994] FS:  0000000000000000(0000) GS:ffff888277a00000(0000) knlGS:0000000000000000
[ 1575.299995] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1575.299996] CR2: 0000000000000198 CR3: 0000000236de8005 CR4: 0000000000760ef0
[ 1575.300000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1575.300001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1575.300001] PKRU: 55555554
[ 1575.300002] Call Trace:
[ 1575.300012]  <IRQ>
[ 1575.300016]  blk_mq_complete_request+0xda/0xfd
[ 1575.300021]  nvmet_req_complete+0x11/0x5e [nvmet]
[ 1575.300025]  nvmet_bio_done+0x2b/0x3d [nvmet]
[ 1575.300027]  blk_update_request+0x177/0x27b
[ 1575.300032]  ? null_complete_rq+0x11/0x11 [null_blk]
[ 1575.300034]  blk_mq_end_request+0x1a/0xc8
[ 1575.300036]  null_cmd_timer_expired+0xe/0x11 [null_blk]
[ 1575.300040]  __hrtimer_run_queues+0x176/0x238
[ 1575.300043]  ? kvm_clock_read+0x14/0x23
[ 1575.300045]  hrtimer_interrupt+0x103/0x21c
[ 1575.300049]  smp_apic_timer_interrupt+0xd3/0x141
[ 1575.300051]  apic_timer_interrupt+0xf/0x20
[ 1575.300053]  </IRQ>
[ 1575.300055] RIP: 0010:console_unlock+0x3a8/0x45f
[ 1575.300057] Code: 59 00 8a 1d bc 0e 5d 01 48 c7 c7 f0 0c 6a 82 4c 89 2d b6 0e 5d 01 e8 fe c0 59 00 84 db 75 15 e8 9f 1c 00 00 48 8b 3c 24 57 9d <0f> 1f 44 00 00 e9 aa fc ff ff c6 05 89 0e 5d 01 00 e8 83 1c 00 00
[ 1575.300057] RSP: 0018:ffffc90003a3fc20 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[ 1575.300059] RAX: 0000000080000002 RBX: 0000000000000000 RCX: 0000000000000000
[ 1575.300060] RDX: 0000000000000001 RSI: 0000000000000046 RDI: 0000000000000246
[ 1575.300060] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
[ 1575.300061] R10: 0000000005f5e100 R11: ffffffff826a00e7 R12: ffffffff821e7460
[ 1575.300062] R13: 0000000000000000 R14: ffffffff826a00e0 R15: 0000000000000000
[ 1575.300067]  vprintk_emit+0x1ff/0x236
[ 1575.300069]  printk+0x52/0x6e
[ 1575.300071]  blk_update_request+0x10a/0x27b
[ 1575.300074]  blk_mq_end_request+0x1a/0xc8
[ 1575.300076]  blk_mq_complete_request+0xda/0xfd
[ 1575.300080]  nvme_cancel_request+0x5b/0x60
[ 1575.300082]  bt_tags_for_each+0xe2/0x10c
[ 1575.300085]  ? nvme_complete_rq+0x162/0x162
[ 1575.300087]  ? nvme_complete_rq+0x162/0x162
[ 1575.300089]  blk_mq_tagset_busy_iter+0x68/0x75
[ 1575.300091]  nvme_loop_shutdown_ctrl+0x38/0x86 [nvme_loop]
[ 1575.300094]  nvme_loop_reset_ctrl_work+0x2a/0xcf [nvme_loop]
[ 1575.300098]  process_one_work+0x1da/0x313
[ 1575.300101]  ? rescuer_thread+0x282/0x282
[ 1575.300103]  process_scheduled_works+0x27/0x2c
[ 1575.300105]  worker_thread+0x1e7/0x295
[ 1575.300107]  kthread+0x115/0x11d
[ 1575.300109]  ? kthread_park+0x76/0x76
[ 1575.300111]  ret_from_fork+0x35/0x40
[ 1575.300113] Modules linked in: nvme_loop nvmet nvme_fabrics null_blk scsi_debug xfs libcrc32c isofs iTCO_wdt iTCO_vendor_support i2c_i801 i2c_core lpc_ich mfd_core ip_tables sr_mod cdrom usb_storage sd_mod ahci libahci libata crc32c_intel virtio_scsi qemu_fw_cfg dm_mirror dm_region_hash dm_log dm_mod [last unloaded: null_blk]
[ 1575.300127] Dumping ftrace buffer:
[ 1575.300129]    (ftrace buffer empty)
[ 1575.300130] CR2: 0000000000000198
[ 1575.300133] ---[ end trace f941476562612d99 ]---

thanks,
Ming
