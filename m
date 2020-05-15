Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9425FC433E0
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 15:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C3D20758
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 15:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEOPcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 11:32:52 -0400
Received: from verein.lst.de ([213.95.11.211]:57311 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgEOPcw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 11:32:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C00E068C65; Fri, 15 May 2020 17:32:48 +0200 (CEST)
Date:   Fri, 15 May 2020 17:32:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/6] blk-mq: allocate request on cpu in hctx->cpumask
 for blk_mq_alloc_request_hctx
Message-ID: <20200515153248.GA29610@lst.de>
References: <20200515014153.2403464-1-ming.lei@redhat.com> <20200515014153.2403464-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515014153.2403464-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 15, 2020 at 09:41:48AM +0800, Ming Lei wrote:
> blk_mq_alloc_request_hctx() asks blk-mq to allocate request from
> specified hctx, which is usually bound with fixed cpu mapping, and
> request is supposed to be allocated on CPU in hctx->cpumask.
> 
> So use smp_call_function_any() to allocate request on the cpu in
> hctx->cpumask for blk_mq_alloc_request_hctx().
> 
> Dedclare blk_mq_get_request() beforehand because the following patches
> reuses __blk_mq_alloc_request for blk_mq_get_request().
> 
> Prepare for improving cpu hotplug support.

With your series applied the kernel instantly panics  when creating a
nvme-loop controller:

[   27.189993] nvmet: creating controller 1 for subsystem testnqn for NQN
hostnqn.
[   27.199370] nvme nvme0: creating 4 I/O queues.
[   27.202650] BUG: kernel NULL pointer dereference, address: 0000000000000128
[   27.205004] #PF: supervisor read access in kernel mode
[   27.206382] #PF: error_code(0x0000) - not-present page
[   27.207741] PGD 800000012dfc9067 P4D 800000012dfc9067 PUD 12dfae067 PMD 0 
[   27.209326] Oops: 0000 [#1] PREEMPT SMP PTI
[   27.210214] CPU: 2 PID: 3786 Comm: bash Not tainted 5.7.0-rc2+ #44
[   27.211511] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1 04/01/2014
[   27.213626] RIP: 0010:smp_call_function_any+0x34/0xf0
[   27.214736] Code: 41 54 49 89 f4 55 48 89 fd bf 01 00 00 00 e8 33 23 f8 ff 48 c7 c7 3b 0b 12 d
[   27.218079] RSP: 0018:ffffc900003d3b90 EFLAGS: 00010202
[   27.219340] RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000001
[   27.221199] RDX: 0000000000000000 RSI: ffffffff8198c920 RDI: ffffffff83120b3b
[   27.222517] RBP: 0000000000000128 R08: 0000000000000002 R09: 0000000000020022
[   27.223780] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8198c920
[   27.225002] R13: ffffc900003d3bb8 R14: 0000000000000001 R15: ffff88812b488008
[   27.226195] FS:  00007fca23cae740(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
[   27.227520] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.228378] CR2: 0000000000000128 CR3: 000000012eba6000 CR4: 00000000000006e0
[   27.229444] Call Trace:
[   27.229810]  blk_mq_alloc_request_hctx+0xe7/0x140
[   27.230487]  nvme_alloc_request+0x2d/0x70
[   27.231053]  __nvme_submit_sync_cmd+0x4a/0x1f0
[   27.231720]  ? mark_held_locks+0x49/0x70
[   27.232279]  ? __slab_alloc.isra.0.constprop.0+0x63/0x80
[   27.233038]  ? nvmf_connect_io_queue+0x85/0x180
[   27.233687]  nvmf_connect_io_queue+0x12d/0x180
[   27.234296]  ? cpumask_next_and+0x19/0x20
[   27.234848]  ? nvme_loop_connect_io_queues+0x4c/0x60
[   27.235718]  ? blk_mq_init_queue_data+0x36/0x60
[   27.236598]  nvme_loop_connect_io_queues+0x4c/0x60
[   27.237379]  nvme_loop_create_ctrl+0x2f0/0x450
[   27.238016]  nvmf_dev_write+0x7e3/0xb2f
[   27.238541]  ? find_held_lock+0x2b/0x80
[   27.239080]  ? do_user_addr_fault+0x205/0x480
[   27.239763]  vfs_write+0xb4/0x1a0
[   27.240302]  ksys_write+0x63/0xe0
[   27.240845]  do_syscall_64+0x4b/0x1e0
[   27.241446]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[   27.242253] RIP: 0033:0x7fca233a2134
[   27.242821] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8d 05 5
[   27.245798] RSP: 002b:00007ffe430d43e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   27.247255] RAX: ffffffffffffffda RBX: 000000000000002b RCX: 00007fca233a2134
[   27.248525] RDX: 000000000000002b RSI: 000000000119f408 RDI: 0000000000000001
[   27.249806] RBP: 000000000119f408 R08: 000000000000000a R09: 00000000011d8988
[   27.251238] R10: 000000000000000a R11: 0000000000000246 R12: 00007fca2366f760
[   27.252195] R13: 000000000000002b R14: 00007fca2366a760 R15: 000000000000002b
[   27.253157] Modules linked in:
[   27.253603] CR2: 0000000000000128
[   27.254056] ---[ end trace 75ba575e2625a1c6 ]---
[   27.254684] RIP: 0010:smp_call_function_any+0x34/0xf0
[   27.255398] Code: 41 54 49 89 f4 55 48 89 fd bf 01 00 00 00 e8 33 23 f8 ff 48 c7 c7 3b 0b 12 d
[   27.258140] RSP: 0018:ffffc900003d3b90 EFLAGS: 00010202
[   27.258966] RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000001
[   27.260075] RDX: 0000000000000000 RSI: ffffffff8198c920 RDI: ffffffff83120b3b
[   27.261166] RBP: 0000000000000128 R08: 0000000000000002 R09: 0000000000020022
[   27.262278] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8198c920
[   27.263219] R13: ffffc900003d3bb8 R14: 0000000000000001 R15: ffff88812b488008
[   27.264139] FS:  00007fca23cae740(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
[   27.265175] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.265893] CR2: 0000000000000128 CR3: 000000012eba6000 CR4: 00000000000006e0
[   27.266805] Kernel panic - not syncing: Fatal exception
[   27.267640] Kernel Offset: disabled
[   27.268087] ---[ end Kernel panic - not syncing: Fatal exception ]---

