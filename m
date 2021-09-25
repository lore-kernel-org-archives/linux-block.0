Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E548C433FE
	for <linux-block@archiver.kernel.org>; Sat, 25 Sep 2021 20:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598C661090
	for <linux-block@archiver.kernel.org>; Sat, 25 Sep 2021 20:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhIYUeS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Sep 2021 16:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhIYUeN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Sep 2021 16:34:13 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA42C06176A
        for <linux-block@vger.kernel.org>; Sat, 25 Sep 2021 13:32:35 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id w1so14454765ilv.1
        for <linux-block@vger.kernel.org>; Sat, 25 Sep 2021 13:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=DjoQ8DR8uRQrakcf0hKDSJZKLaj8QglUTAZQ9w6AAlQ=;
        b=YSULce+COrOKLEhb5agm1+7WZBUbWsB8RcBePTwY9xEddEmepGBdDea6CLIxByjIiC
         c3lH+d5lcbnXgHpGc74HrbGd5BmbonmFbod7dP8FVbCdkfUkAF6YU4ntx+luTUrWDoJo
         SYntxILe7oxvT5KYMRBP3b60XqxM1Prfiez9rbyGZKArMZOvEsg52mNwXLWhY7MWKdxD
         Q17VWXWx3w4xbEX+JF46gY6qwFMhGwpIozNcQ6KOHDlsq2Pt/DPVMKFFR44of+BqzHoU
         qLDYgiWi87x1w6yrpFZ/IeWtsZc+WycYIQQ+HRawt7SSrTagK4+Vt14BfzbNdEQrR7Di
         UtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=DjoQ8DR8uRQrakcf0hKDSJZKLaj8QglUTAZQ9w6AAlQ=;
        b=WbWdER7YVYdpVk26pQMs81P/ffwWaUP2eN/3FwObSDXZ2ez5TGutGbUXJVCcDwkMnr
         wtReJIsvRUeN320wTUl2BOPJkKNa7Gr0nc70uNnTF6qKDgNawt80uSPhReF/D2x2ROKG
         hyi20kAN6ffEcuHiZ+cHKNUFWHyrQoDoC+i6arszyhDLHTvcXFAyDCe78cmWJh83v+KK
         Vg1XUkv5FQQQIufZAef583otWMYGw5N3IXmoGPOwOk970SvB1rPRJCHHMWs+TUgjG90m
         Or8G9NkmR8QpccEGAqyjvqNqy7DYSv8RGMPTsA/GXbQTM7sYyYg3cIHpUSrtfs4XmyQ6
         MoDw==
X-Gm-Message-State: AOAM532p5vOh53YYAvm7i5rtLUZgT3ynHU8GX6+Jf4WGg2Dn7RcRG/YM
        YKlPZ8Y4eIkTYE/BlPvyVg7+5bFvfZOYfw==
X-Google-Smtp-Source: ABdhPJwx9v6IYNf6w4rrWP9n0VwzgL34j3zWhtBoSXia9Rwlt8qZ5AqRog/fQ3Vw87g+jRdo1MVhIQ==
X-Received: by 2002:a92:2c0d:: with SMTP id t13mr13018585ile.99.1632601954191;
        Sat, 25 Sep 2021 13:32:34 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id f17sm6285191ilq.44.2021.09.25.13.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Sep 2021 13:32:33 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.15-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <7bab443c-0410-470b-a95c-b3c2e0ca908e@kernel.dk>
Date:   Sat, 25 Sep 2021 14:32:32 -0600
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

- NVMe pull request via Christoph:
	- keep ctrl->namespaces ordered (Christoph Hellwig)
	- fix incorrect h2cdata pdu offset accounting in nvme-tcp
	  (Sagi Grimberg)
	- handled updated hw_queues in nvme-fc more carefully (Daniel
	  Wagner, James Smart)

- md lock order fix (Christoph)

- fallocate locking fix (Ming)

- blktrace UAF fix (Zhihao)

- rq-qos bio tracking fix (Ming)

Please pull!


The following changes since commit 858560b27645e7e97aca37ee8f232cccd658fbd2:

  blk-cgroup: fix UAF by grabbing blkcg lock before destroying blkg pd (2021-09-15 12:03:18 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.15-2021-09-25

for you to fetch changes up to f278eb3d8178f9c31f8dfad7e91440e603dd7f1a:

  block: hold ->invalidate_lock in blkdev_fallocate (2021-09-24 11:06:58 -0600)

----------------------------------------------------------------
block-5.15-2021-09-25

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: keep ctrl->namespaces ordered
      md: fix a lock order reversal in md_alloc

Daniel Wagner (1):
      nvme-fc: update hardware queues before using them

James Smart (2):
      nvme-fc: avoid race between time out and tear down
      nvme-fc: remove freeze/unfreeze around update_nr_hw_queues

Jens Axboe (2):
      Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.15
      Merge tag 'nvme-5.15-2021-09-24' of git://git.infradead.org/nvme into block-5.15

Ming Lei (2):
      block: don't call rq_qos_ops->done_bio if the bio isn't tracked
      block: hold ->invalidate_lock in blkdev_fallocate

Sagi Grimberg (1):
      nvme-tcp: fix incorrect h2cdata pdu offset accounting

Zhihao Cheng (1):
      blktrace: Fix uaf in blk_trace access after removing by sysfs

 block/bio.c              |  2 +-
 block/fops.c             | 21 ++++++++++-----------
 drivers/md/md.c          |  5 -----
 drivers/nvme/host/core.c | 33 +++++++++++++++++----------------
 drivers/nvme/host/fc.c   | 18 +++++++++---------
 drivers/nvme/host/tcp.c  | 13 ++++++++++---
 kernel/trace/blktrace.c  |  8 ++++++++
 7 files changed, 55 insertions(+), 45 deletions(-)

-- 
Jens Axboe

