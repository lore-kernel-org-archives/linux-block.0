Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D824DC433E1
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 15:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE26206BE
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 15:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aKcsqNs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgGQPuq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQPup (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 11:50:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADFBC0619D2
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2020 08:50:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d1so5600247plr.8
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2020 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GYLi1TpV7jolzw2RC2neJrdZm9TyamLEIPv7aAqRKYE=;
        b=aKcsqNs669xGAxg1VoEAnaSnzgps2sY9J5QOM2g1f+9/glGDHPtWS++K1PBU+yu2C9
         o78UUHwgTnWFWjoryPGendtyeppwPwpWZ8XGyR9boBbvmci5qlQqS6jSUlVjfkT+RAch
         N1hQbn8MY8rBZi3qgjj03pMRbwtz9Cr3O9aUEc/zPah1Ru/Vy8/G7oNXy928L4vYV9+A
         J44r3K24XpEhhMTSEkE703mzeJMbVnsVlUrTKZj+gAOwpzJRoeyl6emx0g7MMLsQcH1P
         Pb5kQ2p87Y3kqiLeWdKeYa5sHA+NVMfpP9IQKv/JJfRrsdkkO7xgRmEYc4VKE6Ez1pcX
         k1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GYLi1TpV7jolzw2RC2neJrdZm9TyamLEIPv7aAqRKYE=;
        b=WR2ruWhhwRLVzbmeclX0O/AzggHI+u9I6sUjL/iP7tA1VbITplmgVIGmyUUOL6vB61
         w6KZQcqDG8uedVnXsrheUGvw8arz18kIk6PHogSuUL826v4kE/0v8S0aRLH2kL91FrSW
         VLgl0oKfrc8e2p9UcRSNzKtHtT3sM3oZX/WfoGWX3UKc9Vll71xvrhJAG4DXGKMzeC+N
         hrT9xtNqN3T9BnyYjU6B9I2YE3HkL3gW09w7F2oIJkFcshFnxO7gcv2iR2x9bAxzg41K
         qJ97IxaFJUMTjMSaErBBJHRp4OapNaWaUYpbK3inL5Xr+WH5XhI52qtFvYx7PDLiNq/l
         Rjtg==
X-Gm-Message-State: AOAM531M+Q/T/pwvg3KXgRKHNn8bJ2xOg4rSfT63awL6GIIbum7u+qf+
        PZb/LfgdD6JOhV0qrCf3woKhpvkBXfZG1w==
X-Google-Smtp-Source: ABdhPJyGBRxlH4o7U8rdn8gkCTBAjP/HllMXuV+3w50MbWQ+BnPPWJvKDNejxIYoxn7oGzcEsoQWtw==
X-Received: by 2002:a17:90a:66c7:: with SMTP id z7mr10822225pjl.172.1595001044511;
        Fri, 17 Jul 2020 08:50:44 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q29sm8239141pfl.77.2020.07.17.08.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 08:50:43 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 5.8-rc6
Message-ID: <4dd7ab11-feb0-6ea8-46b6-0e9590d0890d@kernel.dk>
Date:   Fri, 17 Jul 2020 09:50:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Single NVMe multipath capacity fix

Please pull!


The following changes since commit 579dd91ab3a5446b148e7f179b6596b270dace46:

  nbd: Fix memory leak in nbd_add_socket (2020-07-08 15:42:18 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.8-2020-07-17

for you to fetch changes up to 1f273e255b285282707fa3246391f66e9dc4178f:

  Merge branch 'nvme-5.8' of git://git.infradead.org/nvme into block-5.8 (2020-07-16 08:58:14 -0600)

----------------------------------------------------------------
block-5.8-2020-07-17

----------------------------------------------------------------
Anthony Iliopoulos (1):
      nvme: explicitly update mpath disk capacity on revalidation

Jens Axboe (1):
      Merge branch 'nvme-5.8' of git://git.infradead.org/nvme into block-5.8

 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/nvme.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)

-- 
Jens Axboe

