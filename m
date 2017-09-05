Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] First set of block changes for 4.14-rc1
Message-ID: <c1aab1af-4dba-b324-0972-c3933816ecc8@kernel.dk>
Date: Tue, 5 Sep 2017 08:31:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

This is the first pull request for 4.14, containing most of the code
changes. It's a quiet series this round, which I think we needed after
the churn of the last few series. This pull request contains:

- Fix for a registration race in loop, from Anton Volkov.

- Overflow complaint fix from Arnd for DAC960.

- Series of drbd changes from the usual suspects.

- Conversion of the stec/skd driver to blk-mq. From Bart.

- A few BFQ improvements/fixes from Paolo.

- CFQ improvement from Ritesh, allowing idling for group idle.

- A few fixes found by Dan's smatch, courtesy of Dan.

- A warning fixup for a race between changing the IO scheduler and
  device remova. From David Jeffery.

- A few nbd fixes from Josef.

- Support for cgroup info in blktrace, from Shaohua.

- Also from Shaohua, new features in the null_blk driver to allow it to
  actually hold data, among other things.

- Various corner cases and error handling fixes from Weiping Zhang.

- Improvements to the IO stats tracking for blk-mq from me. Can
  drastically improve performance for fast devices and/or big machines.

- Series from Christoph removing bi_bdev as being needed for IO
  submission, in preparation for nvme multipathing code.

- Series from Bart, including various cleanups and fixes for switch fall
  through case complaints.

Note that you'll hit a conflict in block/bio-integrity.c and
mm/page_io.c, since we had fixes later in the 4.13 series for both of
those that ended up conflicting with new changes. Both are trivial to
fix up, I've included my resolution at the end of this email.

Please pull!


  git://git.kernel.dk/linux-block.git for-4.14/block


----------------------------------------------------------------
Anton Volkov (1):
      loop: fix to a race condition due to the early registration of device

Arnd Bergmann (1):
      block: DAC960: shut up format-overflow warning

Baoyou Xie (1):
      drbd: mark symbols static where possible

Bart Van Assche (78):
      block: Fix two comments that refer to .queue_rq() return values
      block: Unexport blk_queue_end_tag()
      blk-mq: Make blk_mq_reinit_tagset() calls easier to read
      blk-mq-debugfs: Declare a local symbol static
      genhd: Annotate all part and part_tbl pointer dereferences
      ide-floppy: Use blk_rq_is_scsi()
      virtio_blk: Use blk_rq_is_scsi()
      xen-blkback: Fix indentation
      xen-blkback: Avoid that gcc 7 warns about fall-through when building with W=1
      xen-blkfront: Avoid that gcc 7 warns about fall-through when building with W=1
      block: Relax a check in blk_start_queue()
      skd: Avoid that module unloading triggers a use-after-free
      skd: Submit requests to firmware before triggering the doorbell
      skd: Switch to GPLv2
      skd: Update maintainer information
      skd: Remove unneeded #include directives
      skd: Remove ESXi code
      skd: Remove unnecessary blank lines
      skd: Avoid that gcc 7 warns about fall-through when building with W=1
      skd: Fix spelling in a source code comment
      skd: Fix a function name in a comment
      skd: Remove set-but-not-used local variables
      skd: Remove a set-but-not-used variable from struct skd_device
      skd: Remove useless barrier() calls
      skd: Switch from the pr_*() to the dev_*() logging functions
      skd: Fix endianness annotations
      skd: Document locking assumptions
      skd: Introduce the symbolic constant SKD_MAX_REQ_PER_MSG
      skd: Introduce SKD_SKCOMP_SIZE
      skd: Fix size argument in skd_free_skcomp()
      skd: Reorder the code in skd_process_request()
      skd: Simplify the code for deciding whether or not to send a FIT msg
      skd: Simplify the code for allocating DMA message buffers
      skd: Use a structure instead of hardcoding structure offsets
      skd: Check structure sizes at build time
      skd: Use __packed only when needed
      skd: Make the skd_isr() code more brief
      skd: Use ARRAY_SIZE() where appropriate
      skd: Simplify the code for handling data direction
      skd: Remove superfluous initializations from skd_isr_completion_posted()
      skd: Drop second argument of skd_recover_requests()
      skd: Use for_each_sg()
      skd: Remove a redundant init_timer() call
      skd: Remove superfluous occurrences of the 'volatile' keyword
      skd: Use kcalloc() instead of kzalloc() with multiply
      skb: Use symbolic names for SCSI opcodes
      skd: Move a function definition
      skd: Rework request failing code path
      skd: Convert explicit skd_request_fn() calls
      skd: Remove SG IO support
      skd: Remove dead code
      skd: Initialize skd_special_context.req.n_sg to one
      skd: Enable request tags for the block layer queue
      skd: Convert several per-device scalar variables into atomics
      skd: Introduce skd_process_request()
      skd: Split skd_recover_requests()
      skd: Move skd_free_sg_list() up
      skd: Coalesce struct request and struct skd_request_context
      skd: Convert to blk-mq
      skd: Switch to block layer timeout mechanism
      skd: Remove skd_device.in_flight
      skd: Reduce memory usage
      skd: Remove several local variables
      skd: Optimize locking
      skd: Bump driver version
      skd: Remove driver version information
      block: Warn if blk_queue_rq_timed_out() is called for a blk-mq queue
      skd: Report completion mismatches once
      skd: Inline skd_process_request()
      skd: Avoid double completions in case of a timeout
      skd: Change default interrupt mode to MSI-X
      compat_hdio_ioctl: Fix a declaration
      skd: Rename skd_softirq_done() into skd_complete_rq()
      skd: Inline skd_end_request()
      skd: Make it easier for static analyzers to analyze skd_free_disk()
      skd: Remove SKD_ID_INCR
      skd: Remove blk_queue_bounce_limit() call
      skd: Let the block layer core choose .nr_requests

