Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BE1C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 14:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855E220896
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 14:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfAROzQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:55:16 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:57911 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbfAROzP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 09:55:15 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id B6FAB13F89C;
        Fri, 18 Jan 2019 15:54:48 +0100 (CET)
Subject: Re: dd hangs when reading large partitions
To:     Ming Lei <tom.leiming@gmail.com>,
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
 <CACVXFVOwihuWJ9p52G_zEE7tw_BgEK7fnw3LgSJuG-FzWGT=ag@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <c1ff1267-c559-9de2-efc6-8ec9a8b9074a@free.fr>
Date:   Fri, 18 Jan 2019 15:54:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVOwihuWJ9p52G_zEE7tw_BgEK7fnw3LgSJuG-FzWGT=ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/01/2019 14:39, Ming Lei wrote:

> On Fri, Jan 18, 2019 at 8:11 PM Marc Gonzalez wrote:
> 
>> I'm running into an issue which I don't know how to debug.
>> So I'm open to ideas and suggestions :-)
>>
>> On my arm64 board, I have enabled Universal Flash Storage support.
>>
>> I wanted to benchmark read performance, and noticed that the system
>> locks up when I read partitions larger than 3.5 GB, unless I tell
>> dd to use direct IO:
>>
>> *** WITH O_DIRECT ***
>> # dd if=/dev/sda of=/dev/null bs=1M iflag=direct status=progress
>> 57892929536 bytes (58 GB, 54 GiB) copied, 697.006 s, 83.1 MB/s
>> 55256+0 records in
>> 55256+0 records out
>> 57940115456 bytes (58 GB, 54 GiB) copied, 697.575 s, 83.1 MB/s
>>
>> *** WITHOUT O_DIRECT ***
>> # dd if=/dev/sda of=/dev/null bs=1M status=progress
>> 3853516800 bytes (3.9 GB, 3.6 GiB) copied, 49.0002 s, 78.6 MB/s
>>
>>
>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> rcu:    1-...0: (8242 ticks this GP) idle=106/1/0x4000000000000000 softirq=168/171 fqs=2626
>> rcu:    6-...0: (99 GPs behind) idle=ec2/1/0x4000000000000000 softirq=71/71 fqs=2626
>> rcu:    (detected by 7, t=5254 jiffies, g=-275, q=2)
>> Task dump for CPU 1:
>> kworker/1:1H    R  running task        0   675      2 0x0000002a
>> Workqueue: kblockd blk_mq_run_work_fn
>> Call trace:
>>  __switch_to+0x168/0x1d0
>>  0xffffffc0f6efbbc8
>>  blk_mq_run_work_fn+0x28/0x40
>>  process_one_work+0x208/0x470
>>  worker_thread+0x48/0x460
>>  kthread+0x128/0x130
>>  ret_from_fork+0x10/0x1c
>> Task dump for CPU 6:
>> kthreadd        R  running task        0     2      0 0x0000002a
>> Call trace:
>>  __switch_to+0x168/0x1d0
>>  0x5b36396f4e7d4000
>>
>>
>> The system always hangs around the 3.6 GiB mark, wherever I start from.
>> How can I debug this issue?
> 
> Maybe you can try to collect debugfs log first via the following command?
> 
> (cd /sys/kernel/debug/block/sda && find . -type f -exec grep -aH . {} \;)

