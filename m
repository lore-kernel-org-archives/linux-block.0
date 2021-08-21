Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4041C4338F
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 02:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85F1610A3
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 02:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhHUC6e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 22:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUC6e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 22:58:34 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E59BC061575
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 19:57:55 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h29so11428460ila.2
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 19:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bnK6Durr7GpI1fh8t3az4Lpynl38WpxrWNykOMtfCOk=;
        b=W2B0xR3tvuH28/mIALbALab8JTjcoNAsBaCJCNPYoeLvGffVQqPXIE+8zq1afpy/fg
         qAQWFtLjM3ltu4VN2HHhK1pjpQJXX2ewDBHz14tniAE1vFIsMqIioqn4RJHq1IzrIM0n
         uAm/EeNz0sbnqwqbAhbXqvpIPJPAqPoBwbpq0ZNAJ/UYK5p0Gru5WVDaoW+XX0KMZsCS
         DVEkX+YlybzLhQGiQqArksJJGBs2Ocr5VFr/PDhD/xzBefWl45rgIgxBoL+yWpKf5VuU
         OJ51MfNK2iIG1nS9enlLD9V4IaeVIiDMexl3H6sNuIvBFs+EI3Ae5Qq0vZtLLhqYe7f7
         06CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bnK6Durr7GpI1fh8t3az4Lpynl38WpxrWNykOMtfCOk=;
        b=MNP6ORmM45NC39C6JUxjONC9ukQ9476kIdJLQtt80Ygpx+Ndj5W0R25nEpOVCUq66r
         0ayOqJfHd3OuLwfzkyWE8NadUW8e6TAzSHb0zkVRkhBO30sSK4/N9l9tMnVVoZFis3j1
         TtukuNvph9p/pw7TT9o5EWNNVO1tYY91d1eJbOqqdTsxbS0U+5jLBKXY3dTsWcvGp6G/
         9ZABe/4yFeRJ4XJ535Re/FGg7EEdTCB1aXLDI8sfzdmoAftLYZqPXFXrAxnQ2yjoy9gC
         GoP2hT0VUXe882Tnz2x50QYNCrA5rAl/pyfUEQ793QHgplkjCI5E4lMvZ6spOmeNR6wF
         ODgA==
X-Gm-Message-State: AOAM530MsRUowjnsPppieeihMIxQDMmp4fm7blbAuY+U25pNaOM08szK
        CS0To0SPR6fgqnxswPxTHOYg5oyYuhauvI41
X-Google-Smtp-Source: ABdhPJxMFIo1Gk9pr6kxdDRH0VQbWUE0L0u802wYzBIgJBHbmj8oL8BShKNAApLvxUdktacJptksiQ==
X-Received: by 2002:a92:d20d:: with SMTP id y13mr12835729ily.294.1629514674483;
        Fri, 20 Aug 2021 19:57:54 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id m1sm4363346ilf.24.2021.08.20.19.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 19:57:54 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.14-rc7
Message-ID: <d8ec384e-9c35-7a79-5bc3-14c8c0739e43@kernel.dk>
Date:   Fri, 20 Aug 2021 20:57:52 -0600
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

Three fixes from Ming Lei that should go into 5.14:

- Fix for a kernel panic when iterating over tags for some cases where a
  flush request is present, a regression in this cycle.

- Request timeout fix

- Fix flush request checking

Please pull!


The following changes since commit cddce01160582a5f52ada3da9626c052d852ec42:

  nbd: Aovid double completion of a request (2021-08-13 09:46:48 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.14-2021-08-20

for you to fetch changes up to a9ed27a764156929efe714033edb3e9023c5f321:

  blk-mq: fix is_flush_rq (2021-08-17 20:17:34 -0600)

----------------------------------------------------------------
block-5.14-2021-08-20

----------------------------------------------------------------
Ming Lei (3):
      blk-mq: don't grab rq's refcount in blk_mq_check_expired()
      blk-mq: fix kernel panic during iterating over flush request
      blk-mq: fix is_flush_rq

 block/blk-core.c  |  1 -
 block/blk-flush.c | 13 +++++++++++++
 block/blk-mq.c    | 32 ++++++--------------------------
 block/blk.h       |  6 +-----
 4 files changed, 20 insertions(+), 32 deletions(-)

-- 
Jens Axboe

