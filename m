Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B4BC432BE
	for <linux-block@archiver.kernel.org>; Sat,  7 Aug 2021 18:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6629E60E9B
	for <linux-block@archiver.kernel.org>; Sat,  7 Aug 2021 18:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhHGSWK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Aug 2021 14:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhHGSWK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 7 Aug 2021 14:22:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D799860F25;
        Sat,  7 Aug 2021 18:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628360512;
        bh=lEQhVU3HFTPSqnKq/Btb4+ZuDVe0zAxWRUBa59RSIuU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XATJixgLnM9STSpjNLrrEJxJsm2XiZnn9aW6wXceq+H0zV+fum2kSeFAk2+DbwsWt
         HW7zAu8Acp2JlDgJ5Kz0pcphBPsBs8qgwUb2kCAF/G1yGT7EDe1xVf2jwwFYCqJpMG
         SzgYeHccGUfrCLbIczSVPwOKXpKv0XG6hUonUK/EObDRl6BeARWyuvqNgjLeDghQ2+
         80JIAqyZk0gmnrMbl8B/AwsQZGHeUu5GtulTUBpfDEzdM9IWbnkBshThkW+d8Yh4Kj
         9r0rVjB9th6ILv1OO7+KoeDQ6Yw+qkYqYiE2Pepu7nMwh+GKVrn1LH6RO6goMwmZR0
         51SJoGueWsOCg==
Subject: Re: [GIT PULL] Block fixes for 5.14-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9c6e6b8b-ef8e-6c14-1afd-e18569c3df45@kernel.dk>
References: <9c6e6b8b-ef8e-6c14-1afd-e18569c3df45@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <9c6e6b8b-ef8e-6c14-1afd-e18569c3df45@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.14-2021-08-07
X-PR-Tracked-Commit-Id: fb7b9b0231ba8f77587c23f5257a4fdb6df1219e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bbf59145c4b29a384b0a66d63ddfbf55eeb91c4
Message-Id: <162836051285.5679.18344575237651203873.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Aug 2021 18:21:52 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 7 Aug 2021 10:50:26 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.14-2021-08-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bbf59145c4b29a384b0a66d63ddfbf55eeb91c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
