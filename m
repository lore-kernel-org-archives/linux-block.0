Return-Path: <ming.lei@redhat.com>
Date: Mon, 29 Oct 2018 23:05:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org, Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCHSET 0/28] blk-mq driver conversions and legacy path removal
Message-ID: <20181029150554.GB7808@ming.t460p>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181029120036.GA17708@ming.t460p>
 <9cf74419-6c4f-81b7-2339-405f2023a9c8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9cf74419-6c4f-81b7-2339-405f2023a9c8@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 29, 2018 at 08:50:25AM -0600, Jens Axboe wrote:
> On 10/29/18 6:00 AM, Ming Lei wrote:
> > On Thu, Oct 25, 2018 at 03:10:11PM -0600, Jens Axboe wrote:
> >> The first round of this went into 4.20-rc, but we've still some of
> >> them pending. This patch series converts the remaining drivers to
> >> blk-mq. The ones that support dual paths (like SCSI and DM) have
> >> the non-mq path removed. At the end, legacy IO code and schedulers
> >> are killed off.
> >>
> >> This patch series is on top of my for-linus branch. It can also
> >> be bound in my mq-conversions branch.
> >>
> >>  Documentation/block/biodoc.txt         |   88 -
> >>  Documentation/block/cfq-iosched.txt    |  291 --
> >>  Documentation/scsi/scsi-parameters.txt |    5 -
> >>  block/Kconfig                          |    6 -
> >>  block/Kconfig.iosched                  |   61 -
> >>  block/Makefile                         |    5 +-
> >>  block/bfq-iosched.c                    |    1 -
> >>  block/blk-cgroup.c                     |   55 -
> >>  block/blk-core.c                       | 1860 +-----------
> >>  block/blk-exec.c                       |   20 +-
> >>  block/blk-flush.c                      |  154 +-
> >>  block/blk-ioc.c                        |   46 +-
> >>  block/blk-merge.c                      |   35 +-
> >>  block/blk-mq-debugfs.c                 |    2 -
> >>  block/blk-mq-tag.c                     |    6 +-
> >>  block/blk-mq.c                         |   13 +-
> >>  block/blk-settings.c                   |   49 -
> >>  block/blk-softirq.c                    |   20 -
> >>  block/blk-sysfs.c                      |   39 +-
> >>  block/blk-tag.c                        |  378 ---
> >>  block/blk-timeout.c                    |   99 +-
> >>  block/blk-wbt.c                        |    3 +-
> >>  block/blk.h                            |   60 +-
> >>  block/bsg-lib.c                        |  131 +-
> >>  block/cfq-iosched.c                    | 4916 --------------------------------
> >>  block/deadline-iosched.c               |  560 ----
> >>  block/elevator.c                       |  447 +--
> >>  block/kyber-iosched.c                  |    1 -
> >>  block/mq-deadline.c                    |    1 -
> >>  block/noop-iosched.c                   |  124 -
> >>  drivers/block/sunvdc.c                 |  149 +-
> >>  drivers/ide/ide-atapi.c                |   25 +-
> >>  drivers/ide/ide-cd.c                   |  175 +-
> >>  drivers/ide/ide-disk.c                 |    5 +-
> >>  drivers/ide/ide-io.c                   |  101 +-
> >>  drivers/ide/ide-park.c                 |    4 +-
> >>  drivers/ide/ide-pm.c                   |   28 +-
> >>  drivers/ide/ide-probe.c                |   68 +-
> >>  drivers/infiniband/ulp/srp/ib_srp.c    |    7 -
> >>  drivers/md/Kconfig                     |   11 -
> >>  drivers/md/dm-core.h                   |   10 -
> >>  drivers/md/dm-mpath.c                  |   18 +-
> >>  drivers/md/dm-rq.c                     |  293 +-
> >>  drivers/md/dm-rq.h                     |    4 -
> >>  drivers/md/dm-sysfs.c                  |    3 +-
> >>  drivers/md/dm-table.c                  |   36 +-
> >>  drivers/md/dm.c                        |   21 +-
> >>  drivers/md/dm.h                        |    1 -
> >>  drivers/memstick/core/ms_block.c       |  110 +-
> >>  drivers/memstick/core/ms_block.h       |    1 +
> >>  drivers/memstick/core/mspro_block.c    |  121 +-
> >>  drivers/s390/block/dasd_ioctl.c        |   22 +-
> >>  drivers/scsi/Kconfig                   |   12 -
> >>  drivers/scsi/cxlflash/main.c           |    6 -
> >>  drivers/scsi/hosts.c                   |   29 +-
> >>  drivers/scsi/lpfc/lpfc_scsi.c          |    2 +-
> >>  drivers/scsi/osd/osd_initiator.c       |    4 +-
> >>  drivers/scsi/osst.c                    |    2 +-
> >>  drivers/scsi/qedi/qedi_main.c          |    3 +-
> >>  drivers/scsi/qla2xxx/qla_os.c          |   30 +-
> >>  drivers/scsi/scsi.c                    |    5 +-
> >>  drivers/scsi/scsi_debug.c              |    3 +-
> >>  drivers/scsi/scsi_error.c              |    4 +-
> >>  drivers/scsi/scsi_lib.c                |  624 +---
> >>  drivers/scsi/scsi_priv.h               |    1 -
> >>  drivers/scsi/scsi_scan.c               |   10 +-
> >>  drivers/scsi/scsi_sysfs.c              |    8 +-
> >>  drivers/scsi/scsi_transport_fc.c       |   72 +-
> >>  drivers/scsi/scsi_transport_iscsi.c    |    9 +-
> >>  drivers/scsi/scsi_transport_sas.c      |   10 +-
> >>  drivers/scsi/sg.c                      |    2 +-
> >>  drivers/scsi/st.c                      |    2 +-
> >>  drivers/scsi/ufs/ufshcd.c              |    6 -
> >>  drivers/target/target_core_pscsi.c     |    2 +-
> >>  include/linux/blk-cgroup.h             |  108 -
> >>  include/linux/blkdev.h                 |  174 +-
> >>  include/linux/bsg-lib.h                |    3 +-
> >>  include/linux/elevator.h               |   90 +-
> >>  include/linux/ide.h                    |   13 +-
> >>  include/linux/init.h                   |    1 -
> >>  include/scsi/scsi_host.h               |   18 +-
> >>  include/scsi/scsi_tcq.h                |   14 +-
> >>  init/do_mounts_initrd.c                |    3 -
> >>  init/initramfs.c                       |    6 -
> >>  init/main.c                            |   12 -
> >>  85 files changed, 833 insertions(+), 11144 deletions(-)
> > 
> > Hi Jens,
> > 
> > Kernel oops[2] is triggered when running elevator switch stress test[1].
> > 
> > [1] https://people.redhat.com/~minlei/tests/tools/elv-switch
> > 
> > [2] kernel oops
> > 
> > [  399.702365] scsi 8:0:0:0: Direct-Access     Linux    scsi_debug       0188 PQ: 0 ANSI: 7
> > [  399.703603] sd 8:0:0:0: Power-on or device reset occurred
> > [  399.709833] sd 8:0:0:0: [sdd] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
> > [  399.711745] sd 8:0:0:0: [sdd] Write Protect is off
> > [  399.712395] sd 8:0:0:0: [sdd] Mode Sense: 73 00 10 08
> > [  399.715119] sd 8:0:0:0: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
> > [  399.803561] sd 8:0:0:0: [sdd] Attached SCSI disk
> > [  399.844825] sd 8:0:0:0: [sdd] Synchronizing SCSI cache
> > [  399.968945] scsi 8:0:0:0: Direct-Access     Linux    scsi_debug       0188 PQ: 0 ANSI: 7
> > [  399.970077] sd 8:0:0:0: Power-on or device reset occurred
> > [  399.972904] sd 8:0:0:0: [sdd] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
> > [  399.974823] sd 8:0:0:0: [sdd] Write Protect is off
> > [  399.975411] sd 8:0:0:0: [sdd] Mode Sense: 73 00 10 08
> > [  399.978052] sd 8:0:0:0: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
> > [  400.030588] BUG: unable to handle kernel NULL pointer dereference at 0000000000000500
> > [  400.032195] PGD 0 P4D 0
> > [  400.032482] Oops: 0000 [#1] PREEMPT SMP PTI
> > [  400.032945] CPU: 2 PID: 318 Comm: kworker/u8:5 Not tainted 4.19.0_0ffdea6679a9_mq-conversions+ #1
> > [  400.033927] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
> > [  400.034915] Workqueue: events_unbound async_run_entry_fn
> > [  400.035536] RIP: 0010:bfq_reset_rate_computation+0x52/0x85
> > [  400.036177] Code: 00 48 89 83 b0 00 00 00 8b 45 20 c1 e8 09 89 83 d8 00 00 00 48 89 83 d0 00 00 00 eb 0a c7 87 c8 00 00 00 00 00 00 00 48 8b 03 <48> 8b b8 00 05 00 00 48 85 ff 74 24 8b 8b c8 00 00 00 4c 8b 8b d0
> > [  400.038300] RSP: 0018:ffffc90000a47c50 EFLAGS: 00010046
> > [  400.038915] RAX: 0000000000000000 RBX: ffff88017ac2bc00 RCX: 0000000017d6067a
> > [  400.039746] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88017ac2bc00
> > [  400.040573] RBP: ffff88017ac2bc00 R08: 00000000f461e6ac R09: 0000000000000006
> > [  400.041361] R10: 000000000000020f R11: 0000000000000000 R12: ffff88016c130000
> > [  400.042127] R13: 0000005d1c095013 R14: ffff88017ac2bf78 R15: 0000000000000020
> > [  400.042957] FS:  0000000000000000(0000) GS:ffff88017bb00000(0000) knlGS:0000000000000000
> > [  400.043895] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  400.044518] CR2: 0000000000000500 CR3: 0000000179c32004 CR4: 0000000000760ee0
> > [  400.045294] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [  400.046070] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [  400.046843] PKRU: 55555554
> > [  400.047144] Call Trace:
> > [  400.047438]  bfq_finish_requeue_request+0x145/0x2fd
> > [  400.047977]  blk_mq_free_request+0x49/0xea
> > [  400.048429]  __scsi_execute+0x16c/0x17b
> > [  400.048885]  scsi_mode_sense+0x113/0x265
> > [  400.049356]  sd_revalidate_disk+0xb5b/0x109a [sd_mod]
> > [  400.049947]  ? __device_add_disk+0x3d2/0x3f6
> > [  400.050415]  sd_probe_async+0x10d/0x18b [sd_mod]
> > [  400.050924]  async_run_entry_fn+0x6d/0x12b
> > [  400.051374]  process_one_work+0x1da/0x313
> > [  400.051841]  ? rescuer_thread+0x282/0x282
> > [  400.052313]  worker_thread+0x1ca/0x295
> > [  400.052769]  kthread+0x115/0x11d
> > [  400.053127]  ? kthread_park+0x76/0x76
> > [  400.053531]  ret_from_fork+0x35/0x40
> > [  400.053929] Modules linked in: scsi_debug null_blk isofs iTCO_wdt iTCO_vendor_support i2c_i801 i2c_core lpc_ich mfd_core ip_tables sr_mod cdrom usb_storage sd_mod ahci libahci crc32c_intel libata virtio_scsi qemu_fw_cfg dm_mirror dm_region_hash dm_log dm_mod [last unloaded: null_blk]
> > [  400.056640] Dumping ftrace buffer:
> > [  400.057022]    (ftrace buffer empty)
> > [  400.057418] CR2: 0000000000000500
> > [  400.057820] ---[ end trace 812cbc0fe8802fdd ]---
> 
> Doesn't look related to the series, more like a bug in BFQ. Are you
> sure it passes on current -git? Or maybe the bug is exposed by the
> series.
> 
> I'll try and reproduce it here and see what happens.

Look it is only observed on mq-conversion, and not see it on
for-linus, will double check it tomorrow.

Thanks,
Ming
