Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9D1C433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Dec 2021 21:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhLQVnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Dec 2021 16:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhLQVnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Dec 2021 16:43:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96735C061574
        for <linux-block@vger.kernel.org>; Fri, 17 Dec 2021 13:43:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35E35623C1
        for <linux-block@vger.kernel.org>; Fri, 17 Dec 2021 21:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9ABEDC36AE2;
        Fri, 17 Dec 2021 21:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639777397;
        bh=jTtbKcQo/of0S5X6A++eWcoIKcf1Qf/bZt1ypjv+1IA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fGIEHkOX5p7hdsvslfzPOwpBhOfOCoL9x7QdYamyssffmgXzfVyS+4F2d+CP3PmoO
         ntruUCK9uGwev0bVVEbUuLqYvg1zOqjDQ/oHhJj/aYwqdv3/81+inFun8+0eM2gATT
         4ahhKlEbynkulThW7QyPDdrcsNmGBgUy4smPXMcP4qq274j68cFp+klkRXKO8xseWn
         U0x/tpsLPQUJXKzD5x9oMRGHFAqJ5S9PJIsoEuhimGPL2MTXkeGxMCuxAUhTsFnulO
         JCpBMAkjjn34a6JDcQkSfwOIjukFsqz6mBC687VWEznOK7igqXOa4YhIy45xRDFEot
         r4o+b1KY1otjA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 725A260A39;
        Fri, 17 Dec 2021 21:43:17 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2a664593-191b-db70-7dde-0b02ef2b6e6a@kernel.dk>
References: <2a664593-191b-db70-7dde-0b02ef2b6e6a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2a664593-191b-db70-7dde-0b02ef2b6e6a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.16-2021-12-17
X-PR-Tracked-Commit-Id: aa97f6cdb7e92909e17c8ca63e622fcb81d57a57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa09ca5ebce5b293ddba9b042d8fa9ed690bd91d
Message-Id: <163977739740.30898.9095122798228211603.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Dec 2021 21:43:17 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 17 Dec 2021 10:00:24 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.16-2021-12-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa09ca5ebce5b293ddba9b042d8fa9ed690bd91d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
