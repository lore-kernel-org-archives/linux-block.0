Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479A9C001B0
	for <linux-block@archiver.kernel.org>; Mon,  3 Jul 2023 20:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGCUOy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jul 2023 16:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGCUOx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jul 2023 16:14:53 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98800E47
        for <linux-block@vger.kernel.org>; Mon,  3 Jul 2023 13:14:52 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-345badc9869so2162285ab.1
        for <linux-block@vger.kernel.org>; Mon, 03 Jul 2023 13:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688415292; x=1691007292;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9O2SJubE7COEEzs2giIEnSf7CqRJQ1l9ONtGJBOkXMQ=;
        b=Y7zSNl4dteTPAu8VsAmp5JfGo9Z2+060tsdHvw+U0q0IvQHThPEc/WwO1qtWxMyTkH
         z00+ZidDT1n39RJUsHokJU6zXFW2Mu/W7PQThzux7KsAzC+1u4pk6K+XrYahqGMoIA9X
         HWwr5oswOHfxIQezV9amptm+0EhwbfNyJAX/TSf+zvvczhcHAEXm9KwX+Ce8K01+wfy1
         5M6oi7J91L5TqU8wCzt+Ra2nGTIyCjyOOSsbaGa3yNlTTVJfB4StTqnEEK6ITBdFoPdv
         wJu8niFw+RbttUXXVsgF4vO47E0IDVTP7aSYjOanJA5tOv6/mG/ckOX/q4jtolZvUU7n
         KCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688415292; x=1691007292;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9O2SJubE7COEEzs2giIEnSf7CqRJQ1l9ONtGJBOkXMQ=;
        b=fuhe13KK3+rSySRDFltZrW2ulDvDCiRPo8QtO9925eKsFfLO6PUXGRKUOvncnkD/dH
         9R0X0f8QFRxYO2Q8BKGIBCwk0hnBIBl3LJh++stTHTNejGwafLQDtyCq5hcxrUA93bML
         lBDMVkOWGPRrYUrYuoAa4u8yLwBZy0Q+B/0En1+LTYtT0zaef0j8revS/+P0eUTnfbdr
         h0NlBF/otTHlfv57kx4XKZWEKf6pVo/lo3QXNEo/WNAxQ5RWdHRFYIBX3sU7tX6FU+mD
         1hj3s1cbQo68mxdINRsn4peXZ84ybQbQr48VL5AVqjKkXGyfasMxevjN60dXFmZIo+A9
         KuBQ==
X-Gm-Message-State: ABy/qLaSYWvo2Fbc75FTXcASzaQq/rW/KSmzfQ/QnWoV71+laHypPd/w
        lpczUbla/owBzCgx7Xh9x7g6JMI0CliOHdJsVWQ=
X-Google-Smtp-Source: APBJJlESOkgx4qoYgHNhr/LP2VV5m8iTDL8g8lSub8jf7ZHP7dum1gGZBiahvbGnEusIicpZ38h6jQ==
X-Received: by 2002:a92:c14e:0:b0:345:bdc2:eb42 with SMTP id b14-20020a92c14e000000b00345bdc2eb42mr9605697ilh.3.1688415291933;
        Mon, 03 Jul 2023 13:14:51 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090ade1100b00263987a50fcsm4669642pjv.22.2023.07.03.13.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 13:14:51 -0700 (PDT)
Message-ID: <23c4b3f1-9a66-5a30-dc94-defe37d4ef7f@kernel.dk>
Date:   Mon, 3 Jul 2023 14:14:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.5-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Mostly items that came in a bit late for the initial pull request,
wanted to make sure they had the appropriate amount of linux-next soak
before going upstream. Outside of stragglers, just generic fixes for
either merge window items, or longer standing bugs.

Please pull!


The following changes since commit 89181f544ffa4da682b0145738342f9b78b9e8dc:

  Merge tag 'mmc-v6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc (2023-06-28 14:06:39 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.5-2023-07-03

