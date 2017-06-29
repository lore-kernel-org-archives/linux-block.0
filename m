Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbdF2Ler (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 07:34:47 -0400
Date: Thu, 29 Jun 2017 19:34:45 +0800
From: Eryu Guan <eguan@redhat.com>
To: linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [v4.12-rc6 regression] commit dc9edc44de6c introduced use-after-free
Message-ID: <20170629113445.GS23360@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

I got a use-after-free report from kasan-enabled kernel, when running
fstests xfs/279 (generic/108 could trigger too). I appended the console
log at the end of email.

git bisect pointed first bad commit to dc9edc44de6c ("block: Fix a
blk_exit_rl() regression"), and reverting that commit on top of
v4.12-rc7 kernel does resolve the use-after-free.

I can reproduce it by simply inserting & removing scsi_debug module.

modprobe scsi_debug
modprobe -r scsi_debug

If you need more info please let me know.

Thanks,
Eryu

[  101.977744] run fstests xfs/279 at 2017-06-29 19:08:59
[  102.458699] scsi host5: scsi_debug: version 1.86 [20160430]
[  102.458699]   dev_size_mb=128, opts=0x0, submit_queues=1, statistics=0
[  102.472103] scsi 5:0:0:0: Direct-Access     Linux    scsi_debug       0186 PQ: 0 ANSI: 7
[  102.503428] sd 5:0:0:0: Attached scsi generic sg5 type 0
[  102.505414] sd 5:0:0:0: [sde] 262144 512-byte logical blocks: (134 MB/128 MiB)
[  102.505418] sd 5:0:0:0: [sde] 4096-byte physical blocks
[  102.506568] sd 5:0:0:0: [sde] Write Protect is off
[  102.508874] sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA
[  102.535845] sd 5:0:0:0: [sde] Attached SCSI disk
[  104.876076] sd 5:0:0:0: [sde] Synchronizing SCSI cache
[  104.925555] ==================================================================
[  104.932796] BUG: KASAN: use-after-free in scsi_exit_rq+0xf3/0x120
[  104.938886] Read of size 1 at addr ffff88022d574580 by task kworker/3:1/78
[  104.945755]
[  104.947254] CPU: 3 PID: 78 Comm: kworker/3:1 Not tainted 4.12.0-rc6.kasan #98
[  104.954382] Hardware name: IBM System x3550 M3 -[7944OEJ]-/90Y4784     , BIOS -[D6E150CUS-1.11]- 02/08/2011
[  104.964117] Workqueue: events __blk_release_queue
[  104.968819] Call Trace:
[  104.971271]  dump_stack+0x63/0x89
[  104.974588]  print_address_description+0x78/0x290
[  104.979291]  ? scsi_exit_rq+0xf3/0x120
[  104.983042]  kasan_report+0x230/0x340
[  104.986706]  __asan_report_load1_noabort+0x19/0x20
[  104.991496]  scsi_exit_rq+0xf3/0x120
[  104.995074]  free_request_size+0x44/0x60
[  104.998999]  mempool_destroy.part.6+0x9b/0x150
[  105.003444]  mempool_destroy+0x13/0x20
[  105.007195]  blk_exit_rl+0x3b/0x60
[  105.010599]  __blk_release_queue+0x14c/0x410
[  105.014874]  process_one_work+0x5be/0xe90
[  105.018883]  worker_thread+0xe4/0xe70
[  105.022547]  ? pci_mmcfg_check_reserved+0x110/0x110
[  105.027423]  kthread+0x2d3/0x3d0
[  105.030653]  ? process_one_work+0xe90/0xe90
[  105.034836]  ? kthread_create_on_node+0xb0/0xb0
[  105.039366]  ret_from_fork+0x25/0x30
[  105.042940]
[  105.044436] Allocated by task 2763:
[  105.047927]  save_stack_trace+0x1b/0x20
[  105.051761]  save_stack+0x46/0xd0
[  105.055074]  kasan_kmalloc+0xad/0xe0
[  105.058653]  __kmalloc+0x105/0x1f0
[  105.062057]  scsi_host_alloc+0x6d/0x11b0
[  105.065980]  0xffffffffa0ad5ba6
[  105.069123]  driver_probe_device+0x5d2/0xc70
[  105.073393]  __device_attach_driver+0x1d3/0x2a0
[  105.077920]  bus_for_each_drv+0x114/0x1c0
[  105.081928]  __device_attach+0x1bf/0x290
[  105.085850]  device_initial_probe+0x13/0x20
[  105.090031]  bus_probe_device+0x19b/0x240
[  105.094038]  device_add+0x842/0x1420
[  105.097616]  device_register+0x1a/0x20
[  105.101365]  0xffffffffa0adf185
[  105.104507]  0xffffffffa0920a55
[  105.107650]  do_one_initcall+0x91/0x210
[  105.111487]  do_init_module+0x1bb/0x549
[  105.115323]  load_module+0x4ea8/0x5f50
[  105.119073]  SYSC_finit_module+0x169/0x1a0
[  105.123169]  SyS_finit_module+0xe/0x10
[  105.126919]  do_syscall_64+0x18a/0x410
[  105.130669]  return_from_SYSCALL_64+0x0/0x6a
[  105.134937]
[  105.136432] Freed by task 2823:
[  105.139573]  save_stack_trace+0x1b/0x20
[  105.143407]  save_stack+0x46/0xd0
[  105.146721]  kasan_slab_free+0x72/0xc0
[  105.150471]  kfree+0x96/0x1a0
[  105.153440]  scsi_host_dev_release+0x2cb/0x430
[  105.157883]  device_release+0x76/0x1d0
[  105.161634]  kobject_put+0x192/0x3f0
[  105.165209]  put_device+0x17/0x20
[  105.168524]  scsi_host_put+0x15/0x20
[  105.172100]  0xffffffffa0ad8e0b
[  105.175242]  device_release_driver_internal+0x26a/0x4e0
[  105.180463]  device_release_driver+0x12/0x20
[  105.184733]  bus_remove_device+0x2d0/0x590
[  105.188830]  device_del+0x526/0x8d0
[  105.192317]  device_unregister+0x1a/0xa0
[  105.196239]  0xffffffffa0ad6381
[  105.199379]  0xffffffffa0ae8924
[  105.202520]  SyS_delete_module+0x38e/0x440
[  105.206617]  do_syscall_64+0x18a/0x410
[  105.210366]  return_from_SYSCALL_64+0x0/0x6a
[  105.214634]
[  105.216130] The buggy address belongs to the object at ffff88022d574400
[  105.216130]  which belongs to the cache kmalloc-2048 of size 2048
[  105.228808] The buggy address is located 384 bytes inside of
[  105.228808]  2048-byte region [ffff88022d574400, ffff88022d574c00)
[  105.240618] The buggy address belongs to the page:
[  105.245410] page:ffffea0008b55c00 count:1 mapcount:0 mapping:          (null) index:0x0 compound_mapcount: 0
[  105.255229] flags: 0x6fffff80008100(slab|head)
[  105.259674] raw: 006fffff80008100 0000000000000000 0000000000000000 00000001800f000f
[  105.267411] raw: dead000000000100 dead000000000200 ffff88017b403040 0000000000000000
[  105.275149] page dumped because: kasan: bad access detected
[  105.280716]
[  105.282211] Memory state around the buggy address:
[  105.287001]  ffff88022d574480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  105.294216]  ffff88022d574500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  105.301432] >ffff88022d574580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  105.308649]                    ^
[  105.311878]  ffff88022d574600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  105.319092]  ffff88022d574680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

(gdb) l *(blk_exit_rl+0x3b)
0xffffffff8190381b is in blk_exit_rl (block/blk-core.c:661).
656
657     void blk_exit_rl(struct request_queue *q, struct request_list *rl)
658     {
659             if (rl->rq_pool) {
660                     mempool_destroy(rl->rq_pool);
661                     if (rl != &q->root_rl)
662                             blk_put_queue(q);
663             }
664     }
665
(gdb) l *(scsi_exit_rq+0xf3)
0xffffffff81e7fc23 is in scsi_exit_rq (drivers/scsi/scsi_lib.c:50).
45      static DEFINE_MUTEX(scsi_sense_cache_mutex);
46
47      static inline struct kmem_cache *
48      scsi_select_sense_cache(struct Scsi_Host *shost)
49      {
50              return shost->unchecked_isa_dma ?
51                      scsi_sense_isadma_cache : scsi_sense_cache;
52      }
53
54      static void scsi_free_sense_buffer(struct Scsi_Host *shost,
