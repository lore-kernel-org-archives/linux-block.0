Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EE7C48BCF
	for <linux-block@archiver.kernel.org>; Sat, 12 Jun 2021 15:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4F36138C
	for <linux-block@archiver.kernel.org>; Sat, 12 Jun 2021 15:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhFLPQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jun 2021 11:16:38 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:39635 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLPQf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jun 2021 11:16:35 -0400
Received: by mail-pl1-f171.google.com with SMTP id v11so4310708ply.6
        for <linux-block@vger.kernel.org>; Sat, 12 Jun 2021 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dlKssdmEq9KNzh3jhmmsiXpyw8DnuVCke31h2mtsOwU=;
        b=AkGSIaecRg79fSDRQLK7xKpMMdHAPJgaPGUtWrniWrqgw4syls6k0UAtoNOs0BlZ+G
         x/oHlelT3m8Hd8PVsyQGeFCPcGkWU41ykmiOmHez24c6Amxf+hUZw0zEhS6mGihmgi87
         xG4Uo8CMtaAPzP/QN4fC0q1H6ZMfu0aAIgT7x0O77T5v8vhkzCc+LMV8/A505FjK4mbS
         2CV3ZO3b8pHIS07xVQdqh9HQjIfXsYQ1BKJRxchLGMC6maUXeNIbrF+ooqzbtAciDry8
         8vWdG7G0hqeHCrq4QtWGsIiORtCLzY10eRUmx2s0ARNdW8lfBeRrAZAZXKrat7/um6AD
         TBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dlKssdmEq9KNzh3jhmmsiXpyw8DnuVCke31h2mtsOwU=;
        b=JkteEwqSI+oGZqn+/T4ULToP0mEhPrqrzfPhdyzRbLv5oJ2IRrNSsVbPtT+5GBMtUz
         y6g52D162+cSOKxPUbhf+NwCthtJ28QEITHYySL9ZxyRAv2TqSu98waNYEuRnsPApdo+
         zT3HX0nbJFTy89xXgcoA717M+fNlqlGWX4Nl95cupKceYwNJpUQMHebxISjQ8a+blkp+
         Cj+YbhzIi7AVU+ZFYu1UgkDYZmKdy14HNuabLibaKW1G5pkBX2eg4JwMuv5MQnhw1eYQ
         LLqTCyNrYhW5NLnNNoV3vEMvP/DO8U673zXW/4+DhOPsesE7HoMuL95NldRjRajXzQFp
         6r4A==
X-Gm-Message-State: AOAM530wW3UnbFB6GuqMTfHWhG0u5SKLx2MsslgT7J1rhgCRZxysvA7N
        duZ4a/uxCEtjwQDfrFj+w6cQKpWu7BBKHA==
X-Google-Smtp-Source: ABdhPJxCVa0QYMukrg9aFdjs9NHVzg5Jl1rVOpy0eSN/V0+j6s/XGo/VrjjnEHESXheG3LAS5pU1ug==
X-Received: by 2002:a17:902:7244:b029:f5:2ffd:37f9 with SMTP id c4-20020a1709027244b02900f52ffd37f9mr8838111pll.26.1623510815520;
        Sat, 12 Jun 2021 08:13:35 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id s22sm8179219pfe.208.2021.06.12.08.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jun 2021 08:13:34 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.13-rc6
Message-ID: <502db269-c291-5675-779b-fccae75b86d5@kernel.dk>
Date:   Sat, 12 Jun 2021 09:13:33 -0600
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

A few fixes that should go into 5.13:

- Fix a regression deadlock introduced in this release between open and
  remove of a bdev (Christoph)

- Fix an async_xor md regression in this release (Xiao)

- Fix bcache oversized read issue (Coly)

Please pull!


The following changes since commit e369edbb0d8cee50efa6375d5c598a04b7cb3032:

  Merge tag 'nvme-5.13-2021-06-03' of git://git.infradead.org/nvme into block-5.13 (2021-06-03 07:42:27 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.13-2021-06-12

for you to fetch changes up to 85f3f17b5db2dd9f8a094a0ddc665555135afd22:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.13 (2021-06-11 11:56:08 -0600)

----------------------------------------------------------------
block-5.13-2021-06-12

----------------------------------------------------------------
Christoph Hellwig (1):
      block: loop: fix deadlock between open and remove

Coly Li (2):
      bcache: remove bcache device self-defined readahead
      bcache: avoid oversized read request in cache missing code path

Jens Axboe (1):
      Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.13

Xiao Ni (1):
      async_xor: check src_offs is not NULL before updating it

 crypto/async_tx/async_xor.c |  3 ++-
 drivers/block/loop.c        | 25 +++++++------------------
 drivers/block/loop.h        |  1 +
 drivers/md/bcache/bcache.h  |  1 -
 drivers/md/bcache/request.c | 20 +++++++-------------
 drivers/md/bcache/stats.c   | 14 --------------
 drivers/md/bcache/stats.h   |  1 -
 drivers/md/bcache/sysfs.c   |  4 ----
 8 files changed, 17 insertions(+), 52 deletions(-)

-- 
Jens Axboe

