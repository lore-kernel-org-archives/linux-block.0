Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B89BC77B7A
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 17:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjEZRSI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 13:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjEZRSI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 13:18:08 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E8B10DF
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 10:17:40 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7747cc8bea0so6003339f.1
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 10:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685121457; x=1687713457;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpced3SsdQHRfS617gxu6ozYyb9KoRHyHaRv14KMM50=;
        b=2TFL50trJVughSxjeE5m7cujCK5jvdTV48wiKI3krLn3dqAKVM8iKA7OFg5Nx4Z77l
         aDqktIHhZtXFtWSFz+k6M3ju9Pj5r0XUpsqFu9mGrcgqfruxat96PeM5Li+kYEsfBOJy
         iVTyDupduVSctrJcAhBaHexg/O61jHlG1IKkOGJ6PDmHY69/PzjwJM6Y0Lf/DcTvWkiN
         Qvyr+7EazItNbm0ntq0070dE20JQuF2Ki3lPCsMuHTJKsm3Zg/R49PJoCX63V0Fsva0b
         MXJE5oSiQ+fZpif0m8LNzNdSrvJlveNLSNk1JmHuv57nOrliSyTG9/3N8ijyYF/Io8NY
         oPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685121457; x=1687713457;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qpced3SsdQHRfS617gxu6ozYyb9KoRHyHaRv14KMM50=;
        b=byk/AHdKiMxkn+qvTk4XWXWV7rc/LRa1uV7tH0SOiD9pcl9T444Fv0Y/HxSCPb0aJ3
         omXTFv7IoBuBphDwTJs7POJdab4NNMuRB48kLAIKYZz2Yox5r2SLYjiCNJNXYae8U85a
         K3cyFPWqsmrdeHgUu7APO4wG+dHgofDY1z2GK+A1yBqaAjBrZrUVm9DKEVFDXsV6AEg/
         bhxWYoE4CqARvHJvKsWpFoHlDpfqUvPCm5bv5X7zTeZLpOi9PsUOffJAqh0/UjTbkBUh
         g/33x57CZ8wSxvWZr3dlglE85aq/8ilrzPcjs2R+hmANvek2MI1wrh1s/imnMRqpWKxr
         ezPg==
X-Gm-Message-State: AC+VfDyFyyMLXaqlEtpwSSo8iqdGGOnmeAJ5+HMFCk7X9rp2HX8sVqp3
        Dk+Y8TpXtipCSxUhZeKx0hQK+RElGKncxhOnZik=
X-Google-Smtp-Source: ACHHUZ4HyQ3EYEzTHBspMlb8xWExaTji+Jh3Ioec2AN6bWXHNk1LHriurximN0l48FtH1SoKsIH1zA==
X-Received: by 2002:a05:6e02:961:b0:33a:a895:891d with SMTP id q1-20020a056e02096100b0033aa895891dmr1065194ilt.1.1685121456811;
        Fri, 26 May 2023 10:17:36 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y3-20020a92c983000000b0032867b9427esm79361iln.38.2023.05.26.10.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 10:17:36 -0700 (PDT)
Message-ID: <61594ff7-f3ca-b609-7b0f-9c520f6df46a@kernel.dk>
Date:   Fri, 26 May 2023 11:17:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.4-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes for the storage side of things:

- Fix bio caching condition for passthrough IO (Anuj)

- end-of-device check fix for zero sized devices (Christoph)

- Update Paolo's email address

- NVMe pull request via Keith with a single quirk addition

- Fix regression in how wbt enablement is done (Yu)

- Fix race in active queue accounting (Tian)

Please pull!

	
The following changes since commit e3afec91aad23c52dfe426c7d7128e4839c3eed8:

  block: remove NFL4_UFLG_MASK (2023-05-20 05:38:01 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.4-2023-05-26

for you to fetch changes up to 9491d01fbc550d123d72bf1cd7a0985508a9c469:

  Merge tag 'nvme-6.4-2023-05-26' of git://git.infradead.org/nvme into block-6.4 (2023-05-26 09:46:01 -0600)

----------------------------------------------------------------
block-6.4-2023-05-26

----------------------------------------------------------------
Anuj Gupta (1):
      block: fix bio-cache for passthru IO

Christoph Hellwig (1):
      block: make bio_check_eod work for zero sized devices

Jens Axboe (1):
      Merge tag 'nvme-6.4-2023-05-26' of git://git.infradead.org/nvme into block-6.4

Paolo Valente (1):
      block, bfq: update Paolo's address in maintainer list

Tatsuki Sugiura (1):
      NVMe: Add MAXIO 1602 to bogus nid list.

Tian Lan (1):
      blk-mq: fix race condition in active queue accounting

Yu Kuai (1):
      blk-wbt: fix that wbt can't be disabled by default

 MAINTAINERS             |  2 +-
 block/blk-core.c        |  2 +-
 block/blk-map.c         |  2 +-
 block/blk-mq-tag.c      | 12 ++++++++----
 block/blk-wbt.c         | 12 +++++++-----
 drivers/nvme/host/pci.c |  2 ++
 6 files changed, 20 insertions(+), 12 deletions(-)

-- 
Jens Axboe

