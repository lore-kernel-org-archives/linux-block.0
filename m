Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D18C04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 23:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9332082E
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 23:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YTi6+Ber"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfEPXMW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 19:12:22 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33534 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfEPXMW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 19:12:22 -0400
Received: by mail-pl1-f179.google.com with SMTP id y3so2375757plp.0
        for <linux-block@vger.kernel.org>; Thu, 16 May 2019 16:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KTJw8DLFxpkT+2eJdxpFuLzFAIXlonpYDU/KqgspgW4=;
        b=YTi6+BerECNoTZ9LsHNG5gi0jOSHe2o8M7H5Tyq7o/ykHlgSZ5VBo2DnE9z/idAwLe
         SPPu9FAqAQ6ZetehnpJKdZLAEYpEfwoW6WVkbFT5zkVU1ePS2A+P77bYhIwCKiUY6p3n
         gcJbA/z4c81ghjU/uiLD0SQ48aX/R88AlEohnZeXdQrcsKKY62DXt7WKnvRsHxlQgPit
         DW7U4hvKiPSNgPrK1uqjJ4jlSBbo+8a97GK6Vtbf/JBQnQwcREe06+4UMKlDy9End6XZ
         NLIrAnSeKZUzbDLEOrZjYYSn1g3OdSrROafhRh7y0IuoN/ZhdBIAlLfm9mBFcruRBkQH
         HDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KTJw8DLFxpkT+2eJdxpFuLzFAIXlonpYDU/KqgspgW4=;
        b=U6w0zV8BKmbj+mGY/GhV0s0bKJzhvOO20KhJAB1TwylDZKyNmHjrPDOlAfk2sf6yIk
         v0CRelx9NuvNPeHFy7647SSdCuLlUdFDEkpZUGC6HIQqexpC/NXXReD24NZGZ/3ydVt5
         7Wm1KG3N6hqgOhIY7CeoG+zPJQxwp6rblGsZ7q86h/2MFPhFGu6acMoFsC/pzjwyf24G
         RftX/UmFBD8ChIjfzC0Lxbjj0Qwc2NtrlFd0G/mcpZk79N4Ld3cSZG3K1eim+hPADO75
         fmJRtK/av0/EXCuPPxif2krr3d12PpwHP06ct3h56J2xKG4P8izmOHt5RkildRoFAP/r
         /t+Q==
X-Gm-Message-State: APjAAAVoN6wcVfBSXpw2EsIUlpoXj/8r7zLwnICkH2RnipPMShzWziRa
        xAZnyKop17+U5ls/YkJa3ziZMl48+DCO4Q==
X-Google-Smtp-Source: APXvYqz24GXdvkWPVAUkfOmEaA1+w9+62rIoMkHXlN1PC9XCzJO1COIc7fKrSnSsVWQchhg8wUwmvw==
X-Received: by 2002:a17:902:6bc2:: with SMTP id m2mr52408710plt.24.1558048340766;
        Thu, 16 May 2019 16:12:20 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id f17sm7046780pgv.16.2019.05.16.16.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 16:12:19 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup block changes for 5.2-rc1
Message-ID: <da4fdf69-a8dc-1e69-f3de-f0accaed544e@kernel.dk>
Date:   Thu, 16 May 2019 17:12:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This pull request is mainly some late lightnvm changes that came in just
before the merge window, as well as fixes that have been queued up since
the initial pull request was frozen. This pull request contains:

- lightnvm changes, fixing race conditions, improving memory
  utilization, and improving pblk compatability (Chansol, Igor, Marcin)

- NVMe pull request with minor fixes all over the map (via Christoph)

- Remove redundant error print in sata_rcar (Geert)

- struct_size() cleanup (Jackie)

- dasd CONFIG_LBADF warning fix (Ming)

- brd cond_resched() improvement (Mikulas)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.2/block-post-20190516


----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme: trace all async notice events

Chansol Kim (1):
      lightnvm: pblk: fix bio leak when bio is split

Christoph Hellwig (2):
      nvme: change locking for the per-subsystem controller list
      nvme: validate cntlid during controller initialisation

Geert Uytterhoeven (1):
      sata_rcar: Remove ata_host_alloc() error printing

