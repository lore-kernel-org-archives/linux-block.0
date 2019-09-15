Return-Path: <SRS0=U2g7=XK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5F1C4CEC7
	for <linux-block@archiver.kernel.org>; Sun, 15 Sep 2019 23:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C18B20665
	for <linux-block@archiver.kernel.org>; Sun, 15 Sep 2019 23:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FpQZ5/J1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfIOXxS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Sep 2019 19:53:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38151 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfIOXxS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Sep 2019 19:53:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id x10so722577pgi.5
        for <linux-block@vger.kernel.org>; Sun, 15 Sep 2019 16:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Fr5FpNgfBQJRNcMaaSjZIOUavnmfgYSh137RAE5VCE8=;
        b=FpQZ5/J1GUyIDwCBUSR2HwCSpyvtDwtpTtPi6Ce61dbzdN8lTzjI3gBMWBtL88L1uq
         PVoC4YlIEnmTFB8c+wfWdpX8w1Kwy6YvzvrwwjsteEFxtZOR5HzP+wT92ES49S3rTUH1
         Wp/pFrYu/wWnaCMyjj3iCBn9a1bhk0hKp+E273OQ4ax8eo1imFqjC/YjLJ8cZ0xvQvV5
         MAgVPh30sUdaJt62x4Lj3FBOkituzDTLNvuOJUdWiyeXphuyxgQZECwnC4VkN4fI5cjA
         cf1N5mn7FAWeHUv7TV97Fs0IRByNseLKvFhDIKfTBrs5/gsV8xtU0RSf5QnD6Jc3mwMl
         QCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Fr5FpNgfBQJRNcMaaSjZIOUavnmfgYSh137RAE5VCE8=;
        b=QtBX6sWYhCpt1bGfdrxriwQ9lYcQa2of+6osUMZT6cl1JykT3QYveTbpHNb61L1cZc
         RFjixykn0ClbNEz4nJH6EJHAnFZrtPvDCS5/V2ifbnKixcLIPe3snJxuKxbC7B3li7bR
         EHnn0dWTJdvdfhB3eh0YQKoseO93rZQ6iVXebFcw32CGtSq6As3u9jPRH20HRJPhItwt
         ZvL9LLYGxt1zgDkdfEadPBe7N0Paj31+h9rFjdGGM1/dArjBcvzwCoXIaDsr4Fu1/uDX
         7aX4iEI4V7ZINReUPjUetNfJ2NBmO2iRa7eameW8QocTDjLaGvf20rGrvpnX0hIptFu7
         AtGg==
X-Gm-Message-State: APjAAAVZoZlZ5F8nY8bE76oeegfQIWgxb/yraiRbq2GXCQGQL2je3uxp
        VurA1c4ZynMO09XLC5Hts26xyfXdj40GYQ==
X-Google-Smtp-Source: APXvYqzThcjKuOVfsvaZmDOIbR868YLLmNgmLCXenecdyOrYmWC88ssO+XKr1rvvprzaXtdPAEWr5g==
X-Received: by 2002:a62:3585:: with SMTP id c127mr65839275pfa.18.1568591596723;
        Sun, 15 Sep 2019 16:53:16 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:edde:3241:ce2f:af1c? ([2605:e000:100e:83a1:edde:3241:ce2f:af1c])
        by smtp.gmail.com with ESMTPSA id d1sm8101658pfc.98.2019.09.15.16.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2019 16:53:15 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring changes for 5.4
Message-ID: <1559f166-52c3-532d-3523-d9b3e34a04b6@kernel.dk>
Date:   Sun, 15 Sep 2019 17:53:13 -0600
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

Here are the changes for io_uring for 5.4. This pull request contains:

- Allocate SQ/CQ ring together, more efficient. Expose this through a
  feature flag as well, so we can reduce the number of mmaps by 1.
  (Hristo and me.

- Fix for sequence logic with SQ thread (Jackie).

- Add support for links with drain commands (Jackie).

- Improved async merging (me)

- Improved buffered async write performance (me)

- Support SQ poll wakeup + event get in single io_uring_enter() (me)

- Support larger SQ ring size. For epoll conversions, the 4k limit was
  too small for some prod workloads (Daniel).

- put_user_page() usage (John)

Please pull!


  git://git.kernel.dk/linux-block.git for-5.4/io_uring-2019-09-15


----------------------------------------------------------------
Daniel Xu (1):
      io_uring: increase IORING_MAX_ENTRIES to 32K

Hristo Venev (1):
      io_uring: allocate the two rings together

Jackie Liu (2):
      io_uring: fix wrong sequence setting logic
      io_uring: add support for link with drain

Jens Axboe (6):
      io_uring: expose single mmap capability
      io_uring: optimize submit_and_wait API
      io_uring: add io_queue_async_work() helper
      io_uring: limit parallelism of buffered writes
      io_uring: extend async work merging
      io_uring: make sqpoll wakeup possible with getevents

John Hubbard (1):
      fs/io_uring.c: convert put_page() to put_user_page*()

 fs/io_uring.c                 | 531 +++++++++++++++++++++++++++---------------
 include/uapi/linux/io_uring.h |   8 +-
 2 files changed, 355 insertions(+), 184 deletions(-)

-- 
Jens Axboe

