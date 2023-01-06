Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23C9C3DA7A
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 16:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbjAFQ2H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Jan 2023 11:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbjAFQ15 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2023 11:27:57 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8271976EE8
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 08:27:55 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id h26so1190888ila.11
        for <linux-block@vger.kernel.org>; Fri, 06 Jan 2023 08:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKrVGoXgnsCRRWhNdnFQqDkSk2/oUR/D2swwml1Qvtg=;
        b=L9lW01QDqfCm4ZMlYyKPm1q7/ijTTS4E7mQ25heYKwcVUKuIz+gRTfTbbMz9rwib7z
         DDWFaALrx1BlWj096KM2Btl9fbk3JftoHqlKY6xmx7FXn6PrDhM130to6qtdilPu1wiI
         RcN7L8ZUXLq6XFbSkHCO23pMOCVPfDeAzHvF6qsPYyT5UOnLEXMkjYsvSsuBwi3xjY6X
         0wBZMRJmD5dp4py83bkz9Hhzk8Mz0EUMvITbVLqV/7sh53D9XqilxSaGzGg01PgoOMeI
         cv0TcZoud9NTRTdau9oNCARUBok8FXFH5Pt7XAMZNemvOJTC8pNztbTL0CctHzterGdv
         3+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DKrVGoXgnsCRRWhNdnFQqDkSk2/oUR/D2swwml1Qvtg=;
        b=jCbfXdeYxubaTvSgKLR/y9XiZnxnOjEdUzCyVV2uQqdhZ7nUk4bxrnItexbrnfEoCP
         CRuvOJa0CjGsvhLxyxZSBQtCtJqQrD3N/OyzBJV5oOO9WcG+T11IeA/J5kYxM8P5Li9N
         gZskw5rqJmRYclXb6IkKuLOn8JoWDTzDd4CsdFFQUawSYtwQru5PC7QDjv4ETscxYcoh
         OFg9HJc+HF4rZVP+mZUOufbPhxRBfyYrgOX1U357pA8G6d0WmI6RFi6LIGZps+RxB5Ht
         VMFQmstEvB26u3IevYjEKn/8/tn8CoSC/Zaw89qlgk6fFNti2lgsWapENoipwJTUDocO
         Y3aA==
X-Gm-Message-State: AFqh2kqJDXALbzNnsRLtmfuxs6r7SEFkkm7Q299ieOTednE7hNKoF0UI
        PnsA9YKa+eNA/b60u9anGINjEmaQfvXBDKaS
X-Google-Smtp-Source: AMrXdXsyj8HBVpPifkgvKohnZ8og/i2acXs8OX4IR8KfmcpRIUzJIZiQT+YYueRSDH9taVHaCo4QRg==
X-Received: by 2002:a92:d307:0:b0:30b:d947:6bc8 with SMTP id x7-20020a92d307000000b0030bd9476bc8mr7680607ila.1.1673022474734;
        Fri, 06 Jan 2023 08:27:54 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f26-20020a02a11a000000b00389d6a02740sm408863jag.157.2023.01.06.08.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 08:27:54 -0800 (PST)
Message-ID: <e9134737-84e2-143c-258b-6945d492a789@kernel.dk>
Date:   Fri, 6 Jan 2023 09:27:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.2-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The big change here is obviously the revert of the pktcdvd driver
removal. Outside of that, just minor tweaks. In detail:

- Re-instate the pktcdvd driver, which necessitates adding back
  bio_copy_data_iter() and the fops->devnode() hook for now (me)

- Fix for splitting of a bio marked as NOWAIT, causing either nowait
  reads or writes to error with EAGAIN even if parts of the IO completed
  (me)

- Fix for ublk, punting management commands to io-wq as they can all
  easily block for extended periods of time (Ming)

- Removal of SRCU dependency for the block layer (Paul)

Please pull!


The following changes since commit 1551ed5a178ca030adc92b1eb29157b5e92bf134:

  Merge tag 'nvme-6.2-2022-12-29' of git://git.infradead.org/nvme into block-6.2 (2022-12-29 11:31:45 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-2023-01-06

for you to fetch changes up to b2b50d572135c5c6e10c2ff79cd828d5a8141ef6:

  block: Remove "select SRCU" (2023-01-05 08:50:10 -0700)

----------------------------------------------------------------
block-2023-01-06

----------------------------------------------------------------
Jens Axboe (5):
      block: handle bio_split_to_limits() NULL return
      block: don't allow splitting of a REQ_NOWAIT bio
      Revert "block: bio_copy_data_iter"
      Revert "block: remove devnode callback from struct block_device_operations"
      Revert "pktcdvd: remove driver."

Ming Lei (1):
      ublk: honor IO_URING_F_NONBLOCK for handling control command

Paul E. McKenney (1):
      block: Remove "select SRCU"

 Documentation/ABI/testing/debugfs-pktcdvd     |   18 +
 Documentation/ABI/testing/sysfs-class-pktcdvd |   97 +
 MAINTAINERS                                   |    7 +
 block/Kconfig                                 |    1 -
 block/bio.c                                   |   37 +-
 block/blk-merge.c                             |   14 +-
 block/blk-mq.c                                |    5 +-
 block/genhd.c                                 |   11 +
 drivers/block/Kconfig                         |   43 +
 drivers/block/Makefile                        |    1 +
 drivers/block/drbd/drbd_req.c                 |    2 +
 drivers/block/pktcdvd.c                       | 2944 +++++++++++++++++++++++++
 drivers/block/ps3vram.c                       |    2 +
 drivers/block/ublk_drv.c                      |    3 +
 drivers/md/dm.c                               |    2 +
 drivers/md/md.c                               |    2 +
 drivers/nvme/host/multipath.c                 |    2 +
 drivers/s390/block/dcssblk.c                  |    2 +
 include/linux/bio.h                           |    2 +
 include/linux/blkdev.h                        |    1 +
 include/linux/pktcdvd.h                       |  197 ++
 include/uapi/linux/pktcdvd.h                  |  112 +
 22 files changed, 3487 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-pktcdvd
 create mode 100644 Documentation/ABI/testing/sysfs-class-pktcdvd
 create mode 100644 drivers/block/pktcdvd.c
 create mode 100644 include/linux/pktcdvd.h
 create mode 100644 include/uapi/linux/pktcdvd.h

-- 
Jens Axboe

