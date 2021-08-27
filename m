Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A74DC432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 22:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4E460FD8
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 22:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhH0Wcd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhH0Wcd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 18:32:33 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10769C0613D9
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 15:31:44 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id f6so10724271iox.0
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 15:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=yk5Ji43ngXbbo8J/72kK78Lyb5MNvCAGNnbB0kan7nE=;
        b=Mi1g+8yo/1abXg+I5TMf1VtjbBymdZujyL82lEkaDDLDzdpHa1Vem6EzYEDnrQbgbe
         Vu6p3zmFgs+MoZ1F/Ys490R36YcqOfNKWRauXKrV8L0T794UC5iYx1iRjZgdCC+8VuQ3
         9OYiv8ADHwMYI0HdgFJpXU9OstgvdByNyVYqr5taEbju2HtoFpgaSW3D3/5kZqf4ARjy
         Hh7p5Hr0iVAgqkvg/7uorK3lcoPjcGknhXpN4hssfh+SsEiuCNyFEw25Ib3IBCw6u3vt
         bS2HUaoqneB7YfDZ9lre3PZrR8TPVKPFApBwXujx4wKZl/hi9RuMeemENqGKNBY5s26d
         eIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yk5Ji43ngXbbo8J/72kK78Lyb5MNvCAGNnbB0kan7nE=;
        b=ADKTT+poN9JegJTl7Vy6q1r5zAf0m3N+QPcOx0tmbpyttAbC0diWouaHSM0jb4sB/z
         m0ZFazQexzDco7u2ibz7PtCC6PjUxlnF83v1GGC1RZf/Z7NkUdEz9mKyt5TuLBkyZti3
         0JfZDjy6PulrfO5ifBuZwhtp2z2aGJoBmXcKQ1GdMdmv7px4xLnEStcJFbscaToxxGs6
         eue0QjdNhbHZ4g/TU14XIqqfhF/1zFudigRrHLUC9NOi8/9NpbGf1VcoRzO+bgN+/AGH
         7wTox/gZsTy2OHBjIIawe0tyJt7AtKhDS9WKvbpr4YUkqMR1aMjFNXL72pHwDrMxYP6Z
         9x7Q==
X-Gm-Message-State: AOAM530nIiW2hGEKa77oHKDVqmYLvEHJ6RhJ8zJ58mM9oTysuSWMBJ1b
        P022tMNj+ocS9NtDwBs9aggKDnotB696mA==
X-Google-Smtp-Source: ABdhPJy9UeqQIzGx4j2YnWAe+sfTMvLKgyaQhgNqBuivN+SsJaDD9zku4y565EzjsgX7llmBdqM5vg==
X-Received: by 2002:a6b:fb03:: with SMTP id h3mr9149459iog.198.1630103503268;
        Fri, 27 Aug 2021 15:31:43 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t15sm4078539ilq.88.2021.08.27.15.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 15:31:42 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.14-final
Message-ID: <2d7d0f57-b8f4-cd34-4034-25b9047652fa@kernel.dk>
Date:   Fri, 27 Aug 2021 16:31:42 -0600
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

- Revert the mq-deadline priority handling, it's causing serious
  performance regressions. While experimental patches exists to fix this
  up, it's too late to do so now. Revert it and re-do it properly for
  5.15 instead.

- Fix a NULL vs IS_ERR() regression in this release (Dan)

- Fix a mq-deadline accounting regression in this release (Bart)

- Mark cryptoloop as deprecated. It's broken and dm-crypt fully supports
  it, and it's actively intefering with loop. Plan on removal for 5.16.
  (Christoph)

Please pull!


The following changes since commit a9ed27a764156929efe714033edb3e9023c5f321:

  blk-mq: fix is_flush_rq (2021-08-17 20:17:34 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.14-2021-08-27

for you to fetch changes up to 222013f9ac30b9cec44301daa8dbd0aae38abffb:

  cryptoloop: add a deprecation warning (2021-08-27 10:44:54 -0600)

----------------------------------------------------------------
block-5.14-2021-08-27

----------------------------------------------------------------
Bart Van Assche (1):
      mq-deadline: Fix request accounting

Christoph Hellwig (1):
      cryptoloop: add a deprecation warning

Dan Carpenter (1):
      pd: fix a NULL vs IS_ERR() check

Jens Axboe (1):
      Revert "block/mq-deadline: Prioritize high-priority requests"

 block/mq-deadline.c        | 58 +++++++++++++---------------------------------
 drivers/block/Kconfig      |  4 ++--
 drivers/block/cryptoloop.c |  2 ++
 drivers/block/paride/pd.c  |  2 +-
 4 files changed, 21 insertions(+), 45 deletions(-)

-- 
Jens Axboe

