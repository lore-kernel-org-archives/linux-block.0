Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4C6C07EBF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 19:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D784520657
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 19:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfART1Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:27:16 -0500
Received: from smtp.infotech.no ([82.134.31.41]:54304 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbfART1Q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 14:27:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 5B2A320419B;
        Fri, 18 Jan 2019 20:27:12 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SdIOf-UJeopa; Fri, 18 Jan 2019 20:27:10 +0100 (CET)
Received: from [192.168.48.23] (host-192.252-161-233.dyn.295.ca [192.252.161.233])
        by smtp.infotech.no (Postfix) with ESMTPA id F3EEE20417F;
        Fri, 18 Jan 2019 20:27:08 +0100 (CET)
Reply-To: dgilbert@interlog.com
Subject: Re: dd hangs when reading large partitions
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joao Pinto <jpinto@synopsys.com>, Jens Axboe <axboe@kernel.dk>,
        Fujita Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Paolo Valente <paolo.valente@linaro.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <3746deec-510b-069e-b22d-beef56314b9a@interlog.com>
Date:   Fri, 18 Jan 2019 14:27:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-01-18 7:10 a.m., Marc Gonzalez wrote:
> Hello,
> 
> I'm running into an issue which I don't know how to debug.
> So I'm open to ideas and suggestions :-)
> 
> On my arm64 board, I have enabled Universal Flash Storage support.
> 
> I wanted to benchmark read performance, and noticed that the system
> locks up when I read partitions larger than 3.5 GB, unless I tell
> dd to use direct IO:

Marc,
If you want to benchmark (or torture) UFS read performance I have
many dd variants. In the sg3_utils package there is sgp_dd (using
POSIX threads for a multi-threaded copy or read) and sgm_dd (using
mmap-ed IO). Plus there is a multi-platform ddpt in a package of
the same name.

One major difference between my dd variants and the "standard" one
is that I split the bs=BS option in two: one called bs=BS where BS
is the logical block size of the given device, the other is bpt=BPT
(blocks per transfer) which is the number of logical blocks in each
copy (or read) segment.

So with your example below bs=1M would become, for a LB size of 4096,
'bs=4096 bpt=16k'. Also sgp_dd and sgm_dd don't support status=progress
(ddpt does) but you can always send 'kill -s USR1 <pid_of_dd>'
from another (virtual) console that has root permissions. All my
dd variants and dd itself will accept that signal gracefully and output
a progress report then continue.

Doug Gilbert

> *** WITH O_DIRECT ***
> # dd if=/dev/sda of=/dev/null bs=1M iflag=direct status=progress
> 57892929536 bytes (58 GB, 54 GiB) copied, 697.006 s, 83.1 MB/s
> 55256+0 records in
> 55256+0 records out
> 57940115456 bytes (58 GB, 54 GiB) copied, 697.575 s, 83.1 MB/s
> 
> *** WITHOUT O_DIRECT ***
> # dd if=/dev/sda of=/dev/null bs=1M status=progress
> 3853516800 bytes (3.9 GB, 3.6 GiB) copied, 49.0002 s, 78.6 MB/s
> 
> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    1-...0: (8242 ticks this GP) idle=106/1/0x4000000000000000 softirq=168/171 fqs=2626
> rcu:    6-...0: (99 GPs behind) idle=ec2/1/0x4000000000000000 softirq=71/71 fqs=2626
> rcu:    (detected by 7, t=5254 jiffies, g=-275, q=2)
> Task dump for CPU 1:
> kworker/1:1H    R  running task        0   675      2 0x0000002a
> Workqueue: kblockd blk_mq_run_work_fn
> Call trace:
>   __switch_to+0x168/0x1d0
>   0xffffffc0f6efbbc8
>   blk_mq_run_work_fn+0x28/0x40
>   process_one_work+0x208/0x470
>   worker_thread+0x48/0x460
>   kthread+0x128/0x130
>   ret_from_fork+0x10/0x1c
> Task dump for CPU 6:
> kthreadd        R  running task        0     2      0 0x0000002a
> Call trace:
>   __switch_to+0x168/0x1d0
>   0x5b36396f4e7d4000
> 
> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    1-...0: (8242 ticks this GP) idle=106/1/0x4000000000000000 softirq=168/171 fqs=10500
> rcu:    6-...0: (99 GPs behind) idle=ec2/1/0x4000000000000000 softirq=71/71 fqs=10500
> rcu:    (detected by 7, t=21009 jiffies, g=-275, q=2)
> Task dump for CPU 1:
> kworker/1:1H    R  running task        0   675      2 0x0000002a
> Workqueue: kblockd blk_mq_run_work_fn
> Call trace:
>   __switch_to+0x168/0x1d0
>   0xffffffc0f6efbbc8
>   blk_mq_run_work_fn+0x28/0x40
>   process_one_work+0x208/0x470
>   worker_thread+0x48/0x460
>   kthread+0x128/0x130
>   ret_from_fork+0x10/0x1c
> Task dump for CPU 6:
> kthreadd        R  running task        0     2      0 0x0000002a
> Call trace:
>   __switch_to+0x168/0x1d0
>   0x5b36396f4e7d4000
> 
> 
> The system always hangs around the 3.6 GiB mark, wherever I start from.
> How can I debug this issue?
> 
> Regards.
> 

