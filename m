Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD199C0015E
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 20:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjHKUVz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Aug 2023 16:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjHKUVz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 16:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C1010DF
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 13:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691785264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9QPhBNpncPsDukMBt853fyz8Lx5rcrrPA8cAZRDd6MQ=;
        b=RpamCzwUe9J6Vgjh8JEhzKxck9GbCUsV2oetAEqBZRiuiJNzSAo/uZSVocmZqI8edx2f0q
        AAHaFUNookkA+mbdh45Cy2U2kKVBu9yeSL7psoX09QI28tERZMmY+4NdK7NwcSqt7GA1x2
        Hr/lPVAIrs60OMHGBrFP0n4gkbQi8N8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-683-_R7FJZTNP7KIibTCgDmqAA-1; Fri, 11 Aug 2023 16:21:03 -0400
X-MC-Unique: _R7FJZTNP7KIibTCgDmqAA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0731856F67;
        Fri, 11 Aug 2023 20:21:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4270A492B0F;
        Fri, 11 Aug 2023 20:21:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
cc:     dhowells@redhat.com, linux-block@vger.kernel.org
Subject: Timeouts and crash whilst running fio against nullb0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3893580.1691785261.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 11 Aug 2023 21:21:01 +0100
Message-ID: <3893581.1691785261@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

I'm trying to benchmark my recently posted patch.  However, I'm triggering=
 the
attached timeouts and crash against v6.5-rc1 and also -rc5 using:

	./fio/t/io_uring -r20 /dev/nullb0

My test box is a 4-core i3.

	static enum blk_eh_timer_return null_timeout_rq(struct request *rq)
	{
	...
			spin_lock(&nq->poll_lock);
			list_del_init(&rq->queuelist); <--------
			spin_unlock(&nq->poll_lock);
	...
	}

David
---
null_blk: rq 00000000014ce5a0 timed out
timeout error, dev nullb0, sector 442324752 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 000000006fee212f timed out
timeout error, dev nullb0, sector 500845728 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 0000000033b83d1a timed out
timeout error, dev nullb0, sector 462412568 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 0000000037ec6849 timed out
timeout error, dev nullb0, sector 128644920 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 00000000dbfc931b timed out
timeout error, dev nullb0, sector 135219112 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 000000008168b370 timed out
timeout error, dev nullb0, sector 327392896 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 00000000fcc0dcc9 timed out
timeout error, dev nullb0, sector 226050248 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 00000000842cf49f timed out
timeout error, dev nullb0, sector 202735272 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 00000000bec575ea timed out
timeout error, dev nullb0, sector 159381752 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 00000000ce4352d7 timed out
timeout error, dev nullb0, sector 511734656 op 0x0:(READ) flags 0xe00000 p=
hys_seg 1 prio class 2
null_blk: rq 00000000718abe8f timed out
null_blk: rq 000000005f30f6d1 timed out
null_blk: rq 0000000000a51376 timed out
null_blk: rq 00000000a133f2dd timed out
null_blk: rq 000000008e27f277 timed out
BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0 =

Oops: 0002 [#1] PREEMPT SMP PTI
CPU: 3 PID: 1140 Comm: kworker/3:1H Not tainted 6.5.0-rc1-build3 #1637
Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
Workqueue: kblockd blk_mq_timeout_work
RIP: 0010:null_timeout_rq+0x4e/0x91
Code: fc 00 00 00 02 75 37 49 8b 84 24 c8 00 00 00 48 8d 68 58 48 89 ef e8=
 cd 99 45 00 48 8b 4b 48 48 8d 43 48 48 89 ef 48 8b 53 50 <48> 89 51 08 48=
 89 0a 48 89 43 48 48 89 43 50 e8 b5 9a 45 00 80 bb
RSP: 0018:ffff8881087a3d40 EFLAGS: 00010246
RAX: ffff888108fd9548 RBX: ffff888108fd9500 RCX: 0000000000000000
RDX: ffff888108fd9548 RSI: ffffffff8258cb70 RDI: ffff8881092e70d0
RBP: ffff8881092e70d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000028 R11: ffffffff83225277 R12: ffff888102a5cc00
R13: ffff888102a5cc00 R14: ffff8881092729e8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88840fb80000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000010bdda002 CR4: 00000000001706e0
Call Trace:
 <TASK>
 ? __die_body+0x1a/0x5c
 ? page_fault_oops+0x6f/0x9c
 ? kernelmode_fixup_or_oops+0xc6/0xd6
 ? __bad_area_nosemaphore+0x44/0x1eb
 ? exc_page_fault+0xe2/0xf4
 ? asm_exc_page_fault+0x22/0x30
 ? null_timeout_rq+0x4e/0x91
 blk_mq_handle_expired+0x31/0x4b
 bt_iter+0x68/0x84
 ? bt_tags_iter+0x81/0x81
 __sbitmap_for_each_set.constprop.0+0xb0/0xf2
 ? __blk_mq_complete_request_remote+0xf/0xf
 bt_for_each+0x46/0x64
 ? __blk_mq_complete_request_remote+0xf/0xf
 ? percpu_ref_get_many+0xc/0x2a
 blk_mq_queue_tag_busy_iter+0x14d/0x18e
 blk_mq_timeout_work+0x95/0x127
 process_one_work+0x185/0x263
 worker_thread+0x1b5/0x227
 ? rescuer_thread+0x287/0x287
 kthread+0xfa/0x102
 ? kthread_complete_and_exit+0x1b/0x1b
 ret_from_fork+0x22/0x30
 </TASK>
Modules linked in:
CR2: 0000000000000008
---[ end trace 0000000000000000 ]---
RIP: 0010:null_timeout_rq+0x4e/0x91
Code: fc 00 00 00 02 75 37 49 8b 84 24 c8 00 00 00 48 8d 68 58 48 89 ef e8=
 cd 99 45 00 48 8b 4b 48 48 8d 43 48 48 89 ef 48 8b 53 50 <48> 89 51 08 48=
 89 0a 48 89 43 48 48 89 43 50 e8 b5 9a 45 00 80 bb
RSP: 0018:ffff8881087a3d40 EFLAGS: 00010246
RAX: ffff888108fd9548 RBX: ffff888108fd9500 RCX: 0000000000000000
RDX: ffff888108fd9548 RSI: ffffffff8258cb70 RDI: ffff8881092e70d0
RBP: ffff8881092e70d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000028 R11: ffffffff83225277 R12: ffff888102a5cc00
R13: ffff888102a5cc00 R14: ffff8881092729e8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88840fb80000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000010bdda002 CR4: 00000000001706e0
note: kworker/3:1H[1140] exited with irqs disabled
note: kworker/3:1H[1140] exited with preempt_count 1

