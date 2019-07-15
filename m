Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F81C7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 19:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0272A20659
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 19:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Uhf8L3w+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbfGOTrZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:47:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43155 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731414AbfGOTrY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 15:47:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so7904121pfg.10
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=R9KJjEJ+hhDXrTNR9gUq4EUvdAwHFkyOsq4A2xeKvTU=;
        b=Uhf8L3w+EwWVletIJgyL5URku/v6bP5C3KPsDKoZ0etM8KJFFGCwdq42IXJ1aAuBiP
         e5zGYGdKYxayX5hHzxk4fLqF1Bt29sfJPZgd4IJNM3l+fS7/maV7PKSh+IPfZZAkzWlK
         HDqTyshgUGpyv1BwWjijJMKIjieJkhDlNUMWVDekNat1qkH5pngnTB4OgyiOFf/poF1a
         2KyyXze0QXQ2l6HbWtLdPzAHRxLpCU8uk9XD1XUYRE9gQg3uPmm2eJJknQp9KyUrhc8a
         VlRqWTKBKfXLtBmu5fJ51TcRTGxuuqA3xttqffQccntBMnjhM+YXQJc0Xcwp9KNHMekh
         D/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=R9KJjEJ+hhDXrTNR9gUq4EUvdAwHFkyOsq4A2xeKvTU=;
        b=fy6umxeowxv7qZLDgiXxxtYb00g5o0Z4EDOvJXFZ5aZ2yzXdftTx5yAL7j3RYQGEvD
         lJR7+7ih/DOFkd4Hgce+ctFcPenk88ge2s0z5keS8oT90aS/2Xfuq67f4Qb/HfOToag8
         XSauCpLcP0LTQNGT40oapweuYYknS9/4aR5GjOCBy4quuBZAp9qHH+47YDrK7xozKLrL
         HZwouhCEL85pcbfG78mQZZO+Zfn6UsAvsm4toGS3nMA/qersJslQo+Mc0+ZWO4zXzM/E
         Haz6ePQ5afnwQl4rW16VR9JtVNEKF9kl+yYuTD472oYtgDmamBpw6JPF/hfEHGdhmFoX
         q/XA==
X-Gm-Message-State: APjAAAVypcWF0mpj3+8eASwLU6crXy0ioVoCEeEhrJzUsx6+N0lf0Rv+
        UZ+z7JUrPX1JkqQ+VCWZDL8OyINsSAk=
X-Google-Smtp-Source: APXvYqxtT2DWhBY74C56ebqBkdtmKXttbSLhlbbhB2GI4jXGZTGh3xsaAiBaegvQ7KtpMjfgL3p5TQ==
X-Received: by 2002:a63:c008:: with SMTP id h8mr25156442pgg.427.1563220042435;
        Mon, 15 Jul 2019 12:47:22 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id n98sm18374849pjc.26.2019.07.15.12.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 12:47:20 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block remainders for 5.3-rc1
Message-ID: <c8906a8f-347d-fde8-7f24-f3274fdda50d@kernel.dk>
Date:   Mon, 15 Jul 2019 13:47:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------3C31D22E8D87B0CE906FE391"
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------3C31D22E8D87B0CE906FE391
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

A later pull request with some followup items. I had some vacation
coming up to the merge window, so certain things items were delayed a
bit. This pull request also contains fixes that came in within the last
few days of the merge window, which I didn't want to push right before
sending you a pull request.

This pull request contains:

- NVMe pull request, mostly fixes, but also a few minor items on the
  feature side that were timing constrained (Christoph et al)

- Report zones fixes (Damien)

- Removal of dead code (Damien)

- Turn on cgroup psi memstall (Josef)

- block cgroup MAINTAINERS entry (Konstantin)

- Flush init fix (Josef)

- blk-throttle low iops timing fix (Konstantin)

- nbd resize fixes (Mike)

- nbd 0 blocksize crash fix (Xiubo)

- block integrity error leak fix (Wenwen)

- blk-cgroup writeback and priority inheritance fixes (Tejun)

Note the latter renames wbc_account_io() to wbc_account_cgroup_owner()
to better describe what it does. F2FS and XFS both added another user of
this since the patch was done, see attached for the incremental needed
to fix that up. I didn't want to merge current -git for this, thought it
was cleaner if you just applied that as part of the merge.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190715


----------------------------------------------------------------
Alan Mikhak (2):
      nvme-pci: don't create a read hctx mapping without read queues
      nvme-pci: check for NULL return from pci_alloc_p2pmem()

Bart Van Assche (3):
      nvmet: export I/O characteristics attributes in Identify
      nvme: add I/O characteristics fields
      nvme: set physical block size and optimal I/O size

Christoph Hellwig (2):
      nvme-pci: don't fall back to a 32-bit DMA mask
      nvme-pci: limit max_hw_sectors based on the DMA max mapping size

Colin Ian King (1):
      nvme-trace: fix spelling mistake "spcecific" -> "specific"

Damien Le Moal (8):
      block: Fix potential overflow in blk_report_zones()
      block: Remove unused definitions
      block: Fix elevator name declaration
      block: Disable write plugging for zoned block devices
      block: Allow mapping of vmalloc-ed buffers
      block: Kill gfp_t argument of blkdev_report_zones()
      sd_zbc: Fix report zones buffer allocation
      block: Limit zone array allocation size

Hannes Reinecke (3):
      nvme-multipath: factor out a nvme_path_is_disabled helper
      nvme-multipath: also check for a disabled path if there is a single sibling
      nvme-multipath: do not select namespaces which are about to be removed

James Smart (3):
      nvme-fcloop: fix inconsistent lock state warnings
      nvme-fcloop: resolve warnings on RCU usage and sleep warnings
      nvme-fc: fix module unloads while lports still pending