for you to fetch changes up to 3c2f765c81be1c85782ba09f492800a99f765a2c:

  Merge tag 'md-fixes-20230630' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.5 (2023-06-30 20:11:24 -0600)

----------------------------------------------------------------
block-6.5-2023-07-03

----------------------------------------------------------------
Breno Leitao (1):
      nvme: Print capabilities changes just once

Christophe JAILLET (1):
      nvmet: Reorder fields in 'struct nvmet_ns'

Damien Le Moal (1):
      nvme: host: fix command name spelling

Guenter Roeck (1):
      cdrom/gdrom: Fix build error

Jan Kara (2):
      bcache: Alloc holder object before async registration
      bcache: Fix bcache device claiming

Jason Baron (1):
      md/raid0: add discard support for the 'original' layout

Jens Axboe (4):
      Merge tag 'md-next-20230623' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.5/block-late
      Merge branch 'for-6.5/block-late' into block-6.5
      Merge tag 'nvme-6.5-2023-06-30' of git://git.infradead.org/nvme into block-6.5
      Merge tag 'md-fixes-20230630' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.5

Jinke Han (1):
      blk-throttle: Fix io statistics for cgroup v1

Keith Busch (5):
      block: add request polling helper
      nvme: improved uring polling
      nvme: ensure unquiesce on teardown
      nvme: sync timeout work on failed reset
      nvme: disable controller on reset state failure

Li Nan (1):
      md/raid10: fix the condition to call bio_end_io_acct()

Ming Lei (1):
      blk-mq: fix two misuses on RQF_USE_SCHED

Sagi Grimberg (1):
      nvme-mpath: fix I/O failure with EAGAIN when failing over I/O

Song Liu (1):
      md: use mddev->external to select holder in export_rdev()

Yu Kuai (8):
      md/raid1-10: fix casting from randomized structure in raid1_submit_write()
      md: fix 'delete_mutex' deadlock
      raid10: avoid spin_lock from fastpath from raid10_unplug()
      blk-wbt: don't create wbt sysfs entry if CONFIG_BLK_WBT is disabled
      blk-wbt: remove dead code to handle wbt enable/disable with io inflight
      blk-wbt: cleanup rwb_enabled() and wbt_disabled()
      blk-iocost: move wbt_enable/disable_default() out of spinlock
      blk-sysfs: add a new attr_group for blk_mq

 block/blk-cgroup.c            |   6 +-
 block/blk-iocost.c            |   7 +-
 block/blk-mq.c                |  54 +++++++++----
 block/blk-sysfs.c             | 181 ++++++++++++++++++++++++------------------
 block/blk-throttle.c          |   6 --
 block/blk-throttle.h          |   9 +++
 block/blk-wbt.c               |  21 +----
 block/blk-wbt.h               |  19 -----
 drivers/cdrom/gdrom.c         |   4 +-
 drivers/md/bcache/super.c     | 123 ++++++++++++++--------------
 drivers/md/md.c               |  32 +++-----
 drivers/md/md.h               |   4 +-
 drivers/md/raid0.c            |  62 +++++++++++++--
 drivers/md/raid0.h            |   1 +
 drivers/md/raid1-10.c         |   2 +-
 drivers/md/raid10.c           |   6 +-
 drivers/nvme/host/constants.c |   2 +-
 drivers/nvme/host/core.c      |   6 +-
 drivers/nvme/host/ioctl.c     |  70 +++++-----------
 drivers/nvme/host/multipath.c |  10 ++-
 drivers/nvme/host/nvme.h      |   3 +-
 drivers/nvme/host/pci.c       |   5 +-
 drivers/nvme/target/nvmet.h   |   2 +-
 include/linux/blk-mq.h        |   8 +-
 include/uapi/linux/io_uring.h |   2 +
 25 files changed, 341 insertions(+), 304 deletions(-)

-- 
Jens Axboe

