Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560DBC11F68
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 20:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4172861457
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 20:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhF3UXd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 16:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234089AbhF3UXc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 16:23:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 987D061454;
        Wed, 30 Jun 2021 20:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625084463;
        bh=xbmq+X59vilKiPRh1B5Q1h0BtmF59vYjrxy8rtJ7ZSY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f2qwnT5rReNqv5ke+p4gEQJOdc/UIQms6FjW6uc74iEX0hLw/jFkb2Cu0I/wpadZL
         6BYz4d+e9G1haGUzeunptq86gj9wKeg7ZysOH9fgZBZxxOyaIcvoKanufuU2rOg6gO
         3nIupexeFtO3f/FLzdwJPmx2AKQtNvX4M7gprduKZt1wsJH6KdQXdQEmP8UDiqKc6W
         dG8r6YdCAnrssqovl7+1E+t/iz7wBy3R8QkL3oJPNKXN20xmxJ4ah9CkFajEcQiaOH
         tpvAY4+zPLS/Gipmvk6GMYuf6+8ITa2N+itAW9UtlPk2et/mFj94UN+KRW/lGBM48Z
         N8+kuzo9r3Sug==
Subject: Re: [GIT PULL] Block driver updates for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ee6c32c8-e643-f817-bf45-1280e7f254ea@kernel.dk>
References: <ee6c32c8-e643-f817-bf45-1280e7f254ea@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ee6c32c8-e643-f817-bf45-1280e7f254ea@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.14/drivers-2021-06-29
X-PR-Tracked-Commit-Id: 5ed9b357024dc43f75099f597187df05bcd5173c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 440462198d9c45e48f2d8d9b18c5702d92282f46
Message-Id: <162508446359.1549.5537849551381022615.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 20:21:03 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 13:55:41 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.14/drivers-2021-06-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/440462198d9c45e48f2d8d9b18c5702d92282f46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
