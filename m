Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9709BC25B50
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 20:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjATUCO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 15:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjATUCN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 15:02:13 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE2469230
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 12:02:12 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c6so6287426pls.4
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 12:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QSJ28ZrMlkEtgUfsltGFpHxlBrYI8+uA4Dc6wV4jog=;
        b=bktQt8D92tz1lco61Mt+RVqwN4e4IKukK3I5U5kycS2BFnvv9Y2X61GIRHjCGic+0Y
         kLUmfSACNespdi4dTF8vr3enw5NUgqG3xz7Oy8/0jibpcqqJGC0v6YCwZsovWhHA45hH
         yxb9/7pXTn1xhiQr4BgDVhr6+VS1pLMAuAUwNAVREzEwWJGBf9HWTZk6mLOwtfnIAavP
         4o6faebBprFoKSMTWGVcAPspuEcVHE4FL5kepvYR1sjyTYAubijXRquJLDUBvvoJgOQj
         G9jXrEG5lgSbJkrCDfDdPoDcYxq3U7HnVubcK+Ul/C0jnrLzFMmZypT4brnhJEN4PdvN
         kr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/QSJ28ZrMlkEtgUfsltGFpHxlBrYI8+uA4Dc6wV4jog=;
        b=b1iVIBivkzLd4G1b4+iINnHV4JRbgkECqMHFuQu5CFvKigY2Usf4nc7+B8l+1T1+RT
         rzX/oMFNWVPkwXqFDeDxQB/9gkuWLVn+rgzYB3g9qpl+6zh5NjnvfVcWXRpVXTVLcbEO
         oE2oV9XI0dZFJQ1Ls4C5OrFjF7uQkLIg1mmalWOPS60TOA2KrD462QoLxD55gkwNTfq/
         yyJstaf2Wrf53yUxPqN546+ZODeFUbSHcRCOG4Z83Lh7FYG+2J7JfOQlIfEYZk578C5b
         EetsBomjOd2MCiMYSPhLEa2yblNDzkJXWkVEXVbe4XSNrCKuFV7Yt4G87THZn8LhrCLH
         idlg==
X-Gm-Message-State: AFqh2kpAfbTAuaePy4SEuRjzoDzM1ig0kVBh5+nkomj5CHYIMHco9nCG
        EDLgsUKe/mRw2KJPSZ4riw5SpqmoZX8HpNzU
X-Google-Smtp-Source: AMrXdXuVKPC4jDPYUQY+mVIEnqs+bMpQmmzvitiYCXoqz1Il7DdBUoCP4hx2k1AATZEA5mv1FSLNEA==
X-Received: by 2002:a17:90a:de01:b0:229:8e05:d59d with SMTP id m1-20020a17090ade0100b002298e05d59dmr3766836pjv.3.1674244931869;
        Fri, 20 Jan 2023 12:02:11 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z3-20020a6552c3000000b0049b7b1205a0sm23129310pgp.54.2023.01.20.12.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 12:02:11 -0800 (PST)
Message-ID: <305650d8-0477-19df-c043-f59b9b75cb48@kernel.dk>
Date:   Fri, 20 Jan 2023 13:02:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.2-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Various little tweaks all over the place:

- NVMe pull request via Christoph
	- fix  controller shutdown regression in nvme-apple (Janne Grunau)
	- fix a polling on timeout regression in nvme-pci (Keith Busch)

- Fix a bug in the read request side request allocation caching (Pavel)

- pktcdvd was brought back after we configured a NULL return on bio
  splits, make it consistent with the others (me)

- BFQ refcount fix (Yu)

- Block cgroup policy activation fix (Yu)

- Fix for an md regression introduced in the 6.2 cycle (Adrian)

Please pull!


The following changes since commit 3d25b1e8369273d76f5f2634f164236ba9e40d32:

  Merge tag 'nvme-6.2-2023-01-12' of git://git.infradead.org/nvme into block-6.2 (2023-01-12 10:36:35 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.2-2023-01-20

for you to fetch changes up to 955bc12299b17aa60325e1748336e1fd1e664ed0:

  Merge tag 'nvme-6.2-2023-01-20' of git://git.infradead.org/nvme into block-6.2 (2023-01-20 08:08:29 -0700)

----------------------------------------------------------------
block-6.2-2023-01-20

----------------------------------------------------------------
Adrian Huang (1):
      md: fix incorrect declaration about claim_rdev in md_import_device

Guoqing Jiang (1):
      block/rnbd-clt: fix wrong max ID in ida_alloc_max

Janne Grunau (2):
      nvme-apple: reset controller during shutdown
      nvme-apple: only reset the controller when RTKit is running

Jens Axboe (3):
      Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.2
      pktcdvd: check for NULL returna fter calling bio_split_to_limits()
      Merge tag 'nvme-6.2-2023-01-20' of git://git.infradead.org/nvme into block-6.2

Keith Busch (1):
      nvme-pci: fix timeout request state check

Pavel Begunkov (1):
      block: fix hctx checks for batch allocation

Yu Kuai (2):
      block, bfq: switch 'bfqg->ref' to use atomic refcount apis
      blk-cgroup: fix missing pd_online_fn() while activating policy

 block/bfq-cgroup.c            |  8 +++-----
 block/bfq-iosched.h           |  2 +-
 block/blk-cgroup.c            |  4 ++++
 block/blk-mq.c                |  6 +++++-
 drivers/block/pktcdvd.c       |  2 ++
 drivers/block/rnbd/rnbd-clt.c |  2 +-
 drivers/md/md.c               |  4 ++--
 drivers/nvme/host/apple.c     | 24 ++++++++++++++++++++----
 drivers/nvme/host/pci.c       |  2 +-
 9 files changed, 39 insertions(+), 15 deletions(-)

-- 
Jens Axboe

