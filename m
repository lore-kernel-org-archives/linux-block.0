Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3379C433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Jun 2022 23:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347495AbiFJXCW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jun 2022 19:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347609AbiFJXCU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jun 2022 19:02:20 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1EF1D088B
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 16:02:17 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id n197so296571qke.1
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 16:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9LGrN71hGYmCGD2rOU7fZmr62+xJ1Vp6jjk3/W+3clI=;
        b=rR3ahiRBwEyxtKXCEFUMFIHKKoqaMxK2irYzVtE4JqD6G8G5/CRKq6C8PvQZirKmy6
         2r4bg6jyAoHlctY4kchFGxK1+Hu8rTByx/xwzo/qbkVmiTgP6mJq08BdG1Ihc2l48rOQ
         vQkxL5nAIoA6coCOLJQYXoSWnrjtVK3aNop60wfv9htXu5wqHyFP+/GgozWHbtMqVHbC
         nP2/Rx5vyr2jJmjlgPXmhbOwvYfkt/mBJShcaeEuFv9uG3dEzV+qSKkQ55cde06wz+tZ
         lvmqJ7xj48+J1Y/RdtlLfGYD7cBqstu8VeWeM4pAvu6Dl1gDRS8fqjZTSwoXZHUjUWTn
         RdkA==
X-Gm-Message-State: AOAM533Q24kmshDJJ34maMn3xfOKUghdgVkG7LgNYAdkJplXoI7BfHcJ
        h6M2uF06HUjz5gnN7BX8UXCD
X-Google-Smtp-Source: ABdhPJy9eMmKIo9FfcxP4rXP3miTML9aPzFtMs1wjmo4pmTYde2sojL+C8P77Bnn0rwBp9BsZbBlKA==
X-Received: by 2002:a05:620a:1a1b:b0:6a7:aa:d474 with SMTP id bk27-20020a05620a1a1b00b006a700aad474mr11216024qkb.680.1654902136194;
        Fri, 10 Jun 2022 16:02:16 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id q12-20020a05622a030c00b00304dd83a9b1sm296245qtw.82.2022.06.10.16.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 16:02:15 -0700 (PDT)
Date:   Fri, 10 Jun 2022 19:02:15 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [git pull] device mapper fixes for 5.19-rc2
Message-ID: <YqPNd1xK0MIqRnev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes-2

for you to fetch changes up to dddf30564054796696bcd4c462b232a5beacf72c:

  dm: fix zoned locking imbalance due to needless check in clone_endio (2022-06-10 15:23:54 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM core's bioset initialization so that blk integrity pool is
  properly setup. Remove now unused bioset_init_from_src.

- Fix DM zoned hang from locking imbalance due to needless check in
  clone_endio().

----------------------------------------------------------------
Christoph Hellwig (2):
      dm: fix bio_set allocation
      block: remove bioset_init_from_src

Mike Snitzer (1):
      dm: fix zoned locking imbalance due to needless check in clone_endio

 block/bio.c           |  20 ---------
 drivers/md/dm-core.h  |  11 ++++-
 drivers/md/dm-rq.c    |   2 +-
 drivers/md/dm-table.c |  11 -----
 drivers/md/dm.c       | 110 +++++++++++++++++---------------------------------
 drivers/md/dm.h       |   2 -
 include/linux/bio.h   |   1 -
 7 files changed, 46 insertions(+), 111 deletions(-)
