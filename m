Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D670C4332F
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 22:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiKRWE6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 17:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiKRWEp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 17:04:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B347382238
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 14:04:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DA69625DC
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 22:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6F0EC433C1;
        Fri, 18 Nov 2022 22:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668809083;
        bh=dXI3maIS6hxkArvDgdTbwo3tEvKltkhtMYxJntpYpiA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p0PRCnN6cCi56K0gtjm/qpkUWRSQgdX2gvltMPGm04QD0pUEgQgstIqDOCJDbA98q
         uxUIc3Uxa4mKQTDCgalc/j4bSGznVgFEp8hNVV4ac1D3E8mDXColfu2pH6GYq7O3iY
         Z9xJPSbnyBkW1j7wb1VoUQBzDE+3JcybUALXO5QfVWNqEmJMkMuR7m54fqS6Ucw75r
         PWVwy4y74uNwZrbZoQrrLJ4J4c++HV5kEJxpe706gT3xrctS/x7pJcksXg1LNhz8uh
         qho1hDsfhEO8HYiCSatfFwnwRircYTrapQc/bzRz88BxDD5cQKalwpk/rFbjhGJaya
         nEirbG8PWREhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A54C2C395F3;
        Fri, 18 Nov 2022 22:04:43 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b6c6cfeb-546e-1236-dda6-81272cdea92f@kernel.dk>
References: <b6c6cfeb-546e-1236-dda6-81272cdea92f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b6c6cfeb-546e-1236-dda6-81272cdea92f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.1-2022-11-18
X-PR-Tracked-Commit-Id: 5c59789ce7ce994e1d9db1973a21f15481bd8513
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4408c3dfcbcc7669caa48786973e88635f3d5e8
Message-Id: <166880908366.32251.9687063946980405898.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Nov 2022 22:04:43 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 18 Nov 2022 14:15:40 -0700:

> git://git.kernel.dk/linux.git tags/block-6.1-2022-11-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4408c3dfcbcc7669caa48786973e88635f3d5e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
