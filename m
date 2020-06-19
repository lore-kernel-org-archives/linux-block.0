Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A625C433E1
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1FF121707
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LG6FxQRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394901AbgFSQ1s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388286AbgFSOza (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 10:55:30 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B9BC06174E
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 07:55:30 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g12so4008585pll.10
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pbsVdpIbsqGdOwt5+ECjysg+L/fmi3GEHXmy3K89h/w=;
        b=LG6FxQRIfqZHzEEEf9qxIO6q7PlcRLLsiYi40WuHHnpGuVZZljt/IUCXbvYjLroZlH
         pyo/Zvbr4c0pv7bvyACCby8DEb5Fdqgm3MJrB6Oaf2LfhnCMAcjfanH/FlfSa3imI0bH
         Ubx8xEJ5OA2vTXdEKEVeYi569LAzdzisVtfa9A+qvj/cZmtRR8MFNCpD93tbRNOn8j8J
         jmk/lHwfKZt80XFT4s1tQyA5keHQE8xE5MbBQ34X8/mEye/0C5OyOefNSuOrSNuTH6Kw
         7BqWFgS8jqGSpptX22o+Tjx4NIlgffYRRuGKNDDAlXIcHDX8GkyOAVhc3YqTjjOGdvWZ
         pEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=pbsVdpIbsqGdOwt5+ECjysg+L/fmi3GEHXmy3K89h/w=;
        b=CJYeAKwFud6BYyluc1dQ4QVY+97u8NSDa+oJjkcXX1oqJXma+2LeiGL0zrWuGElDRO
         vgT9xOQGlLp4xXdt6froZ2n0GqhHKmYld/XDNCubjy3pBTdJJaEg0mxiYiC8IujFyLtg
         kr01w1qUZHtO5UCVcD5d1u2rwxLhJkV31o5mCRETQgAzsdSOtccWzgMj+5oFxmxIs11L
         dkqnI3qtKerByR+h2RlSr9OKKvTiQn8NLbuxPiczvAaO1trC0xmyPjg3sZuOJ17296x9
         Yv4VtUA80bIU2AHjGOym9QVHODzLfpBfkog+DqgwT3boYpZtM9FnpG4FN7w26ZNJjHP6
         0U+A==
X-Gm-Message-State: AOAM530a3awKv+MUUA/IBnyJoPUkujxFlHyBgc8EtBzjrv2sql/onHbS
        IiSkzx58HGwRZDCyTqpChR00LKv7O9NB3w==
X-Google-Smtp-Source: ABdhPJzaIpmkppRuYyo4JpqDj1IIjRmM4X6hzDP/h/Nt89PKCy3sy5yh0qN/4jStku9er3JGhHE2Qw==
X-Received: by 2002:a17:90a:69c3:: with SMTP id s61mr3985052pjj.212.1592578529513;
        Fri, 19 Jun 2020 07:55:29 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d184sm6218121pfd.85.2020.06.19.07.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 07:55:29 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.8-rc2
Message-ID: <a0978751-6105-a269-2c58-de4d7229a646@kernel.dk>
Date:   Fri, 19 Jun 2020 08:55:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Fixes that should go into this release:

- Use import_uuid() where appropriate (Andy)

- bcache fixes (Coly, Mauricio, Zhiqiang)

- blktrace sparse warnings fix (Jan) 

- blktrace concurrent setup fix (Luis)

- blkdev_get use-after-free fix (Jason)

- Ensure all blk-mq maps are updated (Weiping)

- Loop invalidate bdev fix (Zheng)

Please pull!

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.8-2020-06-19

for you to fetch changes up to 3373a3461aa15b7f9a871fa4cb2c9ef21ac20b47:

  block: make function 'kill_bdev' static (2020-06-18 09:24:35 -0600)

----------------------------------------------------------------
block-5.8-2020-06-19

----------------------------------------------------------------
Andy Shevchenko (1):
      partitions/ldm: Replace uuid_copy() with import_uuid() where it makes sense

Baolin Wang (1):
      blk-mq: Remove redundant 'return' statement

Coly Li (2):
      bcache: use delayed kworker fo asynchronous devices registration
      bcache: pr_info() format clean up in bcache_device_init()

Jan Kara (1):
      blktrace: Avoid sparse warnings when assigning q->blk_trace

Jason Yan (1):
      block: Fix use-after-free in blkdev_get()

Luis Chamberlain (1):
      blktrace: break out of blktrace setup on concurrent calls

Mauricio Faria de Oliveira (1):
      bcache: check and adjust logical block size for backing devices

Randy Dunlap (1):
      trace/events/block.h: drop kernel-doc for dropped function parameter

Weiping Zhang (1):
      block: update hctx map when use multiple maps

Zheng Bin (2):
      loop: replace kill_bdev with invalidate_bdev
      block: make function 'kill_bdev' static

Zhiqiang Liu (1):
      bcache: fix potential deadlock problem in btree_gc_coalesce

 block/blk-mq-tag.c           |  2 +-
 block/blk-mq.c               |  4 +++-
 block/partitions/ldm.c       |  2 +-
 drivers/block/loop.c         |  8 ++++----
 drivers/md/bcache/btree.c    |  8 ++++++--
 drivers/md/bcache/super.c    | 35 ++++++++++++++++++++++++++---------
 fs/block_dev.c               | 17 +++++++++--------
 include/linux/fs.h           |  2 --
 include/trace/events/block.h |  1 -
 kernel/trace/blktrace.c      | 30 ++++++++++++++++++++----------
 10 files changed, 70 insertions(+), 39 deletions(-)

-- 
Jens Axboe

