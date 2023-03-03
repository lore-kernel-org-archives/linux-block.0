Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613F3C64EC4
	for <linux-block@archiver.kernel.org>; Fri,  3 Mar 2023 12:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCCMpe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Mar 2023 07:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCCMpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Mar 2023 07:45:33 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C723C78A
        for <linux-block@vger.kernel.org>; Fri,  3 Mar 2023 04:45:32 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so6066405pjh.0
        for <linux-block@vger.kernel.org>; Fri, 03 Mar 2023 04:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1677847532;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jU/Hvt7FnuivZ2l75ZXtgMZKggIuIEzPGAn5M5WqgXo=;
        b=FOsP1v38LT5hDlQBQagfvV0APvGwCDWivKLTAi5olUpmoTkAVRQfqgdrA8+lRRW+S2
         llBRfX1XMMCR4yn4sYKjhJsMHrtAHVUwCLuq0cNFIOgkDlHLtb76BHI4gZ/HiaD/zx5A
         GDtM//mWv/99ZdHnkOtSTFRQRhzbkS3jGZ1G0hcplXonL1bU28lALKQXcq4PXiOFjCbq
         6iEcKBWreaQ3Vh37nyN2518sQZsTIMtLL2Cd36NdJoXoIAjJ6xtVnw3GfFmthlzpPdz7
         H/4wlxS4/g7u04q+HlITSLh1JAQxz6epDj8tuz0dH1WFW2v8uYZKkM3FEMYs+ZOTsFof
         5qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677847532;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jU/Hvt7FnuivZ2l75ZXtgMZKggIuIEzPGAn5M5WqgXo=;
        b=nu+DTen7oPyiuejm+35I5Eah4N6aoAt+Ph1Bkt6QK+w1fcS3b+U2jyJgY9OKpOqEXV
         Q0DDEFoKpJHQnDUZONPduW4j8WKOwRkTaocJChJ7Am4i02r9NVtJvuExkgZpZNtSOzOW
         0BLVuyLgdZrSfuYQZX1Sv7T9wVQ+zyY6OsaH77sMb+nOfMElOeIZn5fpElgOh3SkbI9Y
         nj5ELR0Jf3Ro1LGt0IwaEF+GDHl7JogBCceEswUiWwIPIR5p/X/fJszYyZC4Bfg8Tn7C
         kt5xbGj9elq9JxiH4YEnm1BXnvQGSuI62Xeh35crAJ8tc+TbMxaKikcF+HTS/K8ai+0g
         9xZA==
X-Gm-Message-State: AO0yUKW4Ia0aJjwvsLUcjMAob5WphAj6ul4GzmUpEfwdiFzg/ynefxSM
        n846gNgzDNdbXo5Zwo4C0Ixy9iYBLygbPozW
X-Google-Smtp-Source: AK7set+jLENOHpbzx23sT9VLHfS5DB4cLYvBu6nTFpv/6W/XhMEFoDhqWyL/tsaiagB+N2tLSIxnbg==
X-Received: by 2002:a17:903:32ca:b0:19a:723a:8405 with SMTP id i10-20020a17090332ca00b0019a723a8405mr2133541plr.6.1677847531986;
        Fri, 03 Mar 2023 04:45:31 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id kp3-20020a170903280300b00198ef76ce8dsm1443677plb.72.2023.03.03.04.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 04:45:31 -0800 (PST)
Message-ID: <9d8fd1ba-c96c-667b-daf6-9971958b955a@kernel.dk>
Date:   Fri, 3 Mar 2023 05:45:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup block fixes/changes for 6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Set of block fixes that should go into 6.3-rc1:

- NVMe pull request via Christoph:
	- Don't access released socket during error recovery
	  (Akinobu Mita)
	- Bring back auto-removal of deleted namespaces during
	  sequential scan (Christoph Hellwig)
	- Fix an error code in nvme_auth_process_dhchap_challenge
	  (Dan Carpenter)
	- Show well known discovery name (Daniel Wagner)
	- Add a missing endianess conversion in effects masking
	  (Keith Busch)