Ben Hutchings (2):
      bfq: Re-enable auto-loading when built as a module
      mq-deadline: Enable auto-loading when built as module

Bhumika Goyal (1):
      nbd: make device_attribute const

Christoph Hellwig (9):
      bio-integrity: move the bio integrity profile check earlier in bio_integrity_prep
      dm-crypt: don't mess with BIP_BLOCK_INTEGRITY
      btrfs: index check-integrity state hash by a dev_t
      raid5: remove a call to get_start_sect
      block: reject attempts to allocate more than DISK_MAX_PARTS partitions
      block: add a __disk_get_part helper
      block: cache the partition index in struct block_device
      block: replace bi_bdev with a gendisk pointer and partitions index
      bsg: remove #if 0'ed code

Damien Le Moal (1):
      block: Make blk_dequeue_request() static

Dan Carpenter (3):
      skd: Uninitialized variable in skd_isr_completion_posted()
      skd: error pointer dereference in skd_cons_disk()
      kernfs: checking for IS_ERR() instead of NULL

David Jeffery (1):
      block: fix warning when I/O elevator is changed as request_queue is being removed

Geliang Tang (1):
      drbd: Use setup_timer() instead of init_timer() to simplify the code.

Greg Kroah-Hartman (1):
      drbd: rename "usermode_helper" to "drbd_usermode_helper"

Jan Kara (1):
      block: Add comment to submit_bio_wait()

Jens Axboe (10):
      blk-mq: blk_mq_requeue_work() doesn't need to save IRQ flags
      blk-mq: add warning to __blk_mq_run_hw_queue() for ints disabled
      blk-mq-tag: check for NULL rq when iterating tags
      block: pass in queue to inflight accounting
      block: make part_in_flight() take an array of two ints
      blk-mq: provide internal in-flight variant
      blk-mq: enable checking two part inflight counts at the same time
      block: remove unused syncfull/asyncfull queue flags
      null_blk: update email adress
      null_blk: use available 'dev' in nullb_device_power_store()

Josef Bacik (2):
      nbd: allow device creation at a specific index
      nbd: change the default nbd partitions

Lars Ellenberg (9):
      drbd: introduce drbd_recv_header_maybe_unplug
      drbd: change list_for_each_safe to while(list_first_entry_or_null)
      drbd: add explicit plugging when submitting batches
      drbd: Send P_NEG_ACK upon write error in protocol != C
      drbd: new disk-option disable-write-same
      drbd: fix potential get_ldev/put_ldev refcount imbalance during attach
      drbd: fix rmmod cleanup, remove _all_ debugfs entries
      drbd: fix potential deadlock when trying to detach during handshake
      drbd: fix race between handshake and admin disconnect/down

