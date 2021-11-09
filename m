Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7686EC433EF
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 19:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6319E61360
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 19:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbhKITei (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 14:34:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243331AbhKITeg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Nov 2021 14:34:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 978B861350;
        Tue,  9 Nov 2021 19:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636486310;
        bh=BPXelaj85bhDndQOJbPaApZ28dgl492Qy8xG4deZvPM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rgi+0Uf3jUnHA2AlPoOO0EY1hRUXsJkMUNnzZDj1/aoMvzmM4YtkdGrc7UPQg/lu9
         P12Jhy9VV6iDqn9N3ZquuUXlfMFbHMuJ6ztfukNiuB9wFINcK32yHXon0SwNz3wI0B
         +xRluH8NcnMrGCQ9P9c72it/rm0ktV6KGl6LEclZfdntQRe8eKSjWOXF56xhN5Oi/x
         0Z9KNPzLlcB4pfY2chV86UZDZhikvkYLecJmMB/oGldW2S0lpjRIQeNBwb4edRsqta
         bi/Pu6Muhc3Acs2ePWcobPS3nNAgKFmTD21Wu0bXuat/e8WUAPCmFzKvZZuqLS4V3i
         HywYP1r1QZ4tw==
Subject: Re: [GIT PULL] Followup core block changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b711ba54-4726-0f3c-51ba-332edb7c5ad7@kernel.dk>
References: <b711ba54-4726-0f3c-51ba-332edb7c5ad7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b711ba54-4726-0f3c-51ba-332edb7c5ad7@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.16/block-2021-11-09
X-PR-Tracked-Commit-Id: 26af1cd00364ce20dbec66b93ef42f9d42dc6953
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e28850cbd359bed841b832200f9fc208a9ef040
Message-Id: <163648631058.13393.4254657736048782794.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Nov 2021 19:31:50 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 9 Nov 2021 10:06:44 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.16/block-2021-11-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e28850cbd359bed841b832200f9fc208a9ef040

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
