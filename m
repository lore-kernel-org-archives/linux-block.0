Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEF3C4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 12:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJUMCv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 08:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJUMCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 08:02:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D0E26395E
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 05:02:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p14so2382681pfq.5
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y82sWY7VX4bXoGBzyYS+cW2NikdrUDoZb1MhqlMKfl4=;
        b=aH3OJZjI+SyGPS42n8Su/S5jsdPXCMh7TukRFmAzLwVGTHr8KypZ/pYGo6Ijh3ppOj
         1tAjMVZ5qXzAnsi89+qFpGG4l/NUWaX5KR5OKFPZfjXKCt2pBqgkhPiNzVa8NdpUSujs
         Ncl2Ub749ZCFn+jP2wXBm5WoQ4mIu/jNrSaQrrzCDvgnwKcKa8REKbu+IpPeDRenc6nR
         sXpQVL/+Cra4Zq1XBxRWUYVZyqT8H69un9/p/c65Z5BOzEIP04PQBsnPB7UnG7Whd/WE
         OAJgECl5SeLSWDDhQxJ8y2wfFkvZ2zGg1rirM+gg9lIMa52yq6FVQoqmO6M1ccd9Xmb0
         FzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y82sWY7VX4bXoGBzyYS+cW2NikdrUDoZb1MhqlMKfl4=;
        b=ZncqAl1vdIsc+t+KW9nLXLWwAZJUayAcQ0/Ski92gBr3DDUn5NsTzN27xf/WvedbCD
         wvmCk4XPwbinUQ5clVmWuh3bIZgf+3rUe7AMjxQdAc67YA4WlEsoJ2l7cD4SgILMcu7+
         zUvluMEC/78wh1z7ikvYVsjLlcPnx/AZtfnjji3Keo9JfJ/Pg3KFtNREUIDyRsUxgUzK
         FyEWGj2BrFwUibvTFpba1n3gGvIZVTSKtYCMP2yl032snZm0FT3wGS2k++Oc+ATEb40G
         H7ERyX17M+JgdXj2hNPTZ/E6eh9SjGRrzOfalUca+P8fHqM6KU6zG9iOgwWYV5viaTSn
         2O7A==
X-Gm-Message-State: ACrzQf3c9yI8+h7fadXFRflGkgLUxzk15Ie6PSNj4jT6BIdVx1erLE5s
        1pZPGoE8/2vBGfMhQSUEsEcyjL+d4Ef57510
X-Google-Smtp-Source: AMsMyM6BagkkRDj6AeKdxWwd1qg4lT01W1DMPmQqVtFIZl5AYB+6NqQi7/2jCGHTwdbPc8Vl1zq2Pg==
X-Received: by 2002:a63:211d:0:b0:44e:f294:8440 with SMTP id h29-20020a63211d000000b0044ef2948440mr15759006pgh.103.1666353762929;
        Fri, 21 Oct 2022 05:02:42 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id qe10-20020a17090b4f8a00b00200b12f2bf3sm1460954pjb.51.2022.10.21.05.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 05:02:42 -0700 (PDT)
Message-ID: <aee70812-c3a1-43b8-9d7a-92951e1d3d50@kernel.dk>
Date:   Fri, 21 Oct 2022 05:02:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.1-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few block fixes for this release:

- NVMe pull request via Christoph
	- fix nvme-hwmon for DMA non-cohehrent architectures (Serge Semin)
	- add a nvme-hwmong maintainer (Christoph Hellwig)
	- fix error pointer dereference in error handling (Dan Carpenter)
	- fix invalid memory reference in nvmet_subsys_attr_qid_max_show
	  (Daniel Wagner)
	- don't limit the DMA segment size in nvme-apple (Russell King)
	- fix workqueue MEM_RECLAIM flushing dependency (Sagi Grimberg)
	- disable write zeroes on various Kingston SSDs (Xander Li)

- Series fixing a memory leak with block device tracing (Ye)

- flexible-array fix for ublk (Yushan)

- Document the ublk recovery feature from this merge window
  (ZiyangZhang)

- Remove dead bfq variable in struct (Yuwei)

- Error handling rq clearing fix (Yu)

- Add an IRQ safety check for the cached bio freeing (Pavel)

- drbd bio cloning fix (Christoph)

Please pull!


The following changes since commit 3bc429c1e2cf6fa830057c61ae93d483f270b8ff:

  Merge tag 'nvme-6.1-2022-10-12' of git://git.infradead.org/nvme into block-6.1 (2022-10-12 07:15:53 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.1-2022-10-20

for you to fetch changes up to 2db96217e7e515071726ca4ec791742c4202a1b2:

  blktrace: remove unnessary stop block trace in 'blk_trace_shutdown' (2022-10-20 06:02:52 -0700)

----------------------------------------------------------------
block-6.1-2022-10-20

----------------------------------------------------------------
Christoph Böhmwalder (1):
      drbd: only clone bio if we have a backing device

Christoph Hellwig (2):
      nvme: add Guenther as nvme-hwmon maintainer
      nvme-hwmon: consistently ignore errors from nvme_hwmon_init

Dan Carpenter (1):
      nvme: fix error pointer dereference in error handling

Daniel Wagner (1):
      nvmet: fix invalid memory reference in nvmet_subsys_attr_qid_max_show

Jens Axboe (1):
      Merge tag 'nvme-6.1-2022-10-22' of git://git.infradead.org/nvme into block-6.1

Pavel Begunkov (1):
      bio: safeguard REQ_ALLOC_CACHE bio put

Russell King (Oracle) (1):
      nvme-apple: don't limit DMA segement size

Sagi Grimberg (1):
      nvmet: fix workqueue MEM_RECLAIM flushing dependency

Serge Semin (1):
      nvme-hwmon: kmalloc the NVME SMART log buffer

Xander Li (1):
      nvme-pci: disable write zeroes on various Kingston SSD

Ye Bin (3):
      blktrace: introduce 'blk_trace_{start,stop}' helper
      blktrace: fix possible memleak in '__blk_trace_remove'
      blktrace: remove unnessary stop block trace in 'blk_trace_shutdown'

Yu Kuai (1):
      blk-mq: fix null pointer dereference in blk_mq_clear_rq_mapping()

Yushan Zhou (1):
      ublk_drv: use flexible-array member instead of zero-length array

Yuwei Guan (1):
      block, bfq: remove unused variable for bfq_queue

ZiyangZhang (1):
      Documentation: document ublk user recovery feature

 Documentation/block/ublk.rst   | 36 +++++++++++++++++++
 MAINTAINERS                    |  6 ++++
 block/bfq-iosched.h            |  4 ---
 block/bio.c                    |  2 +-
 block/blk-mq.c                 |  7 ++--
 drivers/block/drbd/drbd_req.c  | 14 ++++----
 drivers/block/ublk_drv.c       |  2 +-
 drivers/nvme/host/apple.c      |  2 ++
 drivers/nvme/host/core.c       |  8 +++--
 drivers/nvme/host/hwmon.c      | 32 +++++++++++------
 drivers/nvme/host/pci.c        | 10 ++++++
 drivers/nvme/target/configfs.c |  4 ---
 drivers/nvme/target/core.c     |  2 +-
 kernel/trace/blktrace.c        | 82 ++++++++++++++++++++----------------------
 14 files changed, 135 insertions(+), 76 deletions(-)

-- 
Jens Axboe