Markus Elfring (1):
      drbd: A single dot should be put into a sequence.

Milan Broz (1):
      bio-integrity: Fix regression if profile verify_fn is NULL

NeilBrown (1):
      drbd: remove BIOSET_NEED_RESCUER flag from drbd_{md_,}io_bio_set

Omar Sandoval (1):
      block: update comments to reflect REQ_FLUSH -> REQ_PREFLUSH rename

Paolo Valente (2):
      block,bfq: refactor device-idling logic
      block, bfq: boost throughput with flash-based non-queueing devices

Philipp Reisner (2):
      drbd: Fix resource role for newly created resources in events2
      drbd: Fix allyesconfig build, fix recent commit

Ritesh Harjani (1):
      cfq: Give a chance for arming slice idle timer in case of group_idle

Roland Kammerer (3):
      drbd: move global variables to drbd namespace and make some static
      drbd: abort drbd_start_resync if there is no connection
      drbd: switch from kmalloc() to kmalloc_array()

Shaohua Li (22):
      kernfs: use idr instead of ida to manage inode number
      kernfs: implement i_generation
      kernfs: add an API to get kernfs node from inode number
      kernfs: don't set dentry->d_fsdata
      kernfs: introduce kernfs_node_id
      kernfs: add exportfs operations
      cgroup: export fhandle info for a cgroup
      blktrace: export cgroup info in trace
      block: always attach cgroup info into bio
      blktrace: add an option to allow displaying cgroup path
      block: use standard blktrace API to output cgroup info for debug notes
      nullb: factor disk parameters
      nullb: add configfs interface
      nullb: add interface to power on disk
      nullb: use ida to manage index
      nullb: support memory backed store
      nullb: support discard
      nullb: bandwidth control
      nullb: emulate cache
      nullb: badbblocks support
      block/nullb: fix NULL dereference
      block/nullb: delete unnecessary memory free

