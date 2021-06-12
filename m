Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4271C48BE5
	for <linux-block@archiver.kernel.org>; Sat, 12 Jun 2021 19:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C26ED61186
	for <linux-block@archiver.kernel.org>; Sat, 12 Jun 2021 19:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhFLTLq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jun 2021 15:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230492AbhFLTLq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jun 2021 15:11:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 690FC61186;
        Sat, 12 Jun 2021 19:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623524986;
        bh=OGOHYP6LSk5T9eTkx2e6kHu6FpJ7CPnNjLFdwa5CJ3s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SV9ttTKiDaYSujRLDi7FjV1mI34yCqHeDsGTkbUYky/WuLGXG3IWpbF3pqqTykShP
         5+ASFxNUU4sDdjhXy01J5Re4ns+hpU4gehYFEx3V+fWZJ8XGQJbn4RK7YxdmVpiojB
         Rxx7HHJ4p1G0kFgL93n+mEjwABQyyFVHpVcto1ijyvz5NBX8i5d7+6aOtGXdskEev6
         XlNb+aoUiprhLXSFAvbXHdq1JN6ijbLT2ahBij32DvaIcwMrE2iRR/o8XPHXFUeR7E
         VI8/G2IzZYXLn95QgdZPwfXqHZ66G4xCNlzHp9kBEDLJG+6o2Lw1KOx5Hp2fEWVouO
         HeWuLaDIq6YuA==
Subject: Re: [GIT PULL] Block fixes for 5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <502db269-c291-5675-779b-fccae75b86d5@kernel.dk>
References: <502db269-c291-5675-779b-fccae75b86d5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <502db269-c291-5675-779b-fccae75b86d5@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.13-2021-06-12
X-PR-Tracked-Commit-Id: 85f3f17b5db2dd9f8a094a0ddc665555135afd22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efc1fd601a751d39a189c3ebe14008aea69a5e37
Message-Id: <162352498529.5734.949378882447667148.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jun 2021 19:09:45 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 12 Jun 2021 09:13:33 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.13-2021-06-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efc1fd601a751d39a189c3ebe14008aea69a5e37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
