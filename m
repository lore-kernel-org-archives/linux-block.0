Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A0BC33CB2
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 10:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1B8206F0
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 10:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY1H6rtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgAaKES (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:04:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40103 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgAaKES (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 05:04:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so7959791wmi.5
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 02:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBcsp5V62vbcl7mY5vhGyGkY3HRKhHaLulxYDPu2cyE=;
        b=NY1H6rtnQqRWGoGpgz9fBFoSbxS/4tuPgFNSB9b93J5ALNVUSKIdWOFQs6StYx4oom
         Oj+yvpu6LIQBv3/avUeoK4JZwkRbE8GVdCjF6pYg7XdldVDKl+8ParQd+CRynie0DEXR
         ecb+S/1Ime8umOQ9QOi+ly2nVRmH9VX1i5r2XvvPzlH+q/MpXu/GVk78iyYvWMJ2OAvd
         4TLZr/DGi2JEfWKNrLIoUsZKaFgn/rXbsDiToOsI502m55PklKF99NNBPUeNCCJDPtVP
         WWjeFie132KPWcpwVeiBysNEuL+I09VKzYM4Y/sKTFquSqAlV1F4US8BUmqXWyvYfTQz
         ZizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBcsp5V62vbcl7mY5vhGyGkY3HRKhHaLulxYDPu2cyE=;
        b=K1qGBcU2MFTl/gr/pDZ3zhMlNhbQ+o+d8zWP8Tn7lyhneRyRHcm8cBUqaMgmncOn4W
         ICuvlttI5lKfUZhTB0HLwAieburPyBXLXZN8nRVT7Aqn2usGc6d/zhB+zSvSdrGUVzRi
         pp4lJ9wk/NGwrlGSFzBBdVnU5mGkwpPr5QgEzrdFXU0VWkg55blQWxujeI9a8dNvJgod
         w5Z4CLH6EXxn27WlH47pyxMnzhY8p/VH6Wzsim56/n9ymdnO/+b8jS0bhVgmswLCApye
         ZxnvRPR1DShmXN7T+J0KHBk99wd38Hu6GZoCw9o4CUQIg8ZMNaMZQflguDeymSIr0Kgz
         MSIA==
X-Gm-Message-State: APjAAAXroqQQ5nk2nAIb1m1bNC59Wk9qmJZI/stWqnlYo8frSDHE6rLc
        ZlQesx1DK9AlKhV+09uKKHRzTxKkhvRMg/7slO8=
X-Google-Smtp-Source: APXvYqwiF3K2GiMuI/wzwrqnv/BQedmWfyNHRtB8xyHC4ZcW99dzu+hHp5zpGX1wEU9px+HTIiA38QOCnnA3I+SGNng=
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr10657868wme.64.1580465054257;
 Fri, 31 Jan 2020 02:04:14 -0800 (PST)
MIME-Version: 1.0
References: <20200115114409.28895-1-ming.lei@redhat.com> <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com>
 <6dbe8c9f-af4e-3157-b6e9-6bbf43efb1e1@huawei.com>
In-Reply-To: <6dbe8c9f-af4e-3157-b6e9-6bbf43efb1e1@huawei.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 31 Jan 2020 18:04:02 +0800
Message-ID: <CACVXFVN8io2Pj1HZWLy=z1dbDrE3h9Q6B0DA4gdGOdK3+bRRPg@mail.gmail.com>
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>,
        chenxiang <chenxiang66@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 20, 2020 at 9:24 PM John Garry <john.garry@huawei.com> wrote:
>
> On 15/01/2020 17:00, John Garry wrote:
> > On 15/01/2020 11:44, Ming Lei wrote:
> >> Hi,
> >>
> >> Thomas mentioned:
> >>      "
> >>       That was the constraint of managed interrupts from the very
> >> beginning:
> >>        The driver/subsystem has to quiesce the interrupt line and the
> >> associated
> >>        queue _before_ it gets shutdown in CPU unplug and not fiddle
> >> with it
> >>        until it's restarted by the core when the CPU is plugged in again.
> >>      "
> >>
> >> But no drivers or blk-mq do that before one hctx becomes inactive(all
> >> CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
> >> to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
> >>
> >> This patchset tries to address the issue by two stages:
> >>
> >> 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
> >>
> >> - mark the hctx as internal stopped, and drain all in-flight requests
> >> if the hctx is going to be dead.
> >>
> >> 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx
> >> becomes dead
> >>
> >> - steal bios from the request, and resubmit them via
> >> generic_make_request(),
> >> then these IO will be mapped to other live hctx for dispatch
> >>
> >> Please comment & review, thanks!
> >>
> >> V5:
> >>     - rename BLK_MQ_S_INTERNAL_STOPPED as BLK_MQ_S_INACTIVE
> >>     - re-factor code for re-submit requests in cpu dead hotplug handler
> >>     - address requeue corner case
> >>
> >> V4:
> >>     - resubmit IOs in dispatch list in case that this hctx is dead
> >>
> >> V3:
> >>     - re-organize patch 2 & 3 a bit for addressing Hannes's comment
> >>     - fix patch 4 for avoiding potential deadlock, as found by Hannes
> >>
> >> V2:
> >>     - patch4 & patch 5 in V1 have been merged to block tree, so remove
> >>       them
> >>     - address comments from John Garry and Minwoo
> >>
> >>
>
> Hi Ming,
>
> Colleague Xiang Chen found this:
>
> Starting 40 processes
> Jobs: 40 (f=40)
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [8.3% done]
> [2899MB/0KB/0KB /s] [742K/0/0 iops] [eta 00m:33s]
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [11.1% done]
> [2892MB/0KB/0KB /s] [740K/0/0 iops] [eta 00m:32s]
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [13.9% done]
> [2887MB/0KB/0KB /s] [739K/0/0 iops] [eta 00m:31s]
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [16.7% done]
> [2850MB/0KB/0KB /s] [730K/0/0 iops] [eta 00m:30s]
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [19.4% done]
> [2834MB/0KB/0KB /s] [726K/0/0 iops] [eta 00m:29s]
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [22.2% done]
> [2827MB/0KB/0KB /s] [724K/0/0 iops] [eta 00m:28s]
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [25.0% done]
> [2804MB/0KB/0KB /s] [718K/0/0 iops] [eta 00m:27s]
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [27.8% done]
> [2783MB/0KB/0KB /s] [713K/0/0 iops] [eta 00m:26s]
> [  112.990292] CPU16: shutdown
> [  112.993113] psci: CPU16 killed (polled 0 ms)
> [  113.029429] CPU15: shutdown
> [  113.032245] psci: CPU15 killed (polled 0 ms)
> [  113.073649] CPU14: shutdown
> [  113.076461] psci: CPU14 killed (polled 0 ms)
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR[  113.121258] CPU13:
> shutdown
> RRRRRRRRRR] [30.[  113.124247] psci: CPU13 killed (polled 0 ms)
> 6% done] [2772MB/0KB/0KB /s] [710K/0/0 iops] [eta 00m:25s]
> [  113.177108] IRQ 600: no longer affine to CPU12
> [  113.183185] CPU12: shutdown
> [  113.186001] psci: CPU12 killed (polled 0 ms)
> [  113.242555] CPU11: shutdown
> [  113.245368] psci: CPU11 killed (polled 0 ms)
> [  113.302598] CPU10: shutdown
> [  113.305420] psci: CPU10 killed (polled 0 ms)
> [  113.365757] CPU9: shutdown
> [  113.368489] psci: CPU9 killed (polled 0 ms)
> [  113.611904] IRQ 599: no longer affine to CPU8
> [  113.620611] CPU8: shutdown
> [  113.623340] psci: CPU8 killed (polled 0 ms)
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [33.3% done]
> [2765MB/0KB/0KB /s] [708K/0/0 iops] [eta 00m:24s]
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [36.1% done]
> [2767MB/0KB/0KB /s] [708K/0/0 iops] [eta 00m:23s]
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [38.9% done]
> [2771MB/0KB/0KB /s] [709K/0/0 iops] [eta 00m:22s]
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [41.7% done]
> [2780MB/0KB/0KB /s] [712K/0/0 iops] [eta 00m:21s]
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [44.4% done]
> [2731MB/0KB/0KB /s] [699K/0/0 iops] [eta 00m:20s]
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [47.2% done]
> [2757MB/0KB/0KB /s] [706K/0/0 iops] [eta 00m:19s]
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [50.0% done]
> [2764MB/0KB/0KB /s] [708K/0/0 iops] [eta 00m:18s]
> [  120.762141] ------------[ cut here ]------------
> [  120.766760] WARNING: CPU: 0 PID: 10 at block/blk.h:299
> generic_make_request_checks+0x480/0x4e8
> [  120.775348] Modules linked in:
> [  120.778397] CPU: 0 PID: 10 Comm: ksoftirqd/0 Not tainted 5.5.0-
>
> Then this:
>
> 1158048319d:18h:40m:34s]
> Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done]
> [0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049605d:23h:03m:30s]
> [  141.915198] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  141.921280] rcu:     96-...0: (4 GPs behind) idle=af6/0/0x1
> softirq=90/90 fqs=2626
> [  141.928658] rcu:     99-...0: (2 GPs behind)
> idle=b82/1/0x4000000000000000 softirq=82/82 fqs=2627
> [  141.937339]  (detected by 17, t=5254 jiffies, g=3925, q=545)
> [  141.942985] Task dump for CPU 96:
> [  141.946292] swapper/96      R  running task        0     0      1
> 0x0000002a
> [  141.953321] Call trace:
> [  141.955763]  __switch_to+0xbc/0x218
> [  141.959244]  0x0
> [  141.961079] Task dump for CPU 99:
> [  141.964385] kworker/99:1H   R  running task        0  3473      2
> 0x0000022a
> [  141.971417] Workqueue: kblockd blk_mq_run_work_fn
> [  141.976109] Call trace:
> [  141.978550]  __switch_to+0xbc/0x218
> [  141.982029]  blk_mq_run_work_fn+0x1c/0x28
> [  141.986027]  process_one_work+0x1e0/0x358
> [  141.990025]  worker_thread+0x40/0x488
> [  141.993678]  kthread+0x118/0x120
> [  141.996897]  ret_from_fork+0x10/0x18

Hi John,

Thanks for your test!

Could you test the following patchset and only the last one is changed?

https://github.com/ming1/linux/commits/my_for_5.6_block

Thanks,
Ming Lei
