Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E87CC4332F
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 19:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJCTkk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 15:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJCTkV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 15:40:21 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8279AE005
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 12:40:19 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n192so8933834iod.3
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=So1wXI+U6eoG/PUGPDwz8jZW35iglBolD2VBcHf/xEI=;
        b=NsvVyO/1/dF2hEa/7O0u/5xPwUyERbgpGrezWS4C/20auMHVp4bey0vpXkFyal9knG
         oUsixp3iKpEuvCm7oCi1dF9XtlOMYIc+Um1qdLZQlEH/1VBNZ425VfN7PMnDIDZiEsb9
         BJl3cbx7U+q6WRR9aTt3sHhuoYLYwLDmutT3UWNpioJgTxGoGDDZgTNkBduhG2oE4bgO
         V44Ybdcfvb1VEYJpdQ6OGvSaqggZlQW7Z8c+vTWJVbBz6C2ksbOdlDPUUHCX4fa7bD2q
         ezsQX4YmHq6Dyf95bBAb2r2+fOht2fcSYcWnQ7+8KUDlfdC77fTjUL9H5V4uZduv6U1M
         xnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=So1wXI+U6eoG/PUGPDwz8jZW35iglBolD2VBcHf/xEI=;
        b=YNJ8NgyTV5+SA6wYZcz1ja5tNXgTYGVUJ/TjDdHwtpBPx754GFnk6RletrA2zDGobq
         WGKc0K79vdPnlO17eayXOYrk8f2+tx1TQ1h/xSUCDb+xUyw8yR2D80SoQqxYLTFICWHv
         4fGxb00sjFXAidWiaHR6dmABdA8c8q/vjBhH1aCkjpGduThgnK/Sp668V9rSWzGhs/C6
         zv9C96HhVUJdOqrkKYArLH6xwIKU0j/tvZ/wWoYLfxFD81xvh1y9oxBTXpXPo35UZSfH
         PR8mZitDmkds87/caVoLDesH1+0gX7f9Z7wE+cN1iv0lgXi0rWE4t1pODdotzKJ7U2IX
         zBog==
X-Gm-Message-State: ACrzQf2wwcBeKUTKwY+/YcBcCm6eXykHKWTlT7MXDdA1vauTI9hqfhRA
        4WCfyWzeFBjYLOturtdr2Uup0Q==
X-Google-Smtp-Source: AMsMyM4LlFbwF9Y9QNTbZlIL3aV8Dwaxh0QrA6BX2me2SufkKvJprcviPfg87OIOhxl6rv1ys2Vqew==
X-Received: by 2002:a05:6638:168e:b0:35a:196a:9e7e with SMTP id f14-20020a056638168e00b0035a196a9e7emr11053137jat.201.1664826018878;
        Mon, 03 Oct 2022 12:40:18 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u12-20020a02b1cc000000b003435c50f000sm4461260jah.14.2022.10.03.12.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 12:40:18 -0700 (PDT)
Message-ID: <dcefcabc-db87-f285-ddce-ad8db26feb2e@kernel.dk>
Date:   Mon, 3 Oct 2022 13:40:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Passthrough updates for 6.1-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of the block and io_uring branches, here are a set of updates for
the passthrough support that was merged in the 6.0 kernel. With these
changes, passthrough NVMe support over io_uring now performs at the same
level as block device O_DIRECT, and in many cases 6-8% better. This pull
request contains:

- Add support for fixed buffers for passthrough (Anuj, Kanchan)

- Enable batched allocations and freeing on passthrough, similarly to
  what we support on the normal storage path (me)

Please pull!


The following changes since commit 30514bd2dd4e86a3ecfd6a93a3eadf7b9ea164a0:

  sbitmap: fix lockup while swapping (2022-09-29 17:58:17 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.1/passthrough-2022-10-03

for you to fetch changes up to 23fd22e55b767be9c31fda57205afb2023cd6aad:

  nvme: wire up fixed buffer support for nvme passthrough (2022-09-30 07:51:13 -0600)

----------------------------------------------------------------
for-6.1/passthrough-2022-10-03

----------------------------------------------------------------
Anuj Gupta (6):
      io_uring: add io_uring_cmd_import_fixed
      io_uring: introduce fixed buffer support for io_uring_cmd
      block: add blk_rq_map_user_io
      scsi: Use blk_rq_map_user_io helper
      nvme: Use blk_rq_map_user_io helper
      block: rename bio_map_put to blk_mq_map_bio_put

Jens Axboe (8):
      Merge branch 'for-6.1/block' into for-6.1/passthrough
      Merge branch 'for-6.1/io_uring' into for-6.1/passthrough
      block: kill deprecated BUG_ON() in the flush handling
      block: enable batched allocation for blk_mq_alloc_request()
      block: change request end_io handler to pass back a return value
      block: allow end_io based requests in the completion batch handling
      nvme: split out metadata vs non metadata end_io uring_cmd completions
      nvme: enable batched completions of passthrough IO

Kanchan Joshi (6):
      nvme: refactor nvme_add_user_metadata
      nvme: refactor nvme_alloc_request
      block: factor out blk_rq_map_bio_alloc helper
      block: extend functionality to map bvec iterator
      nvme: pass ubuffer as an integer
      nvme: wire up fixed buffer support for nvme passthrough

 block/blk-flush.c                  |  11 +-
 block/blk-map.c                    | 150 ++++++++++++++++---
 block/blk-mq.c                     | 107 ++++++++++++--
 drivers/md/dm-rq.c                 |   4 +-
 drivers/nvme/host/core.c           |   6 +-
 drivers/nvme/host/ioctl.c          | 227 +++++++++++++++++++----------
 drivers/nvme/host/pci.c            |  12 +-
 drivers/nvme/target/passthru.c     |   5 +-
 drivers/scsi/scsi_error.c          |   4 +-
 drivers/scsi/scsi_ioctl.c          |  22 +--
 drivers/scsi/sg.c                  |  31 +---
 drivers/scsi/st.c                  |   4 +-
 drivers/target/target_core_pscsi.c |   6 +-
 drivers/ufs/core/ufshpb.c          |   8 +-
 include/linux/blk-mq.h             |  12 +-
 include/linux/io_uring.h           |  10 +-
 include/uapi/linux/io_uring.h      |   9 ++
 io_uring/uring_cmd.c               |  29 +++-
 18 files changed, 476 insertions(+), 181 deletions(-)

-- 
Jens Axboe