weiping zhang (6):
      null_blk: simplify logic for use_per_node_hctx
      null_blk: make sure submit_queues > 0
      block, bfq: fix error handle in bfq_init
      block: remove blk_free_devt in add_partition
      blkcg: avoid free blkcg_root when failed to alloc blkcg policy
      block, scheduler: convert xxx_var_store to void

 MAINTAINERS                         |    6 +
 arch/powerpc/sysdev/axonram.c       |    2 +-
 block/bfq-iosched.c                 |  182 +-
 block/bfq-iosched.h                 |   25 +-
 block/bio-integrity.c               |   29 +-
 block/bio.c                         |   30 +-
 block/blk-cgroup.c                  |    8 +-
 block/blk-core.c                    |  153 +-
 block/blk-flush.c                   |   26 +-
 block/blk-lib.c                     |    8 +-
 block/blk-merge.c                   |    6 +-
 block/blk-mq-debugfs.c              |    4 +-
 block/blk-mq-tag.c                  |   23 +-
 block/blk-mq.c                      |   54 +-
 block/blk-mq.h                      |    3 +
 block/blk-settings.c                |    1 +
 block/blk-sysfs.c                   |    2 +
 block/blk-tag.c                     |    1 -
 block/blk-throttle.c                |   13 +-
 block/blk-zoned.c                   |    4 +-
 block/blk.h                         |    3 +-
 block/bsg.c                         |    7 -
 block/cfq-iosched.c                 |   31 +-
 block/compat_ioctl.c                |    2 +-
 block/deadline-iosched.c            |    9 +-
 block/elevator.c                    |    4 +
 block/genhd.c                       |   91 +-
 block/mq-deadline.c                 |   10 +-
 block/partition-generic.c           |   23 +-
 drivers/block/DAC960.c              |   12 +-
 drivers/block/Kconfig               |    1 +
 drivers/block/brd.c                 |    5 +-
 drivers/block/drbd/drbd_actlog.c    |    2 +-
 drivers/block/drbd/drbd_bitmap.c    |    2 +-
 drivers/block/drbd/drbd_int.h       |   31 +-
 drivers/block/drbd/drbd_main.c      |  113 +-
 drivers/block/drbd/drbd_nl.c        |   60 +-
 drivers/block/drbd/drbd_proc.c      |   10 +-
 drivers/block/drbd/drbd_receiver.c  |   60 +-
 drivers/block/drbd/drbd_req.c       |   86 +-
 drivers/block/drbd/drbd_req.h       |    6 +
 drivers/block/drbd/drbd_state.c     |   48 +-
 drivers/block/drbd/drbd_state.h     |    8 +
 drivers/block/drbd/drbd_worker.c    |   48 +-
 drivers/block/floppy.c              |    2 +-
 drivers/block/loop.c                |   14 +-
 drivers/block/nbd.c                 |   15 +-
 drivers/block/null_blk.c            | 1309 ++++++++++++--
 drivers/block/pktcdvd.c             |   11 +-
 drivers/block/rsxx/dev.c            |    6 +-
 drivers/block/skd_main.c            | 3210 +++++++++--------------------------
 drivers/block/skd_s1120.h           |   38 +-
 drivers/block/virtio_blk.c          |    2 +-
 drivers/block/xen-blkback/blkback.c |    9 +-
 drivers/block/xen-blkback/xenbus.c  |    3 +-
 drivers/block/xen-blkfront.c        |    2 +-
 drivers/block/zram/zram_drv.c       |    5 +-
 drivers/ide/ide-floppy.c            |    2 +-
 drivers/md/bcache/debug.c           |    2 +-
 drivers/md/bcache/io.c              |    2 +-
 drivers/md/bcache/journal.c         |    6 +-
 drivers/md/bcache/request.c         |   21 +-
 drivers/md/bcache/super.c           |    6 +-
 drivers/md/bcache/writeback.c       |    5 +-
 drivers/md/dm-bio-record.h          |    9 +-
 drivers/md/dm-bufio.c               |    2 +-
 drivers/md/dm-cache-target.c        |    4 +-
 drivers/md/dm-crypt.c               |    7 +-
 drivers/md/dm-delay.c               |    4 +-
 drivers/md/dm-era-target.c          |    2 +-
 drivers/md/dm-flakey.c              |    2 +-
 drivers/md/dm-integrity.c           |   11 +-
 drivers/md/dm-io.c                  |    2 +-
 drivers/md/dm-linear.c              |    2 +-
 drivers/md/dm-log-writes.c          |    8 +-
 drivers/md/dm-mpath.c               |    2 +-
 drivers/md/dm-raid1.c               |   12 +-
 drivers/md/dm-snap.c                |   16 +-
 drivers/md/dm-stripe.c              |   10 +-
 drivers/md/dm-switch.c              |    2 +-
 drivers/md/dm-thin.c                |    6 +-
 drivers/md/dm-verity-target.c       |    2 +-
 drivers/md/dm-zoned-metadata.c      |    6 +-
 drivers/md/dm-zoned-target.c        |    4 +-
 drivers/md/dm.c                     |   16 +-
 drivers/md/faulty.c                 |    4 +-
 drivers/md/linear.c                 |    6 +-
 drivers/md/md.c                     |   10 +-
 drivers/md/md.h                     |    9 +-
 drivers/md/multipath.c              |    8 +-
 drivers/md/raid0.c                  |    7 +-
 drivers/md/raid1.c                  |   34 +-
 drivers/md/raid10.c                 |   50 +-
 drivers/md/raid5-cache.c            |    6 +-
 drivers/md/raid5-ppl.c              |    6 +-
 drivers/md/raid5.c                  |   16 +-
 drivers/nvdimm/nd.h                 |    9 +-
 drivers/nvme/host/core.c            |   11 +-
 drivers/nvme/host/fc.c              |    4 +-
 drivers/nvme/host/lightnvm.c        |   15 +-
 drivers/nvme/host/rdma.c            |   11 +-
 drivers/nvme/target/io-cmd.c        |    6 +-
 drivers/s390/block/dcssblk.c        |    4 +-
 drivers/s390/block/xpram.c          |    2 +-
 drivers/target/target_core_iblock.c |    4 +-
 fs/block_dev.c                      |    5 +-
 fs/btrfs/check-integrity.c          |   41 +-
 fs/btrfs/disk-io.c                  |    2 +-
 fs/btrfs/extent_io.c                |    6 +-
 fs/btrfs/raid56.c                   |    8 +-
 fs/btrfs/scrub.c                    |   12 +-
 fs/btrfs/volumes.c                  |    2 +-
 fs/buffer.c                         |    4 +-
 fs/crypto/bio.c                     |    2 +-
 fs/direct-io.c                      |    8 +-
 fs/exofs/ore.c                      |    2 +-
 fs/ext4/page-io.c                   |    4 +-
 fs/ext4/readpage.c                  |    2 +-
 fs/f2fs/data.c                      |    5 +-
 fs/f2fs/segment.c                   |    2 +-
 fs/gfs2/lops.c                      |    2 +-
 fs/gfs2/meta_io.c                   |    2 +-
 fs/gfs2/ops_fstype.c                |    2 +-
 fs/hfsplus/wrapper.c                |    2 +-
 fs/iomap.c                          |    4 +-
 fs/jfs/jfs_logmgr.c                 |    4 +-
 fs/jfs/jfs_metapage.c               |    4 +-
 fs/kernfs/dir.c                     |  111 +-
 fs/kernfs/file.c                    |   10 +-
 fs/kernfs/inode.c                   |    9 +-
 fs/kernfs/kernfs-internal.h         |    9 +
 fs/kernfs/mount.c                   |   94 +-
 fs/kernfs/symlink.c                 |    6 +-
 fs/mpage.c                          |    2 +-
 fs/nfs/blocklayout/blocklayout.c    |    2 +-
 fs/nilfs2/segbuf.c                  |    2 +-
 fs/ocfs2/cluster/heartbeat.c        |    2 +-
 fs/xfs/xfs_aops.c                   |    2 +-
 fs/xfs/xfs_buf.c                    |    2 +-
 include/linux/bio.h                 |   27 +-
 include/linux/blk-cgroup.h          |    3 +
 include/linux/blk-mq.h              |    5 +-
 include/linux/blk_types.h           |    3 +-
 include/linux/blkdev.h              |   60 +-
 include/linux/blktrace_api.h        |   13 +-
 include/linux/cgroup.h              |   16 +-
 include/linux/drbd.h                |    2 +-
 include/linux/drbd_genl.h           |    3 +-
 include/linux/drbd_limits.h         |    8 +-
 include/linux/fs.h                  |    1 +
 include/linux/genhd.h               |   26 +-
 include/linux/kernfs.h              |   28 +-
 include/trace/events/bcache.h       |    6 +-
 include/trace/events/block.h        |   16 +-
 include/trace/events/f2fs.h         |    2 +-
 include/trace/events/writeback.h    |    2 +-
 include/uapi/linux/blktrace_api.h   |    3 +
 kernel/cgroup/cgroup.c              |   15 +-
 kernel/power/swap.c                 |    5 +-
 kernel/trace/blktrace.c             |  261 ++-
 mm/page_io.c                        |   17 +-
 161 files changed, 3686 insertions(+), 3485 deletions(-)

