Return-Path: <SRS0=tC1N=2M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50891C2D0C0
	for <linux-block@archiver.kernel.org>; Sun, 22 Dec 2019 06:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113EA2070A
	for <linux-block@archiver.kernel.org>; Sun, 22 Dec 2019 06:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="q8GZQuAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfLVGNV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Dec 2019 01:13:21 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:35728 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfLVGNV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Dec 2019 01:13:21 -0500
Received: by mail-pj1-f51.google.com with SMTP id s7so6007672pjc.0
        for <linux-block@vger.kernel.org>; Sat, 21 Dec 2019 22:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kM7jqhnhb79Bx5hWfQw8OUNTZdFkmq9y73JA7f+sBCw=;
        b=q8GZQuAaFGuiVzEijRu8DqsYhYdfTo+taad+wB5PVpl8UHo3lU7JgOb5DBLE1INKgz
         fHKCxluU5g+CqxE3cZ9uBW6asDVTsXik2cG4hO5Ic7qzEbJEaoISEYYA4CFOz9GPDSGJ
         yLI1Ws6ngiXHUCaloSl7a/eXQB1rG03ImpUAQj+El4JbUEZLG7/3yecuZaBuRwDbgM61
         mlILnnUXOV9QKrr3WZ4fsoanVkXX5U/kO9n8NVDwl+BEJnb0vb5z60S2p/f3kHW0IR1x
         +1BYSDEwa9UuKOD0ERNsswsl2Bdu2d3x+BRyG9FT6xe+ds+HxHKi7l3nUXz0f2IWDFO4
         Twqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kM7jqhnhb79Bx5hWfQw8OUNTZdFkmq9y73JA7f+sBCw=;
        b=Da8fQpGQqPAQJyH7zNN69/dPalw9gLB4TMZKNUKJs2LdRerq4FDpnpdEeoVj1gUKAa
         VCZ87LDoOxZvSA/xybiAAu8U0kydg2uQljeQxpxv6g7pQgpvKIs1obUEnbEBasR7fWh4
         kaCT1X7ZGDXVmCUwu5gg75y3UrmWnoo+JkR6BPtRGJ7vlsDjoE7uSgWGdkzCX0Rd+WBf
         3bLruSqzebOqqBB26guS2tb3ijb5UaKkwqF5iDi1NYVaojFA1DUMLKg7jYcBIycCcfs1
         bErGJjuIW2aDEU7MjvgOHkan4Jtp40XeAIQkEp9kzBChzwzDisXdoEe6sPb5TboxEjiY
         sn8w==
X-Gm-Message-State: APjAAAXIqwIJGpn3/BKGaea3o9Aqx6qb/fqAARuaBuw/IEVrNnnWZFNH
        EKEcpWzIS+021P/tlASZNZIp9uQUDI6HVA==
X-Google-Smtp-Source: APXvYqz8/f2n3xfXPnJhfO6K1zdOkitC4QV9GAED1+j+WQZ+VdL/zy0bVYIPH4e83RopXQc6Ke44qQ==
X-Received: by 2002:a17:90b:4383:: with SMTP id in3mr8063837pjb.111.1576995200043;
        Sat, 21 Dec 2019 22:13:20 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id w187sm1520618pfw.62.2019.12.21.22.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2019 22:13:19 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL v2] Block fixes for 5.5-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <b6a949e1-44b2-097d-4c82-237aa707e43c@kernel.dk>
Date:   Sat, 21 Dec 2019 23:13:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Let's try this one again, this time without the compat_ioctl changes.
We've got those fixed up, but that can go out next week. This pull
request contains:

- block queue flush lockdep annotation (Bart)

- Type fix for bsg_queue_rq() (Bart)

- Three dasd fixes (Stefan, Jan)

- nbd deadlock fix (Mike)

- Error handling bio user map fix (Yang)

- iocost fix (Tejun)

- sbitmap waitqueue addition fix that affects the kyber IO scheduler
  (David)

Please pull!
 

  git://git.kernel.dk/linux-block.git tags/block-5.5-20191221


----------------------------------------------------------------
Bart Van Assche (2):
      block: Fix the type of 'sts' in bsg_queue_rq()
      block: Fix a lockdep complaint triggered by request queue flushing

David Jeffery (1):
      sbitmap: only queue kyber's wait callback if not already active

Jan Höppner (1):
      s390/dasd/cio: Interpret ccw_device_get_mdc return value correctly

Mike Christie (1):
      nbd: fix shutdown and recv work deadlock v2

Roman Penyaev (1):
      block: end bio with BLK_STS_AGAIN in case of non-mq devs and REQ_NOWAIT

Stefan Haberland (2):
      s390/dasd: fix memleak in path handling error case
      s390/dasd: fix typo in copyright statement

Tejun Heo (1):
      iocost: over-budget forced IOs should schedule async delay

Yang Yingliang (1):
      block: fix memleak when __blk_rq_map_user_iov() is failed

 block/blk-core.c               | 11 +++++++----
 block/blk-flush.c              |  5 +++++
 block/blk-iocost.c             | 13 ++++++++-----
 block/blk-map.c                |  2 +-
 block/blk.h                    |  1 +
 block/bsg-lib.c                |  2 +-
 drivers/block/nbd.c            |  6 +++---
 drivers/s390/block/dasd_eckd.c | 28 +++++++---------------------
 drivers/s390/block/dasd_fba.h  |  2 +-
 drivers/s390/block/dasd_proc.c |  2 +-
 drivers/s390/cio/device_ops.c  |  2 +-
 lib/sbitmap.c                  |  2 +-
 12 files changed, 37 insertions(+), 39 deletions(-)

-- 
Jens Axboe

