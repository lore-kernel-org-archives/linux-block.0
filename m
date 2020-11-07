Return-Path: <SRS0=Y6k2=EN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE90C388F7
	for <linux-block@archiver.kernel.org>; Sat,  7 Nov 2020 22:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF3920874
	for <linux-block@archiver.kernel.org>; Sat,  7 Nov 2020 22:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604786909;
	bh=6Sd4LlhldpP03v6mDeNGZGPORSjZT3yNxlqALYWQwUc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=N0Q0w4M8dCr7umaG+6FeNq4ofYbJSrpYBotO0cItYAxk8mZrwG/9+og5PlarjW3cN
	 t1dJXJTPTkbyLT5ccDugloRq0uWB3YBEmHFzNca+KgFhoghm2PseG56Cf5B5I9YyZz
	 RwGHwO0o7eTsKY1P3ErXhzTxZFkGOlBZ8Q+kRcO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgKGWI2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Nov 2020 17:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgKGWI2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 7 Nov 2020 17:08:28 -0500
Subject: Re: [GIT PULL] Block fixes for 5.10-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604786907;
        bh=6Sd4LlhldpP03v6mDeNGZGPORSjZT3yNxlqALYWQwUc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o1vr8BrHyoy4vaLyccs8361OwHXvdfHGrDbUQG90G92okj2gQaQY4g7jxT6Ajmjzc
         5NT9IKPHx0HmBjUITi139dYKu5TNQ05KOZUzP4SNDP+kNxJ3987a4QQoVJ1dO3K6Ks
         Ka6GpKr3Zdi4I9KjkUvVfYIzHTsvYsiuvEveTZLI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bdeefa97-9ec3-cac8-3e6b-dd912d0c0c33@kernel.dk>
References: <bdeefa97-9ec3-cac8-3e6b-dd912d0c0c33@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <bdeefa97-9ec3-cac8-3e6b-dd912d0c0c33@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.10-2020-11-07
X-PR-Tracked-Commit-Id: e1777d099728a76a8f8090f89649aac961e7e530
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4429f14aeea979b63bcafdcf9f09677fcf8fd475
Message-Id: <160478690793.18289.14124482235571299779.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Nov 2020 22:08:27 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 7 Nov 2020 13:14:02 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.10-2020-11-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4429f14aeea979b63bcafdcf9f09677fcf8fd475

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
