Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F330C433F5
	for <linux-block@archiver.kernel.org>; Sat, 11 Sep 2021 14:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21700611C3
	for <linux-block@archiver.kernel.org>; Sat, 11 Sep 2021 14:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbhIKOax (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Sep 2021 10:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbhIKOax (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Sep 2021 10:30:53 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880FC061574
        for <linux-block@vger.kernel.org>; Sat, 11 Sep 2021 07:29:40 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id j18so6124582ioj.8
        for <linux-block@vger.kernel.org>; Sat, 11 Sep 2021 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+2KuG7rInW6mUr1U/SYWGrk+FsHmj1aTz6Tzs6FDcf0=;
        b=XR9cEhK2UAyTTMnxDLpaIwpy/rYZtMj+D3SnHMz+KsvqUvgr0WgKeVSCqwkO1igMy6
         SeTmzIv+knbTGZG+kj6dzXw9TmjhfMIfiALwmbWiHeKzsf0ESoshtKjN0OE7vS89C7iZ
         Enlq44c8FwqKYvDriXV40dSvt6R2f96jkWj92EgmpuKsvUR6xW8hFmiPXTlpIJ+7oW3J
         djYdHEHu8uv8UyukYHy27RMvZBUfuraEYPlefoYeCbVlqk94nK5e6kG0ZL8JmWFYf5Z/
         OKZuHNzIBlgRb4v77Tk5lagCAGB6Q8RltT7DmeG8piFomPdNZKT8MZewk4dstGMKWitz
         EJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+2KuG7rInW6mUr1U/SYWGrk+FsHmj1aTz6Tzs6FDcf0=;
        b=iLjQey3W8nFCel4QSdc6RPzzEtMg2xkykyoRQ4SkTCLTZdmo1Vi1o4e0sDji1isI/D
         YddfApDUF6HOG+9qfwvSUdAZaB6fBGCPsEhV+Z/sTg6xJ3XJDleBbcYSa9hUJ5sHnrlL
         gdMIJKNiEUOY90kFXn7PWZordMupnY8cFc0/0+xllQh4FzhW211qAzTnxYForgAofnIt
         TgAEfW6jFHGitEvCAJQ4QVZXRSmmtxe5djJnes/UW7Od3uH3nxnayLB/I7QG8M6HMzs/
         GPqYOtHIEsUIKI6VQa7XZ/MK5bDwgeELE8Rw7Qhr/RMy3lRAB/GxwfmMAO0BUnwKEBmy
         87zA==
X-Gm-Message-State: AOAM530+p12UKY6SMZofQV8lLw1lQzJfHa5LgusM5dn9EjotLIl/GUKj
        o76GjpBmOkVPbWD/taqv/a7gwEEhtcqHJA==
X-Google-Smtp-Source: ABdhPJyiCJOEPePAaeORNVwmJdZnFjlWibYEpqbu675xLm/ED0vK4ZvLZoGDqSfbz/7TOS+kQbLa0w==
X-Received: by 2002:a6b:a06:: with SMTP id z6mr2079351ioi.146.1631370579973;
        Sat, 11 Sep 2021 07:29:39 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j5sm980961ilu.11.2021.09.11.07.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 07:29:39 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.15-rc1
Message-ID: <e165b1c8-2e0d-13d9-36a5-2a58191d8b0f@kernel.dk>
Date:   Sat, 11 Sep 2021 08:29:38 -0600
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

- NVMe pull request from Christoph:
	- fix nvmet command set reporting for passthrough controllers
	  (Adam Manzanares)
	- update a MAINTAINERS email address (Chaitanya Kulkarni)
	- set QUEUE_FLAG_NOWAIT for nvme-multipth (me)
	- handle errors from add_disk() (Luis Chamberlain)
	- update the keep alive interval when kato is modified
	  (Tatsuya Sasaki)
	- fix a buffer overrun in nvmet_subsys_attr_serial
	  (Hannes Reinecke)
	- do not reset transport on data digest errors in nvme-tcp
	  (Daniel Wagner)
	- only call synchronize_srcu when clearing current path
	  (Daniel Wagner)
	- revalidate paths during rescan (Hannes Reinecke)

- Split out the fs/block_dev into block/fops.c and block/bdev.c, which
  has been long overdue. Do this now before -rc1, to avoid annoying
  conflicts due to this. (Christoph)

- blk-throtl use-after-free fix (Li)

- Improve plug depth for multi-device plugs, greatly increasing md
  resync performance (Song)

- blkdev_show() locking fix (Tetsuo)

- n64cart error check fix (Yang)

Please pull!


The following changes since commit 1c500ad706383f1a6609e63d0b5d1723fd84dab9:

  loop: reduce the loop_ctl_mutex scope (2021-09-03 22:14:40 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.15-2021-09-11

for you to fetch changes up to 221e8360834c59f0c9952630fa5904a94ebd2bb8:

  n64cart: fix return value check in n64cart_probe() (2021-09-09 14:24:02 -0600)

----------------------------------------------------------------
block-5.15-2021-09-11

----------------------------------------------------------------
Adam Manzanares (2):
      nvme: move nvme_multi_css into nvme.h
      nvmet: looks at the passthrough controller when initializing CAP

Chaitanya Kulkarni (1):
      nvme: update MAINTAINERS email address

Christoph Hellwig (4):
      nvme-multipath: set QUEUE_FLAG_NOWAIT
      nvmet: return bool from nvmet_passthru_ctrl and nvmet_is_passthru_req
      block: split out operations on block special files
      block: move fs/block_dev.c to block/bdev.c

Daniel Wagner (2):
      nvme-tcp: Do not reset transport on data digest errors
      nvme: only call synchronize_srcu when clearing current path

Hannes Reinecke (2):
      nvme-multipath: revalidate paths during rescan
      nvmet: fixup buffer overrun in nvmet_subsys_attr_serial()

Jens Axboe (1):
      Merge tag 'nvme-5.15-2021-09-07' of git://git.infradead.org/nvme into block-5.15

Li Jinlin (1):
      blk-throttle: fix UAF by deleteing timer in blk_throtl_exit()

Luis Chamberlain (1):
      nvme: add error handling support for add_disk()

Song Liu (1):
      blk-mq: allow 4x BLK_MAX_REQUEST_COUNT at blk_plug for multiple_queues

Tatsuya Sasaki (1):
      nvme: update keep alive interval when kato is modified

Tetsuo Handa (1):
      block: genhd: don't call blkdev_show() with major_names_lock held

Yang Yingliang (1):
      n64cart: fix return value check in n64cart_probe()

 Documentation/core-api/kernel-api.rst     |   3 +
 Documentation/filesystems/api-summary.rst |   3 -
 MAINTAINERS                               |   3 +-
 block/Makefile                            |   2 +-
 fs/block_dev.c => block/bdev.c            | 641 +-----------------------------
 block/blk-mq.c                            |  14 +-
 block/blk-throttle.c                      |   1 +
 block/blk.h                               |   2 +
 block/fops.c                              | 640 +++++++++++++++++++++++++++++
 block/genhd.c                             |   9 +-
 drivers/block/n64cart.c                   |   4 +-
 drivers/nvme/host/core.c                  |  68 +++-
 drivers/nvme/host/multipath.c             |  19 +-
 drivers/nvme/host/nvme.h                  |  10 +
 drivers/nvme/host/tcp.c                   |  22 +-
 drivers/nvme/target/admin-cmd.c           |   2 +-
 drivers/nvme/target/configfs.c            |   5 +-
 drivers/nvme/target/core.c                |  10 +-
 drivers/nvme/target/nvmet.h               |  11 +-
 drivers/nvme/target/passthru.c            |  14 +-
 fs/Makefile                               |   2 +-
 fs/internal.h                             |   2 +-
 22 files changed, 805 insertions(+), 682 deletions(-)
 rename fs/block_dev.c => block/bdev.c (63%)
 create mode 100644 block/fops.c

-- 
Jens Axboe

