Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239B8C433FE
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 19:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106C561360
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 19:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243346AbhKITei (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 14:34:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243340AbhKITeh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Nov 2021 14:34:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C02AD61381;
        Tue,  9 Nov 2021 19:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636486310;
        bh=GQfx3VFW4OwvA31uxWhTmehusMkmYoUCxW8fn5gs/4c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GMmhqXFsdCXMKLClmbLaQR0gA4xM4UeIntjlOuvt40yRyhXaXLzPIcWo1B6A3SL54
         i3IPbgmL1YxBFjai/wEp70l5sBIOOixSHcFuC1uQqIH8jziZQTkz1fEJ/A6CO6EQFD
         t58fct7aSrBeAG4+qPumXYwszzrklwMGt6kDSgZTStnrN6QLWrRZiFDqu0NxA/h5+F
         G7fvQvQ3wBu5ft9tDUkhLrjIcZutqukWjrE2QbywerbwzIXu8Wh0D9g8Qq9IJKpF/d
         qAQqyh31aNwny+QfNMnK9FzuRtXohdhJ9ZgdMs0LMUe/+bQ2tHZE5XG8c+W7K7WhoY
         L8waAqEbLQXAg==
Subject: Re: [GIT PULL] Followup block driver changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <be148553-4784-34ca-af75-ff77251a7da2@kernel.dk>
References: <be148553-4784-34ca-af75-ff77251a7da2@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <be148553-4784-34ca-af75-ff77251a7da2@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.16/drivers-2021-11-09
X-PR-Tracked-Commit-Id: 2878feaed543c35f9dbbe6d8ce36fb67ac803eef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb690f5238d71f543f4ce874aa59237cf53a877c
Message-Id: <163648631075.13393.12048349558944964841.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Nov 2021 19:31:50 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 9 Nov 2021 10:06:48 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.16/drivers-2021-11-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb690f5238d71f543f4ce874aa59237cf53a877c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
