Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B664C433F5
	for <linux-block@archiver.kernel.org>; Fri,  1 Apr 2022 19:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245438AbiDATkW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Apr 2022 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbiDATkV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Apr 2022 15:40:21 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BE31AC70D
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 12:38:31 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id x4so4373077iop.7
        for <linux-block@vger.kernel.org>; Fri, 01 Apr 2022 12:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=QtLDD+hpm0/9TCUiDXd6oieaWudsMn6CYkvzN9fAUDk=;
        b=TipgiB7gx6HnWAgqXYM75y0heOpMGl0dLFGOhnaPeAJjbpRFou+wLW1IxOXky/9bJt
         XpzVBXThhvNOgxI5FKgvZypR2WmqdvNydpiSul4YdMjrXbQrVQ9cJTXre2xKSOOD3eNR
         p71eCDm9ciNeYliJLmpB5nt9XdtOJvFaHT55vCV8Ejat+CVkNfx0u4tr477i4iMd6KmI
         zOuc2aCiCHxYc3jQhgOXVbgbwSYJzpi0uNmeq7AIxH9P9quaBDxBczLNxVFTGrv7F0jo
         IT7ibUNrftEV6fFiIC4kEB+tHrCXCUKy+mgGadc14VvXlx4Sg6sJ6y9irE2YWJzRNcvp
         UBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=QtLDD+hpm0/9TCUiDXd6oieaWudsMn6CYkvzN9fAUDk=;
        b=JA8EKl4/wgjuOZrLGzS5SWzGSy4vswy68bz1aLStneXauhGWPe54dvCvPbFTdA67h7
         FLUKQdRtk8OImiKYNPV6WTVg2REBy+dP51R+NOrW+omQ3GfIm3EL/vT+T3LnHamhDzhn
         ABglS00pfV5623tJS0YWv3IybqGwEN9pWV5d6QkseHJE6baLs6F7zg8WkCVTUYUdTSz2
         68hx6+juDdDl3Qn8HiBpGfgdpxg0txaBvjsOO976AvGWPBk72jpOvwdzwT3+RekPpRRF
         FX5UH0hPmB2+/cE+QSr/bRFWJEavl2nvK5eLLKWYHSMjjMdio5gE9p/bBeusssVexo0A
         14YQ==
X-Gm-Message-State: AOAM532Ghb/G5/gDOmup71kBdhZhBVuBSLdXjnIgS814VM4MyYKkcVFB
        PS8ji48j6rxh5pxNHrzVZdhIkBZ7qooix9K9
X-Google-Smtp-Source: ABdhPJzntKyjmroB9Nlp7Lkb5D5qV5bfcnBGEIFBmW15bpmIUBUeNF5oUcZzo24ojeL1jKvp8zohtw==
X-Received: by 2002:a05:6638:1194:b0:323:6cfd:9014 with SMTP id f20-20020a056638119400b003236cfd9014mr6439480jas.34.1648841910837;
        Fri, 01 Apr 2022 12:38:30 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f2-20020a056e020c6200b002c9cb3afc79sm1719743ilj.30.2022.04.01.12.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 12:38:30 -0700 (PDT)
Message-ID: <d5869c35-c548-a84a-6355-8dfa0bf6eced@kernel.dk>
Date:   Fri, 1 Apr 2022 13:38:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver fixes for 5.18-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Followup block driver updates and fixes for the 5.18-rc1 merge window.
In detail:

- NVMe pull request
	- Fix multipath hang when disk goes live over reconnect
	  (Anton Eidelman)
	- fix RCU hole that allowed for endless looping in multipath round
	  robin (Chris Leech)
	- remove redundant assignment after left shift (Colin Ian King)
	- add quirks for Samsung X5 SSDs (Monish Kumar R)
	- fix the read-only state for zoned namespaces with unsupposed
	  features (Pankaj Raghav)
	- use a private workqueue instead of the system workqueue in nvmet
	  (Sagi Grimberg)
	- allow duplicate NSIDs for private namespaces (Sungup Moon)
	- expose use_threaded_interrupts read-only in sysfs (Xin Hao)"

- nbd minor allocation fix (Zhang)