Jens Axboe (2):
      Merge branch 'nvme-5.3' of git://git.infradead.org/nvme into for-linus
      null_blk: fixup ->report_zones() for !CONFIG_BLK_DEV_ZONED

Josef Bacik (2):
      block: init flush rq ref count to 1
      blk-cgroup: turn on psi memstall stuff

Konstantin Khlebnikov (2):
      blk-throttle: fix zero wait time for iops throttled group
      MAINTAINERS: add entry for block io cgroup

Mike Christie (1):
      nbd: add netlink reconfigure resize support

Mikhail Skorzhinskii (3):
      nvmet: print a hint while rejecting NSID 0 or 0xffffffff
      nvme-tcp: set the STABLE_WRITES flag when data digests are enabled
      nvme-tcp: don't use sendpage for SLAB pages

Minwoo Im (1):
      nvme: fix NULL deref for fabrics options

Sagi Grimberg (1):
      nvme: fix regression upon hot device removal and insertion

Tejun Heo (5):
      cgroup, blkcg: Prepare some symbols for module and !CONFIG_CGROUP usages
      blkcg, writeback: Rename wbc_account_io() to wbc_account_cgroup_owner()
      blkcg, writeback: Add wbc->no_cgroup_owner
      blkcg, writeback: Implement wbc_blkcg_css()
      blkcg: implement REQ_CGROUP_PUNT

Tom Wu (1):
      nvme-trace: add delete completion and submission queue to admin cmds tracer

Wenwen Wang (1):
      block/bio-integrity: fix a memory leak bug

Xiubo Li (1):
      nbd: fix crash when the blksize is zero

YueHaibing (1):
      nvme-pci: make nvme_dev_pm_ops static

 Documentation/admin-guide/cgroup-v2.rst |   2 +-
 Documentation/block/biodoc.txt          |   5 --
 MAINTAINERS                             |  13 ++++
 block/bio-integrity.c                   |   8 ++-
 block/bio.c                             |  28 ++++++++-
 block/blk-cgroup.c                      |  66 +++++++++++++++++--
 block/blk-core.c                        |   6 +-
 block/blk-mq.c                          |   2 +-
 block/blk-mq.h                          |  32 ++++++++++
 block/blk-throttle.c                    |   9 +--
 block/blk-zoned.c                       |  69 +++++++++++---------
 drivers/block/nbd.c                     |  59 +++++++++++++----
 drivers/block/null_blk.h                |   5 +-
 drivers/block/null_blk_zoned.c          |   3 +-
 drivers/md/dm-flakey.c                  |   5 +-
 drivers/md/dm-linear.c                  |   5 +-
 drivers/md/dm-zoned-metadata.c          |  16 +++--
 drivers/md/dm.c                         |   6 +-
 drivers/nvme/host/core.c                |  43 +++++++++++--
 drivers/nvme/host/fc.c                  |  51 ++++++++++++++-
 drivers/nvme/host/multipath.c           |  18 ++++--
 drivers/nvme/host/nvme.h                |   1 +
 drivers/nvme/host/pci.c                 |  26 +++++---
 drivers/nvme/host/tcp.c                 |   9 ++-
 drivers/nvme/host/trace.c               |  28 ++++++++-
 drivers/nvme/target/admin-cmd.c         |   3 +
 drivers/nvme/target/configfs.c          |   4 +-
 drivers/nvme/target/fcloop.c            |  44 ++++++-------
 drivers/nvme/target/io-cmd-bdev.c       |  39 ++++++++++++
 drivers/nvme/target/nvmet.h             |   8 +++
 drivers/nvme/target/trace.c             |   2 +-
 drivers/scsi/sd.h                       |   3 +-
 drivers/scsi/sd_zbc.c                   | 108 ++++++++++++++++++++++----------
 fs/btrfs/extent_io.c                    |   4 +-
 fs/buffer.c                             |   2 +-
 fs/ext4/page-io.c                       |   2 +-
 fs/f2fs/data.c                          |   4 +-
 fs/f2fs/super.c                         |   4 +-
 fs/fs-writeback.c                       |  13 ++--
 fs/mpage.c                              |   2 +-
 include/linux/backing-dev.h             |   1 +
 include/linux/blk-cgroup.h              |  16 ++++-
 include/linux/blk_types.h               |  10 +++
 include/linux/blkdev.h                  |  14 +++--
 include/linux/cgroup.h                  |   1 +
 include/linux/device-mapper.h           |   3 +-
 include/linux/elevator.h                |  11 +---
 include/linux/nvme.h                    |  12 +++-
 include/linux/writeback.h               |  41 +++++++++---
 49 files changed, 658 insertions(+), 208 deletions(-)

-- 
Jens Axboe


--------------3C31D22E8D87B0CE906FE391
Content-Type: text/x-patch;
 name="wbc-cgroup-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="wbc-cgroup-fix.patch"

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 323306630f93..4eb2f3920140 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -513,7 +513,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	}
 
 	if (fio->io_wbc)
-		wbc_account_io(fio->io_wbc, page, PAGE_SIZE);
+		wbc_account_cgroup_owner(fio->io_wbc, page, PAGE_SIZE);
 
 	inc_page_count(fio->sbi, WB_DATA_TYPE(page));
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 761248ee2778..f16d5f196c6b 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -796,7 +796,7 @@ xfs_add_to_ioend(
 	}
 
 	wpc->ioend->io_size += len;
-	wbc_account_io(wbc, page, len);
+	wbc_account_cgroup_owner(wbc, page, len);
 }
 
 STATIC void

--------------3C31D22E8D87B0CE906FE391--
