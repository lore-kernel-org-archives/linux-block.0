Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03355C433B4
	for <linux-block@archiver.kernel.org>; Sat, 15 May 2021 16:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3746143C
	for <linux-block@archiver.kernel.org>; Sat, 15 May 2021 16:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhEOQaW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 May 2021 12:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233441AbhEOQaO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 May 2021 12:30:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 97122613C5;
        Sat, 15 May 2021 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621096140;
        bh=NrnOBVVfgSJFz/PXufx7OglURM0DP7l0gHuRWauD03U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E/LADsIQLzbMC9zkCThZnoBJ0tZo8rjBq+5ZuL5++2Pn8eSG0pmWadAw38h1JHOe7
         H+AxedHZucO2kIR3AQIu4eaJXK0KYsa+dFvW+JcwXVmG6AnjqtnIeDQRWXys51aMAQ
         BwZuwpShHtUbCeE8r9S8TdxAvD328qyMV/jFeyc6aBe034EcfYBvUMk2ML2HVFBikG
         24/MZZ/uerLqPzygTVyi5jRs2yVYNq6qbWwoX1kfV7mNyuMPiO8jCcPpmpbt0sgHBt
         SJ8u8LMGJdUZA5p3Z7l8ugcn0utXNQ7NY7nhUG6ogQNc0JwZxrcdAyeoAQDuhtCBEa
         6I1HJ451/x0OQ==
Subject: Re: [GIT PULL] Block fixes for 5.13-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e1e84296-62d5-ba60-82f7-f33ff9988ca7@kernel.dk>
References: <e1e84296-62d5-ba60-82f7-f33ff9988ca7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e1e84296-62d5-ba60-82f7-f33ff9988ca7@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-14
X-PR-Tracked-Commit-Id: 4bc2082311311892742deb2ce04bc335f85ee27a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f4ae0f68c5cb796cda02b7d68b5b5c1ff6365b8
Message-Id: <162109614059.13678.3580327215405286598.pr-tracker-bot@kernel.org>
Date:   Sat, 15 May 2021 16:29:00 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 14 May 2021 21:06:01 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f4ae0f68c5cb796cda02b7d68b5b5c1ff6365b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
