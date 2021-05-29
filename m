Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC3DC4708F
	for <linux-block@archiver.kernel.org>; Sat, 29 May 2021 00:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330BD61358
	for <linux-block@archiver.kernel.org>; Sat, 29 May 2021 00:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhE2Awg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 May 2021 20:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhE2Awg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 20:52:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0F0BC61358;
        Sat, 29 May 2021 00:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622249461;
        bh=FYkbVCkqngifjysGMYGWIyiikaouKjLeaJNXbfk75Fw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tB2i6O8cALWT5Uwfet/sYwsdwOJvCCkjsCicK9GDo3fWUEI/Yaae5P4SEtmd3nCv8
         2OhJ11dku3ncMomRLXcJZJ0MJUIzs4MGI/23fRiomRzj9G9m1ZYXq1hkO2KTZwICda
         4vkqoa/S8rUKMWdyNHgFybZIigmO6kHXjlCj4NcCWf9xif5dQICu/ZR21psKpiJAoU
         JC4dvdd4EJmUAAx902BQ4mKpS7gimCocqGVcEqbXADeDELYGsMY1YbdeaZgUokojY3
         8p4QtafYdIwJV5kJCj0oHkYZgOAOzHyswRCBaQN6QWdMnLl/db2ySJwzq6NAMD3SxQ
         ZO8sMXZXDKK/Q==
Subject: Re: [GIT PULL] Block fixes for 5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d2e82bd5-21a7-f170-1da8-5528fb5724cd@kernel.dk>
References: <d2e82bd5-21a7-f170-1da8-5528fb5724cd@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d2e82bd5-21a7-f170-1da8-5528fb5724cd@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-28
X-PR-Tracked-Commit-Id: a4b58f1721eb4d7d27e0fdcaba60d204248dcd25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0217a27e4d19f6ecc81a14de7c5e2d7886af845f
Message-Id: <162224946091.17808.14581072858261564751.pr-tracker-bot@kernel.org>
Date:   Sat, 29 May 2021 00:51:00 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 28 May 2021 15:57:35 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0217a27e4d19f6ecc81a14de7c5e2d7886af845f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
