Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBB8C77B75
	for <linux-block@archiver.kernel.org>; Sat,  6 May 2023 10:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjEFKvR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 May 2023 06:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjEFKvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 May 2023 06:51:15 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3150B44A0
        for <linux-block@vger.kernel.org>; Sat,  6 May 2023 03:51:14 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9e7058d52aso459761276.0
        for <linux-block@vger.kernel.org>; Sat, 06 May 2023 03:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683370273; x=1685962273;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4lYB/swm1Oc9U88peOo/UZACzE4REZ1+acY56MWRcc=;
        b=1fABiimhUfEQm8A9TBrXLHYCju8KXkQngK4H5oy1S26sxfGPPh9jSeCHLGB86Qwvyi
         sLAfxBdLGOjBVEjR81c6Lo0cKdrzyWC9FoN9wwwKXRxRJAnSZdpbPOm7IMI/jc3mk4/T
         kQoQtWh00sCpkVwY4JnHqbJ2cxLm5Q9cPqeHY5bVQuDvvQELZGab/qfz8kwsMd6pAd3S
         JgqRaYAAmbcoeWMJu2GNFWl4Dhwox4Lbl8JxxQxRfPffuKTCwqM+8qGYiS1ksgmqJGXx
         mhk3XHZZ8T1/FCIKW0L2yp3T1UT69SLE3udJk+8mB87y2B4oaDRXye6xlSy00iV7GD9U
         hmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683370273; x=1685962273;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A4lYB/swm1Oc9U88peOo/UZACzE4REZ1+acY56MWRcc=;
        b=dpw/3O9f8QGpRRqjbRowtlxhzF4Bf97f62o2auoWc9IiCVebqD/AB86Ul8cF9lcqLO
         pT++R86uWMRJqSpwAFRRvAJ6IRsUuM+XzgzC/GJc4UHqFcU9ZIm0bnjeaAkhI/KdScVp
         CSnHUNZsudxJhYsjmvsmImLdSZSF5mmQiccj1HMYiJYmmCx/wheEto1JhZAoaVIpowUH
         g87k7ET3pMBU1VAVk3xY3xG0gPulNvk8x3VXOyu7aWoU3YetuFH72l0hBqjMx06lZkws
         JabHbBtDTGL/Pb/rGGiILihunp3OqTXr7C/RisPDUo4x1wMzy0yZyFANAXIVLeK1ITUM
         jMQQ==
X-Gm-Message-State: AC+VfDzEl20UdxI1pXeA9PipXxQ4572DC+gGjHaQW9tf5cjKFHKQsZL1
        RPq7RE7yNPgmxNPwfzWAKHGI9D+VkmYU1Y5KYQE=
X-Google-Smtp-Source: ACHHUZ4RpD5Kr3rkLGBY4r3B8EfkrMOeLsiVONMzVTJSGXWxnqLhSa+4A04JNXLF+2+tVcsU7GGITw==
X-Received: by 2002:a25:db04:0:b0:b9e:5aac:2e7e with SMTP id g4-20020a25db04000000b00b9e5aac2e7emr4932506ybf.3.1683370273243;
        Sat, 06 May 2023 03:51:13 -0700 (PDT)
Received: from [172.20.2.186] ([12.153.103.3])
        by smtp.gmail.com with ESMTPSA id v2-20020a816102000000b0055db91a6ddfsm482410ywb.73.2023.05.06.03.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 03:51:12 -0700 (PDT)
Message-ID: <637e86c5-5a03-7252-bd46-4ec76d9d18bd@kernel.dk>
Date:   Sat, 6 May 2023 04:51:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup block fixes for 6.4-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Set of changes for the block code that didn't make the initial pull
request. Some of these I was a bit late in getting picked up, and some
of them are fixes for code that went in with the first merge window pull
request. In detail:

