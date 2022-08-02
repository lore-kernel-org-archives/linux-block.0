Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCCAC3F6B0
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 21:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiHBVaR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiHBVaQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 17:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8E262D0
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 14:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02C3761543
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 21:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 650E6C43142;
        Tue,  2 Aug 2022 21:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659475814;
        bh=kemXjcHzOKr6nkQxwGYUxsmiQkbJDlJbK7/wHpRwjZM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dvcrXfSZQ2dYr254LlFjg6DbY/sUkiSYXOsuD9wgH6y3Z1SG27jQq4BNkDEqYHP7d
         YTUlGyXe+0t7UD6yQ9WWDRXjeO4ILQIHyUedK2J7wbgkJ9a3GXayj8wZu2xXbtf/r3
         jP1KOnjJGJuYEWrCxfS0880wVQujH+Veo3UIF9tIx2VS9d+dDVv3f3YuQkrfbTOZcz
         z5zDzoaMOTR9Dx57A/DqR4jpDiIJBGRh5xStXhj6d8nagIbtMNYQ/itI1thztsE2dx
         LgSlqiI+CGliLYINidPAURnhAV20eLEYm/XPEupjDHafjqyz69wJasCDEq1GEqpyAd
         khlIqhyJzbHuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 507D2C43140;
        Tue,  2 Aug 2022 21:30:14 +0000 (UTC)
Subject: Re: [GIT PULL] Block changes for 5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <83a24590-fe65-4b8c-9069-45ad8290a451@kernel.dk>
References: <83a24590-fe65-4b8c-9069-45ad8290a451@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <83a24590-fe65-4b8c-9069-45ad8290a451@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.20/block-2022-07-29
X-PR-Tracked-Commit-Id: 8d9fdb6011b4d413271eba3a62e10f89efecc419
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c013d0af81f60cc7dbe357c4e2a925fb6738dbfe
Message-Id: <165947581432.30731.1080067046883784803.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 21:30:14 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 31 Jul 2022 09:03:43 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.20/block-2022-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c013d0af81f60cc7dbe357c4e2a925fb6738dbfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
