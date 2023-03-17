Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ACCC74A5B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 18:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCQSwi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 14:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCQSwh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 14:52:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE60C6DA1
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 11:52:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BA8B6103A
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 18:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70131C433D2;
        Fri, 17 Mar 2023 18:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679079155;
        bh=/xD1dPT3bOwSWCj9CtzW7NlhaA1TgtBqCF74qaCXu3w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JDCo6I4m2u0n/VYrHJZWi+WL30LaWrTcllyglH46XBM18vX97oDGHitcDMRR8f/Wb
         Wmb9FCdIHyJCYpz5V/jzpl//41H6Qvpi8cEHDL2YsuBjSCNHsCDst7htqJPILpFOSK
         j2T2EguO3YYSgJWR3zlj08NxmtCEWloVg89UcBbguRp8fpZ7HSLCor84v5ulvy0qNi
         EnQa8zdY2YFOYkM3iFp7OLRdP2kydvDQERhay5DrYpxraLljdWoHH68n70A6X5dkYk
         4dd3Vn4WAT3Pud05WVBVvbJiBSOP95I15MrayPRVpezI7jFgzTibJexXudb4SJdNcQ
         bNW4sd5uvEoug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FAB3C43161;
        Fri, 17 Mar 2023 18:52:35 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.3-2023-03-16
X-PR-Tracked-Commit-Id: 8f0d196e4dc137470bbd5de98278d941c8002fcb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d3c682a5e3d9dfc2448ecbb22f4cd48359b9e21
Message-Id: <167907915538.16534.9616279472853940604.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Mar 2023 18:52:35 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 17 Mar 2023 11:16:02 -0600:

> git://git.kernel.dk/linux.git tags/block-6.3-2023-03-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d3c682a5e3d9dfc2448ecbb22f4cd48359b9e21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
