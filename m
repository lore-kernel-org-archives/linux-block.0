Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8D2C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 12:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EB520883
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 12:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfARMLP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:11:15 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53736 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbfARMLO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 07:11:14 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id B644713F89C;
        Fri, 18 Jan 2019 13:10:49 +0100 (CET)
To:     fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joao Pinto <jpinto@synopsys.com>, Jens Axboe <axboe@kernel.dk>,
        Fujita Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Paolo Valente <paolo.valente@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: dd hangs when reading large partitions
Message-ID: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
Date:   Fri, 18 Jan 2019 13:10:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I'm running into an issue which I don't know how to debug.
So I'm open to ideas and suggestions :-)

On my arm64 board, I have enabled Universal Flash Storage support.

I wanted to benchmark read performance, and noticed that the system
locks up when I read partitions larger than 3.5 GB, unless I tell
dd to use direct IO:

*** WITH O_DIRECT ***
# dd if=/dev/sda of=/dev/null bs=1M iflag=direct status=progress
57892929536 bytes (58 GB, 54 GiB) copied, 697.006 s, 83.1 MB/s 
55256+0 records in
55256+0 records out
57940115456 bytes (58 GB, 54 GiB) copied, 697.575 s, 83.1 MB/s

*** WITHOUT O_DIRECT ***
# dd if=/dev/sda of=/dev/null bs=1M status=progress
3853516800 bytes (3.9 GB, 3.6 GiB) copied, 49.0002 s, 78.6 MB/s


rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:    1-...0: (8242 ticks this GP) idle=106/1/0x4000000000000000 softirq=168/171 fqs=2626 
rcu:    6-...0: (99 GPs behind) idle=ec2/1/0x4000000000000000 softirq=71/71 fqs=2626 
rcu:    (detected by 7, t=5254 jiffies, g=-275, q=2)
Task dump for CPU 1:
kworker/1:1H    R  running task        0   675      2 0x0000002a
Workqueue: kblockd blk_mq_run_work_fn
Call trace:
 __switch_to+0x168/0x1d0
 0xffffffc0f6efbbc8
 blk_mq_run_work_fn+0x28/0x40
 process_one_work+0x208/0x470
 worker_thread+0x48/0x460
 kthread+0x128/0x130
 ret_from_fork+0x10/0x1c
Task dump for CPU 6:
kthreadd        R  running task        0     2      0 0x0000002a
Call trace:
 __switch_to+0x168/0x1d0
 0x5b36396f4e7d4000


rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:    1-...0: (8242 ticks this GP) idle=106/1/0x4000000000000000 softirq=168/171 fqs=10500 
rcu:    6-...0: (99 GPs behind) idle=ec2/1/0x4000000000000000 softirq=71/71 fqs=10500 
rcu:    (detected by 7, t=21009 jiffies, g=-275, q=2)
Task dump for CPU 1:
kworker/1:1H    R  running task        0   675      2 0x0000002a
Workqueue: kblockd blk_mq_run_work_fn
Call trace:
 __switch_to+0x168/0x1d0
 0xffffffc0f6efbbc8
 blk_mq_run_work_fn+0x28/0x40
 process_one_work+0x208/0x470
 worker_thread+0x48/0x460
 kthread+0x128/0x130
 ret_from_fork+0x10/0x1c
Task dump for CPU 6:
kthreadd        R  running task        0     2      0 0x0000002a
Call trace:
 __switch_to+0x168/0x1d0
 0x5b36396f4e7d4000


The system always hangs around the 3.6 GiB mark, wherever I start from.
How can I debug this issue?

Regards.
