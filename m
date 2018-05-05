Return-Path: <loberman@redhat.com>
Return-Path: <loberman@redhat.com>
Message-ID: <1525563110.4007.1.camel@redhat.com>
Subject: Re: [PATCH V4 0/7] nvme: pci: fix & improve timeout handling
From: Laurence Oberman <loberman@redhat.com>
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Jianchao Wang
 <jianchao.w.wang@oracle.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Date: Sat, 05 May 2018 19:31:50 -0400
In-Reply-To: <1525561893.3082.1.camel@redhat.com>
References: <20180505135905.18815-1-ming.lei@redhat.com>
	 <1525561893.3082.1.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sat, 2018-05-05 at 19:11 -0400, Laurence Oberman wrote:
> On Sat, 2018-05-05 at 21:58 +0800, Ming Lei wrote:
> > Hi,
> > 
> > The 1st patch introduces blk_quiesce_timeout() and
> > blk_unquiesce_timeout()
> > for NVMe, meantime fixes blk_sync_queue().
> > 
> > The 2nd patch covers timeout for admin commands for recovering
> > controller
> > for avoiding possible deadlock.
> > 
> > The 3rd and 4th patches avoid to wait_freeze on queues which aren't
> > frozen.
> > 
> > The last 4 patches fixes several races wrt. NVMe timeout handler,
> > and
> > finally can make blktests block/011 passed. Meantime the NVMe PCI
> > timeout
> > mecanism become much more rebost than before.
> > 
> > gitweb:
> > 	https://github.com/ming1/linux/commits/v4.17-rc-nvme-timeout.V4
> > 
> > V4:
> > 	- fixe nvme_init_set_host_mem_cmd()
> > 	- use nested EH model, and run both nvme_dev_disable() and
> > 	resetting in one same context
> > 
> > V3:
> > 	- fix one new race related freezing in patch 4,
> > nvme_reset_work()
> > 	may hang forever without this patch
> > 	- rewrite the last 3 patches, and avoid to break
> > nvme_reset_ctrl*()
> > 
> > V2:
> > 	- fix draining timeout work, so no need to change return value
> > from
> > 	.timeout()
> > 	- fix race between nvme_start_freeze() and nvme_unfreeze()
> > 	- cover timeout for admin commands running in EH
> > 
> > Ming Lei (7):
> >   block: introduce blk_quiesce_timeout() and
> > blk_unquiesce_timeout()
> >   nvme: pci: cover timeout for admin commands running in EH
> >   nvme: pci: only wait freezing if queue is frozen
> >   nvme: pci: freeze queue in nvme_dev_disable() in case of error
> >     recovery
> >   nvme: core: introduce 'reset_lock' for sync reset state and reset
> >     activities
> >   nvme: pci: prepare for supporting error recovery from resetting
> >     context
> >   nvme: pci: support nested EH
> > 
> >  block/blk-core.c         |  21 +++-
> >  block/blk-mq.c           |   9 ++
> >  block/blk-timeout.c      |   5 +-
> >  drivers/nvme/host/core.c |  46 ++++++-
> >  drivers/nvme/host/nvme.h |   5 +
> >  drivers/nvme/host/pci.c  | 304
> > ++++++++++++++++++++++++++++++++++++++++-------
> >  include/linux/blkdev.h   |  13 ++
> >  7 files changed, 356 insertions(+), 47 deletions(-)
> > 
> > Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: linux-nvme@lists.infradead.org
> > Cc: Laurence Oberman <loberman@redhat.com>
> 
> Hello Ming
> 
> I have a two node NUMA system here running your kernel tree
> 4.17.0-rc3.ming.nvme+
> 
> [root@segstorage1 ~]# numactl --hardware
> available: 2 nodes (0-1)
> node 0 cpus: 0 3 5 6 8 11 13 14
> node 0 size: 63922 MB
> node 0 free: 61310 MB
> node 1 cpus: 1 2 4 7 9 10 12 15
> node 1 size: 64422 MB
> node 1 free: 62372 MB
> node distances:
> node   0   1 
>   0:  10  20 
>   1:  20  10 
> 
> I ran block/011
> 
> [root@segstorage1 blktests]# ./check block/011
> block/011 => nvme0n1 (disable PCI device while doing I/O)    [failed]
>     runtime    ...  106.936s
>     --- tests/block/011.out	2018-05-05 18:01:14.268414752
> -0400
>     +++ results/nvme0n1/block/011.out.bad	2018-05-05
> 19:07:21.028634858 -0400
>     @@ -1,2 +1,36 @@
>      Running block/011
>     +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
> IO_U_F_FLIGHT) == 0' failed.
>     +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
> IO_U_F_FLIGHT) == 0' failed.
>     +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
> IO_U_F_FLIGHT) == 0' failed.
>     +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
> IO_U_F_FLIGHT) == 0' failed.
>     +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
> IO_U_F_FLIGHT) == 0' failed.
>     +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
> IO_U_F_FLIGHT) == 0' failed.
>     ...
>     (Run 'diff -u tests/block/011.out
> results/nvme0n1/block/011.out.bad' to see the entire diff)
> 
> [ 1421.738551] run blktests block/011 at 2018-05-05 19:05:34
> [ 1452.676351] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1452.718221] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1452.718239] nvme nvme0: EH 0: before shutdown
> [ 1452.760890] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1452.760894] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1452.760897] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1452.760900] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1452.760903] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1452.760906] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1452.760909] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1452.760912] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1452.760915] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1452.760918] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1452.760921] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1452.760923] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1452.760926] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1453.330251] nvme nvme0: controller is down; will reset: CSTS=0x3,
> PCI_STATUS=0x10
> [ 1453.391713] nvme nvme0: EH 0: after shutdown
> [ 1456.804695] device-mapper: multipath: Failing path 259:0.
> [ 1526.721196] nvme nvme0: I/O 15 QID 0 timeout, disable controller
> [ 1526.754335] nvme nvme0: EH 1: before shutdown
> [ 1526.793257] nvme nvme0: EH 1: after shutdown
> [ 1526.793327] nvme nvme0: Identify Controller failed (-4)
> [ 1526.847869] nvme nvme0: Removing after probe failure status: -5
> [ 1526.888206] nvme nvme0: EH 0: after recovery
> [ 1526.888212] nvme0n1: detected capacity change from 400088457216 to
> 0
> [ 1526.947520] print_req_error: 1 callbacks suppressed
> [ 1526.947522] print_req_error: I/O error, dev nvme0n1, sector 794920
> [ 1526.947534] print_req_error: I/O error, dev nvme0n1, sector 569328
> [ 1526.947540] print_req_error: I/O error, dev nvme0n1, sector
> 1234608
> [ 1526.947556] print_req_error: I/O error, dev nvme0n1, sector 389296
> [ 1526.947564] print_req_error: I/O error, dev nvme0n1, sector 712432
> [ 1526.947566] print_req_error: I/O error, dev nvme0n1, sector 889304
> [ 1526.947572] print_req_error: I/O error, dev nvme0n1, sector 205776
> [ 1526.947574] print_req_error: I/O error, dev nvme0n1, sector 126480
> [ 1526.947575] print_req_error: I/O error, dev nvme0n1, sector
> 1601232
> [ 1526.947580] print_req_error: I/O error, dev nvme0n1, sector
> 1234360
> [ 1526.947745] Pid 683(fio) over core_pipe_limit
> [ 1526.947746] Skipping core dump
> [ 1526.947747] Pid 675(fio) over core_pipe_limit
> [ 1526.947748] Skipping core dump
> [ 1526.947863] Pid 672(fio) over core_pipe_limit
> [ 1526.947863] Skipping core dump
> [ 1526.947865] Pid 674(fio) over core_pipe_limit
> [ 1526.947866] Skipping core dump
> [ 1526.947870] Pid 676(fio) over core_pipe_limit
> [ 1526.947871] Pid 679(fio) over core_pipe_limit
> [ 1526.947872] Skipping core dump
> [ 1526.947872] Skipping core dump
> [ 1526.948197] Pid 677(fio) over core_pipe_limit
> [ 1526.948197] Skipping core dump
> [ 1526.948245] Pid 686(fio) over core_pipe_limit
> [ 1526.948245] Skipping core dump
> [ 1526.974610] Pid 680(fio) over core_pipe_limit
> [ 1526.974611] Pid 684(fio) over core_pipe_limit
> [ 1526.974611] Skipping core dump
> [ 1526.980370] nvme nvme0: failed to mark controller CONNECTING
> [ 1526.980373] nvme nvme0: Removing after probe failure status: -19
> [ 1526.980385] nvme nvme0: EH 1: after recovery
> [ 1526.980477] Pid 687(fio) over core_pipe_limit
> [ 1526.980478] Skipping core dump
> [ 1527.858207] Skipping core dump
> 
> And leaves me looping here
> 
> [ 1721.272276] INFO: task kworker/u66:0:24214 blocked for more than
> 120
> seconds.
> [ 1721.311263]       Tainted: G          I       4.17.0-
> rc3.ming.nvme+
> #1
> [ 1721.348027] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 1721.392957] kworker/u66:0   D    0 24214      2 0x80000080
> [ 1721.424425] Workqueue: nvme-wq nvme_remove_dead_ctrl_work [nvme]
> [ 1721.458568] Call Trace:
> [ 1721.472499]  ? __schedule+0x290/0x870
> [ 1721.493515]  schedule+0x32/0x80
> [ 1721.511656]  blk_mq_freeze_queue_wait+0x46/0xb0
> [ 1721.537609]  ? remove_wait_queue+0x60/0x60
> [ 1721.561081]  blk_cleanup_queue+0x7e/0x180
> [ 1721.584637]  nvme_ns_remove+0x106/0x140 [nvme_core]
> [ 1721.612589]  nvme_remove_namespaces+0x8e/0xd0 [nvme_core]
> [ 1721.643163]  nvme_remove+0x80/0x120 [nvme]
> [ 1721.666188]  pci_device_remove+0x3b/0xc0
> [ 1721.688553]  device_release_driver_internal+0x148/0x220
> [ 1721.719332]  nvme_remove_dead_ctrl_work+0x29/0x40 [nvme]
> [ 1721.750474]  process_one_work+0x158/0x360
> [ 1721.772632]  worker_thread+0x47/0x3e0
> [ 1721.792471]  kthread+0xf8/0x130
> [ 1721.810354]  ? max_active_store+0x80/0x80
> [ 1721.832459]  ? kthread_bind+0x10/0x10
> [ 1721.852845]  ret_from_fork+0x35/0x40
> 
> Did I di something wrong
> 
> I never set anything else, the nvme0n1 was not mounted etc.
> 
> Thanks
> Laurence

