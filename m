Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33012 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753318AbdIDJMx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Sep 2017 05:12:53 -0400
Received: by mail-wr0-f178.google.com with SMTP id b9so4398343wra.0
        for <linux-block@vger.kernel.org>; Mon, 04 Sep 2017 02:12:52 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V4 00/14] blk-mq-sched: improve SCSI-MQ performance
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170902151729.6162-1-ming.lei@redhat.com>
Date: Mon, 4 Sep 2017 11:12:49 +0200
Cc: Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Message-Id: <C23AE9D4-3F8B-4268-9FC9-ECDAE7231224@linaro.org>
References: <20170902151729.6162-1-ming.lei@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 02 set 2017, alle ore 17:17, Ming Lei <ming.lei@redhat.com> =
ha scritto:
>=20
> Hi,
>=20
> In Red Hat internal storage test wrt. blk-mq scheduler, we
> found that I/O performance is much bad with mq-deadline, especially
> about sequential I/O on some multi-queue SCSI devcies(lpfc, qla2xxx,
> SRP...)
>=20
> Turns out one big issue causes the performance regression: requests
> are still dequeued from sw queue/scheduler queue even when ldd's
> queue is busy, so I/O merge becomes quite difficult to make, then
> sequential IO degrades a lot.
>=20
> The 1st five patches improve this situation, and brings back
> some performance loss.
>=20
> Patch 6 ~ 7 uses q->queue_depth as hint for setting up
> scheduler queue depth.
>=20
> Patch 8 ~ 15 improve bio merge via hash table in sw queue,
> which makes bio merge more efficient than current approch
> in which only the last 8 requests are checked. Since patch
> 6~14 converts to the scheduler way of dequeuing one request
> from sw queue one time for SCSI device, and the times of
> acquring ctx->lock is increased, and merging bio via hash
> table decreases holding time of ctx->lock and should eliminate
> effect from patch 14.=20
>=20
> With this changes, SCSI-MQ sequential I/O performance is
> improved much, Paolo reported that mq-deadline performance
> improved much[2] in his dbench test wrt V2. Also performanc
> improvement on lpfc/qla2xx was observed with V1.[1]
>=20
> Also Bart worried that this patchset may affect SRP, so provide
> test data on SCSI SRP this time:
>=20
> - fio(libaio, bs:4k, dio, queue_depth:64, 64 jobs)
> - system(16 cores, dual sockets, mem: 96G)
>=20
>          |v4.13-rc6+*  |v4.13-rc6+   | patched v4.13-rc6+=20
> -----------------------------------------------------
> IOPS(K)  |  DEADLINE   |    NONE     |    NONE    =20
> -----------------------------------------------------
> read      |      587.81 |      511.96 |      518.51=20
> -----------------------------------------------------
> randread  |      116.44 |      142.99 |      142.46=20
> -----------------------------------------------------
> write     |      580.87 |       536.4 |      582.15=20
> -----------------------------------------------------
> randwrite |      104.95 |      124.89 |      123.99=20
> -----------------------------------------------------
>=20
>=20
>          |v4.13-rc6+   |v4.13-rc6+   | patched v4.13-rc6+=20
> -----------------------------------------------------
> IOPS(K)  |  DEADLINE   |MQ-DEADLINE  |MQ-DEADLINE =20
> -----------------------------------------------------
> read      |      587.81 |       158.7 |      450.41=20
> -----------------------------------------------------
> randread  |      116.44 |      142.04 |      142.72=20
> -----------------------------------------------------
> write     |      580.87 |      136.61 |      569.37=20
> -----------------------------------------------------
> randwrite |      104.95 |      123.14 |      124.36=20
> -----------------------------------------------------
>=20
> *: v4.13-rc6+ means v4.13-rc6 with block for-next
>=20
>=20
> Please consider to merge to V4.4.
>=20
> [1] http://marc.info/?l=3Dlinux-block&m=3D150151989915776&w=3D2
> [2] https://marc.info/?l=3Dlinux-block&m=3D150217980602843&w=3D2
>=20
> V4:
> 	- add Reviewed-by tag
> 	- some trival change: typo fix in commit log or comment,
> 	variable name, no actual functional change
>=20
> V3:
> 	- totally round robin for picking req from ctx, as suggested
> 	by Bart
> 	- remove one local variable in __sbitmap_for_each_set()
> 	- drop patches of single dispatch list, which can improve
> 	performance on mq-deadline, but cause a bit degrade on
> 	none because all hctxs need to be checked after ->dispatch
> 	is flushed. Will post it again once it is mature.
> 	- rebase on v4.13-rc6 with block for-next
>=20
> V2:
> 	- dequeue request from sw queues in round roubin's style
> 	as suggested by Bart, and introduces one helper in sbitmap
> 	for this purpose
> 	- improve bio merge via hash table from sw queue
> 	- add comments about using DISPATCH_BUSY state in lockless way,
> 	simplifying handling on busy state,
> 	- hold ctx->lock when clearing ctx busy bit as suggested
> 	by Bart
>=20
>=20

Tested-by: Paolo Valente <paolo.valente@linaro.org>

> Ming Lei (14):
>  blk-mq-sched: fix scheduler bad performance
>  sbitmap: introduce __sbitmap_for_each_set()
>  blk-mq: introduce blk_mq_dispatch_rq_from_ctx()
>  blk-mq-sched: move actual dispatching into one helper
>  blk-mq-sched: improve dispatching from sw queue
>  blk-mq-sched: don't dequeue request until all in ->dispatch are
>    flushed
>  blk-mq-sched: introduce blk_mq_sched_queue_depth()
>  blk-mq-sched: use q->queue_depth as hint for q->nr_requests
>  block: introduce rqhash helpers
>  block: move actual bio merge code into __elv_merge
>  block: add check on elevator for supporting bio merge via hashtable
>    from blk-mq sw queue
>  block: introduce .last_merge and .hash to blk_mq_ctx
>  blk-mq-sched: refactor blk_mq_sched_try_merge()
>  blk-mq: improve bio merge from blk-mq sw queue
>=20
> block/blk-mq-debugfs.c  |   1 +
> block/blk-mq-sched.c    | 186 =
+++++++++++++++++++++++++++++++-----------------
> block/blk-mq-sched.h    |  23 ++++++
> block/blk-mq.c          |  93 +++++++++++++++++++++++-
> block/blk-mq.h          |   7 ++
> block/blk-settings.c    |   2 +
> block/blk.h             |  55 ++++++++++++++
> block/elevator.c        |  93 ++++++++++++++----------
> include/linux/blk-mq.h  |   3 +
> include/linux/sbitmap.h |  54 ++++++++++----
> 10 files changed, 399 insertions(+), 118 deletions(-)
>=20
> --=20
> 2.9.5
>=20