Gustavo A. R. Silva (1):
      nvme-pci: mark expected switch fall-through

Hannes Reinecke (2):
      nvme-fc: use separate work queue to avoid warning
      nvme-multipath: avoid crash on invalid subsystem cntlid enumeration

Igor Konopko (23):
      lightnvm: pblk: line reference fix in GC
      lightnvm: pblk: rollback on error during gc read
      lightnvm: pblk: reduce L2P memory footprint
      lightnvm: pblk: remove unused smeta_ssec field
      lightnvm: pblk: gracefully handle GC vmalloc fail
      lightnvm: pblk: fix race during put line
      lightnvm: pblk: ensure that erase is chunk aligned
      lightnvm: pblk: cleanly fail when there is not enough memory
      lightnvm: pblk: set proper read status in bio
      lightnvm: Inherit mdts from the parent nvme device
      lightnvm: pblk: fix lock order in pblk_rb_tear_down_check
      lightnvm: pblk: kick writer on write recovery path
      lightnvm: pblk: fix update line wp in OOB recovery
      lightnvm: pblk: propagate errors when reading meta
      lightnvm: pblk: wait for inflight IOs in recovery
      lightnvm: pblk: remove internal IO timeout
      lightnvm: pblk: GC error handling
      lightnvm: pblk: IO path reorganization
      lightnvm: pblk: recover only written metadata
      lightnvm: track inflight target creations
      lightnvm: do not remove instance under global lock
      lightnvm: pblk: simplify partial read path
      lightnvm: pblk: use nvm_rq_to_ppa_list()

Jackie Liu (1):
      block/bio-integrity: use struct_size() in kmalloc()

Jens Axboe (1):
      Merge branch 'nvme-5.2' of git://git.infradead.org/nvme into for-5.2/block-post

Marcin Dziegielewski (2):
      lightnvm: pblk: set propper line as data_line after gc
      lightnvm: prevent race condition on pblk remove

Max Gurtovoy (1):
      nvme-rdma: remove redundant reference between ib_device and tagset

Maxim Levitsky (2):
      nvme-pci: init shadow doorbell after each reset
      nvme-pci: add known admin effects to augument admin effects log page

Mikulas Patocka (1):
      brd: add cond_resched to brd_free_pages

Ming Lei (1):
      s390/dasd: fix build warning in dasd_eckd_build_cp_raw

Minwoo Im (2):
      nvme-fabrics: remove unused argument
      nvme: fix typos in nvme status code values

 block/bio-integrity.c            |   3 +-
 drivers/ata/sata_rcar.c          |   1 -
 drivers/block/brd.c              |   6 +
 drivers/lightnvm/core.c          |  82 +++++---
 drivers/lightnvm/pblk-cache.c    |   8 +-
 drivers/lightnvm/pblk-core.c     |  65 ++++---
 drivers/lightnvm/pblk-gc.c       |  52 +++---
 drivers/lightnvm/pblk-init.c     |  65 +++----
 drivers/lightnvm/pblk-map.c      |   1 +
 drivers/lightnvm/pblk-rb.c       |  13 +-
 drivers/lightnvm/pblk-read.c     | 394 +++++++++++----------------------------
 drivers/lightnvm/pblk-recovery.c |  74 +++++---
 drivers/lightnvm/pblk-write.c    |   1 +
 drivers/lightnvm/pblk.h          |  28 +--
 drivers/nvme/host/core.c         |  79 ++++----
 drivers/nvme/host/fabrics.c      |   4 +-
 drivers/nvme/host/fc.c           |  14 +-
 drivers/nvme/host/lightnvm.c     |   1 +
 drivers/nvme/host/multipath.c    |   2 +-
 drivers/nvme/host/pci.c          |   4 +-
 drivers/nvme/host/rdma.c         |  34 +---
 drivers/nvme/host/trace.h        |   1 +
 drivers/s390/block/dasd_eckd.c   |   2 +-
 include/linux/lightnvm.h         |   2 +
 include/linux/nvme.h             |   4 +-
 25 files changed, 398 insertions(+), 542 deletions(-)

-- 
Jens Axboe

