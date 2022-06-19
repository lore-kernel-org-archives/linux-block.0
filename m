Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1686DC433EF
	for <linux-block@archiver.kernel.org>; Sun, 19 Jun 2022 06:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiFSGGB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiFSGGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 02:06:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F7CEE2D
        for <linux-block@vger.kernel.org>; Sat, 18 Jun 2022 23:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=SYm7AAAHqkZ81PJH0TfzCDI3HgiEpXhOftqxUNCgyDU=; b=JSF18Ycy7a56lS01rCjlfvh30r
        EilZPNSVyh4+t+A/4S8ydfkjtt4LLTP9sdzcDiHjzBXifIYvEI5d8RRfAqESvL+uVwKxjTcuOYDIG
        MrH3G2qLCJT+3ZXlzwvCJmQUiGWgToHfzRoiWoM5utkGoSgOwH02SX9dpflXZDDPsocrf06yMAOCM
        v7fFI9kBp5eYHoMK/A95ZbNUhi9aBhqNQHGwPqBl7W9PK7rCZx95YMtg+Stx22phwE5YV+DI2KVdk
        934M6gJnAOe8s/zZuLtnkFRoI5sGJ0s0TVto8lhIlgN5PJb7LqR3HeB2/sndgqgml4gOoa/mX3A76
        9khhoxZA==;
Received: from [2001:4bb8:189:7251:513c:d533:c6f1:1e56] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2o4J-00DJla-Da; Sun, 19 Jun 2022 06:05:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: fully tear down the queue in del_gendisk
Date:   Sun, 19 Jun 2022 08:05:46 +0200
Message-Id: <20220619060552.1850436-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series simplifies teardown for most block drivers.  Right now they
also have to call blk_cleanup_queue after calling del_gendisk, making
the teardown process rather confusing.

Instead this series records if the request_queue is owned by the gendisk,
which is always the case except for scsi and dasd or queues without a
gendisk at all, and then does the entire teardown in del_gendisk.

Note that while intended or 5.20, this series is generated against the
block-5.19 branch as that contains fixes in this area that haven't
made it to the for-5.10/block branch yet.

Diffstat:
 arch/m68k/emu/nfblock.c             |    4 
 arch/um/drivers/ubd_kern.c          |    4 
 arch/xtensa/platforms/iss/simdisk.c |    4 
 block/blk-core.c                    |   43 -----
 block/blk-mq-debugfs.c              |    8 
 block/blk-mq.c                      |   43 ++++-
 block/blk-sysfs.c                   |    5 
 block/blk.h                         |    3 
 block/bsg-lib.c                     |    4 
 block/genhd.c                       |   38 +---
 drivers/block/amiflop.c             |    2 
 drivers/block/aoe/aoeblk.c          |    2 
 drivers/block/aoe/aoedev.c          |    2 
 drivers/block/ataflop.c             |    5 
 drivers/block/brd.c                 |    4 
 drivers/block/drbd/drbd_main.c      |    4 
 drivers/block/floppy.c              |    6 
 drivers/block/loop.c                |    3 
 drivers/block/mtip32xx/mtip32xx.c   |  298 +++++-------------------------------
 drivers/block/mtip32xx/mtip32xx.h   |    5 
 drivers/block/n64cart.c             |    2 
 drivers/block/nbd.c                 |    4 
 drivers/block/null_blk/main.c       |    4 
 drivers/block/paride/pcd.c          |    4 
 drivers/block/paride/pd.c           |    4 
 drivers/block/paride/pf.c           |    4 
 drivers/block/pktcdvd.c             |    4 
 drivers/block/ps3disk.c             |    4 
 drivers/block/ps3vram.c             |    4 
 drivers/block/rbd.c                 |    2 
 drivers/block/rnbd/rnbd-clt.c       |    6 
 drivers/block/sunvdc.c              |    4 
 drivers/block/swim.c                |    2 
 drivers/block/swim3.c               |    2 
 drivers/block/sx8.c                 |    6 
 drivers/block/virtio_blk.c          |    3 
 drivers/block/xen-blkfront.c        |    4 
 drivers/block/z2ram.c               |    3 
 drivers/block/zram/zram_drv.c       |    4 
 drivers/cdrom/gdrom.c               |    3 
 drivers/md/bcache/super.c           |    2 
 drivers/md/dm.c                     |    2 
 drivers/md/md.c                     |    4 
 drivers/memstick/core/ms_block.c    |    3 
 drivers/memstick/core/mspro_block.c |    3 
 drivers/mmc/core/block.c            |    1 
 drivers/mmc/core/queue.c            |    1 
 drivers/mtd/mtd_blkdevs.c           |    4 
 drivers/mtd/ubi/block.c             |    4 
 drivers/nvdimm/btt.c                |    4 
 drivers/nvdimm/pmem.c               |    4 
 drivers/nvme/host/apple.c           |    2 
 drivers/nvme/host/core.c            |    3 
 drivers/nvme/host/fc.c              |   12 -
 drivers/nvme/host/multipath.c       |    2 
 drivers/nvme/host/pci.c             |    2 
 drivers/nvme/host/rdma.c            |   12 -
 drivers/nvme/host/tcp.c             |   12 -
 drivers/nvme/target/loop.c          |   12 -
 drivers/s390/block/dasd.c           |    2 
 drivers/s390/block/dasd_genhd.c     |    4 
 drivers/s390/block/dcssblk.c        |    8 
 drivers/s390/block/scm_blk.c        |    4 
 drivers/scsi/scsi_lib.c             |    6 
 drivers/scsi/scsi_sysfs.c           |    2 
 drivers/scsi/sd.c                   |    4 
 drivers/scsi/sr.c                   |    4 
 drivers/ufs/core/ufshcd.c           |    4 
 include/linux/blk-mq.h              |    3 
 include/linux/blkdev.h              |    7 
 70 files changed, 225 insertions(+), 472 deletions(-)
