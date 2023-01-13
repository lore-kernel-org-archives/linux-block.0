Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9896C677F1
	for <linux-block@archiver.kernel.org>; Fri, 13 Jan 2023 23:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjAMXoR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjAMXoQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2023 18:44:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168FC7A397
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 15:44:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E2A2B82271
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 23:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30FC5C433D2;
        Fri, 13 Jan 2023 23:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673653451;
        bh=P5NyTiHhAycwdRI+LqsXFO/MEHAguQotGUpmuJH27zE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UUGHJTB/zXQPy1SrSTPKvxhIEvIg/R25zSQSHnYwpZoezduQuK98Jkut35wfKfAIH
         qowKJdgkDMLT7pbL2V/TWhaWRKWIm22RKc5tW3xzrlQ027n4IZ8aPuLpcZnGflO5mk
         8vu54U2wND3BG7HqKANgKlHmq5QBaXfZNTnAtqScy7u4j4aPPBRne1cj6caG4l89Jp
         pKZBEzjYsPbJwppPkZtGt7HLLEO32dFDFQzekxqM4UwX19B6/a3j5r1sue0SpAHS2C
         U4FQFhicTF6NEsGw080CMOMHxKmGf2dyJnLtKbbxOioWOqlm40fWdp6B1QKCKXpHCl
         XNqd03D8ILAFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EA43C395C7;
        Fri, 13 Jan 2023 23:44:11 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.2-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2ccb1b3a-ea42-134c-b906-4a3ecdd6f29b@kernel.dk>
References: <2ccb1b3a-ea42-134c-b906-4a3ecdd6f29b@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2ccb1b3a-ea42-134c-b906-4a3ecdd6f29b@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.2-2023-01-13
X-PR-Tracked-Commit-Id: 3d25b1e8369273d76f5f2634f164236ba9e40d32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97ec4d559d939743e8af83628be5af8da610d9dc
Message-Id: <167365345111.26027.3875867178959837327.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Jan 2023 23:44:11 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 13 Jan 2023 12:33:48 -0700:

> git://git.kernel.dk/linux.git tags/block-6.2-2023-01-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97ec4d559d939743e8af83628be5af8da610d9dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
