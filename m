Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1294AC3E8C5
	for <linux-block@archiver.kernel.org>; Fri, 27 Nov 2020 21:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C441621534
	for <linux-block@archiver.kernel.org>; Fri, 27 Nov 2020 21:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2Fkv1378"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgK0Vco (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Nov 2020 16:32:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730218AbgK0VWC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Nov 2020 16:22:02 -0500
Subject: Re: [GIT PULL] Block fix for 5.10-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606512122;
        bh=DhofVfYhZ2x0+lyuskC1rMJhP5IyRuQe3JsBhoRAs4Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2Fkv1378mKDN9p0hn0H3Sf9pNJTKOZwcQAy1s85sX31vOp7iXs4B+VAFLiRTwsDhe
         6n1fhxug8agtVuSTQWYvoeeeBj9H3rEaDKpJi/kK+1N8vmLU97fpcL/twzsaX7cNKu
         2DRLQainYHCHa32yZWxDgVZunnCYj6Rg6MCiM/nA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5287b66c-74e6-c86c-a55b-b1cb5da39399@kernel.dk>
References: <5287b66c-74e6-c86c-a55b-b1cb5da39399@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5287b66c-74e6-c86c-a55b-b1cb5da39399@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.10-2020-11-27
X-PR-Tracked-Commit-Id: 47a846536e1bf62626f1c0d8488f3718ce5f8296
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d021c3e56d48b0a435eab3b3ec99d4e8bf8df2d1
Message-Id: <160651212226.4351.2968269501125241472.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Nov 2020 21:22:02 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 27 Nov 2020 13:47:04 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.10-2020-11-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d021c3e56d48b0a435eab3b3ec99d4e8bf8df2d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
