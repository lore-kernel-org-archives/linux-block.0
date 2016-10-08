Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751425AbcJHCJU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Oct 2016 22:09:20 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] blk-mq irq/cpu mapping updates
Message-ID: <e5d29019-fd55-b462-0e5a-5a00f88e992b@fb.com>
Date: Fri, 7 Oct 2016 20:09:08 -0600
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------E46A1E35ADB7677398403FBE"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--------------E46A1E35ADB7677398403FBE
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

This is the block-irq topic branch for 4.9-rc. It's mostly from
Christoph, and it allows drivers to specify their own mappings, and more
importantly, to share the blk-mq mappings with the IRQ affinity
mappings. It's a good step towards making this work better out of the
box.

This will throw a few merge conflicts with later patches in the main
branch that you already pulled. I kept this a private branch due to the
pci dependencies. I have attached the diff of how I resolved it, just in
case.

Please pull!


   git://git.kernel.dk/linux-block.git for-4.9/block-irq


----------------------------------------------------------------
Christoph Hellwig (8):
       blk-mq: don't redistribute hardware queues on a CPU hotplug event
       blk-mq: only allocate a single mq_map per tag_set
       blk-mq: remove ->map_queue
       blk-mq: allow the driver to pass in a queue mapping
       blk-mq: provide a default queue mapping for PCI device
       nvme: switch to use pci_alloc_irq_vectors
       nvme: remove the post_scan callout
       blk-mq: get rid of the cpumask in struct blk_mq_tags

Jens Axboe (2):
       Merge branch 'irq/for-block' of git://git.kernel.org/.../tip/tip 
into for-4.9/msi-irq
       blk-mq: kill unused blk_mq_create_mq_map()

Stephen Rothwell (1):
       blk_mq: linux/blk-mq.h does not include all the headers it depends on

  Documentation/block/biodoc.txt    |   4 +-
  block/Kconfig                     |   5 +
  block/Makefile                    |   2 +-
  block/bio.c                       |   2 +-
  block/blk-core.c                  |  16 +-
  block/blk-flush.c                 |   6 +-
  block/blk-mq-cpumap.c             |  25 +--
  block/blk-mq-pci.c                |  47 +++++
  block/blk-mq-sysfs.c              |  15 +-
  block/blk-mq-tag.c                |  11 +-
  block/blk-mq-tag.h                |   1 -
  block/blk-mq.c                    | 117 +++++------
  block/blk-mq.h                    |  10 +-
  block/blk.h                       |  11 +-
  drivers/block/loop.c              |   1 -
  drivers/block/mtip32xx/mtip32xx.c |   3 +-
  drivers/block/nbd.c               | 411 
+++++++++++++++-----------------------
  drivers/block/null_blk.c          |   1 -
  drivers/block/rbd.c               |   1 -
  drivers/block/virtio_blk.c        |   1 -
  drivers/block/xen-blkfront.c      |   1 -
  drivers/md/dm-crypt.c             |   2 +-
  drivers/md/dm-rq.c                |   1 -
  drivers/mtd/ubi/block.c           |   1 -
  drivers/nvme/host/core.c          |   3 -
  drivers/nvme/host/nvme.h          |   1 -
  drivers/nvme/host/pci.c           | 109 ++++------
  drivers/nvme/host/rdma.c          |   2 -
  drivers/nvme/target/loop.c        |   2 -
  drivers/scsi/scsi_lib.c           |   1 -
  fs/befs/linuxvfs.c                |   2 +-
  fs/block_dev.c                    |  11 +-
  fs/btrfs/inode.c                  |   5 +-
  include/linux/bio.h               |   2 -
  include/linux/blk-mq-pci.h        |   9 +
  include/linux/blk-mq.h            |  26 ++-
  include/linux/blk_types.h         |  21 +-
  include/linux/blkdev.h            |   4 +-
  include/linux/ioprio.h            |   1 -
  include/linux/workqueue.h         |   1 +
  kernel/workqueue.c                |  40 ++--
  41 files changed, 429 insertions(+), 506 deletions(-)
  create mode 100644 block/blk-mq-pci.c
  create mode 100644 include/linux/blk-mq-pci.h

-- 
Jens Axboe


--------------E46A1E35ADB7677398403FBE
Content-Type: text/x-patch; name="block-irq-resolve.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="block-irq-resolve.patch"

diff --cc block/blk-mq-tag.c
index cef618f6fc92,2eae3d5f7145..000000000000
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@@ -412,9 -673,8 +406,8 @@@ struct blk_mq_tags *blk_mq_init_tags(un
  
  void blk_mq_free_tags(struct blk_mq_tags *tags)
  {
 -	bt_free(&tags->bitmap_tags);
 -	bt_free(&tags->breserved_tags);
 +	sbitmap_queue_free(&tags->bitmap_tags);
 +	sbitmap_queue_free(&tags->breserved_tags);
- 	free_cpumask_var(tags->cpumask);
  	kfree(tags);
  }
  
diff --cc block/blk-mq-tag.h
index 09f4cc0aaa84,556964134d1c..000000000000
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@@ -17,8 -42,8 +17,6 @@@ struct blk_mq_tags 
  
  	struct request **rqs;
  	struct list_head page_list;
--
- 	cpumask_var_t cpumask;
 -	int alloc_policy;
  };
  
  
diff --cc block/blk-mq.c
index dc5f47f60931,f1c5263c44e8..000000000000
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@@ -224,11 -245,21 +224,11 @@@ struct request *blk_mq_alloc_request(st
  		return ERR_PTR(ret);
  
  	ctx = blk_mq_get_ctx(q);
- 	hctx = q->mq_ops->map_queue(q, ctx->cpu);
+ 	hctx = blk_mq_map_queue(q, ctx->cpu);
  	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
 -
  	rq = __blk_mq_alloc_request(&alloc_data, rw, 0);
 -	if (!rq && !(flags & BLK_MQ_REQ_NOWAIT)) {
 -		__blk_mq_run_hw_queue(hctx);
 -		blk_mq_put_ctx(ctx);
 -
 -		ctx = blk_mq_get_ctx(q);
 -		hctx = blk_mq_map_queue(q, ctx->cpu);
 -		blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
 -		rq =  __blk_mq_alloc_request(&alloc_data, rw, 0);
 -		ctx = alloc_data.ctx;
 -	}
  	blk_mq_put_ctx(ctx);
 +
  	if (!rq) {
  		blk_queue_exit(q);
  		return ERR_PTR(-EWOULDBLOCK);

--------------E46A1E35ADB7677398403FBE--
