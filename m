Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF46C433ED
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 01:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C5B6105A
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 01:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhDAB1s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232866AbhDAB1i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 21:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617240457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=55pRu/VgXOrIM183gAcqeYWoZWsfD4Tt0ZvvM2EcqXk=;
        b=i27djCEWO3Ejb0jEk01F52/raWbC5h3rPgxtTbQ5xuzL2sVs38m4pwIqxDyb73CSXQDcVY
        q35D9I9zGwxhE2AWHBOHimzyXTbjXXZodIppwHmuiDJKeGjcziLw4Fwxbjp4SHiMR5Df3Q
        RhEfiDWVL+PZumGxBKBhLsKiz/S6bsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-b_LSwtOyNNSqsuX_AcTNKQ-1; Wed, 31 Mar 2021 21:27:35 -0400
X-MC-Unique: b_LSwtOyNNSqsuX_AcTNKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 110481005D4F;
        Thu,  1 Apr 2021 01:27:35 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0835819C44;
        Thu,  1 Apr 2021 01:27:34 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id E44DA4BB7B;
        Thu,  1 Apr 2021 01:27:34 +0000 (UTC)
Date:   Wed, 31 Mar 2021 21:27:34 -0400 (EDT)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-block <linux-block@vger.kernel.org>
Cc:     paolo.valente@linaro.org
Message-ID: <1366443410.1203736.1617240454513.JavaMail.zimbra@redhat.com>
In-Reply-To: <841664844.1202812.1617239260115.JavaMail.zimbra@redhat.com>
Subject: [bisected] bfq regression on latest linux-block/for-next
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.19]
Thread-Topic: bfq regression on latest linux-block/for-next
Thread-Index: inBfmr8LEfgvZQ/4efLqriWGzme7Kg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi
We reproduced this bfq regression[3] on ppc64le with blktests[2] on the latest linux-block/for-next branch, seems it was introduced with [1] from my bisecting, pls help check it. Let me know if you need any testing for it, thanks.

[1]
commit 430a67f9d6169a7b3e328bceb2ef9542e4153c7c (HEAD, refs/bisect/bad)
Author: Paolo Valente <paolo.valente@linaro.org>
Date:   Thu Mar 4 18:46:27 2021 +0100

    block, bfq: merge bursts of newly-created queues

[2] blktests: nvme_trtype=tcp ./check nvme/011