# find . -type f -exec grep -aH . {} \;
./hctx0/cpu7/completed:0 0
./hctx0/cpu7/merged:0
./hctx0/cpu7/dispatched:0 0
./hctx0/cpu6/completed:0 5
./hctx0/cpu6/merged:0
./hctx0/cpu6/dispatched:0 5
./hctx0/cpu5/completed:0 0
./hctx0/cpu5/merged:0
./hctx0/cpu5/dispatched:0 0
./hctx0/cpu4/completed:0 0
./hctx0/cpu4/merged:0
./hctx0/cpu4/dispatched:0 0
./hctx0/cpu3/completed:5 38
./hctx0/cpu3/merged:0
./hctx0/cpu3/dispatched:5 38
./hctx0/cpu2/completed:0 0
./hctx0/cpu2/merged:0
./hctx0/cpu2/dispatched:0 0
./hctx0/cpu1/completed:0 0
./hctx0/cpu1/merged:0
./hctx0/cpu1/dispatched:0 0
./hctx0/cpu0/completed:0 0
./hctx0/cpu0/merged:0
./hctx0/cpu0/dispatched:0 0
./hctx0/type:default
./hctx0/dispatch_busy:0
./hctx0/active:0
./hctx0/run:43
./hctx0/queued:48
./hctx0/dispatched:       0     0
./hctx0/dispatched:       1     43
./hctx0/dispatched:       2     0
./hctx0/dispatched:       4     0
./hctx0/dispatched:       8     0
./hctx0/dispatched:      16     0
./hctx0/dispatched:      32+    0
./hctx0/io_poll:considered=0
./hctx0/io_poll:invoked=0
./hctx0/io_poll:success=0
./hctx0/tags_bitmap:00000000: ff07 070f
./hctx0/tags:nr_tags=32
./hctx0/tags:nr_reserved_tags=0
./hctx0/tags:active_queues=0
./hctx0/tags:bitmap_tags:
./hctx0/tags:depth=32
./hctx0/tags:busy=0
./hctx0/tags:cleared=18
./hctx0/tags:bits_per_word=8
./hctx0/tags:map_nr=4
./hctx0/tags:alloc_hint={12, 7, 12, 24, 12, 27, 10, 18}
./hctx0/tags:wake_batch=4
./hctx0/tags:wake_index=0
./hctx0/tags:ws_active=0
./hctx0/tags:ws={
./hctx0/tags:   {.wait_cnt=4, .wait=inactive},
./hctx0/tags:   {.wait_cnt=4, .wait=inactive},
./hctx0/tags:   {.wait_cnt=4, .wait=inactive},
./hctx0/tags:   {.wait_cnt=4, .wait=inactive},
./hctx0/tags:   {.wait_cnt=4, .wait=inactive},
./hctx0/tags:   {.wait_cnt=4, .wait=inactive},
./hctx0/tags:   {.wait_cnt=4, .wait=inactive},
./hctx0/tags:   {.wait_cnt=4, .wait=inactive},
./hctx0/tags:}
./hctx0/tags:round_robin=0
./hctx0/tags:min_shallow_depth=4294967295
./hctx0/ctx_map:00000000: 00
./hctx0/flags:alloc_policy=FIFO SHOULD_MERGE|TAG_SHARED|SG_MERGE
./write_hints:hint0: 0
./write_hints:hint1: 0
./write_hints:hint2: 0
./write_hints:hint3: 0
./write_hints:hint4: 0
./state:SAME_COMP|NONROT|IO_STAT|DISCARD|INIT_DONE|WC|FUA|REGISTERED|SCSI_PASSTHROUGH
./pm_only:0
./poll_stat:read  (512 Bytes): samples=0
./poll_stat:write (512 Bytes): samples=0
./poll_stat:read  (1024 Bytes): samples=0
./poll_stat:write (1024 Bytes): samples=0
./poll_stat:read  (2048 Bytes): samples=0
./poll_stat:write (2048 Bytes): samples=0
./poll_stat:read  (4096 Bytes): samples=0
./poll_stat:write (4096 Bytes): samples=0
./poll_stat:read  (8192 Bytes): samples=0
./poll_stat:write (8192 Bytes): samples=0
./poll_stat:read  (16384 Bytes): samples=0
./poll_stat:write (16384 Bytes): samples=0
./poll_stat:read  (32768 Bytes): samples=0
./poll_stat:write (32768 Bytes): samples=0
./poll_stat:read  (65536 Bytes): samples=0
./poll_stat:write (65536 Bytes): samples=0


> BTW,  I have several questions on this report:
> 
> - what is the kernel version in your test?

v5.0-rc1 + a few patches to enable UFS

> - can you reproduce this issue on other disk (not UFS)?

