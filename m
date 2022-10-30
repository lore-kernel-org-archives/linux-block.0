Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF237FA3745
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 01:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJ3B3x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Oct 2022 21:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJ3B3s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2022 21:29:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1791711A2D
        for <linux-block@vger.kernel.org>; Sat, 29 Oct 2022 18:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1A9BB80D7D
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 01:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DF68C433D6;
        Sun, 30 Oct 2022 01:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667093384;
        bh=RiERipF2cKYpdrro0dhkDuoBGmXEXksk7+wc6Je6IM0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cBqWEa807Z0RkmN5UHlxjy+aQS+1msvD9XdlgK1slNR4+sukIOPA5BX/9uFiEkWpM
         P0HvNpP3MPcbbDSKbxAlYY5+69eTzEJVhGf9l6UwWY1PDVTzbnsYpVudU91Fxos4JE
         t2QB14JV7XUJcJeYMTbvPDTmy9LflCQ/zlVltmRjjzmxaXJnoU0NYou3vVAoafLKkP
         wHU2/SGsAbkKFtdzcHGnClAYQ+PgkpgxrS2A28fNJiyjgya8Ez3+FmBz/DYf+GfRSN
         nyBkiR24peAN/4K/2UvwVRoVvgN5ZDwXQdUMP8dh4BM1DBzhwMmNn46fHYNQGE2U1n
         +iazG/EDoJtOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C6C5C41672;
        Sun, 30 Oct 2022 01:29:44 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2866e5f1-4cb0-ee89-d418-a663d4b54b7c@kernel.dk>
References: <2866e5f1-4cb0-ee89-d418-a663d4b54b7c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2866e5f1-4cb0-ee89-d418-a663d4b54b7c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.1-2022-10-28
X-PR-Tracked-Commit-Id: e3c5a78cdb6237bfb9641b63cccf366325229eec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6e0e874a8fa055b6b2f536c282a523b9439b209
Message-Id: <166709338437.23656.119426366190785039.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Oct 2022 01:29:44 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 28 Oct 2022 15:15:27 -0600:

> git://git.kernel.dk/linux.git tags/block-6.1-2022-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6e0e874a8fa055b6b2f536c282a523b9439b209

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
