Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C935C4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 11:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEAD2238EB
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 11:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgLHLhg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 06:37:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:34672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbgLHLhf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Dec 2020 06:37:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3AFCEAC9A;
        Tue,  8 Dec 2020 11:36:54 +0000 (UTC)
Date:   Tue, 8 Dec 2020 12:36:53 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20201208113653.awqz4zggmy37vbog@beryllium.lan>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208082220.hhel5ubeh4uqrwnd@linutronix.de>
 <20201208084409.koeftbpnvesp4xtv@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208084409.koeftbpnvesp4xtv@beryllium.lan>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 08, 2020 at 09:44:10AM +0100, Daniel Wagner wrote:
> On Tue, Dec 08, 2020 at 09:22:20AM +0100, Sebastian Andrzej Siewior wrote:
> > Sagi mentioned nvme-tcp as a user of this remote completion and Daniel
> > has been kind to run some nvme-tcp tests.
> 
> I've started with some benchmarking. The first thing I tried is to find
> a setup where the remote path is taken. I found a setup with nvme-fc
> with a workload which results in ca 10% remote completion.

Setup:
  - Dell Express Flash NVMe PM1725 800GB SFF
  - 2 Gold 6130, 64 cores

Workload:
  - fio --rw=randread --name=test --filename=/dev/nvme0n1 \
        --iodepth=64 --direct=1 --bs=4k --numjobs=32 \
        --time_based --runtime=5m --ioengine=libaio --group_reporting

(Searched for a workload with the highest IOPs which seems to be
randread)

Obvious in this configuration there are no remote completions (verified
it).

- baseline 5.10-rc7

Jobs: 32 (f=32): [r(32)][100.0%][r=2544MiB/s][r=651k IOPS][eta 00m:00s]
test: (groupid=0, jobs=32): err= 0: pid=24118: Tue Dec  8 11:33:21 2020
  read: IOPS=636k, BW=2485MiB/s (2605MB/s)(728GiB/300006msec)
    slat (nsec): min=1502, max=450956, avg=5576.99, stdev=1475.94
    clat (usec): min=195, max=59296, avg=3212.51, stdev=1640.48
     lat (usec): min=201, max=59302, avg=3218.23, stdev=1640.58
    clat percentiles (usec):
     |  1.00th=[ 2573],  5.00th=[ 2671], 10.00th=[ 2769], 20.00th=[ 2868],
     | 30.00th=[ 2933], 40.00th=[ 2999], 50.00th=[ 3064], 60.00th=[ 3163],
     | 70.00th=[ 3261], 80.00th=[ 3359], 90.00th=[ 3589], 95.00th=[ 3818],
     | 99.00th=[ 4948], 99.50th=[ 5669], 99.90th=[40633], 99.95th=[44303],
     | 99.99th=[49021]
   bw (  MiB/s): min=  444, max= 2598, per=99.99%, avg=2484.33, stdev= 8.36, samples=19200
   iops        : min=113782, max=665312, avg=635988.04, stdev=2139.63, samples=19200
  lat (usec)   : 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=96.85%, 10=2.96%, 20=0.01%, 50=0.16%
  lat (msec)   : 100=0.01%
  cpu          : usr=9.11%, sys=14.58%, ctx=131930047, majf=0, minf=28434
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=190817510,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=2485MiB/s (2605MB/s), 2485MiB/s-2485MiB/s (2605MB/s-2605MB/s), io=728GiB (782GB), run=300006-300006msec

Disk stats (read/write):
  nvme0n1: ios=190707084/0, merge=0/0, ticks=611781701/0, in_queue=611781702, util=100.00%


- patched

Jobs: 32 (f=32): [r(32)][100.0%][r=2548MiB/s][r=652k IOPS][eta 00m:00s]
test: (groupid=0, jobs=32): err= 0: pid=3059: Tue Dec  8 12:11:25 2020
  read: IOPS=637k, BW=2489MiB/s (2610MB/s)(729GiB/300006msec)
    slat (nsec): min=1453, max=4793.6k, avg=5662.01, stdev=1960.75
    clat (usec): min=77, max=59685, avg=3207.13, stdev=1633.85
     lat (usec): min=82, max=59696, avg=3212.92, stdev=1633.95
    clat percentiles (usec):
     |  1.00th=[ 2573],  5.00th=[ 2671], 10.00th=[ 2737], 20.00th=[ 2835],
     | 30.00th=[ 2933], 40.00th=[ 2999], 50.00th=[ 3064], 60.00th=[ 3163],
     | 70.00th=[ 3228], 80.00th=[ 3359], 90.00th=[ 3556], 95.00th=[ 3785],
     | 99.00th=[ 4948], 99.50th=[ 5669], 99.90th=[40633], 99.95th=[43779],
     | 99.99th=[49021]
   bw (  MiB/s): min=  560, max= 2617, per=99.99%, avg=2488.34, stdev= 8.39, samples=19199
   iops        : min=143452, max=670006, avg=637013.93, stdev=2148.64, samples=19199
  lat (usec)   : 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=96.92%, 10=2.89%, 20=0.01%, 50=0.16%
  lat (msec)   : 100=0.01%
  cpu          : usr=9.32%, sys=14.88%, ctx=130862793, majf=0, minf=38825
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=191130719,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=2489MiB/s (2610MB/s), 2489MiB/s-2489MiB/s (2610MB/s-2610MB/s), io=729GiB (783GB), run=300006-300006msec

Disk stats (read/write):
  nvme0n1: ios=191019060/0, merge=0/0, ticks=611718395/0, in_queue=611718395, util=100.00%


Again, the numbers look very alike.

Thanks,
Daniel
