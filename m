Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E56C433F5
	for <linux-block@archiver.kernel.org>; Fri,  1 Apr 2022 19:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351593AbiDAT25 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Apr 2022 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351598AbiDAT2y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Apr 2022 15:28:54 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446AE175866
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 12:27:03 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id kc20so2786912qvb.3
        for <linux-block@vger.kernel.org>; Fri, 01 Apr 2022 12:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nvFo57OWxTfF6xwdTmogwqLgyZ3UA+Mu9A7SNgh8l+A=;
        b=dX9+XwiniKa/T3cMgwo9BVoPf1zf8rhP9DsQQ+dJXes6jaW/sisFtOK54UKNE0U86d
         VRA0A/3uf/ObLVO59KknIDg7OORV1jALTPw3T5puV4Q0cp6oO8PWq2og+xhC1lDUNg8b
         gN390365hAhtGaO9z1ASokJGCR0E8xEO6OfXqcTJRw1+lykmg8JpKN7b0TjlE2u9meFF
         Ibo7FGWRtVp8rHd3Q4zMVtPMxOFnv9F3xY1yCa6AtmJm/E/RLuOhy1LKN+78swknfKeD
         /q4/5UPIczQ1I52ShTuVmCemLoOUcNQXd0FN4NkQyt4O96BSq2gGS2G+nEDSFu6/R+iJ
         Fi0w==
X-Gm-Message-State: AOAM531Uc9cdh8Ju8XP+WrPcfgS/hz9kkwGKEdZaTe3o6/+ZxFySfotd
        5ryt2dsdU2DnWbjBWCT/2dVx
X-Google-Smtp-Source: ABdhPJz7IojtZWqKLAmzeellR8Hr0SP+8z17HN70PVGT0MGDxgLjPsXgmnzE3U9TIQxU971k8XygPA==
X-Received: by 2002:ad4:5ba7:0:b0:441:75bc:d7a6 with SMTP id 7-20020ad45ba7000000b0044175bcd7a6mr37912669qvq.123.1648841221729;
        Fri, 01 Apr 2022 12:27:01 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id s31-20020a05622a1a9f00b002e1df010316sm2387410qtc.80.2022.04.01.12.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 12:27:01 -0700 (PDT)
Date:   Fri, 1 Apr 2022 15:27:00 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [git pull] device mapper fixes for 5.18-rc1
Message-ID: <YkdSBEf1PpU9w2qs@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 3f7282139fe1594be464b90141d56738e7a0ea8a:

  Merge tag 'for-5.18/64bit-pi-2022-03-25' of git://git.kernel.dk/linux-block (2022-03-26 12:01:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.18/dm-fixes

for you to fetch changes up to 5291984004edfcc7510024e52eaed044573b79c7:

  dm: fix bio polling to handle possibile BLK_STS_AGAIN (2022-04-01 13:23:12 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM integrity shrink crash due to journal entry not being marked
  unused.

- Fix DM bio polling to handle possibility that underlying device(s)
  return BLK_STS_AGAIN during submission.

- Fix dm_io and dm_target_io flags race condition on Alpha.

- Add some pr_err debugging to help debug cases when DM ioctl
  structure is corrupted.

----------------------------------------------------------------
Mikulas Patocka (3):
      dm ioctl: log an error if the ioctl structure is corrupted
      dm integrity: set journal entry unused when shrinking device
      dm: fix dm_io and dm_target_io flags race condition on Alpha

Ming Lei (1):
      dm: fix bio polling to handle possibile BLK_STS_AGAIN

 drivers/md/dm-core.h      |  4 ++--
 drivers/md/dm-integrity.c |  6 ++++--
 drivers/md/dm-ioctl.c     | 15 ++++++++++++---
 drivers/md/dm.c           | 20 +++++++++++++-------
 include/linux/blk_types.h |  2 ++
 5 files changed, 33 insertions(+), 14 deletions(-)
