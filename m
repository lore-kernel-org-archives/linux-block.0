Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725B6C4332B
	for <linux-block@archiver.kernel.org>; Sat,  6 Feb 2021 02:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F3B64FE4
	for <linux-block@archiver.kernel.org>; Sat,  6 Feb 2021 02:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhBFCox (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 21:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhBFCkF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Feb 2021 21:40:05 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFDEC08ED38
        for <linux-block@vger.kernel.org>; Fri,  5 Feb 2021 15:16:50 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g15so5589338pgu.9
        for <linux-block@vger.kernel.org>; Fri, 05 Feb 2021 15:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Qzublt+OSpzjrakyinu33+i+M4UkOIdnFqOBEWhR9Ds=;
        b=Qt32I1ykmR+juSOU2UYUjoCULWgIzKxi16l4onKNx+1VsS7eCIbrdcFDOiZDJindHP
         rxr4l4h2pM+n7/aG2Ge0F546UlB6ObXrWu3WNSP8LW0bYKFBga1KLHP5LjMEXS+JNZor
         E9Qbz77uihS/BWOxnfuu4YC+YmnqA38Qox/Grm7zKn9Oy9EGgr3mZdh/0059TKsp4FoS
         My+8poGn5Ilwd6KLdfhWWCX9RVTZ5r2iNzn3v6pnK4/LCh8vfvzN4zcr6dIApLY9Emij
         kpaV3owUlEDkJAB4LtXXmJc3V6+kuG0P9rz/fwKYq9riNqPjKFpsyHaQh4SPiEbbxk0X
         5cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Qzublt+OSpzjrakyinu33+i+M4UkOIdnFqOBEWhR9Ds=;
        b=FgXixPeRleo8GkRcILNDQj2uj0qcjRNehHXe60igWxD4tw5excyPzG2T6bus6B2u4p
         ifWjRk6u0lnDqQ0/UoBsWZBRa3IfaGNRRmsn4VrCZuB3aKfVoR91IVkl1QjNpTYq3ghh
         mr17yu3TpeEoa6tZv/hktfc+3OUT0zxLHjItE0tAVC0ZkA4p7eBPrMNRQD94u/I7ER3V
         lA8KL0KQDz6LVPqqxEIdAKzGemBeSROuuBW1J5Rj3wkyTLWt76Aq1AuBJPirmGRWUYOa
         3zm0vDnIfoYbjo5E6sFf/0S/3at1VPWbB5uPvtbMhbJ7dr3hajrWR8faaeyxtlvFHvj8
         FE0Q==
X-Gm-Message-State: AOAM5302r/thLhcAUqZJKXQruSiM6nyQH1PJAMNjk2cuogCvlZmydfon
        8rd0eqWPPzng54yb81hXMWhAEKuW7VKh6Q==
X-Google-Smtp-Source: ABdhPJzn/wwdkk97Bv4rXRsFPztDfe+QYJx5EkiS4aXWf3pKkrlEDQ7sFwxMFKTS6MjHjV075BnIGg==
X-Received: by 2002:a63:4444:: with SMTP id t4mr6481289pgk.329.1612567009463;
        Fri, 05 Feb 2021 15:16:49 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j26sm10072215pfa.35.2021.02.05.15.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 15:16:49 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.11-rc7
Message-ID: <1b6014c3-84cf-ec3e-69bf-73a8b10c7e88@kernel.dk>
Date:   Fri, 5 Feb 2021 16:16:47 -0700
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

A few small regression fixes:

- NVMe pull request from Christoph:
	- more quirks for buggy devices (Thorsten Leemhuis, Claus Stovgaard)
	- update the email address for Keith (Keith Busch)
	- fix an out of bounds access in nvmet-tcp (Sagi Grimberg)

- Regression fix for BFQ shallow depth calculations introduced in this
  merge window (Lin)

Please pull!


The following changes since commit cd92cdb9c8bcfc27a8f28bcbf7c414a0ea79e5ec:

  null_blk: cleanup zoned mode initialization (2021-01-29 07:49:22 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.11-2021-02-05

for you to fetch changes up to ea8465e611022a04d85393f776874911a9fc0a2b:

  Merge branch 'nvme-5.11' of git://git.infradead.org/nvme into block-5.11 (2021-02-04 08:24:16 -0700)

----------------------------------------------------------------
block-5.11-2021-02-05

----------------------------------------------------------------
Claus Stovgaard (1):
      nvme-pci: ignore the subsysem NQN on Phison E16

Jens Axboe (1):
      Merge branch 'nvme-5.11' of git://git.infradead.org/nvme into block-5.11

Keith Busch (1):
      update the email address for Keith Bush

Lin Feng (1):
      bfq-iosched: Revert "bfq: Fix computation of shallow depth"

Sagi Grimberg (1):
      nvmet-tcp: fix out-of-bounds access when receiving multiple h2cdata PDUs

Thorsten Leemhuis (1):
      nvme-pci: avoid the deepest sleep state on Kingston A2000 SSDs

 .mailmap                  | 2 ++
 block/bfq-iosched.c       | 8 ++++----
 drivers/nvme/host/pci.c   | 4 ++++
 drivers/nvme/target/tcp.c | 3 ++-
 4 files changed, 12 insertions(+), 5 deletions(-)

-- 
Jens Axboe

