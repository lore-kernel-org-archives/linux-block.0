Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A73C433EF
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 19:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356865AbiALTNv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:13:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59532 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356935AbiALTMK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 14:12:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9053861ABD
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 19:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64CFAC36AEA;
        Wed, 12 Jan 2022 19:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642014730;
        bh=ZzvJY08BNr5RupD+jtQqtPHJyV+5V2JHWwXGTkVIKVc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KaFjruZ7ilsuLvzF5hnDxGlxbywAUxLStx2kaXkQ/kW9LbydvGkuCa2y8oBZshFTJ
         ykA8z//06eZ9NCvvsuZ9/U3N9FU1TdEGMkNDJwlkAq+mVgcXVz222Zh0LMpG6dRmKs
         z3uIv8Xd7vYHhdQafJuUYt28JXF8zAG2thVsmf+G2YiL6khiV4DM3m5Ur7Lt4P0fcY
         QOmFJMODf5DTulyTnZjPbkEx5TZq7MI/G7+Mp4x85AF13YyNX3ERGD2+klV4kwpv55
         0EDs5McsIA0JFdh73zSLstjqSp6E+d4Lvb+4LqkkbkVx/QgnGmrlvQP9MbYE6CYkj/
         00jPE9P20u9GA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55102F6078C;
        Wed, 12 Jan 2022 19:12:10 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 5.17-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c4086937-5e74-b8e8-d8a1-5e203c926c71@kernel.dk>
References: <c4086937-5e74-b8e8-d8a1-5e203c926c71@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c4086937-5e74-b8e8-d8a1-5e203c926c71@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.17/block-2022-01-11
X-PR-Tracked-Commit-Id: f029cedb9bb5bab7f1bb3042be348f2dac0ee66e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3c810803576d867265277df8e94eee386351c9d
Message-Id: <164201473034.2601.9578620752394314519.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 19:12:10 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 14:47:06 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.17/block-2022-01-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3c810803576d867265277df8e94eee386351c9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
