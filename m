Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6C9C433ED
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 15:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E71961078
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 15:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhEGQAv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 May 2021 12:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbhEGQAu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 May 2021 12:00:50 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA6C061574
        for <linux-block@vger.kernel.org>; Fri,  7 May 2021 08:59:50 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id l19so8039628ilk.13
        for <linux-block@vger.kernel.org>; Fri, 07 May 2021 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=TqJYAgSiKEvqxy/yOJNiZvsNy3OX8RdxW1kpvBo7AZw=;
        b=ToEd/Ime4ryqh9AjcUKJ50ZdYmc49o56tzd3Ntbjdkl0r5SvR9F89pDuI7m+KerXlZ
         kWbu5A99F7S1pxrAgafaPh5SuZ5fg8Q5n7cIlCMZwRXfcFjrUNd8RX4WkGHiX2BoZBv0
         QamEO80pAOxaZDb9cx1OzPlkK2jKw001DHcAKcwdi3Ghr1MVw52os8K5kcCj371S3J8T
         iVgcrS2NKz8AoeSJ4l+suACXWegYA80DF4Epap99y1ChpWMdpX20iC+mw/J6prlOusbi
         VAofOICQKGyqucXetVy4IUOSnrNCxvgSuT2Jpnx3ieKRnP5vAWIxmhgH6yXPjxg1nwed
         lxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=TqJYAgSiKEvqxy/yOJNiZvsNy3OX8RdxW1kpvBo7AZw=;
        b=SYyLIABU0mD2PWBOrNSytlCP39HZfZhoiGN1HBsyHoJ5278mGvBsas6kW7JB8BTNvf
         zG4veqVSluIUCZpjOpb8GkJxEF0yJmUZzLDwDDK1zP9T1rLbdKBWLIv0VCpHxrsTFjM+
         AfB3NLAlOyMj/6zkN3CZUwTXuM/wxmPXXLkM2hDPlTy4vL3c4l2dOELVOzqIG3zEcHmj
         9jq5HxpVONlj9YBQR1uIGTrWx1C9ErEFfRv+wS+e7hwHTYCWFZmAYjS0yxqVnfcJYV8v
         rt7fZsZCcAanPzixc1ErxhdxMkgKnzLAi1Ovu/yDfJ6tAHWTHJOCen/NAoclNxGO2xmB
         WgXQ==
X-Gm-Message-State: AOAM531IKkOa928Upibl7qKa8FcYINTNiQ//QcYnYOMRfnmoDKjO7KlK
        ocEAdDt6YT2B87KOrUNlRcDcyIofaHzWLg==
X-Google-Smtp-Source: ABdhPJzI3hL/tC31WOivZMjlphzhszLs7njG00bO6Yl7v7bqyDWlxVw3EtH2SjN8GrDM5vTwNrFhXA==
X-Received: by 2002:a05:6e02:1ca1:: with SMTP id x1mr9706259ill.86.1620403189598;
        Fri, 07 May 2021 08:59:49 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 21sm119660iou.33.2021.05.07.08.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 08:59:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.13-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <237ad54a-fa95-fbb7-a7b7-0a7540928289@kernel.dk>
Date:   Fri, 7 May 2021 09:59:48 -0600
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

- dasd spelling fixes (Bhaskar)

- Limit bio max size on multi-page bvecs to the hardware limit, to avoid
  overly large bio's (and hence latencies). Originally queued for the
  merge window, but needed a fix and was dropped from the initial pull
  (Changheun)

- NVMe pull request (Christoph):
	- reset the bdev to ns head when failover (Daniel Wagner)
	- remove unsupported command noise (Keith Busch)
	- misc passthrough improvements (Kanchan Joshi)
	- fix controller ioctl through ns_head (Minwoo Im)
	- fix controller timeouts during reset (Tao Chiu)

- rnbd fixes/cleanups (Gioh, Md, Dima)

- Fix iov_iter re-expansion (yangerkun)

Please pull!


The following changes since commit 635de956a7f5a6ffcb04f29d70630c64c717b56b:

  Merge tag 'x86-mm-2021-04-29' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2021-04-29 11:41:43 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-07

for you to fetch changes up to cf7b39a0cbf6bf57aa07a008d46cf695add05b4c:

  block: reexpand iov_iter after read/write (2021-05-06 09:24:03 -0600)

----------------------------------------------------------------
block-5.13-2021-05-07

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      s390: dasd: Mundane spelling fixes

Changheun Lee (1):
      bio: limit bio max size

Daniel Wagner (1):
      nvme-multipath: reset bdev to ns head when failover

Dima Stepanov (1):
      block/rnbd: Fix style issues

Gioh Kim (2):
      block/rnbd: Remove all likely and unlikely
      RDMA/rtrs: fix uninitialized symbol 'cnt'

Jens Axboe (1):
      Merge tag 'nvme-5.13-2021-05-05' of git://git.infradead.org/nvme into block-5.13

Kanchan Joshi (2):
      nvme: add nvme_get_ns helper
      nvme: avoid memset for passthrough requests

Keith Busch (1):
      nvmet: remove unsupported command noise

Md Haris Iqbal (2):
      block/rnbd-clt: Change queue_depth type in rnbd_clt_session to size_t
      block/rnbd-clt: Check the return value of the function rtrs_clt_query

Minwoo Im (1):
      nvme: fix controller ioctl through ns_head

Tao Chiu (2):
      nvme: move the fabrics queue ready check routines to core
      nvme-pci: fix controller reset hang when racing with nvme_timeout

yangerkun (1):
      block: reexpand iov_iter after read/write

 block/bio.c                            | 13 ++++-
 block/blk-settings.c                   |  5 ++
 drivers/block/rnbd/rnbd-clt.c          | 46 +++++++++-------
 drivers/block/rnbd/rnbd-clt.h          |  2 +-
 drivers/block/rnbd/rnbd-srv.c          |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c |  3 +-
 drivers/nvme/host/core.c               | 98 ++++++++++++++++++++++++----------
 drivers/nvme/host/fabrics.c            | 57 --------------------
 drivers/nvme/host/fabrics.h            | 13 -----
 drivers/nvme/host/fc.c                 |  4 +-
 drivers/nvme/host/ioctl.c              | 65 +++++++++++++---------
 drivers/nvme/host/multipath.c          |  3 ++
 drivers/nvme/host/nvme.h               | 16 +++++-
 drivers/nvme/host/pci.c                |  3 ++
 drivers/nvme/host/rdma.c               |  4 +-
 drivers/nvme/host/tcp.c                |  4 +-
 drivers/nvme/target/admin-cmd.c        |  6 +--
 drivers/nvme/target/loop.c             |  4 +-
 drivers/s390/block/dasd_eckd.h         |  8 +--
 fs/block_dev.c                         | 20 +++++--
 include/linux/bio.h                    |  4 +-
 include/linux/blkdev.h                 |  2 +
 22 files changed, 216 insertions(+), 166 deletions(-)

-- 
Jens Axboe

