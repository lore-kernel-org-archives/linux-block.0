Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15915C61DA4
	for <linux-block@archiver.kernel.org>; Sat, 18 Feb 2023 19:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBRTQ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Feb 2023 14:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBRTQ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Feb 2023 14:16:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9604515547
        for <linux-block@vger.kernel.org>; Sat, 18 Feb 2023 11:16:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 329C160BC2
        for <linux-block@vger.kernel.org>; Sat, 18 Feb 2023 19:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 937E5C433EF;
        Sat, 18 Feb 2023 19:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676747773;
        bh=f65O8Ofw7WDe0mbvtTy5xoVATO+IYdgemJ5Rg040+nc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aKwfnV23FFsVqnauxlMf547PlXqofRy20qU31Q7FiWXe9rnAsOdNTlA0R+xDYxnau
         g/E+h5ULmcDjZ5ZTZPnJqVlkyn5HDG/gyok9F+x1OU+teXNGO8JIXvHBvo95DTkZ0s
         +qr81LIeDDJZayIr32zWKM3j2xno4Nl7LDwNyNeFvGiWXjtyJp2/9gLi3F+bDQi8cV
         YcFKsVKuj9mufoHiJh2JPft2SIsFlytaX6zVHFhvslUY/DFGGGEUmSvEqbgF+Gz1Hn
         nOyfhDXLqGKLfudjjAI3mnjN68YWcgZZlAmh8HW/I5p1zyiPtYEJOkjm+aXcSppCqz
         YZi5zrpTD3nTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81359C41676;
        Sat, 18 Feb 2023 19:16:13 +0000 (UTC)
Subject: Re: [GIT PULL] Followup block fix for 6.2-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <58231104-74e0-c1df-5a47-9027ed0241c6@kernel.dk>
References: <58231104-74e0-c1df-5a47-9027ed0241c6@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <58231104-74e0-c1df-5a47-9027ed0241c6@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.2-2023-02-17
X-PR-Tracked-Commit-Id: 1250421697312a7f2f13213a71b430402f2ae8f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e9fd589e61dace0dcc9848fbf6eb38f16d25f08
Message-Id: <167674777352.30281.4646705800836571169.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Feb 2023 19:16:13 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 17 Feb 2023 19:32:44 -0700:

> git://git.kernel.dk/linux.git tags/block-6.2-2023-02-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e9fd589e61dace0dcc9848fbf6eb38f16d25f08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
