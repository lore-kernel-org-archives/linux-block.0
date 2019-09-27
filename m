Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76193C4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 14:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C2521841
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 14:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="H5f6ZAZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfI0O65 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:58:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40573 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfI0O65 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 10:58:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id l3so3236738wru.7
        for <linux-block@vger.kernel.org>; Fri, 27 Sep 2019 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ewYDN1PlLV89dmxzX/B1gBoOpNgLpWGO6HKqKHnjQKw=;
        b=H5f6ZAZtyzYdtFvgaqC4otL5rT78JAjWW5wjHSc4WerhThILG5PbLiDAoU7RVB7O/G
         5E4YSoL7RhJcVYKUB/mOChA43C9OQ3X0l18Ah643pGc5aN7P10XVipl7FyGSrtpRSP2f
         Cdi1kQF8ETtc88Rie1thAk9GB5LyHZpAl4cm8nxrLaDNM4AbxCKby7NVEqrc4erBLkvC
         qJkbkG4b7qEfi/hI3PG6rJy4qVvM/N6I+hJZUqgqbW9gpax2aKvm5oDpTinBcho4IcOF
         kxRfUud3CefR9ZjgOjtOewK9F0jpVE0mWwnCcaMKf+nIJzcc1S7wSkq2lvC7FEIrwODm
         C4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ewYDN1PlLV89dmxzX/B1gBoOpNgLpWGO6HKqKHnjQKw=;
        b=QV84D2IMetCVfVMXRi9nVXq7qn6LTqIbtBgxBmTPmdHhGKaUYMwR1eWAKBOexnxNEJ
         yIdeD+j8PxhveH0R7ioIcq51AyuhSYQvhjQoSzLR2PLcZVKW8pkB71lKu3zs7sE7Ni95
         V1rDOwfNM6cOPnroOwyhuTTuFIF0TGuCJD3X5Vh/Gp6Z13VLVONsEP647ahoKzWHajgb
         wexaroHcB2yUFLb2FaULps2WRmJiojX6J7qI3JXKqoxp6rcde+R0qqoctdDk/9smOu+n
         +y8RygWIlUtHESSHBKt0yv9mu7oxtQbv+NLBlOEFlz3lgf6K2LshkH0ndD19YEI+j81k
         qFQA==
X-Gm-Message-State: APjAAAXouj7hCfvQU78pWk9VK0mvFHZfrQE/7yxtRMsrdeqlH3qvJzhG
        WO/o7nUHgDR4gj4sIcFM4fsj9SiaZnbJSWEc
X-Google-Smtp-Source: APXvYqz7jzineHoMJctrRHChCZoSXlCZOfQ6tJhvKlBD8MU7CwoQGUs87w9ejOuuj2vcSSkpGXl7lg==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr3256679wrq.165.1569596334001;
        Fri, 27 Sep 2019 07:58:54 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id f20sm4115005wmb.6.2019.09.27.07.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 07:58:52 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring changes for 5.4-rc1
Message-ID: <c4e59df0-3fbd-44c8-f696-8eb424028b7c@kernel.dk>
Date:   Fri, 27 Sep 2019 16:58:52 +0200
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

Just two things in this pull request:

- Improvement to the io_uring CQ ring wakeup for batched IO (me)

- Fix wrong comparison in poll handling (yangerkun)

I realize the first one is a little late in the game, but it felt
pointless to hold it off until the next release. Went through various
testing and reviews with Pavel and peterz.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.4/io_uring-2019-09-27


----------------------------------------------------------------
Jens Axboe (1):
      io_uring: make CQ ring wakeups be more efficient

yangerkun (1):
      io_uring: compare cached_cq_tail with cq.head in_io_uring_poll

 fs/io_uring.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 11 deletions(-)

-- 
Jens Axboe

