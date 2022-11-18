Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9EEC433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 21:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiKRVPy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 16:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiKRVPs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 16:15:48 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5BF9B39F
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 13:15:42 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y6so4759393iof.9
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 13:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+5FPdrX+uwOyUOr5InI/thvdu8gaznXiaciTHR1gUY=;
        b=jOphvH9IjmWyG1fp+pfW5BkaZwvabRNcpU8o56cEdWqUkFI7uJRzAStME82Qjdye9k
         VYL6xSHYPnJsn6EvbcyyIcuSc5oacdL4vf92/GH3b/jcIjYJHvuliLr2PGaQ4myQy2rE
         bbuRb2WG/K62oq6kRDG41TcrnJjjcblpYlM4TCxjInBVlfcxQLFR1RckFBhJF4NjPnqO
         /qkyxbViY8IfPP7RG4WjgynPlCjSqpxPtqnVxwZcKkE56pXNeM3N98cNDVodc+5NfLXv
         xBGrt0e4Khu3b5yMdbO4XY+CD0fpLuOyirQZRrQb1XZeFDITVlM1+MIER/qAMF8ItM0P
         JMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d+5FPdrX+uwOyUOr5InI/thvdu8gaznXiaciTHR1gUY=;
        b=m14GLK1M/3SSk6vjkZTqeuXKfPm3HMOBOg40irph/GVttbJHrZCQvga+zTUwVvrafk
         afHH5l1Nh+XqkR+Q3K2ncyMUTr3cEDanTTzCojMLc0hkg7fDs1ZxH+4IDoR2bclIEMop
         npNnE5VheAwiUkoPEPRPrFQe7/okM4cY77ijG+3/lw+mjjlhaTtTpDbVFQj5QRW8JYAh
         tU1W4hYaWzC0Mcb7QU0mc6u1kiWX43vnftGRwNyMUb1zcWp7IdLHcNbt2iF4cTacggmg
         ghKxzRMxkd30ylcz1IgCrpmIz0WyDd0DpHHjL6SlWN4egUjTdDWw/CWSyflKVXt29INJ
         Xdlg==
X-Gm-Message-State: ANoB5plkgGN0oIxaZlHpr36qqVFDVC7poht0BmHqM70v2OANOSLZt46n
        1nJe8kVp4jGeYO37Mexlt2KSSG56NJHu1w==
X-Google-Smtp-Source: AA0mqf7DGvwUqedoe6Pj+KM+D2hATah8A8JCfyq6EwAMrsAWfOhqTqwZA76Z57Lb/mSAnlQyIScYDQ==
X-Received: by 2002:a05:6638:4907:b0:375:ca55:284e with SMTP id cx7-20020a056638490700b00375ca55284emr4006379jab.248.1668806142094;
        Fri, 18 Nov 2022 13:15:42 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d1-20020a92d5c1000000b0030287ff00fesm1576633ilq.60.2022.11.18.13.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 13:15:41 -0800 (PST)
Message-ID: <b6c6cfeb-546e-1236-dda6-81272cdea92f@kernel.dk>
Date:   Fri, 18 Nov 2022 14:15:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.1-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are some block fixes that should go into the 6.1 release:

- NVMe pull request via Christoph
	- Two more bogus nid quirks (Bean Huo, Tiago Dias Ferreira)
	- Memory leak fix in nvmet (Sagi Grimberg)

- Regression fix for block cgroups pinning the wrong blkcg, causing
  leaks of cgroups and blkcgs (Chris)

- UAF fix for drbd setup error handling (Dan)

- Series fixing DMA alignment propagation in DM (Keith)

Please pull!


The following changes since commit df24560d058d11f02b7493bdfc553131ef60b23d:

  Merge tag 'nvme-6.1-2022-11-10' of git://git.infradead.org/nvme into block-6.1 (2022-11-10 06:55:02 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.1-2022-11-18

for you to fetch changes up to 5c59789ce7ce994e1d9db1973a21f15481bd8513:

  Merge tag 'nvme-6.1-2022-11-18' of git://git.infradead.org/nvme into block-6.1 (2022-11-18 07:47:54 -0700)

----------------------------------------------------------------
block-6.1-2022-11-18

----------------------------------------------------------------
Bean Huo (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Micron Nitro

Chris Mason (1):
      blk-cgroup: properly pin the parent in blkcg_css_online

Dan Carpenter (1):
      drbd: use after free in drbd_create_device()

Jens Axboe (1):
      Merge tag 'nvme-6.1-2022-11-18' of git://git.infradead.org/nvme into block-6.1

Keith Busch (5):
      block: make dma_alignment a stacking queue_limit
      dm-crypt: provide dma_alignment limit in io_hints
      block: make blk_set_default_limits() private
      dm-integrity: set dma_alignment limit in io_hints
      dm-log-writes: set dma_alignment limit in io_hints

Sagi Grimberg (1):
      nvmet: fix a memory leak in nvmet_auth_set_key

Tiago Dias Ferreira (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Netac NV7000

 block/blk-cgroup.c             |  2 +-
 block/blk-core.c               |  1 -
 block/blk-settings.c           |  9 +++++----
 block/blk.h                    |  1 +
 drivers/block/drbd/drbd_main.c |  4 ++--
 drivers/md/dm-crypt.c          |  1 +
 drivers/md/dm-integrity.c      |  1 +
 drivers/md/dm-log-writes.c     |  1 +
 drivers/nvme/host/pci.c        |  4 ++++
 drivers/nvme/target/auth.c     |  2 ++
 include/linux/blkdev.h         | 16 ++++++++--------
 11 files changed, 26 insertions(+), 16 deletions(-)

-- 
Jens Axboe
