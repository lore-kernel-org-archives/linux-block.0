Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbdHHJKC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Aug 2017 05:10:02 -0400
Date: Tue, 8 Aug 2017 17:09:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V2 00/20] blk-mq-sched: improve SCSI-MQ performance
Message-ID: <20170808090938.GA19390@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <C4CCF877-AEAD-4E8E-A728-002D0A8FE3EA@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C4CCF877-AEAD-4E8E-A728-002D0A8FE3EA@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 08, 2017 at 10:09:57AM +0200, Paolo Valente wrote:
> 
> > Il giorno 05 ago 2017, alle ore 08:56, Ming Lei <ming.lei@redhat.com> ha scritto:
> > 
> > In Red Hat internal storage test wrt. blk-mq scheduler, we
> > found that I/O performance is much bad with mq-deadline, especially
> > about sequential I/O on some multi-queue SCSI devcies(lpfc, qla2xxx,
> > SRP...)
> > 
> > Turns out one big issue causes the performance regression: requests
> > are still dequeued from sw queue/scheduler queue even when ldd's
> > queue is busy, so I/O merge becomes quite difficult to make, then
> > sequential IO degrades a lot.
> > 
> > The 1st five patches improve this situation, and brings back
> > some performance loss.
> > 
> > But looks they are still not enough. It is caused by
> > the shared queue depth among all hw queues. For SCSI devices,
> > .cmd_per_lun defines the max number of pending I/O on one
> > request queue, which is per-request_queue depth. So during
> > dispatch, if one hctx is too busy to move on, all hctxs can't
> > dispatch too because of the per-request_queue depth.
> > 
> > Patch 6 ~ 14 use per-request_queue dispatch list to avoid
> > to dequeue requests from sw/scheduler queue when lld queue
> > is busy.
> > 
> > Patch 15 ~20 improve bio merge via hash table in sw queue,
> > which makes bio merge more efficient than current approch
> > in which only the last 8 requests are checked. Since patch
> > 6~14 converts to the scheduler way of dequeuing one request
> > from sw queue one time for SCSI device, and the times of
> > acquring ctx->lock is increased, and merging bio via hash
> > table decreases holding time of ctx->lock and should eliminate
> > effect from patch 14. 
> > 
> > With this changes, SCSI-MQ sequential I/O performance is
> > improved much, for lpfc, it is basically brought back
> > compared with block legacy path[1], especially mq-deadline
> > is improved by > X10 [1] on lpfc and by > 3X on SCSI SRP,
> > For mq-none it is improved by 10% on lpfc, and write is
> > improved by > 10% on SRP too.
> > 
> > Also Bart worried that this patchset may affect SRP, so provide
> > test data on SCSI SRP this time:
> > 
> > - fio(libaio, bs:4k, dio, queue_depth:64, 64 jobs)
> > - system(16 cores, dual sockets, mem: 96G)
> > 
> >              |v4.13-rc3     |v4.13-rc3     | v4.13-rc3+patches |
> >              |blk-legacy dd |blk-mq none   | blk-mq none  |
> > -----------------------------------------------------------|  
> > read     :iops|         587K |         526K |         537K |
> > randread :iops|         115K |         140K |         139K |
> > write    :iops|         596K |         519K |         602K |
> > randwrite:iops|         103K |         122K |         120K |
> > 
> > 
> >              |v4.13-rc3     |v4.13-rc3     | v4.13-rc3+patches
> >              |blk-legacy dd |blk-mq dd     | blk-mq dd    |
> > ------------------------------------------------------------
> > read     :iops|         587K |         155K |         522K |
> > randread :iops|         115K |         140K |         141K |
> > write    :iops|         596K |         135K |         587K |
> > randwrite:iops|         103K |         120K |         118K |
> > 
> > V2:
> > 	- dequeue request from sw queues in round roubin's style
> > 	as suggested by Bart, and introduces one helper in sbitmap
> > 	for this purpose
> > 	- improve bio merge via hash table from sw queue
> > 	- add comments about using DISPATCH_BUSY state in lockless way,
> > 	simplifying handling on busy state,
> > 	- hold ctx->lock when clearing ctx busy bit as suggested
> > 	by Bart
> > 
> > 
> 
> Hi,
> I've performance-tested Ming's patchset with the dbench4 test in
> MMTests, and with the mq-deadline and bfq schedulers.  Max latencies,
> have decreased dramatically: up to 32 times.  Very good results for
> average latencies as well.
> 
> For brevity, here are only results for deadline.  You can find full
> results with bfq in the thread that triggered my testing of Ming's
> patches [1].
> 
> MQ-DEADLINE WITHOUT MING'S PATCHES
> 
>  Operation                Count    AvgLat    MaxLat
>  --------------------------------------------------
>  Flush                    13760    90.542 13221.495
>  Close                   137654     0.008    27.133
>  LockX                      640     0.009     0.115
>  Rename                    8064     1.062   246.759
>  ReadX                   297956     0.051   347.018
>  WriteX                   94698   425.636 15090.020
>  Unlink                   35077     0.580   208.462
>  UnlockX                    640     0.007     0.291
>  FIND_FIRST               66630     0.566   530.339
>  SET_FILE_INFORMATION     16000     1.419   811.494
>  QUERY_FILE_INFORMATION   30717     0.004     1.108
>  QUERY_PATH_INFORMATION  176153     0.182   517.419
>  QUERY_FS_INFORMATION     30857     0.018    18.562
>  NTCreateX               184145     0.281   582.076
> 
> Throughput 8.93961 MB/sec  64 clients  64 procs  max_latency=15090.026 ms
> 
> MQ-DEADLINE WITH MING'S PATCHES
> 
>  Operation                Count    AvgLat    MaxLat
>  --------------------------------------------------
>  Flush                    13760    48.650   431.525
>  Close                   144320     0.004     7.605
>  LockX                      640     0.005     0.019
>  Rename                    8320     0.187     5.702
>  ReadX                   309248     0.023   216.220
>  WriteX                   97176   338.961  5464.995
>  Unlink                   39744     0.454   315.207
>  UnlockX                    640     0.004     0.027
>  FIND_FIRST               69184     0.042    17.648
>  SET_FILE_INFORMATION     16128     0.113   134.464
>  QUERY_FILE_INFORMATION   31104     0.004     0.370
>  QUERY_PATH_INFORMATION  187136     0.031   168.554
>  QUERY_FS_INFORMATION     33024     0.009     2.915
>  NTCreateX               196672     0.152   163.835

Hi Paolo,

Thanks very much for testing this patchset!

BTW, could you share us which kind of disk you are using
in this test?

Thanks,
Ming
