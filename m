Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1525989567.28673.1.camel@redhat.com>
References: <20180505135905.18815-1-ming.lei@redhat.com> <1525561893.3082.1.camel@redhat.com>
 <20180510102828.GA32127@ming.t460p> <1525989567.28673.1.camel@redhat.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 11 May 2018 06:10:01 +0800
Message-ID: <CACVXFVPaXdqxy0ic91QibFniXEOLgGJ2tQATHaUZc2K5PkVA1Q@mail.gmail.com>
Subject: Re: [PATCH V4 0/7] nvme: pci: fix & improve timeout handling
To: Laurence Oberman <loberman@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Laurence,

Great thanks for your so quick test!

On Fri, May 11, 2018 at 5:59 AM, Laurence Oberman <loberman@redhat.com> wrote:
> On Thu, 2018-05-10 at 18:28 +0800, Ming Lei wrote:
>> On Sat, May 05, 2018 at 07:11:33PM -0400, Laurence Oberman wrote:
>> > On Sat, 2018-05-05 at 21:58 +0800, Ming Lei wrote:
>> > > Hi,
>> > >
>> > > The 1st patch introduces blk_quiesce_timeout() and
>> > > blk_unquiesce_timeout()
>> > > for NVMe, meantime fixes blk_sync_queue().
>> > >
>> > > The 2nd patch covers timeout for admin commands for recovering
>> > > controller
>> > > for avoiding possible deadlock.
>> > >
>> > > The 3rd and 4th patches avoid to wait_freeze on queues which
>> > > aren't
>> > > frozen.
>> > >
>> > > The last 4 patches fixes several races wrt. NVMe timeout handler,
>> > > and
>> > > finally can make blktests block/011 passed. Meantime the NVMe PCI
>> > > timeout
>> > > mecanism become much more rebost than before.
>> > >
>> > > gitweb:
>> > >   https://github.com/ming1/linux/commits/v4.17-rc-nvme-timeout.V4
>> > >
>> > > V4:
>> > >   - fixe nvme_init_set_host_mem_cmd()
>> > >   - use nested EH model, and run both nvme_dev_disable() and
>> > >   resetting in one same context
>> > >
>> > > V3:
>> > >   - fix one new race related freezing in patch 4,
>> > > nvme_reset_work()
>> > >   may hang forever without this patch
>> > >   - rewrite the last 3 patches, and avoid to break
>> > > nvme_reset_ctrl*()
>> > >
>> > > V2:
>> > >   - fix draining timeout work, so no need to change return value
>> > > from
>> > >   .timeout()
>> > >   - fix race between nvme_start_freeze() and nvme_unfreeze()
>> > >   - cover timeout for admin commands running in EH
>> > >
>> > > Ming Lei (7):
>> > >   block: introduce blk_quiesce_timeout() and
>> > > blk_unquiesce_timeout()
>> > >   nvme: pci: cover timeout for admin commands running in EH
>> > >   nvme: pci: only wait freezing if queue is frozen
>> > >   nvme: pci: freeze queue in nvme_dev_disable() in case of error
>> > >     recovery
>> > >   nvme: core: introduce 'reset_lock' for sync reset state and
>> > > reset
>> > >     activities
>> > >   nvme: pci: prepare for supporting error recovery from resetting
>> > >     context
>> > >   nvme: pci: support nested EH
>> > >
>> > >  block/blk-core.c         |  21 +++-
>> > >  block/blk-mq.c           |   9 ++
>> > >  block/blk-timeout.c      |   5 +-
>> > >  drivers/nvme/host/core.c |  46 ++++++-
>> > >  drivers/nvme/host/nvme.h |   5 +
>> > >  drivers/nvme/host/pci.c  | 304
>> > > ++++++++++++++++++++++++++++++++++++++++-------
>> > >  include/linux/blkdev.h   |  13 ++
>> > >  7 files changed, 356 insertions(+), 47 deletions(-)
>> > >
>> > > Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
>> > > Cc: Christoph Hellwig <hch@lst.de>
>> > > Cc: Sagi Grimberg <sagi@grimberg.me>
>> > > Cc: linux-nvme@lists.infradead.org
>> > > Cc: Laurence Oberman <loberman@redhat.com>
>> >
>> > Hello Ming
>> >
>> > I have a two node NUMA system here running your kernel tree
>> > 4.17.0-rc3.ming.nvme+
>> >
>> > [root@segstorage1 ~]# numactl --hardware
>> > available: 2 nodes (0-1)
>> > node 0 cpus: 0 3 5 6 8 11 13 14
>> > node 0 size: 63922 MB
>> > node 0 free: 61310 MB
>> > node 1 cpus: 1 2 4 7 9 10 12 15
>> > node 1 size: 64422 MB
>> > node 1 free: 62372 MB
>> > node distances:
>> > node   0   1
>> >   0:  10  20
>> >   1:  20  10
>> >
>> > I ran block/011
>> >
>> > [root@segstorage1 blktests]# ./check block/011
>> > block/011 => nvme0n1 (disable PCI device while doing
>> > I/O)    [failed]
>> >     runtime    ...  106.936s
>> >     --- tests/block/011.out 2018-05-05 18:01:14.268414752
>> > -0400
>> >     +++ results/nvme0n1/block/011.out.bad   2018-05-05
>> > 19:07:21.028634858 -0400
>> >     @@ -1,2 +1,36 @@
>> >      Running block/011
>> >     +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
>> > IO_U_F_FLIGHT) == 0' failed.
>> >     +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
>> > IO_U_F_FLIGHT) == 0' failed.
>> >     +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
>> > IO_U_F_FLIGHT) == 0' failed.
>> >     +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
>> > IO_U_F_FLIGHT) == 0' failed.
>> >     +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
>> > IO_U_F_FLIGHT) == 0' failed.
>> >     +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
>> > IO_U_F_FLIGHT) == 0' failed.
>> >     ...
>> >     (Run 'diff -u tests/block/011.out
>> > results/nvme0n1/block/011.out.bad' to see the entire diff)
>> >
>> > [ 1421.738551] run blktests block/011 at 2018-05-05 19:05:34
>> > [ 1452.676351] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1452.718221] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1452.718239] nvme nvme0: EH 0: before shutdown
>> > [ 1452.760890] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1452.760894] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1452.760897] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1452.760900] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1452.760903] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1452.760906] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1452.760909] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1452.760912] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1452.760915] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1452.760918] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1452.760921] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1452.760923] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1452.760926] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1453.330251] nvme nvme0: controller is down; will reset:
>> > CSTS=0x3,
>> > PCI_STATUS=0x10
>> > [ 1453.391713] nvme nvme0: EH 0: after shutdown
>> > [ 1456.804695] device-mapper: multipath: Failing path 259:0.
>> > [ 1526.721196] nvme nvme0: I/O 15 QID 0 timeout, disable controller
>> > [ 1526.754335] nvme nvme0: EH 1: before shutdown
>> > [ 1526.793257] nvme nvme0: EH 1: after shutdown
>> > [ 1526.793327] nvme nvme0: Identify Controller failed (-4)
>> > [ 1526.847869] nvme nvme0: Removing after probe failure status: -5
>> > [ 1526.888206] nvme nvme0: EH 0: after recovery
>> > [ 1526.888212] nvme0n1: detected capacity change from 400088457216
>> > to 0
>> > [ 1526.947520] print_req_error: 1 callbacks suppressed
>> > [ 1526.947522] print_req_error: I/O error, dev nvme0n1, sector
>> > 794920
>> > [ 1526.947534] print_req_error: I/O error, dev nvme0n1, sector
>> > 569328
>> > [ 1526.947540] print_req_error: I/O error, dev nvme0n1, sector
>> > 1234608
>> > [ 1526.947556] print_req_error: I/O error, dev nvme0n1, sector
>> > 389296
>> > [ 1526.947564] print_req_error: I/O error, dev nvme0n1, sector
>> > 712432
>> > [ 1526.947566] print_req_error: I/O error, dev nvme0n1, sector
>> > 889304
>> > [ 1526.947572] print_req_error: I/O error, dev nvme0n1, sector
>> > 205776
>> > [ 1526.947574] print_req_error: I/O error, dev nvme0n1, sector
>> > 126480
>> > [ 1526.947575] print_req_error: I/O error, dev nvme0n1, sector
>> > 1601232
>> > [ 1526.947580] print_req_error: I/O error, dev nvme0n1, sector
>> > 1234360
>> > [ 1526.947745] Pid 683(fio) over core_pipe_limit
>> > [ 1526.947746] Skipping core dump
>> > [ 1526.947747] Pid 675(fio) over core_pipe_limit
>> > [ 1526.947748] Skipping core dump
>> > [ 1526.947863] Pid 672(fio) over core_pipe_limit
>> > [ 1526.947863] Skipping core dump
>> > [ 1526.947865] Pid 674(fio) over core_pipe_limit
>> > [ 1526.947866] Skipping core dump
>> > [ 1526.947870] Pid 676(fio) over core_pipe_limit
>> > [ 1526.947871] Pid 679(fio) over core_pipe_limit
>> > [ 1526.947872] Skipping core dump
>> > [ 1526.947872] Skipping core dump
>> > [ 1526.948197] Pid 677(fio) over core_pipe_limit
>> > [ 1526.948197] Skipping core dump
>> > [ 1526.948245] Pid 686(fio) over core_pipe_limit
>> > [ 1526.948245] Skipping core dump
>> > [ 1526.974610] Pid 680(fio) over core_pipe_limit
>> > [ 1526.974611] Pid 684(fio) over core_pipe_limit
>> > [ 1526.974611] Skipping core dump
>> > [ 1526.980370] nvme nvme0: failed to mark controller CONNECTING
>> > [ 1526.980373] nvme nvme0: Removing after probe failure status: -19
>> > [ 1526.980385] nvme nvme0: EH 1: after recovery
>> > [ 1526.980477] Pid 687(fio) over core_pipe_limit
>> > [ 1526.980478] Skipping core dump
>> > [ 1527.858207] Skipping core dump
>> >
>> > And leaves me looping here
>> >
>> > [ 1721.272276] INFO: task kworker/u66:0:24214 blocked for more than
>> > 120
>> > seconds.
>> > [ 1721.311263]       Tainted: G          I       4.17.0-
>> > rc3.ming.nvme+
>> > #1
>> > [ 1721.348027] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> > disables this message.
>> > [ 1721.392957] kworker/u66:0   D    0 24214      2 0x80000080
>> > [ 1721.424425] Workqueue: nvme-wq nvme_remove_dead_ctrl_work [nvme]
>> > [ 1721.458568] Call Trace:
>> > [ 1721.472499]  ? __schedule+0x290/0x870
>> > [ 1721.493515]  schedule+0x32/0x80
>> > [ 1721.511656]  blk_mq_freeze_queue_wait+0x46/0xb0
>> > [ 1721.537609]  ? remove_wait_queue+0x60/0x60
>> > [ 1721.561081]  blk_cleanup_queue+0x7e/0x180
>> > [ 1721.584637]  nvme_ns_remove+0x106/0x140 [nvme_core]
>> > [ 1721.612589]  nvme_remove_namespaces+0x8e/0xd0 [nvme_core]
>> > [ 1721.643163]  nvme_remove+0x80/0x120 [nvme]
>> > [ 1721.666188]  pci_device_remove+0x3b/0xc0
>> > [ 1721.688553]  device_release_driver_internal+0x148/0x220
>> > [ 1721.719332]  nvme_remove_dead_ctrl_work+0x29/0x40 [nvme]
>> > [ 1721.750474]  process_one_work+0x158/0x360
>> > [ 1721.772632]  worker_thread+0x47/0x3e0
>> > [ 1721.792471]  kthread+0xf8/0x130
>> > [ 1721.810354]  ? max_active_store+0x80/0x80
>> > [ 1721.832459]  ? kthread_bind+0x10/0x10
>> > [ 1721.852845]  ret_from_fork+0x35/0x40
>> >
>> > Did I di something wrong
>> >
>> > I never set anything else, the nvme0n1 was not mounted etc.
>>
>> Hi Laurence,
>>
>> Thanks for your test!
>>
>> Could you run the following V5(not posted yest) and see if
>> the issues you triggered can be fixed? If not, please provide
>> me the dmesg log.
>>
>> https://github.com/ming1/linux/commits/v4.17-rc-nvme-timeout.V5
>>
>> BTW, the main change is on handling reset failure, in V5, only
>> the failure from top EH is handled.
>>
>> Thanks,
>> Ming
>
> Hello Ming
>
> Seems better , had a failure on first test but no panics.
> Following tests have all passed
>
> root@segstorage1 blktests]# ./check block/011
> block/011 => nvme0n1 (disable PCI device while doing I/O)    [failed]
>     runtime  41.790s  ...  79.184s
>     --- tests/block/011.out     2018-05-05 18:01:14.268414752 -0400
>     +++ results/nvme0n1/block/011.out.bad       2018-05-10
> 17:48:34.792080746 -0400
>     @@ -1,2 +1,3 @@
>      Running block/011
>     +tests/block/011: line 47: echo: write error: Input/output error
>      Test complete

