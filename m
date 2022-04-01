Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32E7C433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Apr 2022 19:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346921AbiDATgi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Apr 2022 15:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245438AbiDATgh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Apr 2022 15:36:37 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC84190E81
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 12:34:47 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p21so4389372ioj.4
        for <linux-block@vger.kernel.org>; Fri, 01 Apr 2022 12:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=1h7Y7J0rb7JBxLiuKUh5toLCo/YmE8yiwrotHzLNM2c=;
        b=g/AHpzt0O20TNczxLRwpbG/bvB0XWTXlp123r8XcUO/HNeLGN41xHU4jEzdK+0CqzZ
         ZGCoVuVneNNwW7Lx/6P4TG4PBi9xRfh+FerVaRbgGWloM4gY986WKaLlIakg6IIpvlkW
         sYcxL3Aszxy5y2H424Sw6JNYF91OGXT26H4b/6V84k2B1PydHBhbOOXUuX9uJPUFS0Uh
         a9o2E4S0Zg8g1PJukju+Ul59GOspFtASmkpXP8W5fJi29xut0H2lX1RN0DmVbXgmzhv8
         7hKcF5/fTpFTfUSxXzprcWZR5UAILUre+WQgT89RMZKrnJ5BD7x13AuHlLefgQswvsfT
         iVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=1h7Y7J0rb7JBxLiuKUh5toLCo/YmE8yiwrotHzLNM2c=;
        b=PG0x+TBRg4p56FwRP0yep06FP16V4mGg184idD1/da4xXW72GRY0uH/eS0Urpa8OOf
         C0a9xnfo39fD8/5yF/hxQo1nkjN0R2V6uLsMd2f4+4IMwd/g7219f39FxL2tGu8skGVa
         m1GDA87cl+zJN20rquUCQnF7SnvqRbbVlgud9MIAbZWaaARoMct7m1ZssJod4n8z9u2c
         5XD9vaxyUIjv2o//6LzaGgjbt6J7M5uRsMaYRBnfdpe5QIBtMKRP79InUgk289nWf4+3
         ibv/pErD4oGVjd2aKui4nPFs+zU6kIZ6F4wNPJbRg3d52R9zRR1QICDYBJnGc+1LNjke
         s1hQ==
X-Gm-Message-State: AOAM530rHAbzDIMYE1AnOy66RHo3qZYwKH7GTKrPAvhY1SUldmY+h50u
        1PpMleTHgMXGNE+bonJ+1XJ9XS0LtKkuaXI6
X-Google-Smtp-Source: ABdhPJxBCx6CQMnb3VAKL5upd8/7876RskYfWBuD7yvOeqNP45VJXtJ14aCltJHGs0d6ugvwAHg5hQ==
X-Received: by 2002:a5d:950e:0:b0:64c:adf3:7bd with SMTP id d14-20020a5d950e000000b0064cadf307bdmr575908iom.48.1648841686539;
        Fri, 01 Apr 2022 12:34:46 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k3-20020a0566022a4300b0064ca623b65esm2010495iov.4.2022.04.01.12.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 12:34:46 -0700 (PDT)
Message-ID: <b7d7893a-971b-9ac6-b4b9-e39a81038254@kernel.dk>
Date:   Fri, 1 Apr 2022 13:34:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.18-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Either fixes or a few additions that got missed in the initial merge
window pull. In detail:

- List iterator fix to avoid leaking value post loop (Jakob)

- One-off fix in minor count (Christophe)

- Fix for a regression in how io priority setting works for an exiting
  task (Jiri)

- Fix a regression in this merge window with blkg_free() being called in
  an inappropriate context (Ming)

- Misc fixes (Ming, Tom)

Please pull!


The following changes since commit 8f9e7b65f833cb9a4b2e2f54a049d74df394d906:

  block: cancel all throttled bios in del_gendisk() (2022-03-18 09:57:56 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.18/block-2022-04-01

for you to fetch changes up to 8d7829ebc1e48208b3c02c2a10c5f8856246033c:

  blk-wbt: remove wbt_track stub (2022-03-31 12:58:38 -0600)

----------------------------------------------------------------
for-5.18/block-2022-04-01

----------------------------------------------------------------
Christophe JAILLET (1):
      block: Fix the maximum minor value is blk_alloc_ext_minor()

Jakob Koschel (1):
      block: use dedicated list iterator variable

Jiri Slaby (1):
      block: restore the old set_task_ioprio() behaviour wrt PF_EXITING

Ming Lei (2):
      lib/sbitmap: allocate sb->map via kvzalloc_node
      block: avoid calling blkg_free() in atomic context

Tom Rix (1):
      blk-wbt: remove wbt_track stub

 block/blk-cgroup.c         | 32 ++++++++++++++++++++++----------
 block/blk-ioc.c            |  3 +--
 block/blk-mq.c             | 25 ++++++++++++++++---------
 block/blk-wbt.h            |  3 ---
 block/genhd.c              |  2 +-
 include/linux/blk-cgroup.h |  5 ++++-
 include/linux/sbitmap.h    |  2 +-
 lib/sbitmap.c              |  2 +-
 8 files changed, 46 insertions(+), 28 deletions(-)

-- 
Jens Axboe

