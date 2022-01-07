Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64135C433F5
	for <linux-block@archiver.kernel.org>; Fri,  7 Jan 2022 20:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiAGU2R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jan 2022 15:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiAGU2R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jan 2022 15:28:17 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4429FC061574
        for <linux-block@vger.kernel.org>; Fri,  7 Jan 2022 12:28:17 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id c3so5710676pls.5
        for <linux-block@vger.kernel.org>; Fri, 07 Jan 2022 12:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=C4+kQNPQTrEKF2CM79Q1krqdZKNzSjkYu2X3Qu21itY=;
        b=6NOonsjioK9j5CfirQzSBPZKisxO3ClPOXoTS5+FRlduRS/qNiua9LtX4O8XDpyrr6
         WABTONklWNY4gQSHyBlHqeK4wH9f8llDEZzX2BUumAn9Kr/M7RBpOd3AwLFNKCmYIfEQ
         4BJNQ4o3QwpBkVGMobpFAwtMgnyjH3ha+S/qvWVGHIC+D0Qn5r06Ov6X7upzO78cMwN+
         vXvlrxqDa3w9LR0yBImbQMzoUKatHpvSegQNIe9c7LoX53XfEdghESuKHzpyiswT1R5R
         Mvke7uOjD+0RMYg1RECq0FQfG1g7cTN3USc2b4jYQ23kdz699GmR6J44rszCLTVA6PnY
         fSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=C4+kQNPQTrEKF2CM79Q1krqdZKNzSjkYu2X3Qu21itY=;
        b=DM7NDfn8UFOmaxkPWLuQyofFp7LPTkMJZNQHiNq1t4/ykt0ojBWIJS/V/SX9tFDvX+
         qF8VTk8qQbOvCPA7zmKjI61BsgpcmUolphVGQLz9aJDyFl67XvdxBommBW80o97gdfRT
         sVStFxMghjrP1GdXnwdBj1XfHzEDyT8ma9E1VB/3HwDOw2+ZY1V9gmUksLUjIyoTYLL3
         MP+DZE+nANzYQb2Gq5QCnusSsd3ohYhoQGwCtTDJ6hRcDytvz0g9ABz9rP3cE6bk1618
         Mp2Gva2Ev3Qs3f4OoB6grvGWYYp1OD7f0E9JPefQp/z7P3kvQY28dNKQfx/11i6OgB1k
         X5WQ==
X-Gm-Message-State: AOAM533hCYv5jD3jkmd2PzM34yfVhNNF6tdPO5vU8UyHKFhpt6C5r13F
        +x1Z6kK3yG33W5NAMFuuUIobxiPJ1yU8UFZJ
X-Google-Smtp-Source: ABdhPJxCbn4/PEdCGNGcUkgDCc50bMUshVpgeR22eF7aUaQ0RPwzz9WsGQLzXm+65skehjXAUHKK0g==
X-Received: by 2002:a17:903:2486:b0:149:1ce1:d45d with SMTP id p6-20020a170903248600b001491ce1d45dmr64421540plw.57.1641587296350;
        Fri, 07 Jan 2022 12:28:16 -0800 (PST)
Received: from ?IPv6:2600:380:7632:8b8b:20ee:424e:7905:9963? ([2600:380:7632:8b8b:20ee:424e:7905:9963])
        by smtp.gmail.com with ESMTPSA id l6sm6810204pfu.63.2022.01.07.12.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 12:28:15 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 5.16-final
Message-ID: <f7317ed1-9481-43c7-2004-de59ab66b2b7@kernel.dk>
Date:   Fri, 7 Jan 2022 13:28:14 -0700
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

Just the md bitmap regression this time. Please pull!

The following changes since commit 87959fa16cfbcf76245c11559db1940069621274:


  Revert "block: reduce kblockd_mod_delayed_work_on() CPU consumption" (2021-12-19 07:58:44 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.16-2022-01-07

for you to fetch changes up to 26bc4f019c105234639068703186c01efcabe91e:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.16 (2022-01-03 21:21:11 -0700)

----------------------------------------------------------------
block-5.16-2022-01-07

----------------------------------------------------------------
Jens Axboe (1):
      Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.16

Song Liu (1):
      md/raid1: fix missing bitmap update w/o WriteMostly devices

 drivers/md/raid1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
Jens Axboe