Second attempt same issue and this time we panicked

[root@segstorage1 blktests]# ./check block/011
block/011 => nvme0n1 (disable PCI device while doing I/O)    [failed]
    runtime    ...  106.936s
    --- tests/block/011.out	2018-05-05 18:01:14.268414752 -0400
    +++ results/nvme0n1/block/011.out.bad	2018-05-05
19:07:21.028634858 -0400
    @@ -1,2 +1,36 @@
     Running block/011
    +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
IO_U_F_FLIGHT) == 0' failed.
    +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
IO_U_F_FLIGHT) == 0' failed.
    +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
IO_U_F_FLIGHT) == 0' failed.
    +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
IO_U_F_FLIGHT) == 0' failed.
    +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
IO_U_F_FLIGHT) == 0' failed.
    +fio: ioengines.c:289: td_io_queue: Assertion `(io_u->flags &
IO_U_F_FLIGHT) == 0' failed.
    ...
    (Run 'diff -u tests/block/011.out
results/nvme0n1/block/011.out.bad' to see the entire diff)

[  387.483279] run blktests block/011 at 2018-05-05 19:27:33
[  418.076690] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.117901] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.117929] nvme nvme0: EH 0: before shutdown
[  418.158827] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.158830] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.158833] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.158836] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.158838] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.158841] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.158844] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.158847] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.158849] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.158852] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.158855] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.158858] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.158861] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.158863] nvme nvme0: controller is down; will reset: CSTS=0x3,
PCI_STATUS=0x10
[  418.785063] nvme nvme0: EH 0: after shutdown
[  420.708723] device-mapper: multipath: Failing path 259:0.
[  486.106834] nvme nvme0: I/O 6 QID 0 timeout, disable controller
[  486.140306] nvme nvme0: EH 1: before shutdown
[  486.179884] nvme nvme0: EH 1: after shutdown
[  486.179961] nvme nvme0: Identify Controller failed (-4)
[  486.232868] nvme nvme0: Removing after probe failure status: -5
[  486.273935] nvme nvme0: EH 0: after recovery
[  486.274230] nvme0n1: detected capacity change from 400088457216 to 0
[  486.334575] print_req_error: I/O error, dev nvme0n1, sector 1234608
[  486.334582] print_req_error: I/O error, dev nvme0n1, sector 1755840
[  486.334598] print_req_error: I/O error, dev nvme0n1, sector 569328
[  486.334600] print_req_error: I/O error, dev nvme0n1, sector 183296
[  486.334614] print_req_error: I/O error, dev nvme0n1, sector 174576
[  486.334616] print_req_error: I/O error, dev nvme0n1, sector 1234360
[  486.334621] print_req_error: I/O error, dev nvme0n1, sector 786336
[  486.334622] print_req_error: I/O error, dev nvme0n1, sector 205776
[  486.334624] print_req_error: I/O error, dev nvme0n1, sector 534320
[  486.334628] print_req_error: I/O error, dev nvme0n1, sector 712432
[  486.334856] Pid 7792(fio) over core_pipe_limit
[  486.334857] Pid 7799(fio) over core_pipe_limit
[  486.334857] Skipping core dump
[  486.334857] Skipping core dump
[  486.334918] Pid 7784(fio) over core_pipe_limit
[  486.334919] Pid 7797(fio) over core_pipe_limit
[  486.334920] Pid 7798(fio) over core_pipe_limit
[  486.334921] Pid 7791(fio) over core_pipe_limit
[  486.334922] Skipping core dump
[  486.334922] Skipping core dump
[  486.334922] Skipping core dump
[  486.334923] Skipping core dump
[  486.335060] Pid 7789(fio) over core_pipe_limit
[  486.335061] Skipping core dump
[  486.335290] Pid 7785(fio) over core_pipe_limit
[  486.335291] Skipping core dump
[  486.335292] Pid 7796(fio) over core_pipe_limit
[  486.335293] Skipping core dump
[  486.335316] Pid 7786(fio) over core_pipe_limit
[  486.335317] Skipping core dump
[  487.110906] nvme nvme0: failed to mark controller CONNECTING
[  487.141743] nvme nvme0: Removing after probe failure status: -19
[  487.176341] nvme nvme0: EH 1: after recovery
[  487.232034] BUG: unable to handle kernel NULL pointer dereference at
0000000000000000
[  487.276604] PGD 0 P4D 0 
[  487.290548] Oops: 0000 [#1] SMP PTI
[  487.310135] Modules linked in: macsec tcp_diag udp_diag inet_diag
unix_diag af_packet_diag netlink_diag binfmt_misc ebtable_filter
ebtables ip6table_filter ip6_tables devlink xt_physdev br_netfilter
bridge stp llc ipt_REJECT nf_reject_ipv4 nf_conntrack_ipv4
nf_defrag_ipv4 xt_multiport xt_conntrack nf_conntrack iptable_filter
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul
crc32_pclmul ghash_clmulni_intel pcbc aesni_intel dm_round_robin
crypto_simd iTCO_wdt gpio_ich iTCO_vendor_support cryptd ipmi_si
glue_helper pcspkr joydev ipmi_devintf hpilo acpi_power_meter sg
i7core_edac lpc_ich hpwdt dm_service_time ipmi_msghandler shpchp
pcc_cpufreq nfsd auth_rpcgss nfs_acl lockd grace sunrpc dm_multipath
ip_tables xfs libcrc32c radeon i2c_algo_bit drm_kms_helper syscopyarea
sysfillrect sysimgblt
[  487.719632]  fb_sys_fops ttm sd_mod qla2xxx drm nvme_fc nvme_fabrics
i2c_core crc32c_intel nvme serio_raw hpsa bnx2 nvme_core
scsi_transport_fc scsi_transport_sas dm_mirror dm_region_hash dm_log
dm_mod
[  487.817595] CPU: 4 PID: 763 Comm: kworker/u66:8 Kdump: loaded
Tainted: G          I       4.17.0-rc3.ming.nvme+ #1
[  487.876571] Hardware name: HP ProLiant DL380 G7, BIOS P67 08/16/2015
[  487.913158] Workqueue: nvme-wq nvme_remove_dead_ctrl_work [nvme]
[  487.946586] RIP: 0010:sbitmap_any_bit_set+0xb/0x30
[  487.973172] RSP: 0018:ffffb19e47fdfe00 EFLAGS: 00010202
[  488.003255] RAX: ffff8f0457931408 RBX: ffff8f0457931400 RCX:
0000000000000004
[  488.044199] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffff8f04579314d0
[  488.085253] RBP: ffff8f04570b8000 R08: 00000000000271a0 R09:
ffffffffacda1b44
[  488.126295] R10: ffffd6ee3f4ed000 R11: 0000000000000000 R12:
0000000000000001
[  488.166746] R13: 0000000000000001 R14: 0000000000000000 R15:
ffff8f0457821138
[  488.207076] FS:  0000000000000000(0000) GS:ffff8f145b280000(0000)
knlGS:0000000000000000
[  488.252727] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  488.284395] CR2: 0000000000000000 CR3: 0000001e4aa0a006 CR4:
00000000000206e0
[  488.324505] Call Trace:
[  488.337945]  blk_mq_run_hw_queue+0xad/0xf0
[  488.361057]  blk_mq_run_hw_queues+0x4b/0x60
[  488.384507]  nvme_kill_queues+0x26/0x80 [nvme_core]
[  488.411528]  nvme_remove_dead_ctrl_work+0x17/0x40 [nvme]
[  488.441602]  process_one_work+0x158/0x360
[  488.464568]  worker_thread+0x1fa/0x3e0
[  488.486044]  kthread+0xf8/0x130
[  488.504022]  ? max_active_store+0x80/0x80
[  488.527034]  ? kthread_bind+0x10/0x10
[  488.548026]  ret_from_fork+0x35/0x40
[  488.569062] Code: c6 44 0f 46 ce 83 c2 01 45 89 ca 4c 89 54 01 08 48
8b 4f 10 2b 74 01 08 39 57 08 77 d8 f3 c3 90 8b 4f 08 85 c9 74 1f 48 8b
57 10 <48> 83 3a 00 75 18 31 c0 eb 0a 48 83 c2 40 48 83 3a 00 75 0a 83 
[  488.676148] RIP: sbitmap_any_bit_set+0xb/0x30 RSP: ffffb19e47fdfe00
[  488.711006] CR2: 0000000000000000
