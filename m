Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B75C433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 03:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5236E60EBA
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 03:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbhIFDHj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Sep 2021 23:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbhIFDHj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Sep 2021 23:07:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183C2C061575
        for <linux-block@vger.kernel.org>; Sun,  5 Sep 2021 20:06:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k17so3090366pls.0
        for <linux-block@vger.kernel.org>; Sun, 05 Sep 2021 20:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=71Lbt9GQW9FDhnjtYMzPegEWzXNTcAcHWnyITqT+3w8=;
        b=LwiGZFEuHIgzY7v+kGXWOztcfPEsAD1wkrOZylFkPDYHZiQAGGpJq//6Zt71V83vqR
         nmpBs4jdhndY78xlnTRFE+8LPx9Itx5v4GXeEwzoDSvarzkrRWK566eUl3ngU28bDjP8
         EhEhKYAKVh2USJi5Kpp21qTa7Jro0FqHp/mXjm5HT3mnxf5Y+AL8OjU9gBYrps1vFkg2
         xnjJ5542/BqNAFAgZocjzJIidZ7kBthqcn8PhXYLWhImEmM8EPu4USQyqOUOrweJb7So
         QXWFurzpSCMZWbA8pqGu14ubp0woCTLWnL7n39t3OgdWYPAGfvHzZQaM2mRgvjI5Goc2
         ABFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=71Lbt9GQW9FDhnjtYMzPegEWzXNTcAcHWnyITqT+3w8=;
        b=p49lyV+kthNqdJZj/0mmYbuykAIkIJI0ZwcrvVdSKF0S6e45eGOSNZv+49U2PqlMb6
         KGlrWDF2zU9IoIAROj4ml9Zoy6+83VrF1qzzsPphv+0ANZ0zIFrNtSwRdH4Y4AR0U4t0
         GaywYQsyY9K5StRRFup3ipw2Dmsn9SUh6jL8PQAc+g1StgjaQ4qrRdphbcohGjnFZaI/
         a/fadFZ3X1nie5Ezj7S7/YEiGS7ha+MbB416U5kO9zOqSEgRophmYcYntPGWMnyQXjpb
         A8Ob1ukEWsRK6FDEqoC9OxIt1zz8LCTV/znQt8xUjV9TrD0YucQu4wQ0EHCkFPKk5gNL
         LnsQ==
X-Gm-Message-State: AOAM531HwyWRUjuiToIPd2pfjCSxFltpMlApUy1FyHnhp2MxN0AOqzLw
        duojJBcSD8qY8nIXCV2xrBRU+P5D8tpkaQ==
X-Google-Smtp-Source: ABdhPJz8QuU2NhWwQAHWcfgakA+TuyaBWt8GKBezfBw9s+NFMIfRZN8/4F/tyH5u5sqPQqXEQmJeJA==
X-Received: by 2002:a17:902:7e47:b0:137:60bd:c08f with SMTP id a7-20020a1709027e4700b0013760bdc08fmr9091787pln.8.1630897594083;
        Sun, 05 Sep 2021 20:06:34 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a23sm5627510pfo.120.2021.09.05.20.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 20:06:33 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.15-rc1
Message-ID: <e8a816f2-b3f6-cd37-aa4d-b3aa7aed565c@kernel.dk>
Date:   Sun, 5 Sep 2021 21:06:32 -0600
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

Was going to send this one in later this week, but given that -Werror is
now enabled (or at least available), the mq-deadline fix really should
go in for the folks hitting that.

- Ensure dd_queued() is only there if needed (Geert)

- Fix a kerneldoc warning for bio_alloc_kiocb()

- BFQ fix for queue merging

- loop locking fix (Tetsuo)

Please pull!


The following changes since commit 4ac6d90867a4de2e12117e755dbd76e08d88697f:

  Merge tag 'docs-5.15' of git://git.lwn.net/linux (2021-09-01 18:49:47 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.15-2021-09-05

for you to fetch changes up to 1c500ad706383f1a6609e63d0b5d1723fd84dab9:

  loop: reduce the loop_ctl_mutex scope (2021-09-03 22:14:40 -0600)

----------------------------------------------------------------
block-5.15-2021-09-05

----------------------------------------------------------------
Geert Uytterhoeven (1):
      block/mq-deadline: Move dd_queued() to fix defined but not used warning

Jens Axboe (1):
      bio: fix kerneldoc documentation for bio_alloc_kiocb()

Paolo Valente (1):
      block, bfq: honor already-setup queue merges

Tetsuo Handa (1):
      loop: reduce the loop_ctl_mutex scope

 block/bfq-iosched.c  | 16 ++++++++---
 block/bio.c          |  2 +-
 block/mq-deadline.c  | 12 ++++-----
 drivers/block/loop.c | 75 ++++++++++++++++++++++++++++++++++------------------
 drivers/block/loop.h |  1 +
 5 files changed, 70 insertions(+), 36 deletions(-)

-- 
Jens Axboe

