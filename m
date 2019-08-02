Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC955C32750
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 14:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6408520B7C
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 14:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="E2y4iOQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfHBOQL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:16:11 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37541 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbfHBOQL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Aug 2019 10:16:11 -0400
Received: by mail-pf1-f169.google.com with SMTP id 19so36115173pfa.4
        for <linux-block@vger.kernel.org>; Fri, 02 Aug 2019 07:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=t4SwJAXmdng+Bof5AbuJ/SKRazAqnNJM1t77brvUk8U=;
        b=E2y4iOQz/y1loqXHlYqmuq1baCT2NQMvtw19ukD3s+a91uAhxM8kWrRNbF+zEk/ejT
         SDXT/Ps9T+McVI1cpgYhT88qpbIm1F67+pi/R9iLPJLz7iThgFKgIOTJHsi4nhLHDLnE
         DTNCCEju5kzx9tNFNM/epDhOxIhtAYY56ufOSW5rxmi1HLK8g52OYZnZuCbDEkrj2DvO
         QE3uW96DInMMPTJjslXxFhytsNMxtRJWcNFvuOGs/Ts6gpE6aJjo+pAmFewGLu3lxUco
         ijVLU1MXGVERRWRKAmlCjgMG62rl8egWrNIEqCiwkgH1DDmsfXlihTuBebrsalZn4CgY
         tcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=t4SwJAXmdng+Bof5AbuJ/SKRazAqnNJM1t77brvUk8U=;
        b=Kwy938kRKOmIjPP/4Kss7GeOz2gsy/uX8KcI35ecmAhy+uUwMZ7pNvAspSTkweMb8D
         pEE+2YFlONx1/ZZFmZ4Y2vOL8Pu0GzEpZEwbhBJy8JRF7t9GotxG6cRkEP5HE7YlB53p
         OgKVwHuOWb7LYY4ckWj9PwAXYynj98ZuCH9C4s6887zs1UfElhaOILXasLB3EiayxfQg
         HK5sk/7Jz0AJAIUqYuAqwkbmARpb+ZXws0FzYHtcpTJBee1Cp829xM8GONIhn5w0BESV
         WAIT2jSPq1w+Iy/X/RPI+0zOUBBAoluLWEfZR/1S/O+W/TBNiVGHHt9tjiaTUyZJaFTr
         +NEA==
X-Gm-Message-State: APjAAAVHtOKLeKtnYXnHEbRiqWEfJcbc5sDMpEqerFp51zj7VKrKzzVy
        9xkpco/Q6ctdbLCnU2IUrZZxTmDISjc=
X-Google-Smtp-Source: APXvYqzVO5UGqcoDbtBFzYl5cOhZkXn+9d+tIqHH0Fq0P2YELjdcx16VHW+t+Jvi8KTEfMuem18Gcw==
X-Received: by 2002:a63:24a:: with SMTP id 71mr15004200pgc.273.1564755370311;
        Fri, 02 Aug 2019 07:16:10 -0700 (PDT)
Received: from [192.168.200.229] (rrcs-76-80-14-36.west.biz.rr.com. [76.80.14.36])
        by smtp.gmail.com with ESMTPSA id f19sm111463578pfk.180.2019.08.02.07.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 07:16:09 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.3-rc3
Message-ID: <b46c1b0d-4142-e6fb-5ef1-1f90a8d4200d@kernel.dk>
Date:   Fri, 2 Aug 2019 08:16:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here's a small collection of fixes that should go into this series. This
pull request contains:

- io_uring potential use-after-free fix (Jackie)

- loop regression fix (Jan)

- O_DIRECT fragmented bio regression fix (Damien)

- Mark Denis as the new floppy maintainer (Denis)

- ataflop switch fall-through annotation (Gustavo)

- libata zpodd overflow fix (Kees)

- libata ahci deferred probe fix (Miquel)

- nbd invalidation BUG_ON() fix (Munehisa)

- dasd endless loop fix (Stefan)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190802


----------------------------------------------------------------
Damien Le Moal (1):
      block: Fix __blkdev_direct_IO() for bio fragments

Denis Efremov (1):
      MAINTAINERS: floppy: take over maintainership

Gustavo A. R. Silva (1):
      ataflop: Mark expected switch fall-through

Jackie Liu (1):
      io_uring: fix KASAN use after free in io_sq_wq_submit_work

Jan Kara (1):
      loop: Fix mount(2) failure due to race with LOOP_SET_FD

Kees Cook (1):
      libata: zpodd: Fix small read overflow in zpodd_get_mech_type()

Miquel Raynal (1):
      ata: libahci: do not complain in case of deferred probe

Munehisa Kamata (1):
      nbd: replace kill_bdev() with __invalidate_device() again

Stefan Haberland (1):
      s390/dasd: fix endless loop after read unit address configuration

 MAINTAINERS                     |  3 +-
 drivers/ata/libahci_platform.c  |  3 ++
 drivers/ata/libata-zpodd.c      |  2 +-
 drivers/block/ataflop.c         |  1 +
 drivers/block/loop.c            | 16 ++++----
 drivers/block/nbd.c             |  2 +-
 drivers/s390/block/dasd_alias.c | 22 ++++++++---
 fs/block_dev.c                  | 86 ++++++++++++++++++++++++++++-------------
 fs/io_uring.c                   |  3 +-
 include/linux/fs.h              |  6 +++
 10 files changed, 101 insertions(+), 43 deletions(-)

-- 
Jens Axboe

