Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6814DC433E6
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 20:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A4C207DF
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 20:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dRzcS07R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgH1UDg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1UDd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 16:03:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC76AC061264
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2020 13:03:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t185so1171634pfd.13
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2020 13:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=FBMOBjAfhEljTuAGgLFdjCOUirrkMi271bcifXQq7pc=;
        b=dRzcS07Rm6uelxv9NFSOSTnoeSUDeaL9H6m31Dx/jvPEmKSkxo83Z3I1CAux9sFjFN
         PL9TIrZEIR4BUVvzgLNxX4AJegySh2qGYff3Mr04ZkBG/GjnWjlktGmI7OXZENWs2beW
         0wQ54Beb79pTWkmTsYO1FOcD1GclgtrkeUuPkqr3HxbzV3LmdVXSBMQiIb92Cua6nXrB
         Bmndg/o9GcECNZ3kQDEjlFt6DxYgZo2CNBc8PI4rrsYzLUBPx6cvKc9r6Gzpy7COdanI
         oD6Dmi4MbEXe5zRADN/yn7zlplP3pBaogijfZAx1bAz8P2i1mi1soxpik+Jk8esJaI9k
         0tAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=FBMOBjAfhEljTuAGgLFdjCOUirrkMi271bcifXQq7pc=;
        b=S8nAUb4VtEm6cc7IKu0IQ8l8svv8qv9KV4KtHahNv6rCg4DfJrv8W1xUFckUg65ReK
         fYnghMdPhUmzBdSTGnetCbdj6VemzaM2FQCFhquzhvOjaHX13vcy0XhqLF+kE0HPP4ns
         /j7Biv2JHelF2uKPNwIXkBMDdSDsc0u0J4lfwNJjSFipMQaBeX99kU1r1/nucNR3xTVw
         9b/anMb4blvSZNGXNA2iu0yJcdEJaQOSqJki5nrFVikXQas1zDsR1Sy9Kx5tYorhe/qa
         Qor30f2J9AY++1V3cgsCzCY0t3RCcemU2OgALfcUz60FzoDW2PeG9iEPx1Wrle3T3j0U
         Xa4Q==
X-Gm-Message-State: AOAM531I0Wy9EnGGZL89Yq7nrnEqE6KSLxXQC7rcKiW3PWwDgAlfS5Qq
        K4TgmRITquN6TL+ADOMCzcweiBa5QmDjmQi6
X-Google-Smtp-Source: ABdhPJyQoKQNKRXM+XU2uyne228cwg/QhbuVKLRM0c6WV/R7IHHWjrOS9uYIVH6zLKKBXGmgdxHIyw==
X-Received: by 2002:a62:824f:: with SMTP id w76mr540065pfd.264.1598645009566;
        Fri, 28 Aug 2020 13:03:29 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d5sm169407pjw.18.2020.08.28.13.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 13:03:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.9-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <ea435538-0daa-b039-833a-cf619d210bb7@kernel.dk>
Date:   Fri, 28 Aug 2020 14:03:28 -0600
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

- nbd timeout fix (Hou)

- Device size fix for loop LOOP_CONFIGURE (Martijn)

- MD pull from Song with raid5 stripe size fix (Yufen)

Please pull!


The following changes since commit 2d62e6b038e729c3e4bfbfcfbd44800ef0883680:

  null_blk: fix passing of REQ_FUA flag in null_handle_rq (2020-08-21 17:14:28 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.9-2020-08-28

for you to fetch changes up to a433d7217feab712ff69ef5cc2a86f95ed1aca40:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.9 (2020-08-28 07:52:02 -0600)

----------------------------------------------------------------
block-5.9-2020-08-28

----------------------------------------------------------------
Hou Pu (1):
      nbd: restore default timeout when setting it to zero

Jens Axboe (1):
      Merge branch 'md-fixes' of https://git.kernel.org/.../song/md into block-5.9

Martijn Coenen (1):
      loop: Set correct device size when using LOOP_CONFIGURE

Yufen Yu (1):
      md/raid5: make sure stripe_size as power of two

 drivers/block/loop.c | 4 ++--
 drivers/block/nbd.c  | 2 ++
 drivers/md/raid5.c   | 7 +++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

-- 
Jens Axboe

