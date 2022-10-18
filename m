Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74810C4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 18:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJRSol (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJRSoj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 14:44:39 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387AE286ED
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 11:44:38 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id r19so10264759qtx.6
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 11:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stlH/SoLoTxeHdDl6sjryAM2rO8hfi05PwPVPZbgTnE=;
        b=2fU1ix/tNH6g6nz0FK6a+P0PV2oOcdXiONMOCPlZdVBPlM8RGRedepkpIiqfG5Er7d
         QOCo+cfUb3N58ESAWVpsKg/mMelaIoGUKe/AIGQ9fD/uuBU4w2jz+Mr5rZ1QMFkYDM1e
         LLvfGDr/qBncVBwkomt/QtBfQTftd17CnitQylwJc4kuK22mJJx7YCZyNa1M8ufxy7Fs
         B3hwljmoqp1OVjj/hN6cWT05hqlW0DWXQEq/IROhGqu2oRYN5wjlIovs7bPdntLle04w
         OuDvB/SfIcPWiPy8SgovOnp4YZw5RL8J4symNlKejbAznxXxX9aPOw3PAL1CPfsHbjFx
         xjbA==
X-Gm-Message-State: ACrzQf0WQvYJGSN3OuDEXrKyc216/YvII4fEPkZ2ePAi93onGwJGUZsB
        1p/QN08tMldfMzkg6whPWajU
X-Google-Smtp-Source: AMsMyM6CrAbtDjrjT2e043kwE0xeXRgbI9q5gHVmvpiuLusuhlpMS2D1xi9kn0v7CVVHfKrOwIm2VA==
X-Received: by 2002:a05:622a:18a0:b0:39b:e6e5:3f6b with SMTP id v32-20020a05622a18a000b0039be6e53f6bmr3250715qtc.613.1666118677335;
        Tue, 18 Oct 2022 11:44:37 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006e16dcf99c8sm3042688qko.71.2022.10.18.11.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:44:36 -0700 (PDT)
Date:   Tue, 18 Oct 2022 14:44:35 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [git pull] device mapper fix for 6.1-rc2
Message-ID: <Y070ExTjLGLStSQ0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit bb1a1146467ad812bb65440696df0782e2bc63c8:

  Merge tag 'cgroup-for-6.1-rc1-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2022-10-17 18:52:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.1/dm-fix

for you to fetch changes up to 141b3523e9be6f15577acf4bbc3bc1f82d81d6d1:

  dm bufio: use the acquire memory barrier when testing for B_READING (2022-10-18 12:38:16 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix dm-bufio to use test_bit_acquire to properly test_bit on arches
  with weaker memory ordering.

----------------------------------------------------------------
Mikulas Patocka (1):
      dm bufio: use the acquire memory barrier when testing for B_READING

 drivers/md/dm-bufio.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)