- drbd fixes and maintainer addition (Lars, Jakob, Christoph)

- n64cart build fix (Jackie)

- loop compat ioctl fix (Carlos)

- Misc fixes (Colin, Dongli)

Please pull!


The following changes since commit ae53aea611b7a532a52ba966281a8b7a8cfd008a:

  Merge tag 'nvme-5.18-2022-03-17' of git://git.infradead.org/nvme into for-5.18/drivers (2022-03-17 20:46:22 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.18/drivers-2022-04-01

for you to fetch changes up to 2651ee5ae43241831ca63d7158bb2b151a6a0e1f:

  drbd: remove check of list iterator against head past the loop body (2022-03-31 17:08:15 -0600)

----------------------------------------------------------------
for-5.18/drivers-2022-04-01

----------------------------------------------------------------
Anton Eidelman (1):
      nvme-multipath: fix hang when disk goes live over reconnect

Carlos Llamas (1):
      loop: fix ioctl calls using compat_loop_info

Chris Leech (1):
      nvme: fix RCU hole that allowed for endless looping in multipath round robin

Christoph Böhmwalder (1):
      MAINTAINERS: add drbd co-maintainer

Colin Ian King (2):
      xen-blkback: remove redundant assignment to variable i
      nvmet: remove redundant assignment after left shift

Dongli Zhang (1):
      xen/blkfront: fix comment for need_copy

Jackie Liu (1):
      n64cart: convert bi_disk to bi_bdev->bd_disk fix build

Jakob Koschel (2):
      drbd: remove usage of list iterator variable after loop
      drbd: remove check of list iterator against head past the loop body

Jens Axboe (1):
      Merge tag 'nvme-5.18-2022-03-29' of git://git.infradead.org/nvme into for-5.18/drivers

Lars Ellenberg (1):
      drbd: fix potential silent data corruption

Monish Kumar R (1):
      nvme-pci: add quirks for Samsung X5 SSDs

Pankaj Raghav (1):
      nvme: fix the read-only state for zoned namespaces with unsupposed features

Sagi Grimberg (1):
      nvmet: use a private workqueue instead of the system workqueue

Sungup Moon (1):
      nvme: allow duplicate NSIDs for private namespaces

Xin Hao (1):
      nvme-pci: expose use_threaded_interrupts read-only in sysfs

Zhang Wensheng (1):
      nbd: fix possible overflow on 'first_minor' in nbd_dev_add()

 MAINTAINERS                         |  1 +
 drivers/block/drbd/drbd_main.c      |  7 ++++--
 drivers/block/drbd/drbd_req.c       | 45 ++++++++++++++++++++++++-------------
 drivers/block/loop.c                |  1 +
 drivers/block/n64cart.c             |  2 +-
 drivers/block/nbd.c                 | 24 ++++++++++----------
 drivers/block/xen-blkback/blkback.c |  2 +-
 drivers/block/xen-blkfront.c        |  2 +-
 drivers/nvme/host/core.c            | 38 +++++++++++++++++++++----------
 drivers/nvme/host/multipath.c       | 32 +++++++++++++++++++++-----
 drivers/nvme/host/nvme.h            | 23 +++++++++++++++++++
 drivers/nvme/host/pci.c             |  7 ++++--
 drivers/nvme/target/admin-cmd.c     |  2 +-
 drivers/nvme/target/configfs.c      |  2 +-
 drivers/nvme/target/core.c          | 26 +++++++++++++++------
 drivers/nvme/target/fc.c            |  8 +++----
 drivers/nvme/target/fcloop.c        | 16 ++++++-------
 drivers/nvme/target/io-cmd-file.c   |  6 ++---
 drivers/nvme/target/loop.c          |  4 ++--
 drivers/nvme/target/nvmet.h         |  1 +
 drivers/nvme/target/passthru.c      |  2 +-
 drivers/nvme/target/rdma.c          | 12 +++++-----
 drivers/nvme/target/tcp.c           | 10 ++++-----
 include/linux/nvme.h                |  1 +
 include/uapi/linux/loop.h           |  4 ++--
 25 files changed, 186 insertions(+), 92 deletions(-)

-- 
Jens Axboe

