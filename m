Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933703AbdKQOmM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Nov 2017 09:42:12 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAHEfoJs098339
        for <linux-block@vger.kernel.org>; Fri, 17 Nov 2017 09:42:11 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e9y9nxyjy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 17 Nov 2017 09:42:11 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 17 Nov 2017 14:42:08 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>
Date: Fri, 17 Nov 2017 15:42:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <9c5eec5d-f542-4d76-6933-6fe31203ce09@de.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When doing cpu hotplug in a KVM guest with virtio blk  I get  warnings like
  747.652408] ------------[ cut here ]------------
[  747.652410] WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 __blk_mq_run_hw_queue+0xd4/0x100
[  747.652410] Modules linked in: dm_multipath
[  747.652412] CPU: 4 PID: 2895 Comm: kworker/4:1H Tainted: G        W       4.14.0+ #191
[  747.652412] Hardware name: IBM 2964 NC9 704 (KVM/Linux)
[  747.652414] Workqueue: kblockd blk_mq_run_work_fn
[  747.652414] task: 0000000060680000 task.stack: 000000005ea30000
[  747.652415] Krnl PSW : 0704f00180000000 0000000000505864 (__blk_mq_run_hw_queue+0xd4/0x100)
[  747.652417]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
[  747.652417] Krnl GPRS: 0000000000000010 00000000000000ff 000000005cbec400 0000000000000000
[  747.652418]            0000000063709120 0000000000000000 0000000063709500 0000000059fa44b0
[  747.652418]            0000000059fa4480 0000000000000000 000000006370f700 0000000063709100
[  747.652419]            000000005cbec500 0000000000970948 000000005ea33d80 000000005ea33d48
[  747.652423] Krnl Code: 0000000000505854: ebaff0a00004        lmg     %r10,%r15,160(%r15)
           000000000050585a: c0f4ffe690d3       brcl    15,1d7a00
          #0000000000505860: a7f40001           brc     15,505862
          >0000000000505864: 581003b0           l       %r1,944
           0000000000505868: c01b001fff00       nilf    %r1,2096896
           000000000050586e: a784ffdb           brc     8,505824
           0000000000505872: a7f40001           brc     15,505874
           0000000000505876: 9120218f           tm      399(%r2),32
[  747.652435] Call Trace:
[  747.652435] ([<0000000063709600>] 0x63709600)
[  747.652436]  [<0000000000187bcc>] process_one_work+0x264/0x4b8 
[  747.652438]  [<0000000000187e78>] worker_thread+0x58/0x4f8 
[  747.652439]  [<000000000018ee94>] kthread+0x144/0x168 
[  747.652439]  [<00000000008f8a62>] kernel_thread_starter+0x6/0xc 
[  747.652440]  [<00000000008f8a5c>] kernel_thread_starter+0x0/0xc 
[  747.652440] Last Breaking-Event-Address:
[  747.652441]  [<0000000000505860>] __blk_mq_run_hw_queue+0xd0/0x100
[  747.652442] ---[ end trace 4a001a80379b18ba ]---
[  747.652450] ------------[ cut here ]------------


This is 

b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1141)     * are mapped to it.
b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1142)     */
6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1143)    WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1144)            cpu_online(hctx->next_cpu));
6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1145) 
b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1146)    /*


Is this a known issue?

Christian
