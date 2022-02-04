Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9746C433EF
	for <linux-block@archiver.kernel.org>; Fri,  4 Feb 2022 18:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbiBDS2u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Feb 2022 13:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiBDS2t (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Feb 2022 13:28:49 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FDAC061714
        for <linux-block@vger.kernel.org>; Fri,  4 Feb 2022 10:28:49 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id n6-20020a9d6f06000000b005a0750019a7so5770799otq.5
        for <linux-block@vger.kernel.org>; Fri, 04 Feb 2022 10:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pgW3FfHX4y6xVFGvas96PvsLzR4RAaCwfL3uj8TdYA0=;
        b=tlzi4xa31KiHXSY0gBAc4dR9HNT5QuRcpkkdtimaaezHwLg3sco69w7Fu/tYRfODvG
         3eM4ssFBvDC9coPfnksw88WySbbNsbIE78N/swg79+XyQy34mXriqHFiIqU5YDNIxji3
         IG9d7rBlnzUzosU/Kg456nApyftZfDf9SICqEHTnIljUzH8fHeSMRF8BTRALMsFOHs42
         HPqwlET7Av/FeTBkeMOJxXeIE0XmqpXlOSOYM8WaTK7N7RSfsbfkCoMCZ21fr05IeEvZ
         SjrTZ9gErnmf8j4yovwN4Foa/P1cpFsD0j6SsOgop3KTha2Df5hGsMaf994YviXNaDST
         gN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=pgW3FfHX4y6xVFGvas96PvsLzR4RAaCwfL3uj8TdYA0=;
        b=rK6NQRBm5Uq/pp6HA6Lob9ur/jQW9fZTtmHlufvzye2ziaT1ZKE/uu8oyhZhAVIPMH
         7vweSk4XrYIS+yej8sCiBpSMyyDkIrH70aYWrgLj5/SIXd8l7mKLt+xERo0mC7F3IhxK
         yKkXOUy+lnzGwgFTCfMNJ1bWeFafZkZ8TuTMowPU2MHLsA/+Bar5+wKa5kziYUb/m7Cm
         w6N6ljQmnndMb0Y72icv73EL/M4HuA9brPSrYWqcvIh3Kw5577Z1Vlgg0Z6meSlH3irY
         xGvV8UsL9/62gPwjC/0SK5SBqb2oAZkPheLyP7sbizvlXKjX8cVHJSrPIfwuj13XQIzd
         4XWQ==
X-Gm-Message-State: AOAM532i4ww6oeFfDP3RncYt0LrzdlhlRh8RfWR+wRAxhMCt3cVk2pMq
        4ue+SeUOLWAkKNsDM9wl3x4WfzKUOjVRfQ==
X-Google-Smtp-Source: ABdhPJwjE8SKscmFCx6A/Ew4FpULeOfDYVvbnmaYm97XNcVfgL29a0n8ihQuCwiA/8EH0vfjRnI2Xg==
X-Received: by 2002:a9d:341:: with SMTP id 59mr128399otv.286.1643999328759;
        Fri, 04 Feb 2022 10:28:48 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t20sm986942oov.35.2022.02.04.10.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 10:28:48 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.17-rc3
Message-ID: <4c26c740-abde-87a1-3cf0-5f97fad85d4e@kernel.dk>
Date:   Fri, 4 Feb 2022 11:28:47 -0700
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

A set of fixes that should go into this release:

- NVMe pull request
	- fix a use-after-free in rdm and tcp controller reset
	  (Sagi Grimberg)
	- fix the state check in nvmf_ctlr_matches_baseopts
	  (Uday Shankar)

- MD nowait null pointer fix (Song)

- blk-integrity seed advance fix (Martin)

- Fix a dio regression in this merge window (Ilya)

Please pull!


The following changes since commit b879f915bc48a18d4f4462729192435bb0f17052:

  dm: properly fix redundant bio-based IO accounting (2022-01-28 12:28:15 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.17-2022-02-04

for you to fetch changes up to b13e0c71856817fca67159b11abac350e41289f5:

  block: bio-integrity: Advance seed correctly for larger interval sizes (2022-02-03 21:09:24 -0700)

----------------------------------------------------------------
block-5.17-2022-02-04

----------------------------------------------------------------
Ilya Dryomov (1):
      block: fix DIO handling regressions in blkdev_read_iter()

Jens Axboe (2):
      Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.17
      Merge tag 'nvme-5.17-2022-02-03' of git://git.infradead.org/nvme into block-5.17

Martin K. Petersen (1):
      block: bio-integrity: Advance seed correctly for larger interval sizes

Sagi Grimberg (3):
      nvme: fix a possible use-after-free in controller reset during load
      nvme-tcp: fix possible use-after-free in transport error_recovery work
      nvme-rdma: fix possible use-after-free in transport error_recovery work

Song Liu (1):
      md: fix NULL pointer deref with nowait but no mddev->queue

Uday Shankar (1):
      nvme-fabrics: fix state check in nvmf_ctlr_matches_baseopts()

 block/bio-integrity.c       |  2 +-
 block/fops.c                | 33 +++++++++++++++++++--------------
 drivers/md/md.c             |  8 ++++----
 drivers/nvme/host/core.c    |  9 ++++++++-
 drivers/nvme/host/fabrics.h |  1 +
 drivers/nvme/host/rdma.c    |  1 +
 drivers/nvme/host/tcp.c     |  1 +
 7 files changed, 35 insertions(+), 20 deletions(-)

-- 
Jens Axboe

