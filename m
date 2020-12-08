Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA424C4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 08:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A3323A5E
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 08:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgLHIow (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 03:44:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:39756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbgLHIow (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Dec 2020 03:44:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8FE3CAD80;
        Tue,  8 Dec 2020 08:44:10 +0000 (UTC)
Date:   Tue, 8 Dec 2020 09:44:09 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20201208084409.koeftbpnvesp4xtv@beryllium.lan>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208082220.hhel5ubeh4uqrwnd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208082220.hhel5ubeh4uqrwnd@linutronix.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 08, 2020 at 09:22:20AM +0100, Sebastian Andrzej Siewior wrote:
> Sagi mentioned nvme-tcp as a user of this remote completion and Daniel
> has been kind to run some nvme-tcp tests.

I've started with some benchmarking. The first thing I tried is to find
a setup where the remote path is taken. I found a setup with nvme-fc
with a workload which results in ca 10% remote completion.

Setup:
 - NVMe over FC
 - 2x Emulex LPe36000 32Gb PCIe Fibre Channel Adapter
 - 8 mpaths
 - 4 E7-4820 v3, 80 cores

Workload:
 - fio --rw=randwrite --name=test --size=50M \
       --iodepth=32 --direct=0 --bs=4k --numjobs=40 \
       --time_based --runtime=1h --ioengine=libaio \
       --group_reporting

(I played a bit around with different workloads, most of them
 wont use the remote completion path)

I've annotated the code with a counter and exported it via
debugfs.

@@ -671,6 +673,8 @@ bool blk_mq_complete_request_remote(struct request *rq)
                return false;

        if (blk_mq_complete_need_ipi(rq)) {
+               ctx->rq_remote++;
+
                rq->csd.func = __blk_mq_complete_request_remote;
                rq->csd.info = rq;
                rq->csd.flags = 0;


And hacked a small script to collect the data.

- Baseline (5.10-rc7)

  Starting 40 processes
  Jobs: 40 (f=40): [w(40)][100.0%][r=0KiB/s,w=12.0GiB/s][r=0,w=3405k IOPS][eta 00m:00s]
  test: (groupid=0, jobs=40): err= 0: pid=14225: Mon Dec  7 20:09:57 2020
    write: IOPS=3345k, BW=12.8GiB/s (13.7GB/s)(44.9TiB/3600002msec)
      slat (usec): min=2, max=90772, avg= 9.43, stdev=10.67
      clat (usec): min=2, max=91343, avg=371.79, stdev=119.52
       lat (usec): min=5, max=91358, avg=381.31, stdev=122.45
      clat percentiles (usec):
       |  1.00th=[  231],  5.00th=[  245], 10.00th=[  253], 20.00th=[  273],
       | 30.00th=[  293], 40.00th=[  322], 50.00th=[  351], 60.00th=[  388],
       | 70.00th=[  420], 80.00th=[  465], 90.00th=[  529], 95.00th=[  570],
       | 99.00th=[  644], 99.50th=[  676], 99.90th=[  750], 99.95th=[  783],
       | 99.99th=[  873]
     bw (  KiB/s): min=107333, max=749152, per=2.51%, avg=335200.07, stdev=87628.57, samples=288000
     iops        : min=26833, max=187286, avg=83799.66, stdev=21907.09, samples=288000
    lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%
    lat (usec)   : 250=8.04%, 500=6.79%, 750=13.75%, 1000=0.09%
    lat (msec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%
    lat (msec)   : 100=0.01%
    cpu          : usr=29.14%, sys=70.83%, ctx=320219, majf=0, minf=13056
    IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=28.7%, >=64=0.0%
       submit    : 0=0.0%, 4=28.7%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
       complete  : 0=0.0%, 4=28.7%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
       issued rwts: total=0,12042333583,0,0 short=0,0,0,0 dropped=0,0,0,0
       latency   : target=0, window=0, percentile=100.00%, depth=32

  Run status group 0 (all jobs):
    WRITE: bw=12.8GiB/s (13.7GB/s), 12.8GiB/s-12.8GiB/s (13.7GB/s-13.7GB/s), io=44.9TiB (49.3TB), run=3600002-3600002msec

  Disk stats (read/write):
    nvme5n1: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%

- Patched

  Jobs: 40 (f=40): [w(40)][100.0%][r=0KiB/s,w=12.9GiB/s][r=0,w=3383k IOPS][eta 00m:00s]
  test: (groupid=0, jobs=40): err= 0: pid=13413: Mon Dec  7 21:31:01 2020
    write: IOPS=3371k, BW=12.9GiB/s (13.8GB/s)(45.2TiB/3600004msec)
      slat (nsec): min=1984, max=90341k, avg=9308.73, stdev=7068.58
      clat (usec): min=2, max=91259, avg=368.94, stdev=118.31
       lat (usec): min=5, max=91269, avg=378.34, stdev=121.43
      clat percentiles (usec):
       |  1.00th=[  231],  5.00th=[  245], 10.00th=[  255], 20.00th=[  277],
       | 30.00th=[  302], 40.00th=[  318], 50.00th=[  334], 60.00th=[  359],
       | 70.00th=[  392], 80.00th=[  433], 90.00th=[  562], 95.00th=[  635],
       | 99.00th=[  693], 99.50th=[  709], 99.90th=[  766], 99.95th=[  816],
       | 99.99th=[  914]
     bw (  KiB/s): min=124304, max=770204, per=2.50%, avg=337559.07, stdev=91383.66, samples=287995
     iops        : min=31076, max=192551, avg=84389.45, stdev=22845.91, samples=287995
    lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%
    lat (usec)   : 250=7.44%, 500=7.84%, 750=13.79%, 1000=0.15%
    lat (msec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%
    lat (msec)   : 100=0.01%
    cpu          : usr=30.30%, sys=69.69%, ctx=179950, majf=0, minf=7403
    IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=29.2%, >=64=0.0%
       submit    : 0=0.0%, 4=29.2%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
       complete  : 0=0.0%, 4=29.2%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
       issued rwts: total=0,12135617715,0,0 short=0,0,0,0 dropped=0,0,0,0
       latency   : target=0, window=0, percentile=100.00%, depth=32

  Run status group 0 (all jobs):
    WRITE: bw=12.9GiB/s (13.8GB/s), 12.9GiB/s-12.9GiB/s (13.8GB/s-13.8GB/s), io=45.2TiB (49.7TB), run=3600004-3600004msec

  Disk stats (read/write):
    nvme1n1: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%

- Baseline

  nvme5c0n1 completed     411218 remote      38777 9.43%
  nvme5c0n2 completed          0 remote          0 0.00%
  nvme5c1n1 completed     411270 remote      38770 9.43%
  nvme5c1n2 completed         50 remote          0 0.00%
  nvme5c2n1 completed          0 remote          0 0.00%
  nvme5c2n2 completed          0 remote          0 0.00%
  nvme5c3n1 completed     411220 remote      38751 9.42%
  nvme5c3n2 completed          0 remote          0 0.00%
  nvme5c4n1 completed          0 remote          0 0.00%
  nvme5c4n2 completed          0 remote          0 0.00%
  nvme5c5n1 completed          0 remote          0 0.00%
  nvme5c5n2 completed          0 remote          0 0.00%
  nvme5c6n1 completed     411216 remote      38759 9.43%
  nvme5c6n2 completed          0 remote          0 0.00%
  nvme5c7n1 completed          0 remote          0 0.00%
  nvme5c7n2 completed          0 remote          0 0.00%

- Patched

  nvme1c0n1 completed          0 remote          0 0.00%
  nvme1c0n2 completed          0 remote          0 0.00%
  nvme1c1n1 completed     172202 remote      17813 10.34%
  nvme1c1n2 completed         50 remote          0 0.00%
  nvme1c2n1 completed     172147 remote      17831 10.36%
  nvme1c2n2 completed          0 remote          0 0.00%
  nvme1c3n1 completed          0 remote          0 0.00%
  nvme1c3n2 completed          0 remote          0 0.00%
  nvme1c4n1 completed     172159 remote      17825 10.35%
  nvme1c4n2 completed          0 remote          0 0.00%
  nvme1c5n1 completed          0 remote          0 0.00%
  nvme1c5n2 completed          0 remote          0 0.00%
  nvme1c6n1 completed          0 remote          0 0.00%
  nvme1c6n2 completed          0 remote          0 0.00%
  nvme1c7n1 completed     172156 remote      17781 10.33%
  nvme1c7n2 completed          0 remote          0 0.00%


It looks like the patched version show tiny bit better numbers for this
workload. slat seems to be one of the major difference between the two
runs. But that is the only thing I really spotted to be really off.

I keep going with some more testing. Let what kind of tests you would
also want to see. I'll do a few plain NVMe tests next.

Thanks,
Daniel