- MD pull request via Song
	- Improve raid5 sequential IO performance on spinning disks,
	  which fixes a regression since v6.0 (Jan Kara)
	- Fix bitmap offset types, which fixes an issue introduced in
	  this merge window (Jonathan Derrick)

- Cleanup of hweight type used for cgroup writeback (Maxim)

- Fix a regression with the "has_submit_bio" changes across partitions
  (Ming)

- Cleanup of QUEUE_FLAG_ADD_RANDOM clearing. We used to set this flag on
  queues non blk-mq queues, and hence some drivers clear it
  unconditionally. Since all of these have since been converted to true
  blk-mq drivers, drop the useless clear as the bit is not set
 (Chaitanya)

- Fix the flags being set in a bio for a flush for drbd (Christoph)

- Cleanup and deduplication of the code handling setting block device
  capacity (Damien)

- Fix for ublk handling IO timeouts (Ming)

- Fix for a regression in blk-cgroup teardown (Tao)

- NBD documentation and code fixes (Eric)

- Convert blk-integrity to using device_attributes rather than a second
  kobject to manage lifetimes (Thomas)

Please pull!


The following changes since commit 55793ea54d77719a071b1ccc05a05056e3b5e009:

  nbd: fix incomplete validation of ioctl arg (2023-04-20 13:43:44 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.4/block-2023-05-06

for you to fetch changes up to c0b79b0ff53be5b05be98e3caaa6a39de1fe9520:

  ublk: add timeout handler (2023-05-03 09:39:18 -0600)

----------------------------------------------------------------
for-6.4/block-2023-05-06

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      block/drivers: remove dead clear of random flag

Christoph Böhmwalder (1):
      drbd: correctly submit flush bio on barrier

Damien Le Moal (1):
      block: Cleanup set_capacity()/bdev_set_nr_sectors()

Eric Blake (4):
      uapi nbd: improve doc links to userspace spec
      uapi nbd: add cookie alias to handle
      block nbd: use req.cookie instead of req.handle
      docs nbd: userspace NBD now favors github over sourceforge

Jan Kara (1):
      md/raid5: Improve performance for sequential IO

Jens Axboe (2):
      Merge tag 'md-next-2023-04-28' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.4/block
      mailmap: add mailmap entries for Jens Axboe

Jonathan Derrick (1):
      md: Fix bitmap offset type in sb writer

Maxim Korotkov (1):
      writeback: fix call of incorrect macro

Ming Lei (2):
      block: sync part's ->bd_has_submit_bio with disk's
      ublk: add timeout handler

Tao Su (1):
      block: Skip destroyed blkg when restart in blkg_destroy_all()

Thomas Weißschuh (3):
      blk-integrity: use sysfs_emit
      blk-integrity: convert to struct device_attribute
      blk-integrity: register sysfs attributes on struct device

 .mailmap                                   |   5 +-
 Documentation/admin-guide/blockdev/nbd.rst |   2 +-
 block/bdev.c                               |  13 ++-
 block/blk-cgroup.c                         |   3 +
 block/blk-integrity.c                      | 175 ++++++++++-------------------
 block/blk.h                                |  12 +-
 block/genhd.c                              |  19 +---
 block/partitions/core.c                    |   8 --
 drivers/block/brd.c                        |   1 -
 drivers/block/drbd/drbd_receiver.c         |   2 +-
 drivers/block/nbd.c                        |   7 +-
 drivers/block/null_blk/main.c              |   1 -
 drivers/block/ublk_drv.c                   |  31 +++++
 drivers/block/zram/zram_drv.c              |   1 -
 drivers/md/bcache/super.c                  |   1 -
 drivers/md/md-bitmap.c                     |   6 +-
 drivers/md/raid5.c                         |  45 +++++++-
 fs/fs-writeback.c                          |   2 +-
 include/linux/blkdev.h                     |   3 -
 include/uapi/linux/nbd.h                   |  25 ++++-
 20 files changed, 192 insertions(+), 170 deletions(-)

-- 
Jens Axboe

