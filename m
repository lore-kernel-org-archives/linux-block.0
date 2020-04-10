Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128F7C2D0EC
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 17:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03652082D
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586539836;
	bh=GY5UOTZhD4FLcLppQy9CMiVYM9UHn3uCnMAMcIeOIPU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KRrRxExUE1O+qDH2cgwNUYgmIiBbvk+5HaRyIbkAmkrhP/paS1DNssmYoZLfk+S9r
	 r11ZN0eMCEcR7NpRep5Sy27k0J8b9E+Dp7qckc0rX/lqlT3Zwii8M5JeOyNiM0mtZx
	 cUwbh7rYfq8OXDADDx5WrnMvCrfOrM+jy6/5GnKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDJRaf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgDJRaf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Apr 2020 13:30:35 -0400
Subject: Re: Re: [GIT PULL] Block fixes for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586539835;
        bh=GY5UOTZhD4FLcLppQy9CMiVYM9UHn3uCnMAMcIeOIPU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K1yASxc7bROZNFmzEVmlWtasSdnTd0EeKw0nyqyXf0HYWyvZmU1qZbwgFYhbY+vzo
         Wj248+s2q4xwJvxgFos0XCl4D93OvnV/0aNeodycrPcjy6ydvcytModkf1qtd7XsqX
         mBchkzFOBKXUceb3YTFH+h64UZcYWOnRmtCJtkVI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5b4a4f64-3a39-e1a6-6141-60436bb9249b@kernel.dk>
References: <0d580c9a-be04-0b48-0594-17a0339df1b5@kernel.dk>
 <5b4a4f64-3a39-e1a6-6141-60436bb9249b@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5b4a4f64-3a39-e1a6-6141-60436bb9249b@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.7-2020-04-10
X-PR-Tracked-Commit-Id: cb6b771b05c3026a85ed4817c1b87c5e6f41d136
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8df2a0a6da450b0fc28f1fed110817c1d98b84c2
Message-Id: <158653983521.6431.9992574551831042002.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Apr 2020 17:30:35 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 10 Apr 2020 07:37:47 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.7-2020-04-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8df2a0a6da450b0fc28f1fed110817c1d98b84c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
