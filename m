Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7F7C43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 17:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiFXRqk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 13:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiFXRqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 13:46:38 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929412D1ED
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 10:46:35 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y18so3452026iof.2
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 10:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=wsLF77e/VAo+aKJ0DPRX3TUZ5IuMnhfs891MtFo7dU0=;
        b=5G8/MV6WieX+4+0oCkr2XDGVf3mPCd5OjsZWuX/OVX4Pyt7dQK/aSm0iorQbh7K/j5
         hKuGrIVEQnJf+n+VycRt8XxyoPIAdFMYloxwc9jOYPGO3XKS1afugU0fzhzG58OOoRH1
         Njx3LDmm9ZtQTaVroZLce1feEOeHsRDjNuQGDhzSDfsZCEl+FXgDCy+pzByEQOzPv5Di
         9/GM5NyqhZQK5v/GC6WQiMIbm6SLv3nbYhjqXw1l4QqQvREo70e7kHKjcNIT2PGZma0k
         EaExGzZcZsHoaOJKUemzCqCiGVHnhOmWD6+B7EyhyXInyLNSG77XxRNgu5omR8l0p5SK
         8mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=wsLF77e/VAo+aKJ0DPRX3TUZ5IuMnhfs891MtFo7dU0=;
        b=ghtorlhV7fN6dM7BtoP4Z/eeN6wZfltljgjJ62pWEk1dTj7dQPTmUm+nYrdkutWN1R
         j72GWqfu6LNEE6IhTEwKyUaIHgYMHhzYldUQqsacK/sLZwp1DUS5YE+bPEXZv4lMHDy1
         sN56pDlBdtp3fDml0EtjoTAe+ubPSMUMqW29d8xa6Yl2lpmloXwEjRvC0rToVIMuFMyX
         z8RWRQ1kNDKfgEpRTjK5QonBSNMLp4wrJ8gS2LWVxbsANtHj5TQy5iyTKB0kMs7qztGo
         NsdiUKAXopFXldRXOXhZzmXIqX4MUP+fQ8yIKf/1FuH5v+MQriybmC6AOa8PEaTiQc5S
         BJMA==
X-Gm-Message-State: AJIora+7c7jKc3ZioYKaZi1jGEUHg41vmD3b+EYPjTt6r4elA+gssDtj
        cNHs7d6mDpMTzseISj/FjHxEmgSQkV0lsQ==
X-Google-Smtp-Source: AGRyM1u20JkJFJ57qfwEG48vT1cJONHmtlkcEld5vqQ9WKvC/m6uSW4RQpDVCXEQLjI0+X1GXQDrTQ==
X-Received: by 2002:a05:6638:f88:b0:339:df22:3d43 with SMTP id h8-20020a0566380f8800b00339df223d43mr215567jal.42.1656092795243;
        Fri, 24 Jun 2022 10:46:35 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g93-20020a028566000000b003319a68d2f5sm1304805jai.125.2022.06.24.10.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 10:46:34 -0700 (PDT)
Message-ID: <327e6b6a-eddf-3eb1-be6f-6a527fa1ad9f@kernel.dk>
Date:   Fri, 24 Jun 2022 11:46:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.19-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Fixes for the 5.19 kernel:

- Series fixing issues with sysfs locking and name reuse (Christoph)

- NVMe pull request via Christoph
	- Fix the mixed up CRIMS/CRWMS constants (Joel Granados)
	- Add another broken identifier quirk (Leo Savernik)
	- Fix up a quirk because Samsung reuses PCI IDs over different
	  products (Christoph Hellwig)

- Remove old WARN_ON() that doesn't apply anymore (Li)

- Fix for using a stale cached request value for rq-qos throttling
  mechanisms that may schedule(), like iocost (me)

- Remove unused parameter to blk_independent_access_range() (Damien)

Please pull!


The following changes since commit b96f3cab59654ee2c30e6adf0b1c13cf8c0850fa:

  block/bfq: Enable I/O statistics (2022-06-16 16:59:28 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.19-2022-06-24

for you to fetch changes up to e531485a0a0e0a06644de1b639502471415d5e12:

  Merge tag 'nvme-5.19-2022-06-23' of git://git.infradead.org/nvme into block-5.19 (2022-06-23 07:55:07 -0600)

----------------------------------------------------------------
block-5.19-2022-06-24

----------------------------------------------------------------
Christoph Hellwig (5):
      block: disable the elevator int del_gendisk
      block: serialize all debugfs operations using q->debugfs_mutex
      block: remove per-disk debugfs files in blk_unregister_queue
      block: freeze the queue earlier in del_gendisk
      nvme: move the Samsung X5 quirk entry to the core quirks

Damien Le Moal (1):
      block: remove queue from struct blk_independent_access_range

Jens Axboe (2):
      block: pop cached rq before potentially blocking rq_qos_throttle()
      Merge tag 'nvme-5.19-2022-06-23' of git://git.infradead.org/nvme into block-5.19

Joel Granados (1):
      nvme: fix the CRIMS and CRWMS definitions to match the spec

Leo Savernik (1):
      nvme: add a bogus subsystem NQN quirk for Micron MTFDKBA2T0TFH

Li Nan (1):
      block: remove WARN_ON() from bd_link_disk_holder

 block/blk-core.c         | 13 -------------
 block/blk-ia-ranges.c    |  1 -
 block/blk-mq-debugfs.c   | 29 ++++++++++++++++++-----------
 block/blk-mq-debugfs.h   | 10 ----------
 block/blk-mq-sched.c     | 11 +++++++++++
 block/blk-mq.c           | 11 ++++++++---
 block/blk-rq-qos.c       |  2 --
 block/blk-rq-qos.h       |  7 ++++++-
 block/blk-sysfs.c        | 30 ++++++++++++++----------------
 block/genhd.c            | 42 ++++++++++++------------------------------
 block/holder.c           |  4 ----
 drivers/nvme/host/core.c | 14 ++++++++++++++
 drivers/nvme/host/pci.c  |  6 ++----
 include/linux/blkdev.h   |  9 ++++-----
 include/linux/nvme.h     |  4 ++--
 kernel/trace/blktrace.c  |  3 ---
 16 files changed, 91 insertions(+), 105 deletions(-)

-- 
Jens Axboe

