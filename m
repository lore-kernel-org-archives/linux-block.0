Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67976C25B08
	for <linux-block@archiver.kernel.org>; Fri,  5 Aug 2022 03:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbiHED0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Aug 2022 23:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiHED02 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Aug 2022 23:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997392315F
        for <linux-block@vger.kernel.org>; Thu,  4 Aug 2022 20:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 387C760A66
        for <linux-block@vger.kernel.org>; Fri,  5 Aug 2022 03:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 995FAC433D6;
        Fri,  5 Aug 2022 03:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659669982;
        bh=zFSt6MytjkFIi/lDSaV4MjUf9MNd98Ok22u0JwJGb2U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bHMWMwVpGsEJoAXO/tRLZK0PWKzW6C1QihTW95B/KrRwa6WN2mcikyQVP7LZx0qam
         B78vW4zMECd5UyI9Vj8ozj7KFJG61wFX76wj1PoyhjbGDJZbT77rQ7UlYFp11XvFV7
         8WT8fM8bN1g/P9/ydYD4ewqIMUKUO1hIpSViOj/bChg/IGxtBtIuQVILJF5o4Fxz5p
         zxchoGb6NHBmnsVGgzkCAxBFdVXl9G12UAl7uHNMpMXa5qmJJozKtaL5FTgoH7twHM
         3YMdraxTK034AYUkz4nwkfWIoYjpoFK14NazoOELkD7D0oBRJSQELlOZCx11+yyW8A
         WoGtAHnYww+PA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89CB6C43142;
        Fri,  5 Aug 2022 03:26:22 +0000 (UTC)
Subject: Re: [GIT PULL] Followup block changes for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <49f205eb-a4e0-e091-5c21-24c548dcbacd@kernel.dk>
References: <49f205eb-a4e0-e091-5c21-24c548dcbacd@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <49f205eb-a4e0-e091-5c21-24c548dcbacd@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.20/block-2022-08-04
X-PR-Tracked-Commit-Id: bc792884b76f0da2f5c9a8d720e430e2de9756f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa9db655d0e112c108fe838809608caf759bdf5e
Message-Id: <165966998256.9883.284834298138766170.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 03:26:22 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 4 Aug 2022 20:45:00 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.20/block-2022-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa9db655d0e112c108fe838809608caf759bdf5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
