Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235E5C43334
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 19:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiGOTuh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 15:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGOTug (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 15:50:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23EBBC08
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 12:50:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q5so4030552plr.11
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 12:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=mzwdUAO4qxUJWPqPtN/LEmR3gVGFKmYMg5dEZ11AjPg=;
        b=f6FYL6kkzzr/iHfHptttt7VGLfAmrwyz8+9reVgNRizxwgOCYfHyCrZsGrakFTXbcv
         MP7G4Ai98ujtiJhCLduFgAa8djLEWrTKNGVDaACzNJAieufdAJpU6uf9yXvaezVk+q/Z
         1y2McEP2g9GfUU1xEOsS/Zhpl6HRTWmkc7WSVNC4aQIdqnjpEqCua6dBSbpNayXf2svG
         fIIPi8M1JzNWjNoBY/wjh2WSDjzPrtCeVAT7swPRCoto4M8o3OZore5HUvFw5MNY7F4m
         z2g1Hf7fbRMfsJ6IyA13jzFJeK5LZhnh6BmX8zkjiaf/BG9jUjE85Ouc2Msp6nIx4K0W
         Lyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=mzwdUAO4qxUJWPqPtN/LEmR3gVGFKmYMg5dEZ11AjPg=;
        b=VM+W329DYdokaxmuwiQPE5NiJrlzvmQvF2AH8djxf4wVK9afEhFSold/5PHDO2eyAz
         y7de2WkLQaE0Hx+JPdvAr/1BNi7SxwR1eMjhmiiFxnepg+Wj8ujTxq51v/B9ub5bJtHu
         f15o0iftaEdB3HrUsZseg7Un5iNplVNdMuu+YJy3aN40w9aStg9C2zp00y+jJOvTafFz
         VoG9FdL741PyHbTWjr7aEqepXBwq3l7ZjTFI1Xk5+5m4BeejCw7+OwQ9tWC7DBHJvHyb
         yCDKxrTRMdWAVdDZXhcC18F5J3FPMGpd9E/XbbKvqy0kOtI4sSQGczdnnsuXiTh9/JAL
         e4mQ==
X-Gm-Message-State: AJIora88HFyxalnv2EFop++Lmy67SApiw+e2Yha6FTbuMucf2+S+0Qd6
        CF5/QdMsPCS6qovPL8PBsgV+GZqplYHA6g==
X-Google-Smtp-Source: AGRyM1szuMYFP6PoOCSGSonnPgnD2bulbfNbyfcwV+F4AmrtSgNmb+EFFRKT60gPQ62LuNOCgCK/WA==
X-Received: by 2002:a17:90a:e00c:b0:1ef:81e6:9044 with SMTP id u12-20020a17090ae00c00b001ef81e69044mr24022652pjy.169.1657914634072;
        Fri, 15 Jul 2022 12:50:34 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ot8-20020a17090b3b4800b001ef89019352sm13755116pjb.3.2022.07.15.12.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 12:50:33 -0700 (PDT)
Message-ID: <5d50557f-e09b-acbf-690c-b82ca2d2e53d@kernel.dk>
Date:   Fri, 15 Jul 2022 13:50:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.19-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Two NVMe fixes, and a regression fix for the core block layer from this
merge window. Please pull!


The following changes since commit 6b0de7d0f3285df849be2b3cc94fc3a0a31987bf:

  Merge tag 'nvme-5.19-2022-07-07' of git://git.infradead.org/nvme into block-5.19 (2022-07-07 17:38:19 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-15

for you to fetch changes up to 957a2b345cbcf41b4b25d471229f0e35262f066c:

  block: fix missing blkcg_bio_issue_init (2022-07-14 10:54:49 -0600)

----------------------------------------------------------------
block-5.19-2022-07-15

----------------------------------------------------------------
Israel Rukshin (1):
      nvme: fix block device naming collision

Jens Axboe (1):
      Merge tag 'nvme-5.19-2022-07-14' of git://git.infradead.org/nvme into block-5.19

Keith Busch (1):
      nvme-pci: fix freeze accounting for error handling

Muchun Song (1):
      block: fix missing blkcg_bio_issue_init

 block/blk-merge.c        | 1 +
 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/pci.c  | 9 +++++++--
 3 files changed, 11 insertions(+), 5 deletions(-)

-- 
Jens Axboe

