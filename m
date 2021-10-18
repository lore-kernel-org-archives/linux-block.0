Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39725C43217
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 06:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2127A60FDA
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 06:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhJRGEi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 02:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhJRGEi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 02:04:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9DC2760FDA;
        Mon, 18 Oct 2021 06:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634536947;
        bh=XMg/iU/y1h7gtmg96oB1s0djfXpxXNsSGYqpKJi4k38=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZD8SBanCvdIjzJhwmo84fzsFcS4dTMi6x43p2ux1qOjRZUPaPejjgPamz3s/+SeLX
         5bW9N0qAuVbbA1mJXF8EnZ0p61zg/CqKmkc3LRuLlSaZwyEo35yNM4a+Qbk4+wtROR
         fYjpzTYndtsh8DZn0p6fiT57P12gKMSYl2ErTE0KhOpDnKUKo8jMAfkRrIudMr4nPN
         DnjviQ/BREMiDySXaCEjog1KG0LvxURyKlU/JJty67zkvxC/v/AltInL6CzuTozrBt
         2Er8c9LrdMwAvNRXn+W/pE528s7SpznXydji9XOFlZipGfz8B9gcPbcTa20rykFT1z
         xZ6XGGKsoxyVg==
Subject: Re: [GIT PULL] Block fixes for 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <17c55a10-ef17-7503-2a83-664de7255582@kernel.dk>
References: <17c55a10-ef17-7503-2a83-664de7255582@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <17c55a10-ef17-7503-2a83-664de7255582@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-17
X-PR-Tracked-Commit-Id: d29bd41428cfff9b582c248db14a47e2be8457a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2b3420b921d142b4c55f7445385bdab4060d754
Message-Id: <163453694762.9773.10981497458041760581.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Oct 2021 06:02:27 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 17 Oct 2021 07:43:37 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2b3420b921d142b4c55f7445385bdab4060d754

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
