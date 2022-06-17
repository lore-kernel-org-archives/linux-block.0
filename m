Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC7BC43334
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 16:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiFQQW6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 12:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiFQQW5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 12:22:57 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FFC1EC55
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 09:22:56 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id p63so3488233qkd.10
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 09:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4bObu6p1k2g+8vMXl1zhLx65wzpCkPXQManHSgZa+PI=;
        b=EFSgil86YvWSmXIkOyvOUgc85Ztj8Djkvn+1UAkQk1bpnNfZDyFZW5fU3+yPZoCMq5
         h9JYUNfd1Y6GI1TwaoJ+9R1Xq1L/H19Xcbne5Hviux90uVESY5uS6deO11RQe80cj5N1
         0IS1rV1uj3S+Fo42pmVpVw7RqTsRmMoFzbA21zUhvOsrCbjlnC688Dsg51gg9gml6b7t
         ZmVo7Rgu3l5uaaSkIRVHMLLnIk3FSKOsbld+SiKTWp/gnsJqShR+JN5lACBR5iVL/XxJ
         uM2Lbd0XDzG9w8bEbisJbZ33kJehOghosUkRwabdqPqzrsdpYeV0strmBBGLuE7opOzO
         tE4Q==
X-Gm-Message-State: AJIora9qMG/pXRaVSIcwky56axLj5yt8L7Kr/xTGhSvPEf/bYRJIaqQW
        w+hvVMwg9RmMp15MD4ExucUE
X-Google-Smtp-Source: AGRyM1uGUmSAXAbQUvVC96ACQl9YgJNglOsmd/xGTZ+qYJ2/oB9NBV6L2yUsEa7BF4pdlgE+0ywSTw==
X-Received: by 2002:a05:620a:120d:b0:6a6:a5a8:3ced with SMTP id u13-20020a05620a120d00b006a6a5a83cedmr7459056qkj.755.1655482975944;
        Fri, 17 Jun 2022 09:22:55 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id l16-20020a05620a28d000b006a6cadd89efsm5157201qkp.82.2022.06.17.09.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 09:22:55 -0700 (PDT)
Date:   Fri, 17 Jun 2022 12:22:54 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [git pull] device mapper fixes for 5.19-rc3
Message-ID: <YqyqXocn0lrLVJ1R@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes-3

for you to fetch changes up to 85e123c27d5cbc22cfdc01de1e2ca1d9003a02d0:

  dm mirror log: round up region bitmap size to BITS_PER_LONG (2022-06-16 19:39:29 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix a race in DM core's dm_start_io_acct that could result in double
  accounting for abnormal IO (e.g. discards, write zeroes, etc).

- Fix a use-after-free in DM core's dm_put_live_table_bio.

- Fix a race for REQ_NOWAIT bios being issued despite no support from
  underlying DM targets (due to DM table reload at an "unlucky" time)

- Fix access beyond allocated bitmap in DM mirror's log.

----------------------------------------------------------------
Benjamin Marzinski (1):
      dm: fix race in dm_start_io_acct

Mikulas Patocka (3):
      dm: fix use-after-free in dm_put_live_table_bio
      dm: fix narrow race for REQ_NOWAIT bios being issued despite no support
      dm mirror log: round up region bitmap size to BITS_PER_LONG

 drivers/md/dm-log.c |  3 +--
 drivers/md/dm.c     | 24 +++++++++++++++++-------
 2 files changed, 18 insertions(+), 9 deletions(-)
