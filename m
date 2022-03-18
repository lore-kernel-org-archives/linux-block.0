Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6245C4332F
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 21:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbiCRWA4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 18:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241223AbiCRWAz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 18:00:55 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CD7F9557
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 14:59:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 6so5946478pgg.0
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=TMeyZ9NnVRM5GREL8gFa0wSK7oQqM4TfIg29eo0Xlc8=;
        b=VGABW2s0R5TfwfeDe8ybLbH1k5L+My8+JAIm0UNuuKF7kDM1Azc8telsmTF8Bl126a
         9BYJbAdjxkZUu+8Ni1YlzzR7JSTXUg5hFUrT5U/GRngayw4PIsKm8dYNfZtDuxWXqJdy
         MF2LrYk0n688uf1Gd/3iKXUwwFUYC8ARiHcZxvyAYhl3dG5ydAuZWKyjpQbnV4ehseCB
         s+4uUoycFZiV+1ZUqTHxo3QZoIVgKlTXKfQEabDjha442yr82x/OJhVvalOjBLsFGXn9
         UYMS/z3/9+96qtQPJ7C8mPTy+6qFbfec2CZLQ+mMcFLH5S+EF0ZW1Xnl5VCG5ecVyM3T
         mVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=TMeyZ9NnVRM5GREL8gFa0wSK7oQqM4TfIg29eo0Xlc8=;
        b=KuuxbfU3gcjiixRYb+SP1Rm1saX5zr/tCsTMogo1Fjkxpqh9JYBnvSt2+YvaVtNgzF
         qYuWpbOG1JnJVWngSsZoF8K4NfCVaKpCm2s+90YMK9aDsUBjSI4p85DPtRBw484itmqI
         8kWaDxsijCM/09wW61xs+And+1M9XNA/JRSwqV4qAkweYML0CABoLDJXKj0/7hDTUKaM
         FgrgCJFhTht9yuIB30DjE+3eZATK8u+OOAme3fShwo1dmZtOzv6KuVmv1VcZ7qsQfDLc
         hGV+hgcH0UmUJvpz7mVKFmS8gpeflvcNifVPrfiRKq9fHCTnin2EpGybPQyz7azy4yrr
         I3Eg==
X-Gm-Message-State: AOAM532H8sFI/p4ueE1M2yjtVs+b/d6iKaQYolm3dwdDrKglfNzYuLfE
        4JDn/kQFIZDwggxAfBKTEoRpXw==
X-Google-Smtp-Source: ABdhPJwstiJLeh3J1jqEV65XlkLuUjE3fTbLTq9jczVR8TvRS5c+HHT6m20zD3QyYwfdhMX2IcsqyQ==
X-Received: by 2002:a63:6b81:0:b0:380:4fc1:ee7b with SMTP id g123-20020a636b81000000b003804fc1ee7bmr9497789pgc.298.1647640775660;
        Fri, 18 Mar 2022 14:59:35 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w12-20020a056a0014cc00b004f790cdbf9dsm11212815pfu.183.2022.03.18.14.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 14:59:35 -0700 (PDT)
Message-ID: <212e39c2-2e2a-24af-647b-67f3168ea558@kernel.dk>
Date:   Fri, 18 Mar 2022 15:59:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] File system related bio_alloc() cleanups
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of the core block driver branch, here are a set of fs related
cleanups to bio allocations.

Please pull!


The following changes since commit 451f0b6f4c44d7b649ae609157b114b71f6d7875:

  block: default BLOCK_LEGACY_AUTOLOAD to y (2022-02-27 14:49:23 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.18/alloc-cleanups-2022-03-18

for you to fetch changes up to 64bf0eef0171912f7c2f3ea30ee6ad7a2ad0a511:

  f2fs: pass the bio operation to bio_alloc_bioset (2022-03-08 17:59:03 -0700)

----------------------------------------------------------------
for-5.18/alloc-cleanups-2022-03-18

----------------------------------------------------------------
Christoph Hellwig (5):
      mpage: pass the operation to bio_alloc
      ext4: pass the operation to bio_alloc
      nilfs2: pass the operation to bio_alloc
      f2fs: don't pass a bio to f2fs_target_device
      f2fs: pass the bio operation to bio_alloc_bioset

 fs/ext4/page-io.c  |  7 ++---
 fs/f2fs/data.c     | 89 ++++++++++++++++++++++++------------------------------
 fs/f2fs/f2fs.h     |  2 +-
 fs/mpage.c         | 50 +++++++++++++-----------------
 fs/nilfs2/segbuf.c | 20 ++++++------
 5 files changed, 73 insertions(+), 95 deletions(-)

-- 
Jens Axboe