- Fix for a regression introduced in blk-rq-qos during init in this
  merge window (Breno)

- Reorder a few fields in struct blk_mq_tag_set, eliminating a few holes
  and shrinking it (Christophe)

- Remove redundant bdev_get_queue() NULL checks (Juhyung)

- Add sed-opal single user mode support flag (Luca)

- Remove SQE128 check in ublk as it isn't needed, saving some memory
  (Ming)

- Op specific segment checking for cloned requests (Uday)

- Exclusive open partition scan fixes (Yu)

- Loop offset/size checking before assigning them in the device (Zhong)

- Bio polling fixes (me)

Please pull!


The following changes since commit 0aa2988e4fd23c0c8b33999d7b47dfbc5e6bf24b:

  brd: use radix_tree_maybe_preload instead of radix_tree_preload (2023-02-17 06:15:53 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.3-2023-03-03

for you to fetch changes up to 49d24398327e32265eccdeec4baeb5a6a609c0bd:

  blk-mq: enforce op-specific segment limits in blk_insert_cloned_request (2023-03-02 21:00:20 -0700)

----------------------------------------------------------------
block-6.3-2023-03-03

----------------------------------------------------------------
Akinobu Mita (1):
      nvme-tcp: don't access released socket during error recovery

Breno Leitao (1):
      blk-iocost: Pass gendisk to ioc_refresh_params

Christoph Hellwig (1):
      nvme: bring back auto-removal of deleted namespaces during sequential scan

Christophe JAILLET (1):
      blk-mq: Reorder fields in 'struct blk_mq_tag_set'

Dan Carpenter (1):
      nvme-auth: fix an error code in nvme_auth_process_dhchap_challenge()

Daniel Wagner (1):
      nvme-fabrics: show well known discovery name

Jens Axboe (3):
      block: clear bio->bi_bdev when putting a bio back in the cache
      block: be a bit more careful in checking for NULL bdev while polling
      Merge tag 'nvme-6.3-2022-03-01' of git://git.infradead.org/nvme into for-6.3/block

Juhyung Park (1):
      block: remove more NULL checks after bdev_get_queue()

Keith Busch (1):
      nvme: fix sparse warning on effects masking

Luca Boccassi (1):
      sed-opal: add support flag for SUM in status ioctl

Ming Lei (1):
      ublk: remove check IO_URING_F_SQE128 in ublk_ch_uring_cmd

Uday Shankar (1):
      blk-mq: enforce op-specific segment limits in blk_insert_cloned_request

Yu Kuai (2):
      block: Revert "block: Do not reread partition table on exclusively open device"
      block: fix scan partition for exclusively open device again

Zhong Jinghua (1):
      loop: loop_set_status_from_info() check before assignment

 block/bio.c                   |  1 +
 block/blk-core.c              | 10 ++++++++--
 block/blk-iocost.c            | 26 ++++++++++++++++++++------
 block/blk-merge.c             |  7 -------
 block/blk-mq.c                |  7 ++++---
 block/blk-zoned.c             | 10 ----------
 block/blk.h                   |  9 ++++++++-
 block/genhd.c                 | 37 ++++++++++++++++++++++++++++---------
 block/ioctl.c                 | 13 ++++++-------
 block/sed-opal.c              |  2 ++
 drivers/block/loop.c          |  8 ++++----
 drivers/block/ublk_drv.c      |  3 ---
 drivers/nvme/host/auth.c      |  2 +-
 drivers/nvme/host/core.c      | 37 +++++++++++++++++++------------------
 drivers/nvme/host/fabrics.h   |  3 ++-
 drivers/nvme/host/tcp.c       |  6 ++++++
 include/linux/blk-mq.h        |  4 ++--
 include/linux/blkdev.h        |  7 +------
 include/uapi/linux/sed-opal.h |  1 +
 kernel/trace/blktrace.c       |  6 +-----
 20 files changed, 114 insertions(+), 85 deletions(-)

-- 
Jens Axboe

