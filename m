Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318B4C433EF
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 15:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376313AbiCYPMm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 11:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359831AbiCYPMa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 11:12:30 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867AB63532
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 08:09:08 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e18so5401848ilr.2
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=4KU9QslOAVWxuqXxDoOPa6tZMrdFj2dmg2ltYNCcHwg=;
        b=2z9gtalMXBlLV91/8mVRq3pQ2THZ7964EGtVWTb65+n+qWYpimyvo06QxW8Mvzf+5T
         q8kymLAGuLkkZ+fFlcc8sC0WExCHvDGeptMf4onz8oH72F+G5DH5kbUdnF1YbIUsGhWP
         FRWnccdSaXUTLog4jHGB45bKLXN7Mw4j3dD5rRgPea8PXsuVUnv6roPsvpkWe6gjqKay
         w5Mm+VRgrG+37gyyp+06EbWlRBANRnvvRodtJ9spxaYtR1/wGASgwfAUcMJicfVztoVj
         SPgplmys+VF9kpFyIjH9mFJQuweixuvf69gLXqywvLyuyScp6lIboCtGgjgKWwHnCDfl
         ZzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=4KU9QslOAVWxuqXxDoOPa6tZMrdFj2dmg2ltYNCcHwg=;
        b=6ysTczp101KY+GVLi9P+ELZGC/LmB4VNIcGd8zmOL7X8lOlaA9J/aY4A89vgT2ImoU
         +dHuDZDfqV4PZVqoE1FhozK7+tep9C01Ap9CfBtS5DSkQu9KUarDyS6TIf/J+GsU5URA
         TNqWkL51yo4Q35bjG9d4TLdGBQ4H5fVECo/3IOa+gInNjtqNzjwlhh84KitlTHWRW5Gs
         8UgtjHGUL4zA9avIbZQzKLgo4AHa/Q5RBWagsWFlJ7TCiblmb4Ydl+WHXMuSY0cSlufe
         WaUd5NLlpvL9g5OOPVAzlpxG9Isej8KkS9+h9VVHGgRXA1NjhQ763ozn2+sIm1+SYQrv
         ryBw==
X-Gm-Message-State: AOAM530rsTh1W5CrXzuEf8ncD9rZbnmFkw9yEMPfpKEgvbKHmLhXoG6D
        eazqFb+RDt8pE9S1g6SKm0kKRaCpTcIrPGMD
X-Google-Smtp-Source: ABdhPJzbddq3HHrOS3Cxn8Zvx6U2HJyF3Wo0BTl1UlvBMBnuZOqiU+VOHUFEs9flVdOCQKzaWPL3pw==
X-Received: by 2002:a05:6e02:170d:b0:2c8:5b9:fa67 with SMTP id u13-20020a056e02170d00b002c805b9fa67mr5231937ill.300.1648220940970;
        Fri, 25 Mar 2022 08:09:00 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t6-20020a6b0906000000b0064963285af2sm3009538ioi.51.2022.03.25.08.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 08:09:00 -0700 (PDT)
Message-ID: <72c1ee9c-2abb-3ee7-7511-e6d972f4413f@kernel.dk>
Date:   Fri, 25 Mar 2022 09:08:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Remove write streams support
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This removes the write streams support in NVMe. No vendor ever really
shipped working support for this, and they are not interested in
supporting it.

With the NVMe support gone, we have nothing in the tree that supports
this. Remove passing around of the hints.

The only discussion point in this patchset imho is the fact that the
file specific write hint setting/getting fcntl helpers will now return
-1/EINVAL like they did before we supported write hints. No known
applications use these functions, I only know of one prototype that I
help do for RocksDB, and that's not used. That said, with a change like
this, it's always a bit controversial. Alternatively, we could just make
them return 0 and pretend it worked. It's placement based hints after
all.

Diffstat manually generated, as git pull-request doesn't like that it's
based on merges. It will merge cleanly with your current tree.

Please pull!


The following changes since commit 97939610b893de068c82c347d06319cd231a4602:

  block: remove bio_devname (2022-03-07 06:42:33 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.18/write-streams-2022-03-18

for you to fetch changes up to 7b12e49669c99f63bc12351c57e581f1f14d4adf:

  fs: remove fs.f_write_hint (2022-03-08 17:55:03 -0700)

----------------------------------------------------------------
for-5.18/write-streams-2022-03-18

----------------------------------------------------------------
Christoph Hellwig (4):
      nvme: remove support or stream based temperature hint
      block: remove the per-bio/request write hint
      fs: remove kiocb.ki_hint
      fs: remove fs.f_write_hint

Jens Axboe (3):
      Merge branch 'for-5.18/block' into for-5.18/write-streams
      Merge branch 'for-5.18/drivers' into for-5.18/write-streams
      Merge branch 'for-5.18/alloc-cleanups' into for-5.18/write-streams

 block/bio.c                 |   2 -
 block/blk-crypto-fallback.c |   1 -
 block/blk-merge.c           |  14 -----
 block/blk-mq-debugfs.c      |  24 --------
 block/blk-mq.c              |   1 -
 block/bounce.c              |   1 -
 block/fops.c                |   3 -
 drivers/md/raid1.c          |   2 -
 drivers/md/raid5-ppl.c      |  28 +---------
 drivers/md/raid5.c          |   6 --
 drivers/nvme/host/core.c    | 143 -----------------------------------------------
 drivers/nvme/host/nvme.h    |   1 -
 fs/aio.c                    |   1 -
 fs/btrfs/extent_io.c        |   1 -
 fs/buffer.c                 |  13 ++---
 fs/cachefiles/io.c          |   2 -
 fs/direct-io.c              |   3 -
 fs/ext4/page-io.c           |   5 +-
 fs/f2fs/data.c              |   2 -
 fs/f2fs/file.c              |   6 --
 fs/fcntl.c                  |  18 ------
 fs/gfs2/lops.c              |   1 -
 fs/io_uring.c               |   1 -
 fs/iomap/buffered-io.c      |   2 -
 fs/iomap/direct-io.c        |   1 -
 fs/mpage.c                  |   1 -
 fs/open.c                   |   1 -
 fs/zonefs/super.c           |   1 -
 include/linux/blk_types.h   |   1 -
 include/linux/blkdev.h      |   3 -
 include/linux/fs.h          |  21 -------
 include/trace/events/f2fs.h |   3 +-
 32 files changed, 10 insertions(+), 303 deletions(-)

-- 
Jens Axboe