At the moment, UFS is the only available storage option.
(USB is broken, SDHC requires some work.)

> - are there any tasks in 'D' state shown via 'ps -ax'? If yes, please dump their
> stack trace.

(This rootfs provides busybox ps.)

# ps -o pid,user,stat,args
PID   USER     STAT COMMAND
    1 root     S    init
    2 root     SW   [kthreadd]
    3 root     IW<  [rcu_gp]
    4 root     IW<  [rcu_par_gp]
    5 root     IW   [kworker/0:0-eve]
    6 root     IW<  [kworker/0:0H-kb]
    8 root     IW<  [mm_percpu_wq]
    9 root     SW   [ksoftirqd/0]
   10 root     IW   [rcu_preempt]
   11 root     SW   [migration/0]
   12 root     IW   [kworker/0:1-eve]
   13 root     SW   [cpuhp/0]
   14 root     SW   [cpuhp/1]
   15 root     SW   [migration/1]
   16 root     SW   [ksoftirqd/1]
   17 root     IW   [kworker/1:0-eve]
   18 root     IW<  [kworker/1:0H-kb]
   19 root     SW   [cpuhp/2]
   20 root     SW   [migration/2]
   21 root     SW   [ksoftirqd/2]
   22 root     IW   [kworker/2:0-eve]
   23 root     IW<  [kworker/2:0H-kb]
   24 root     SW   [cpuhp/3]
   25 root     SW   [migration/3]
   26 root     SW   [ksoftirqd/3]
   27 root     IW   [kworker/3:0-eve]
   28 root     IW<  [kworker/3:0H-kb]
   29 root     SW   [cpuhp/4]
   30 root     SW   [migration/4]
   31 root     SW   [ksoftirqd/4]
   32 root     IW   [kworker/4:0-eve]
   33 root     IW<  [kworker/4:0H]
   34 root     SW   [cpuhp/5]
   35 root     SW   [migration/5]
   36 root     SW   [ksoftirqd/5]
   37 root     IW   [kworker/5:0-eve]
   38 root     IW<  [kworker/5:0H]
   39 root     SW   [cpuhp/6]
   40 root     SW   [migration/6]
   41 root     SW   [ksoftirqd/6]
   42 root     IW   [kworker/6:0-eve]
   43 root     IW<  [kworker/6:0H-kb]
   44 root     SW   [cpuhp/7]
   45 root     SW   [migration/7]
   46 root     SW   [ksoftirqd/7]
   47 root     IW   [kworker/7:0-eve]
   48 root     IW<  [kworker/7:0H]
   49 root     SW   [kdevtmpfs]
   52 root     SW   [rcu_tasks_kthre]
   53 root     IW   [kworker/3:1-mm_]
   64 root     IW   [kworker/4:1-mm_]
   65 root     IW   [kworker/5:1-eve]
   76 root     IW   [kworker/6:1-mm_]
   78 root     IW   [kworker/1:1-mm_]
   88 root     IW   [kworker/7:1-eve]
  101 root     IW   [kworker/2:1-mm_]
  198 root     SW   [khungtaskd]
  199 root     SW   [oom_reaper]
  200 root     IW<  [writeback]
  202 root     SW   [kcompactd0]
  204 root     IW<  [kblockd]
  223 root     IW<  [devfreq_wq]
  372 root     SW   [kswapd0]
  505 root     SW   [scsi_eh_0]
  506 root     IW<  [scsi_tmf_0]
  507 root     IW<  [ufs_clk_gating_]
  508 root     IW<  [ufs_clkscaling_]
  546 root     IW   [kworker/u16:5-e]
  555 root     IW   [kworker/u16:7-e]
  657 root     S    /sbin/klogd -n
  675 root     S    -sh
  677 root     IW<  [kworker/6:1H-kb]
  678 root     IW<  [kworker/3:1H]
  679 root     IW<  [kworker/1:1H]
  680 root     IW<  [kworker/2:1H]
  681 root     IW<  [kworker/0:1H]
  859 root     R    ps -o pid,user,stat,args


Do you see anything relevant?

Regards.
