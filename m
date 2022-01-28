Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57300C433EF
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 22:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344588AbiA1WHc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 17:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiA1WHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 17:07:31 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5386EC061714
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 14:07:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so7702216pjb.1
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 14:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=qCR/XxEGxCdJDcAyJtLZMVgzHT8JKX0szIHntTFx8xQ=;
        b=H9UXkkz/uFLOmMN5y+CgCAJss1h0lB2o8IPznO1xDY2D04MTPVUspa7Puriq8yQ0Me
         AtXbmopblJZsA6kYD4Udh00aUxcSQS0FbibefsA+2sK016MApkZ9LYihTCbNVXpdzcgQ
         k3J8Arpcjd4xrMDB+wBGaFAfSfj6nPpb1lCac22kD3cZxoqsKs4vsVCN4pO5Ai6wP6yt
         xrGVNNN7VXWDVwN2ONSwA7z0yl6tWQok7uCW9ekWGYp/0Nc19lI9YE4UY7/EYAnMtb11
         oF6C+CYApHxtO6j2r5PJLjRUtSX4A7gERyFbHg7mprGLEJ85ePcy1IkxHCrpahcEtcPb
         Cj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=qCR/XxEGxCdJDcAyJtLZMVgzHT8JKX0szIHntTFx8xQ=;
        b=Hg7PBZEs32ROgT6caa7NUHTqiv7Fq5KNrJ/tFzJnpiHEvpC3vEeJw1J/sbjuGYxVvc
         y3ztVHdHkRy78l9Hy2Cvwhp6ZwvIm1u1iv64LEYzZaxp8ImXnMVyYJeMzsXvkDmxfMm4
         xd8QF7O7Wf7y3J3psXnOerg92ptEzTzLCfZF5KALAFG0XlParjz5kdIT86pmSpnrYLqw
         rMJ7r6WoRHBcTOdgF3R017RpTjD461HqaJYsDvrxUEZ33Mjx1c+2YkBl7Y/klWwIQhyT
         9PUdSverJKsHVw10otcCM79MvyYfCaXV6YLZq3Ky6D+ez6t694h2lZPjq4e9xp90/CA/
         brRw==
X-Gm-Message-State: AOAM531/J9ywJrgUle7GyE7zIdLjJCbI/CtB7j9rPemeyfBr+Oy+o17A
        mtRFrIhB4+984RaiSK7KeTwWwuVO91FTFg==
X-Google-Smtp-Source: ABdhPJznuyFbBWa4i61mzp+dL0JSpFzHTW2yB23TNxxPMfwHBPwEoWzalRFn7HPcQiApe3hPqntZhA==
X-Received: by 2002:a17:90a:5503:: with SMTP id b3mr21889980pji.187.1643407650552;
        Fri, 28 Jan 2022 14:07:30 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x23sm7412408pfh.216.2022.01.28.14.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 14:07:30 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.17-rc2
Message-ID: <a6c3f018-4235-3707-75b1-3c79adfbd15c@kernel.dk>
Date:   Fri, 28 Jan 2022 15:07:29 -0700
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

Set of fixes for 5.17-rc2:

- NVMe pull request
	- add the IGNORE_DEV_SUBNQN quirk for Intel P4500/P4600 SSDs
	  (Wu Zheng)
	- remove the unneeded ret variable in nvmf_dev_show
	  (Changcheng Deng)

- Fix for a hang regression introduced with a patch in the merge window,
  where low queue depth devices would not always get woken correctly
  (Laibin)

- Small series fixing an IO accounting issue with bio backed dm devices
  (Mike, Yu)

- Fix an error handling memory leak (Miaoqian)

Please pull!


The following changes since commit dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0:

  Merge tag 'powerpc-5.17-2' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2022-01-23 17:52:42 +0200)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.17-2022-01-28

for you to fetch changes up to b879f915bc48a18d4f4462729192435bb0f17052:

  dm: properly fix redundant bio-based IO accounting (2022-01-28 12:28:15 -0700)

----------------------------------------------------------------
block-5.17-2022-01-28

----------------------------------------------------------------
Changcheng Deng (1):
      nvme-fabrics: remove the unneeded ret variable in nvmf_dev_show

Jens Axboe (1):
      Merge tag 'nvme-5.17-2022-01-27' of git://git.infradead.org/nvme into block-5.17

Laibin Qiu (1):
      blk-mq: Fix wrong wakeup batch configuration which will cause hang

Miaoqian Lin (1):
      block: fix memory leak in disk_register_independent_access_ranges

Mike Snitzer (3):
      block: add bio_start_io_acct_time() to control start_time
      dm: revert partial fix for redundant bio-based IO accounting
      dm: properly fix redundant bio-based IO accounting

Wu Zheng (1):
      nvme-pci: add the IGNORE_DEV_SUBNQN quirk for Intel P4500/P4600 SSDs

Yu Kuai (1):
      blk-mq: fix missing blk_account_io_done() in error path

 block/blk-core.c            | 25 +++++++++++++++++++------
 block/blk-ia-ranges.c       |  2 +-
 block/blk-mq.c              |  2 ++
 drivers/md/dm.c             | 20 +++-----------------
 drivers/nvme/host/fabrics.c |  3 +--
 drivers/nvme/host/pci.c     |  3 ++-
 include/linux/blkdev.h      |  1 +
 lib/sbitmap.c               |  8 ++++++--
 8 files changed, 35 insertions(+), 29 deletions(-)

-- 
Jens Axboe

