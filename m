Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2842CC7EE29
	for <linux-block@archiver.kernel.org>; Fri,  2 Jun 2023 13:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjFBNYO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFBNYN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jun 2023 09:24:13 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF83132
        for <linux-block@vger.kernel.org>; Fri,  2 Jun 2023 06:24:10 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-760dff4b701so10185539f.0
        for <linux-block@vger.kernel.org>; Fri, 02 Jun 2023 06:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685712249; x=1688304249;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCNMsz4Hf4KvL+9Ehh6e7vaBK4L/g/yzA7xvAPqA5vI=;
        b=awCwmQFEqBB1M8NGPQc2WfXNS3HnsOF7AC8pgI8NJefGKIHPIsbPsoyP2qWN1QEjzj
         9IaruUUvvZYCnOTxxIFNpuhPJL9e5YHqYXjYY8YzOVH4nyLafky7o3C7ZItreOMzwV3T
         AirM70f9i35ZsZYgmX+ZAFk0JQv6/3racILRjLKtfCzopgdEA7YjO7NNdOcMsRrDiU3u
         vul/ODIB4tJZes/a4g32wny0wc00Zb1BzJhup/9yuqk+r9UfzGkjQihG5KNVyaGelj3q
         x0rZyzk8uxqICmgV6MhceMCubYahhCINGwjDd1ch3pl6o87RoSO6oota4u/Hbni4LiSL
         ydkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685712249; x=1688304249;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YCNMsz4Hf4KvL+9Ehh6e7vaBK4L/g/yzA7xvAPqA5vI=;
        b=XdGDJimuPLhGLrjNk0uqLAaePxu4xBfr546GDQaC500r+0Ygog04aNSah+sgjwDRk0
         MzxDKb6UEtsFGAH2RHFBLOPpn6PbZqI0KTxXxRY6TZLes0nR1OUTBNc9scKxUjyEZjNH
         zdoNmPTapwpBOV0CC1S/mpMTZFbF2Le7cO//pDQAdomcWNdYnJ91UV3tGAFSsqmbbenK
         5bUVSjB1JeePUxzSJoYQfaGjHuY6uaVki2j6mLyPAuMUQ9HmyeTYrdiyXTs+ypkhwgNq
         sOCbK6fmX12G0+jPcdZo6JPm5XepYfw1XokqbTfOp06mT3Dun1ZwmoApYwPzbbmQh0XO
         sBew==
X-Gm-Message-State: AC+VfDzOjlI0R+IrSYyZd7qvrpZEFAgdanmuW3hrngkMi3JK5sa83ksr
        ccIrV9lVSUXAIUaVcTS6JAApIWlj8SoYGtnaRKM=
X-Google-Smtp-Source: ACHHUZ717ZTNK/KVEc9v5rrQIt/bADDNRO/DiV+64pyH17sXQVowXcF2KoNDiTBh/KiBRO6OW0wQPw==
X-Received: by 2002:a05:6602:2d8b:b0:774:9337:2d4c with SMTP id k11-20020a0566022d8b00b0077493372d4cmr10093471iow.1.1685712249363;
        Fri, 02 Jun 2023 06:24:09 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z24-20020a6be018000000b00774804141f1sm393516iog.36.2023.06.02.06.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 06:24:08 -0700 (PDT)
Message-ID: <7b49cd00-55fa-5806-39c0-ac0c26051e13@kernel.dk>
Date:   Fri, 2 Jun 2023 07:24:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.4-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just an NVMe pull request with (mostly) KATO fixes, a regression fix for
zoned device revalidation, and a fix for an md raid5 regression. Please
pull!


The following changes since commit 9491d01fbc550d123d72bf1cd7a0985508a9c469:

  Merge tag 'nvme-6.4-2023-05-26' of git://git.infradead.org/nvme into block-6.4 (2023-05-26 09:46:01 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.4-2023-06-02

for you to fetch changes up to 2e45a49531fef55f4abbd6738c052545f53f43d4:

  Merge tag 'nvme-6.4-2023-06-01' of git://git.infradead.org/nvme into block-6.4 (2023-06-01 11:12:46 -0600)

----------------------------------------------------------------
block-6.4-2023-06-02

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: fix the name of Zone Append for verbose logging

Damien Le Moal (1):
      block: fix revalidate performance regression

Jens Axboe (2):
      Merge tag 'md-fixes-2023-05-24' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.4
      Merge tag 'nvme-6.4-2023-06-01' of git://git.infradead.org/nvme into block-6.4

Uday Shankar (3):
      nvme: double KA polling frequency to avoid KATO with TBKAS on
      nvme: check IO start time when deciding to defer KA
      nvme: improve handling of long keep alives

Yu Kuai (1):
      md/raid5: fix miscalculation of 'end_sector' in raid5_read_one_chunk()

min15.li (1):
      nvme: fix miss command type check

 block/blk-settings.c           |  3 ++-
 drivers/md/raid5.c             |  2 +-
 drivers/nvme/host/constants.c  |  2 +-
 drivers/nvme/host/core.c       | 52 ++++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/ioctl.c      |  2 +-
 drivers/nvme/host/nvme.h       |  3 ++-
 drivers/nvme/target/passthru.c |  2 +-
 7 files changed, 56 insertions(+), 10 deletions(-)

-- 
Jens Axboe

