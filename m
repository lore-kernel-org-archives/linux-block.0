Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3493BC433F5
	for <linux-block@archiver.kernel.org>; Sat, 20 Nov 2021 16:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhKTQUk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Nov 2021 11:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhKTQUk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Nov 2021 11:20:40 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2306CC061574
        for <linux-block@vger.kernel.org>; Sat, 20 Nov 2021 08:17:37 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e8so13426116ilu.9
        for <linux-block@vger.kernel.org>; Sat, 20 Nov 2021 08:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SMdm/vn45pWhSHaS5Fj8BcoJtdhVTwarYoTYdEzKVYw=;
        b=zytv2wQOPwr3FcZm+lP2a5XsREQkL5GUW/NULujtmiAMnIjHghj+ziwFo10Wo/SBDg
         DDyXp3GPUNcXumo4YSx7u6HqliiZsLLXETMIhDcmBKgPkKII69YRPgJNybDrxPmExisK
         VRYHWUkVkPza/i1j1AXmi4YUo6uZU5Bjsq6ekcfZFM3/ckSzedJCJW+PlUyGJmjgi84e
         HBzKl7etMg5Unv92FS3MxqfooQyzS9x/LtkIxwB6fgtObz9HtnvSHxlnLmFN9kfzK1Ik
         xMUwTPL4+iRAvKoq/uGjvejjdg0dkwbOPDMqBjix+N8uEl4AW/pIT5MPF88cL29+4Fwh
         apVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SMdm/vn45pWhSHaS5Fj8BcoJtdhVTwarYoTYdEzKVYw=;
        b=gFR0CqMH2dhlgZ+cAQyu/v/ewI2WvXuegRD/AoMWRK87E9/TYcPKvnh4jHeFkx3DPr
         NMtlhcevoMFV4c7KloTHfuk7o7Zc915xCMF2udMrh63VBzk18Q6mYzSLfndvU3DbiF/X
         Xfi9UhFgzzMWmk5uXC9sCYadiHduEVZRD2it6LXfBgH5bofwXbvqs7btB3UEnPO7cgsj
         Zh/pjjAdPXH0cEDTXtnFke8aHfihuQzAuf5QIJr7j23YPv1FjHPmpfZRAyTK6Bv1kqgK
         sP52MMpYwtmh3mb177DRkRlehxnrSlYzi8mQNhp5+I5Z9VG8A0BiuNk5JLIrdSuWtem0
         2rSA==
X-Gm-Message-State: AOAM533Qoqc5xD56fAlBFswJZkf+nm+WSlTiIk8jX1oDaW2ToGmoicBr
        2tiCxvUa/XkN8ePqSv1jHInMn8/rz9YYFpH1
X-Google-Smtp-Source: ABdhPJwZZrPdAeSQ+Cc39sY4VaAjfXTjc/Xg1ee9VOfqiAP5XS1b6fbMwnNi0VFdhbiw11CepEfthw==
X-Received: by 2002:a92:b00c:: with SMTP id x12mr3718109ilh.260.1637425056174;
        Sat, 20 Nov 2021 08:17:36 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b15sm1896737iln.36.2021.11.20.08.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 08:17:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.16-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <5db84f8b-877c-230a-2b1d-f83109d886c0@kernel.dk>
Date:   Sat, 20 Nov 2021 09:17:31 -0700
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

- Flip a cap check to avoid a selinux error (Alistair)

- Fix for a regression this merge window where we can miss a queue ref
  put (me)

- Un-mark pstore-blk as broken, as the condition that triggered that
  change has been rectified (Kees)

- Queue quiesce and sync fixes (Ming)

- FUA insertion fix (Ming)

- blk-cgroup error path put fix (Yu)

Please pull!


The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.16-2021-11-19

for you to fetch changes up to 2b504bd4841bccbf3eb83c1fec229b65956ad8ad:

  blk-mq: don't insert FUA request with data into scheduler queue (2021-11-19 06:28:18 -0700)

----------------------------------------------------------------
block-5.16-2021-11-19

----------------------------------------------------------------
Alistair Delva (1):
      block: Check ADMIN before NICE for IOPRIO_CLASS_RT

Jens Axboe (1):
      block: fix missing queue put in error path

Kees Cook (1):
      Revert "mark pstore-blk as broken"

Ming Lei (3):
      blk-mq: cancel blk-mq dispatch work in both blk_cleanup_queue and disk_release()
      block: avoid to quiesce queue in elevator_init_mq
      blk-mq: don't insert FUA request with data into scheduler queue

Yu Kuai (1):
      blk-cgroup: fix missing put device in error path from blkg_conf_pref()

 block/blk-cgroup.c |  9 +++++----
 block/blk-core.c   |  4 +++-
 block/blk-flush.c  | 12 ++++++------
 block/blk-mq.c     | 33 ++++++++++++++++++++++++---------
 block/blk-mq.h     |  2 ++
 block/blk-sysfs.c  | 10 ----------
 block/blk.h        |  2 +-
 block/elevator.c   | 10 ++++++++--
 block/genhd.c      |  2 ++
 block/ioprio.c     |  9 ++++++++-
 fs/pstore/Kconfig  |  1 -
 11 files changed, 59 insertions(+), 35 deletions(-)

-- 
Jens Axboe

