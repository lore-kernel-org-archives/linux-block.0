Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A709C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A26F60F4A
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhIOGm5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 02:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhIOGm5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 02:42:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E52C061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 23:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=C7VNn0hd1aMSxyn3sAhSUzuP+acVhrXFolc7zCbfteg=; b=bQv3SzRii8TMPRCsNo/9uApvvH
        2XiE94FG6g2PVYCchThRBgbBbDOG5CVQcNe3zb8c2WjO7o6SFa5KmIJGhJhqenDil8brf6ue0pJ0C
        X8Q8DQ2pDA4Wn/YHSerMiCvZ5LjPv+SRitnV5HQmmRCYqSmBIT+qQH8ZAR+LkMU7yghsdImEVQR21
        DZWBnR/03NGX366O5ZFIXCjNDmy3HGD9OXFNb4W+dDXMNtHboh7lsX25xP1GKmewr0FeosQCbNU+S
        NAGeHCcGBKEbBxXJQ3F89guCboQwZh1xrHHlcdgp/aA/ngBuGoaBWv1IcfEEY9FBr3uN8zuZ3Tu30
        T7IPac9g==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOb8-00FQbc-Fn; Wed, 15 Sep 2021 06:41:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: untangle the block headers
Date:   Wed, 15 Sep 2021 08:40:27 +0200
Message-Id: <20210915064044.950534-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series untangles the worst of the block header maze.  It removes
various includes from blkdev.h and genhd.h, and also ensures the
writeback code doesn't pull in blkdev.h leading to huge rebuilds
whenever they change.  Finally it moves various bits out of blkdev.h
which shouldn't be in the general block layer header.

It has surived various randomconfig builds from me and the buildbot,
but I suspect there are a few more conditionally missing headers
that will emerge later for more oscure configs, so it would be great
to get this out early.

Diffstat:
 arch/mips/rb532/prom.c                     |    1 
 arch/mips/sibyte/common/cfe.c              |    1 
 arch/mips/sibyte/swarm/setup.c             |    1 
 arch/openrisc/mm/init.c                    |    1 
 arch/um/drivers/ubd_kern.c                 |    1 
 block/bdev.c                               |    1 
 block/bfq-cgroup.c                         |    2 
 block/bfq-iosched.c                        |    2 
 block/bio-integrity.c                      |    2 
 block/blk-core.c                           |    1 
 block/blk-crypto-fallback.c                |    1 
 block/blk-crypto-internal.h                |    2 
 block/blk-integrity.c                      |    2 
 block/blk-iolatency.c                      |    1 
 block/blk-merge.c                          |   25 
 block/blk-mq-sched.h                       |    1 
 block/blk-mq-tag.h                         |    2 
 block/blk-mq.c                             |    2 
 block/blk.h                                |   40 +
 block/bounce.c                             |    1 
 block/elevator.c                           |    2 
 block/elevator.h                           |   21 
 block/genhd.c                              |    1 
 block/holder.c                             |    1 
 block/keyslot-manager.c                    |    1 
 block/kyber-iosched.c                      |    2 
 block/mq-deadline.c                        |    2 
 block/partitions/core.c                    |    1 
 block/t10-pi.c                             |    2 
 drivers/block/amiflop.c                    |    2 
 drivers/block/ataflop.c                    |    1 
 drivers/block/floppy.c                     |    1 
 drivers/block/rnbd/rnbd-proto.h            |    2 
 drivers/block/swim.c                       |    1 
 drivers/block/xen-blkfront.c               |    1 
 drivers/gpu/drm/i915/i915_utils.h          |    1 
 drivers/md/dm-bio-record.h                 |    1 
 drivers/md/dm-crypt.c                      |    1 
 drivers/md/dm-ps-historical-service-time.c |    1 
 drivers/md/dm-rq.c                         |    1 
 drivers/md/dm-table.c                      |    1 
 drivers/md/dm-verity-target.c              |    1 
 drivers/md/md.c                            |    2 
 drivers/mmc/core/sd.c                      |    1 
 drivers/mtd/mtdsuper.c                     |    1 
 drivers/nvdimm/core.c                      |    1 
 drivers/nvme/host/core.c                   |    1 
 drivers/nvme/host/pci.c                    |    1 
 drivers/nvme/host/rdma.c                   |    1 
 drivers/nvme/target/io-cmd-bdev.c          |    1 
 drivers/nvme/target/rdma.c                 |    1 
 drivers/s390/block/dasd_genhd.c            |    1 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c     |    1 
 drivers/scsi/lpfc/lpfc.h                   |    1 
 drivers/scsi/scsi_lib.c                    |    1 
 drivers/scsi/sd.c                          |    1 
 drivers/scsi/sd_dif.c                      |    2 
 drivers/scsi/sg.c                          |    1 
 drivers/scsi/sr.c                          |    1 
 drivers/scsi/st.c                          |    1 
 drivers/scsi/virtio_scsi.c                 |    1 
 drivers/target/target_core_file.c          |    1 
 drivers/target/target_core_iblock.c        |    2 
 fs/btrfs/compression.c                     |    1 
 fs/btrfs/ctree.c                           |    1 
 fs/btrfs/inode.c                           |    1 
 fs/f2fs/compress.c                         |    1 
 fs/ntfs/file.c                             |    1 
 fs/ntfs3/file.c                            |    1 
 fs/orangefs/inode.c                        |    2 
 fs/orangefs/super.c                        |    1 
 fs/quota/quota.c                           |    1 
 fs/ramfs/inode.c                           |    1 
 include/linux/backing-dev.h                |   19 
 include/linux/blk-integrity.h              |  183 +++++++
 include/linux/blk-mq.h                     |  465 ++++++++++++++++++
 include/linux/blk_types.h                  |    2 
 include/linux/blkdev.h                     |  743 -----------------------------
 include/linux/blktrace_api.h               |    2 
 include/linux/genhd.h                      |   14 
 include/linux/part_stat.h                  |    1 
 include/linux/t10-pi.h                     |    2 
 include/linux/writeback.h                  |   14 
 include/scsi/scsi_device.h                 |    2 
 init/main.c                                |    1 
 kernel/acct.c                              |    1 
 kernel/exit.c                              |    1 
 kernel/fork.c                              |    1 
 kernel/sched/core.c                        |    2 
 kernel/sched/sched.h                       |    1 
 lib/random32.c                             |    1 
 mm/backing-dev.c                           |   19 
 mm/filemap.c                               |    1 
 mm/highmem.c                               |    1 
 mm/mempool.c                               |    1 
 mm/nommu.c                                 |    1 
 mm/readahead.c                             |    1 
 mm/shmem.c                                 |    1 
 mm/swapfile.c                              |    2 
 99 files changed, 830 insertions(+), 825 deletions(-)