[3]
[  109.342525] run blktests nvme/011 at 2021-03-31 20:58:58
[  109.497429] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  109.512868] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  109.584932] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:9b73e8531afa4320963cc96571e0acb1.
[  109.585809] nvme nvme0: creating 128 I/O queues.
[  109.596570] nvme nvme0: mapped 128/0/0 default/read/poll queues.
[  109.654170] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420
[  155.366535] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
[  155.366568] nvmet: ctrl 1 fatal error occurred!
[  155.366608] nvme nvme0: starting error recovery
[  155.374861] block nvme0n1: no usable path - requeuing I/O
[  155.374891] block nvme0n1: no usable path - requeuing I/O
[  155.374911] block nvme0n1: no usable path - requeuing I/O
[  155.374923] block nvme0n1: no usable path - requeuing I/O
[  155.374934] block nvme0n1: no usable path - requeuing I/O
[  155.374954] block nvme0n1: no usable path - requeuing I/O
[  155.374973] block nvme0n1: no usable path - requeuing I/O
[  155.374984] block nvme0n1: no usable path - requeuing I/O
[  155.375004] block nvme0n1: no usable path - requeuing I/O
[  155.375024] block nvme0n1: no usable path - requeuing I/O
[  155.375674] nvme nvme0: Reconnecting in 10 seconds...
[  180.967462] nvmet: ctrl 2 keep-alive timer (15 seconds) expired!
[  180.967486] nvmet: ctrl 2 fatal error occurred!
[  193.427906] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  193.427934] rcu: 	40-...0: (1 GPs behind) idle=f3e/1/0x4000000000000000 softirq=535/535 fqs=2839 
[  193.427966] rcu: 	42-...0: (1 GPs behind) idle=792/1/0x4000000000000000 softirq=160/160 fqs=2839 
[  193.427995] 	(detected by 5, t=6002 jiffies, g=7961, q=7219)
[  193.428030] Sending NMI from CPU 5 to CPUs 40:
[  199.235530] CPU 40 didn't respond to backtrace IPI, inspecting paca.
[  199.235551] irq_soft_mask: 0x01 in_mce: 0 in_nmi: 0 current: 217 (kworker/40:0H)
[  199.235579] Back trace of paca->saved_r1 (0xc000000012973380) (possibly stale):
[  199.235594] Call Trace:
[  199.235601] [c000000012973380] [c0000000129733e0] 0xc0000000129733e0 (unreliable)
[  199.235633] [c000000012973420] [c000000000933008] bfq_allow_bio_merge+0x78/0x110
[  199.235673] [c000000012973460] [c0000000008d7470] elv_bio_merge_ok+0x90/0xb0
[  199.235711] [c000000012973490] [c0000000008d811c] elv_merge+0x6c/0x1b0
[  199.235747] [c0000000129734e0] [c0000000008ea1d8] blk_mq_sched_try_merge+0x48/0x250
[  199.235785] [c000000012973540] [c00000000092d29c] bfq_bio_merge+0xfc/0x230
[  199.235820] [c0000000129735c0] [c0000000008f9e24] __blk_mq_sched_bio_merge+0xa4/0x210
[  199.235848] [c000000012973620] [c0000000008f288c] blk_mq_submit_bio+0xec/0x710
[  199.235877] [c0000000129736c0] [c0000000008dfad4] submit_bio_noacct+0x534/0x680
[  199.235915] [c000000012973760] [c0000000005e0308] iomap_dio_submit_bio+0xd8/0x100
[  199.235953] [c000000012973790] [c0000000005e0ed4] iomap_dio_bio_actor+0x3c4/0x570
[  199.235991] [c000000012973830] [c0000000005db284] iomap_apply+0x1f4/0x3e0
[  199.236017] [c000000012973920] [c0000000005e06e4] __iomap_dio_rw+0x204/0x5b0
[  199.236054] [c0000000129739f0] [c0000000005e0ab0] iomap_dio_rw+0x20/0x80
[  199.236090] [c000000012973a10] [c00800000e4ea660] xfs_file_dio_write_aligned+0xb8/0x1b0 [xfs]
[  199.236230] [c000000012973a60] [c00800000e4eabfc] xfs_file_write_iter+0x104/0x190 [xfs]
[  199.236368] [c000000012973a90] [c008000010440724] nvmet_file_submit_bvec+0xfc/0x160 [nvmet]
[  199.236412] [c000000012973b10] [c008000010440b54] nvmet_file_execute_io+0x2cc/0x3b0 [nvmet]
[  199.236455] [c000000012973b90] [c00800000fa142d8] nvmet_tcp_io_work+0xce0/0xd10 [nvmet_tcp]
[  199.236493] [c000000012973c70] [c000000000179534] process_one_work+0x294/0x580
[  199.236533] [c000000012973d10] [c0000000001798c8] worker_thread+0xa8/0x650
[  199.236568] [c000000012973da0] [c000000000184180] kthread+0x190/0x1a0
[  199.236595] [c000000012973e10] [c00000000000d4ec] ret_from_kernel_thread+0x5c/0x70
[  199.236710] Sending NMI from CPU 5 to CPUs 42:
[  205.044364] CPU 42 didn't respond to backtrace IPI, inspecting paca.
[  205.044381] irq_soft_mask: 0x01 in_mce: 0 in_nmi: 0 current: 3004 (kworker/42:2H)
[  205.044408] Back trace of paca->saved_r1 (0xc00000085194b520) (possibly stale):
[  205.044423] Call Trace:
[  205.044440] [c00000085194b520] [c00000079ac7f700] 0xc00000079ac7f700 (unreliable)
[  205.044468] [c00000085194b540] [c00000000092d248] bfq_bio_merge+0xa8/0x230
[  205.044494] [c00000085194b5c0] [c0000000008f9e24] __blk_mq_sched_bio_merge+0xa4/0x210
[  205.044531] [c00000085194b620] [c0000000008f288c] blk_mq_submit_bio+0xec/0x710
[  205.044569] [c00000085194b6c0] [c0000000008dfad4] submit_bio_noacct+0x534/0x680
[  205.044607] [c00000085194b760] [c0000000005e0308] iomap_dio_submit_bio+0xd8/0x100
[  205.044645] [c00000085194b790] [c0000000005e0ed4] iomap_dio_bio_actor+0x3c4/0x570
[  205.044672] [c00000085194b830] [c0000000005db284] iomap_apply+0x1f4/0x3e0
[  205.044698] [c00000085194b920] [c0000000005e06e4] __iomap_dio_rw+0x204/0x5b0
[  205.044735] [c00000085194b9f0] [c0000000005e0ab0] iomap_dio_rw+0x20/0x80
[  205.044771] [c00000085194ba10] [c00800000e4ea660] xfs_file_dio_write_aligned+0xb8/0x1b0 [xfs]
[  205.044897] [c00000085194ba60] [c00800000e4eabfc] xfs_file_write_iter+0x104/0x190 [xfs]
[  205.045021] [c00000085194ba90] [c008000010440724] nvmet_file_submit_bvec+0xfc/0x160 [nvmet]
[  205.045064] [c00000085194bb10] [c008000010440b54] nvmet_file_execute_io+0x2cc/0x3b0 [nvmet]
[  205.045106] [c00000085194bb90] [c00800000fa142d8] nvmet_tcp_io_work+0xce0/0xd10 [nvmet_tcp]
[  205.045144] [c00000085194bc70] [c000000000179534] process_one_work+0x294/0x580
[  205.045181] [c00000085194bd10] [c0000000001798c8] worker_thread+0xa8/0x650
[  205.045216] [c00000085194bda0] [c000000000184180] kthread+0x190/0x1a0
[  205.045242] [c00000085194be10] [c00000000000d4ec] ret_from_kernel_thread+0x5c/0x70




Best Regards,
  Yi Zhang


