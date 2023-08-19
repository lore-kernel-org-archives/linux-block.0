Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9BDEE4993
	for <linux-block@archiver.kernel.org>; Sat, 19 Aug 2023 14:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjHSO5d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Aug 2023 10:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjHSO5c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Aug 2023 10:57:32 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDBE27D19
        for <linux-block@vger.kernel.org>; Sat, 19 Aug 2023 07:57:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-564670fad4bso234753a12.1
        for <linux-block@vger.kernel.org>; Sat, 19 Aug 2023 07:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692457050; x=1693061850;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5NwsZO+8vVSPNnTaXgp/zwUXabMIVJR4BC6rXS5oqA=;
        b=T6HXZoMttoXhe8UitsZXhHWNSsfbKCT11Nubu3A5/CdQedhnTfudkqrZL6rGf+Se3c
         ZeqA6FwRVP/ALe/q8ZNlk7358I7Y16src/Wi7dBAJShp/5EU8f0NciosaEtFkNMFUA2U
         QOHy5SRCN8QDh2LJ7InJiTilKPvtG2Qet6CX+cWwQD/xSMttu8pV3uLKEx46EQX1Sdg0
         Im6HSTYmNfYhRTzqNrI4+6Yd/6CNiNdy7X4d24PEOkOdIfZeAxLWzgH8Ug+B0Q2rgHhv
         HC5nVwi//U0jCvi6pFQsuzLvjxQSyX6hAr2kOXPwzJT5zaz0S+eCAoq9kYtKR9ZYssA6
         /zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692457050; x=1693061850;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e5NwsZO+8vVSPNnTaXgp/zwUXabMIVJR4BC6rXS5oqA=;
        b=V+HPGBu4hZGXz9KMbnhREFpdbDtpI+fUhnshwuRJe0aV6QpNVWcfg7cynpjJi0tIWi
         iYFrRwV15CGHQeiKC3toBGI+TSR8bdxyX2p/sResfhn/aEfhhGSv1pNv9WDF0uFJWYyp
         M3KVRa20OeXQk3T4V2ZfRZ2xzR2NkhtfaRqzQnoQRgp36qXfjxRl9OACwbepxNLirhll
         WTiyziffxztG4S1NDOlVf4iIFxpB4mWiza0queCg/GahHVSYKYaP7ATeRZSzCyE3KXOH
         qt02iehKb8buaMVgGrtXQJe5Vm9V0OFKew0EQK1Tu/QsWgvKYdgUM6uGX9Fy2CGzgkU9
         ohLA==
X-Gm-Message-State: AOJu0Yx11JwVo2Dl7JJpdg53yy/ik3Fgii9nu3t59iin/VQJzVTNFAzv
        gnT62/uMR8Rkr3KQqhU5+t/BPwDKaFKML2E2RNQ=
X-Google-Smtp-Source: AGHT+IEU3GuUCyAF1zZJm026hdsJBgAEphppBRTVKwivDDKn+2BFf8EJs6yoEUCsfdXLcY+NkhDn1w==
X-Received: by 2002:a17:90a:9e2:b0:26d:1eff:619f with SMTP id 89-20020a17090a09e200b0026d1eff619fmr1976449pjo.2.1692457050486;
        Sat, 19 Aug 2023 07:57:30 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id mv22-20020a17090b199600b00263987a50fcsm5079455pjb.22.2023.08.19.07.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 07:57:29 -0700 (PDT)
Message-ID: <0ca594f5-3145-4e22-89d0-94c8a8f4ac22@kernel.dk>
Date:   Sat, 19 Aug 2023 08:57:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.5-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Main thing in this pull request is the fix for the regression in flush
handling which caused IO hangs/stalls for a few reporters. Hopefully
that should all be sorted out now. Outside of that, just a few minor
fixes for issues that were introduced in this cycle.

Please pull!


  nvme: core: don't hold rcu read lock in nvme_ns_chr_uring_cmd_iopoll (2023-08-11 08:12:32 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.5-2023-08-19

for you to fetch changes up to e5c0ca13659e9d18f53368d651ed7e6e433ec1cf:

  blk-mq: release scheduler resource when request completes (2023-08-19 07:47:17 -0600)

----------------------------------------------------------------
block-6.5-2023-08-19

----------------------------------------------------------------
Chengming Zhou (1):
      blk-mq: release scheduler resource when request completes

Li Zhijian (1):
      drivers/rnbd: restore sysfs interface to rnbd-client

Ming Lei (1):
      blk-cgroup: hold queue_lock when removing blkg->q_node

Sweet Tea Dorminy (1):
      blk-crypto: dynamically allocate fallback profile

 block/blk-cgroup.c                  |  2 ++
 block/blk-crypto-fallback.c         | 36 +++++++++++++++++++++++-------------
 block/blk-mq.c                      | 23 ++++++++++++++++++++---
 block/elevator.c                    |  3 +++
 drivers/block/rnbd/rnbd-clt-sysfs.c |  2 +-
 5 files changed, 49 insertions(+), 17 deletions(-)

-- 
Jens Axboe

