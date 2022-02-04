Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D88C433EF
	for <linux-block@archiver.kernel.org>; Fri,  4 Feb 2022 20:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbiBDUej (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Feb 2022 15:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239131AbiBDUei (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Feb 2022 15:34:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B02C061741
        for <linux-block@vger.kernel.org>; Fri,  4 Feb 2022 12:34:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E98C76154F
        for <linux-block@vger.kernel.org>; Fri,  4 Feb 2022 20:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5931CC36AE2;
        Fri,  4 Feb 2022 20:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644006876;
        bh=xxZS/F+YtwiXY/KI+cNLmhAZ6KKcc1ykg8iPNzPXLLI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=thWFEJcjBSPQtLO4YlJXVR1NBSa7CTjSRNiy74R0iq5JLjMw4m/zlLM5K9qd5++a/
         VqzM/Gxg2Y2nenNqBfEEQma7d4CWTPC1mlWjCAASqT29pL7TqJOquD9S597jNiZv4p
         Y1EaEbDSLWB/+/APGP2T+d8SPvBI8UPdJa45atFvhq6x7ocLdJ0EinXQKZWcLVLrJF
         M4V3zoRsyuQFIalExfPuMe7fdKGAWgttelxRAUHAbnCXTXuthdACfilBYdv3mwmIpO
         QCA59bMNDjGs6oxwpLgo+VbT6RUZ2FEhGhfTAq1K4jPM6E9v/JtX31Sj2PzgK5WzIN
         hjto6+AZrA5qA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46940E6BBD2;
        Fri,  4 Feb 2022 20:34:36 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4c26c740-abde-87a1-3cf0-5f97fad85d4e@kernel.dk>
References: <4c26c740-abde-87a1-3cf0-5f97fad85d4e@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4c26c740-abde-87a1-3cf0-5f97fad85d4e@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.17-2022-02-04
X-PR-Tracked-Commit-Id: b13e0c71856817fca67159b11abac350e41289f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c4a94590e4dc134b36b0edeb5ddcf6e8b3da498
Message-Id: <164400687628.31755.9128679429765971964.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Feb 2022 20:34:36 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 4 Feb 2022 11:28:47 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.17-2022-02-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c4a94590e4dc134b36b0edeb5ddcf6e8b3da498

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
