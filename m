Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1206CC4332F
	for <linux-block@archiver.kernel.org>; Wed,  1 Nov 2023 22:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346609AbjKAWrR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Nov 2023 18:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346603AbjKAWrQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Nov 2023 18:47:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE58910F
        for <linux-block@vger.kernel.org>; Wed,  1 Nov 2023 15:47:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68FEAC433C7;
        Wed,  1 Nov 2023 22:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698878830;
        bh=OXs0O52l9jVHaohh2E8C65m0gwSnK7BvK2FxzTHZEjI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sCJmMiXOWU+VDHlwAeKdKL3Wm8vnrc+tpwYhBljRBqWXuwaWqeBmnNexKYsxFWEOv
         u9QJvJoD1dV4wT93lJEWr0sDXwiCW9+sSKa2gelw+pvyyfSoN9WnFfLPc5gFra3k0Z
         T0MawO+OJLoQ72WSP4+FcWI6OUgtr4VKb5mRIqYJ5TiHQyJwKCjZ/5M1H2/1VqVMVU
         2zC3JCw++WgxBxl3g4k3MUTmT53Dguavnu4Fdl5SVQxc8xS7x2pq30P0XFHGlc6QSy
         APFWCyced8mSR6aCTrSsiezV2NwoJSSOLMDmlNOmIlO+Qy5Pr54dftAM5or6p0++x1
         Y/TVJW+GAIjBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56953C43168;
        Wed,  1 Nov 2023 22:47:10 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1f416960-86d1-435f-825e-fc4a57747204@kernel.dk>
References: <1f416960-86d1-435f-825e-fc4a57747204@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1f416960-86d1-435f-825e-fc4a57747204@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.7/block-2023-10-30
X-PR-Tracked-Commit-Id: 0c696bb38f4cc0f0f90a8e06ae1eda21a9630cd0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90d624af2e5a9945eedd5cafd6ae6d88f32cc977
Message-Id: <169887883034.15957.9338009488468518514.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 22:47:10 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 09:28:11 -0600:

> git://git.kernel.dk/linux.git tags/for-6.7/block-2023-10-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90d624af2e5a9945eedd5cafd6ae6d88f32cc977

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
