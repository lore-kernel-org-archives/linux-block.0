Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912F2C433E6
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 20:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCF664F80
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 20:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhCLU3s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbhCLU3n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 15:29:43 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA8AC061574
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 12:29:42 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id x29so16602736pgk.6
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 12:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UeDWw6Np1eI120i2i7RSNebFxLMgX8BqbvihiK3n5s0=;
        b=BkXNgaRkAHQtke97UyL68NuIiJIYBt15C/jRZvZqVt8cS5Wb6ojCociICKTMTmp7se
         ZzDSTVFULawfBvtUImMmE8HmOpD0Nu0PwlMl82az8i4cDAeyGHEf9DVWjL/NJ3W422Ho
         OAOChLCZ+v82wLE/PpXgWT1R3zfQMXw6SVxpHwyPXU7LSPZqhlKu6zNCUnE3j0uR3FeT
         vMiBtlNhvWHNJvarzAdbUdRQZdQqGp7EZPqiMJq2jCl8Y9OpBDoB+EhWPZyb19u3zVqS
         oLhqckzIgbUYTP1r0tAUArAagETXk4ZpojACoFJ3y5nVgWmsND7a+uZ+uhGtxF1iRnUC
         y1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UeDWw6Np1eI120i2i7RSNebFxLMgX8BqbvihiK3n5s0=;
        b=qaP7ERQ/0YADdxyuAgZU8HbZcnMnEmvpKf0ZH6okQgbzS+ypnLb4YqzGLCqVM7Tdo8
         x0hacunw2iDdqTJCaF/D6GsRFfGKCW/Y7Kan6OXbB4z1dAaSFCMdnEmeI8JC1wXbfGrM
         oYLSNOP/iGjGy1S8/MvkUbp6eeIObitMc1k7IoqCZXncdjCcMoVgem/Wz1gxxmC292YN
         uzFOkoE9iM0RnQj8KOVWcIT+b1HxWo7e4Q5fTlNM+EM+Hl65WkJ1iys0tVjwXl2AY05Q
         r+0z9WnqhcwVsYllAmE1OS4oEKItm+7X1lp+NVHlIHHSx7UMfe8Z3tZa1Mf8wDic9VR/
         OdOA==
X-Gm-Message-State: AOAM530hfw4FUf2YAhYhwbB9tZ/MVBuCViMMjpBq0YLWrvY9tdIpTQ9n
        uWOXDXrB9K9K7Meg/vJ/ildL8yh1xIS2FbEa
X-Google-Smtp-Source: ABdhPJwLPVpA/C+hL1twrpuuVbK5EkKg6MvFWDuY2t+TCZAttqfYmg8VGePMjHT/ShsWJwlXNn6SBA==
X-Received: by 2002:a63:440e:: with SMTP id r14mr13243672pga.331.1615580982065;
        Fri, 12 Mar 2021 12:29:42 -0800 (PST)
Received: from ?IPv6:2600:380:b46b:1540:2a49:5dda:db8:a2f8? ([2600:380:b46b:1540:2a49:5dda:db8:a2f8])
        by smtp.gmail.com with ESMTPSA id w203sm6362301pff.59.2021.03.12.12.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 12:29:41 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL v2] Block fixes for 5.12-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <cc2462b6-b7ae-200c-d9f6-1a3d1aac3632@kernel.dk>
Date:   Fri, 12 Mar 2021 13:29:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Mostly just random fixes all over the map. Only odd-one-out change is
finally getting the rename of BIO_MAX_PAGES to BIO_MAX_VECS done. This
should've been done with the multipage bvec change, but it's been left.
Do it now to avoid hassles around changes piling up for the next merge
window.

- NVMe pull request
	- one more quirk (Dmitry Monakhov)
	- fix max_zone_append_sectors initialization (Chaitanya Kulkarni)
	- nvme-fc reset/create race fix (James Smart)
	- fix status code on aborts/resets (Hannes Reinecke)
	- fix the CSS check for ZNS namespaces (Chaitanya Kulkarni)
	- fix a use after free in a debug printk in nvme-rdma (Lv Yunlong)

- Follow-up NVMe error fix for NULL 'id' (Christoph)

- Fixup for the bd_size_lock being IRQ safe, now that the offending
  driver has been dropped (Damien).

- rsxx probe failure error return (Jia-Ju)

- umem probe failure error return (Wei)

- s390/dasd unbind fixes (Stefan)

- blk-cgroup stats summing fix (Xunlei)

- zone reset handling fix (Damien)

- Rename BIO_MAX_PAGES to BIO_MAX_VECS (Christoph)

- Suppress uevent trigger for hidden devices (Daniel)

- Fix handling of discard on busy device (Jan)

