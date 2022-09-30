Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCEFC433FE
	for <linux-block@archiver.kernel.org>; Fri, 30 Sep 2022 13:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiI3NnR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Sep 2022 09:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiI3NnL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2022 09:43:11 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5ED17CCE4
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 06:43:10 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b23so3287452iof.2
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 06:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=86ypbaE9HMEEUp4HcEZ8Vhii4e+cJbq4gPmtz2KSjJg=;
        b=7ZNmRuphFT+zKjsVjx44nU8k3rFtF2IN9No+4XeUMpkp40hjrgAAr3+2oOLlulm59t
         gzrldH3sKkozvi4V1j8qSYoulJ9o9tFtZH77Z2+mcdNkEznd1Xqer/GLl7PwG1WrWf+D
         BM/jSKskrgudcBUKu//cBBNI3nTfP+tRr2HJ0Favcl6VmrhV5m0hifmWbvyylehtnwNB
         Tdz07+dM3neptvhQBzpPzBBeXoJabR4X/sLrCDbm/jEz9tHqk2ykDhlW0vgLO+NwRvMU
         q5cSyl5z7ZqhCtTRavTMpW94ShQ6eOmAQF4eHPOLVb0kozgpiMfCUxhCsT2ydR0ueo+c
         /r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=86ypbaE9HMEEUp4HcEZ8Vhii4e+cJbq4gPmtz2KSjJg=;
        b=cM9WNsn5Cq/RacD0zpIO5BsVEykp3f/3mCGM8HuWvBKK9bqOnMKmJHWb6tN47e8e6y
         t4E3GSxALdj6thmGZUadIr2H9W5O5OQ4xvsNaXkgJEVXQNJ9S9DDXhCUdScnaic4FWD4
         4TtPOpzT0i+7jyNHvZDtN4Yrq4ai63F/SptxzzZd6HT3bXvVyfW6gHtOe6pKib4nDJ7H
         jZz5CM0c2JlMiPm/mo6J6L++6/mQIBGFz6X9LvEgd6/xZOiN0UbcUXzFe0dLWMJ3ksuP
         QnWbYA1zUxoC/RBD3ykaeuDEABuVnULFaPyNecKyW4LzlMw1OJSDyjGOvwTlrqpAXunS
         CRGA==
X-Gm-Message-State: ACrzQf0KevE6IMQ7XvUILyGk9uMnlJYoFgVieOr0ifHnralb6DR0MQ7P
        CPq464uQIvcWG6ENE0Bis08SKqsunXuF6w==
X-Google-Smtp-Source: AMsMyM635u+tRpJpoEIFcYjFpyjTiA6iEWYct/b1Mgurh1pEOi2zHoDXH31z+HJpVfcJyQAQjJx8ug==
X-Received: by 2002:a05:6638:d54:b0:35a:995f:502b with SMTP id d20-20020a0566380d5400b0035a995f502bmr4859772jak.278.1664545389601;
        Fri, 30 Sep 2022 06:43:09 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p185-20020a0229c2000000b003572ae30370sm941438jap.145.2022.09.30.06.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 06:43:09 -0700 (PDT)
Message-ID: <e5c2a0e5-1a04-50b1-78f0-08d998a8d4e7@kernel.dk>
Date:   Fri, 30 Sep 2022 07:43:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.0-final
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Single NVMe pull request via Christoph with a few fixes that should go
into the 6.0 release:

- Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for nvme devices
  (Michael Kelley)
- Disable Write Zeroes on Phison E3C/E4C (Tina Hsu)

Please pull!


The following changes since commit 4c66a326b5ab784cddd72de07ac5b6210e9e1b06:

  Revert "block: freeze the queue earlier in del_gendisk" (2022-09-20 08:15:44 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.0-2022-09-29

for you to fetch changes up to 6c84501a3c38adaf1c3486fb80b972f728ad8fd1:

  Merge tag 'nvme-6.0-2022-09-29' of git://git.infradead.org/nvme into block-6.0 (2022-09-29 09:04:02 -0600)

----------------------------------------------------------------
block-6.0-2022-09-29

----------------------------------------------------------------
Jens Axboe (1):
      Merge tag 'nvme-6.0-2022-09-29' of git://git.infradead.org/nvme into block-6.0

Michael Kelley (1):
      nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for nvme devices

Tina Hsu (1):
      nvme-pci: disable Write Zeroes on Phison E3C/E4C

 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/pci.c  | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
Jens Axboe
