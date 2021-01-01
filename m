Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FB3C433E0
	for <linux-block@archiver.kernel.org>; Fri,  1 Jan 2021 15:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C70BA2158C
	for <linux-block@archiver.kernel.org>; Fri,  1 Jan 2021 15:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbhAAPB2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Jan 2021 10:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbhAAPB2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jan 2021 10:01:28 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BFDC061573
        for <linux-block@vger.kernel.org>; Fri,  1 Jan 2021 07:00:47 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id i5so14635994pgo.1
        for <linux-block@vger.kernel.org>; Fri, 01 Jan 2021 07:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=nBebF0fJSadWmNQkAi2CBTvPeZLz5elQoxMfv5HpWPw=;
        b=Nw6uWv0hJR1Mu7zoNJ9pwidbEz83a+6XPquIQzxFTxmCgAsR0+y+iUvaPL3FCodmcS
         pbvyeugaKostw8MyY1v9BwoMJ+/wHUO8qPy3SFc9MoGrxPjgovUKQCb53ef8OlY18DYk
         XpwtdVG/EosCL+T6xbf/zxi6lkih+SWNIjNypmWXPEAVFL6DBomiw1yGcvzpnsZ94jgm
         6Uvo9uY2uReYSQ3+VjDNolcxxoZjn1NIkSD9c8sNMhRv5w/Cf35m/4M9W9XLvWiQxtCR
         0SOJMx3JDhl1v+V/LpiBYO/tluwTlXMxKzqY1u25ZImlwkoWu1xGDk76tnLZx3VwT9WQ
         6Brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nBebF0fJSadWmNQkAi2CBTvPeZLz5elQoxMfv5HpWPw=;
        b=NrRQ5bEqxCP4goqlfCudqGVTBjWcJdVhznGPHT+yZhTkLkrjtzm7csw2JVqtUY/NMG
         OYIixNj2y/pn1F0c8IONAh1oVauTVji0zg7XB7+LjIG8m8vu60ZJYrKEYAW6nSXf3OqX
         GElTF3mI6kem84HYjB0RssjT1sa9T/aRrnun1rqZSyiM6LgaUhFtNCBxjVfZZlntFuZ/
         ye2lDZTkVk2+LXtpmJw4LwZVTadxlRyM+pBmt1aBogPPwjdrczcJXcwlkuoEmHgvzQh7
         m549QyApi40AtlUNwV3Q8fOEFEsxKiW2LSymmwpg8NhXLpgZvP2WFht09doGyEHKHC5w
         q5Vw==
X-Gm-Message-State: AOAM530tgueihj9NIupzyrn6L33a892bCloU25bm3r8QrWKE/+V554VN
        yMVWkCjO2WGv1/3VvFypPVm0+QWgIujIPA==
X-Google-Smtp-Source: ABdhPJyWza1mtk4sKJ6zSt7PMFyJLePDo412mnMlSo0N+duei4WTLjnGotfF3+i+Jw6zxLmNgaHCjA==
X-Received: by 2002:a63:1f47:: with SMTP id q7mr229016pgm.10.1609513247157;
        Fri, 01 Jan 2021 07:00:47 -0800 (PST)
Received: from ?IPv6:2603:8001:2900:d1ce:7a2f:4758:8d40:5fe5? (2603-8001-2900-d1ce-7a2f-4758-8d40-5fe5.res6.spectrum.com. [2603:8001:2900:d1ce:7a2f:4758:8d40:5fe5])
        by smtp.gmail.com with ESMTPSA id bg20sm13359788pjb.6.2021.01.01.07.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jan 2021 07:00:46 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.11-rc
Message-ID: <a063a4f6-47d8-8058-cbd3-daad2fab75d8@kernel.dk>
Date:   Fri, 1 Jan 2021 08:00:46 -0700
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

Two minor block fixes from this last week that should go into 5.11:

- Add missing NOWAIT debugfs definition (Andres)

- Fix kerneldoc warning introduced this merge window (Randy)

Please pull!


The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-01

for you to fetch changes up to dc30432605bbbd486dfede3852ea4d42c40a84b4:

  block: add debugfs stanza for QUEUE_FLAG_NOWAIT (2020-12-29 16:47:46 -0700)

----------------------------------------------------------------
block-5.11-2021-01-01

----------------------------------------------------------------
Andres Freund (1):
      block: add debugfs stanza for QUEUE_FLAG_NOWAIT

Randy Dunlap (1):
      fs: block_dev.c: fix kernel-doc warnings from struct block_device changes

 block/blk-mq-debugfs.c | 1 +
 fs/block_dev.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
Jens Axboe

