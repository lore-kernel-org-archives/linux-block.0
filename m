Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37541C433EF
	for <linux-block@archiver.kernel.org>; Fri,  7 Jan 2022 21:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiAGVc7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jan 2022 16:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiAGVc6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jan 2022 16:32:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEA6C06173E
        for <linux-block@vger.kernel.org>; Fri,  7 Jan 2022 13:32:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D921FB82779
        for <linux-block@vger.kernel.org>; Fri,  7 Jan 2022 21:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 914A8C36AE5;
        Fri,  7 Jan 2022 21:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641591175;
        bh=txmOgl9KzdM70h+7Kkdx0y1cnuELIn2NvIOMjAaqBCw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D2Lz8Z8x+LoqT6aEY4tKj5L0+PkQKcyubSG4v4alhvDncmF1/7PWxHgJ2HWtl48M5
         4ljm5KlewOIwYYaicKQ5pM3BKAHtTCQEdhsvfBi6HEr8KcnxImkIQdmvGsFrIlx1hU
         yxDi4WUTES5e1Uz/znMC4bF3xNCxFmfB/FeTQ9C2fFc2Q2YQW5eHrtQsMWqPAdvJtu
         XdfiXpZfcPzaRBd4VJtFcW9A1Fb5QKbmPxsIx3bcIEnby3nsbG4GhGm5iBquAXvN92
         iJIBwz6pVvaVM90oKHIh99A03KBlWg4BNVxb6ykoXnly8RPGk0aTok8CrG5hDCUzj2
         3cJgPV3QgN68g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 811DEF79408;
        Fri,  7 Jan 2022 21:32:55 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 5.16-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f7317ed1-9481-43c7-2004-de59ab66b2b7@kernel.dk>
References: <f7317ed1-9481-43c7-2004-de59ab66b2b7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f7317ed1-9481-43c7-2004-de59ab66b2b7@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.16-2022-01-07
X-PR-Tracked-Commit-Id: 26bc4f019c105234639068703186c01efcabe91e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35632d92ef2daf36f75ddcd68d322c8ba7ad383c
Message-Id: <164159117552.9111.14085804014207516873.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jan 2022 21:32:55 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 7 Jan 2022 13:28:14 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.16-2022-01-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35632d92ef2daf36f75ddcd68d322c8ba7ad383c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