diff --cc block/bio-integrity.c
index 9b1ea478577b,553d75e357b4..5df32907ff3b
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@@ -387,11 -385,12 +385,11 @@@ static void bio_integrity_verify_fn(str
   */
  bool __bio_integrity_endio(struct bio *bio)
  {
- 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
+ 	struct blk_integrity *bi = blk_get_integrity(bio->bi_disk);
 +	struct bio_integrity_payload *bip = bio_integrity(bio);
  
  	if (bio_op(bio) == REQ_OP_READ && !bio->bi_status &&
 -	    bi->profile->verify_fn) {
 -		struct bio_integrity_payload *bip = bio_integrity(bio);
 -
 +	    (bip->bip_flags & BIP_BLOCK_INTEGRITY) && bi->profile->verify_fn) {
  		INIT_WORK(&bip->bip_work, bio_integrity_verify_fn);
  		queue_work(kintegrityd_wq, &bip->bip_work);
  		return false;
diff --cc mm/page_io.c
index 5f61b54ee1f3,9cf1bc751d79..868e7a96bf8a
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@@ -379,12 -378,7 +380,12 @@@ int swap_readpage(struct page *page, bo
  		ret = -ENOMEM;
  		goto out;
  	}
- 	bdev = bio->bi_bdev;
 +	/*
 +	 * Keep this task valid during swap readpage because the oom killer may
 +	 * attempt to access it in the page fault retry time check.
 +	 */
 +	get_task_struct(current);
+ 	disk = bio->bi_disk;
  	bio->bi_private = current;
  	bio_set_op_attrs(bio, REQ_OP_READ, 0);
  	count_vm_event(PSWPIN);

-- 
Jens Axboe
-- 
Jens Axboe
