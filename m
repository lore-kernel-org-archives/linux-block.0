Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278ACC10F1D
	for <linux-block@archiver.kernel.org>; Tue, 13 Dec 2022 19:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiLMTD2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Dec 2022 14:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbiLMTDG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2022 14:03:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6C72AC0
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2022 11:02:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4740C616F0
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2022 19:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B05B4C433D2;
        Tue, 13 Dec 2022 19:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670958164;
        bh=8b5RW06fRUQk08UNKmjNSStPnn3Cx9qH7mMrrR+Kc68=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AopRfOyAHzUUT71zNlejPlE0rqpPBdF2X1byH5cVQei1GjO1Ely7vka5kmdXij5Ua
         8XNTv0e3A+jBpMrVXizWu2fppSon6Us+sf72hgsLBvXBTKpDjgq4EXsP7o3ixGYG0r
         yJkwFtwVOVFoK1rJh3pM3XKDYDm4lE4A1uLV1PojenjLJsgdP0b6B7gZZUdF6MPyhT
         B7ib85nNhk3ZC6rvIIwsoVXLpTXW7EGAz1duCBRXJ3TARzoEM9jyDrIdPjMzOTX7Y8
         U0xfD4QYNvuLOrRAdnE8GCCVZyymkM5X65VYKIWbqMetMjogWuptOYVmQSJJwmRgSd
         Rj8m3JEgo0OsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A03F4C41612;
        Tue, 13 Dec 2022 19:02:44 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <99cd4a7d-32c2-497b-d35b-950eebcd5319@kernel.dk>
References: <99cd4a7d-32c2-497b-d35b-950eebcd5319@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <99cd4a7d-32c2-497b-d35b-950eebcd5319@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.2/block-2022-12-08
X-PR-Tracked-Commit-Id: f596da3efaf4130ff61cd029558845808df9bf99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce8a79d5601aab94c02ed4539c48e8605422ac94
Message-Id: <167095816465.20557.12608856643148424319.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 19:02:44 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 20:24:46 -0700:

> git://git.kernel.dk/linux.git tags/for-6.2/block-2022-12-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce8a79d5601aab94c02ed4539c48e8605422ac94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
