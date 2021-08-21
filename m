Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774DAC432BE
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 15:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5681661163
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 15:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhHUPQw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Aug 2021 11:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhHUPQw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Aug 2021 11:16:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6734661042;
        Sat, 21 Aug 2021 15:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629558972;
        bh=+k6xmuVQyj3NHdODNHcqqXBfCCtfkxHeQllgUwn0tPA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uFM7oNJQ1j+VfFLWEo6wbEz+RS1NY4vuiOw4orrziz+HKp58UsV1THo6BAfvnFEgs
         jRxTPdDW0K5o8ZXTZ4FPaXEsUcEq1+v4+K5MjS5SI1Tg75sqoyEms4buMzfb3ccapC
         KZNppbuQoyYGQfooMc5VAPMN2k3NbtcuR8fTWs/IRH/NE8tFmdrPhlggSeJZfuMdHr
         y15CxLHJZ+GnJQezytHMEhUanTuudaOkk4mrwJoT32RrXb2ygR+5dG94hRRGrUztxN
         R2m2Imom//o06dMSjVjhocoxknarJz8Gcn8eNUBm8ujlW7UjJgyKqMdSZ9bQBZNYOb
         YoRnFCWhke1sQ==
Subject: Re: [GIT PULL] Block fixes for 5.14-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d8ec384e-9c35-7a79-5bc3-14c8c0739e43@kernel.dk>
References: <d8ec384e-9c35-7a79-5bc3-14c8c0739e43@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d8ec384e-9c35-7a79-5bc3-14c8c0739e43@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.14-2021-08-20
X-PR-Tracked-Commit-Id: a9ed27a764156929efe714033edb3e9023c5f321
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 002c0aef109067168ae68ee69b5ce67edc2e63c1
Message-Id: <162955897229.29440.5224935780417005985.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Aug 2021 15:16:12 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 20 Aug 2021 20:57:52 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.14-2021-08-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/002c0aef109067168ae68ee69b5ce67edc2e63c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