This is expected result, since it is possible for request completed
as error finally after retrying 5 times.

I will post out V5 soon.

> [root@segstorage1 blktests]# ./check block/011
> block/011 => nvme0n1 (disable PCI device while doing I/O)    [passed]
>     runtime  79.184s  ...  42.196s
> [root@segstorage1 blktests]# ./check block/011
> block/011 => nvme0n1 (disable PCI device while doing I/O)    [passed]
>     runtime  42.196s  ...  41.390s
> [root@segstorage1 blktests]# ./check block/011
> block/011 => nvme0n1 (disable PCI device while doing I/O)    [passed]
>     runtime  41.390s  ...  42.193s
>
> Kernel 4.17.0-rc3.ming.v5+ on an x86_64
>
> segstorage1 login: [  631.297687] run blktests block/011 at 2018-05-10
> 17:47:15
> [  661.951541] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  661.990218] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  661.990257] nvme nvme0: EH 0: before shutdown
> [  662.031388] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  662.031395] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  662.031398] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  662.031402] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  662.031405] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  662.031409] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  662.031412] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  662.031416] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  662.031420] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  662.436080] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  662.477826] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  662.519368] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  662.560755] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  662.602456] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [  662.657904] nvme nvme0: EH 0: after shutdown
> [  668.730405] nvme nvme0: EH 0: after recovery 0
> [  738.859987] run blktests block/011 at 2018-05-10 17:49:03
> [  810.586431] run blktests block/011 at 2018-05-10 17:50:14
> [ 1065.694108] run blktests block/011 at 2018-05-10 17:54:29



Thanks,
Ming Lei