- Fix stale cache issue with zone reset (Shin'ichiro)

Please pull!


The following changes since commit a2b658e4a07d05fcf056e2b9524ed8cc214f486a:

  Merge tag 'nvme-5.12-2021-03-05' of git://git.infradead.org/nvme into block-5.12 (2021-03-05 09:13:07 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.12-2021-03-12-v2

for you to fetch changes up to f4f9fc29e56b6fa9d7fa65ec51d3c82aff99c99b:

  nvme: fix the nsid value to print in nvme_validate_or_alloc_ns (2021-03-12 13:17:45 -0700)

----------------------------------------------------------------
block-5.12-2021-03-12-v2

----------------------------------------------------------------
Chaitanya Kulkarni (2):
      nvme: set max_zone_append_sectors nvme_revalidate_zones
      nvme-core: check ctrl css before setting up zns

Christoph Hellwig (2):
      block: rename BIO_MAX_PAGES to BIO_MAX_VECS
      nvme: fix the nsid value to print in nvme_validate_or_alloc_ns

Damien Le Moal (1):
      block: Fix REQ_OP_ZONE_RESET_ALL handling

Daniel Wagner (1):
      block: Suppress uevent for hidden device when removed

Dmitry Monakhov (1):
      nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a Samsung PM1725a

Hannes Reinecke (4):
      nvme: simplify error logic in nvme_validate_ns()
      nvme: add NVME_REQ_CANCELLED flag in nvme_cancel_request()
      nvme-fc: set NVME_REQ_CANCELLED in nvme_fc_terminate_exchange()
      nvme-fc: return NVME_SC_HOST_ABORTED_CMD when a command has been aborted

James Smart (1):
      nvme-fc: fix racing controller reset and create association

Jan Kara (1):
      block: Try to handle busy underlying device on discard

Jens Axboe (1):
      Merge tag 'nvme-5.12-2021-03-12' of git://git.infradead.org/nvme into block-5.12

Jia-Ju Bai (1):
      block: rsxx: fix error return code of rsxx_pci_probe()

Lv Yunlong (1):
      nvme-rdma: Fix a use after free in nvmet_rdma_write_data_done

Shin'ichiro Kawasaki (1):
      block: Discard page cache of zone reset target range

Stefan Haberland (2):
      s390/dasd: fix hanging DASD driver unbind
      s390/dasd: fix hanging IO request during DASD driver unbind

Wei Yongjun (1):
      umem: fix error return code in mm_pci_probe()

Xunlei Pang (1):
      blk-cgroup: Fix the recursive blkg rwstat

 block/bio.c                    | 14 +++++++-------
 block/blk-cgroup-rwstat.c      |  3 ++-
 block/blk-crypto-fallback.c    |  2 +-
 block/blk-lib.c                |  2 +-
 block/blk-map.c                |  2 +-
 block/blk-zoned.c              | 40 +++++++++++++++++++++++++++++++++++++---
 block/bounce.c                 |  6 +++---
 block/genhd.c                  |  4 +---
 drivers/block/drbd/drbd_int.h  |  2 +-
 drivers/block/rsxx/core.c      |  1 +
 drivers/block/umem.c           |  5 ++++-
 drivers/md/bcache/super.c      |  2 +-
 drivers/md/dm-crypt.c          |  8 ++++----
 drivers/md/dm-writecache.c     |  4 ++--
 drivers/md/raid5-cache.c       |  4 ++--
 drivers/md/raid5-ppl.c         |  2 +-
 drivers/nvme/host/core.c       | 15 +++++++++++----
 drivers/nvme/host/fc.c         |  5 +++--
 drivers/nvme/host/pci.c        |  1 +
 drivers/nvme/host/zns.c        |  9 +++++++--
 drivers/nvme/target/passthru.c |  6 +++---
 drivers/nvme/target/rdma.c     |  5 ++---
 drivers/s390/block/dasd.c      |  6 +++---
 fs/block_dev.c                 | 17 +++++++++++++----
 fs/btrfs/extent_io.c           |  2 +-
 fs/btrfs/scrub.c               |  2 +-
 fs/crypto/bio.c                |  6 +++---
 fs/erofs/zdata.c               |  2 +-
 fs/ext4/page-io.c              |  2 +-
 fs/f2fs/checkpoint.c           |  2 +-
 fs/f2fs/data.c                 |  4 ++--
 fs/f2fs/segment.c              |  2 +-
 fs/f2fs/segment.h              |  4 ++--
 fs/f2fs/super.c                |  4 ++--
 fs/gfs2/lops.c                 |  2 +-
 fs/iomap/buffered-io.c         |  4 ++--
 fs/iomap/direct-io.c           |  4 ++--
 fs/mpage.c                     |  2 +-
 fs/nilfs2/segbuf.c             |  2 +-
 fs/squashfs/block.c            |  2 +-
 fs/zonefs/super.c              |  2 +-
 include/linux/bio.h            |  4 ++--
 42 files changed, 138 insertions(+), 79 deletions(-)

-- 
Jens Axboe

