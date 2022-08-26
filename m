Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63EEECAAA6
	for <linux-block@archiver.kernel.org>; Fri, 26 Aug 2022 18:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344922AbiHZSKc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Aug 2022 14:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344948AbiHZSKa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Aug 2022 14:10:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05008A2204
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 11:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A45B4B8321A
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 18:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DD1DC433C1;
        Fri, 26 Aug 2022 18:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661537426;
        bh=af2kkdQF170O+U78ND4jD9n4bcEW056n/dUiP3vcKWg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UYqJLBdeg9786IuCgImmj1qaRpuzWIf790igcvor1IfOR1wEEmnKJw09uOyHgW24w
         q+QQ3KW3rzvwYzZsYU1Hv6mtQgDPN6Q0OekrTmmGS3DarPjqi9cwSfwss1Pco8Zhrp
         nNxn/iD0gJilj3GzriMepI+8NvCn0lWX9RQLb+GgHQEmZ76fAXk4z0Qbs/otIpNBJ1
         79ljvHqjMFhIOIw+Lt2HFdFpc+HFh5zQXiEFhXLpX2fDDtF/wz4R6u/UmuLvlGaHn0
         6ccoVHtxWoZne878WLPlIwOt1IwkCDbMJg0MeeFG2hbX21RcYJIdk7zbtDM0szeZie
         YvjTEcS99yedg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A119C0C3EC;
        Fri, 26 Aug 2022 18:10:26 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4dd058e9-1b1f-365e-1b6f-caa330a6500c@kernel.dk>
References: <4dd058e9-1b1f-365e-1b6f-caa330a6500c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4dd058e9-1b1f-365e-1b6f-caa330a6500c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-6.0-2022-08-26
X-PR-Tracked-Commit-Id: 645b5ed871f408c9826a61276b97ea14048d439c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e5c673f0d75bc22b3c26eade87e4db4f374cd34
Message-Id: <166153742622.10059.8762982818771682177.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Aug 2022 18:10:26 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 26 Aug 2022 10:38:49 -0600:

> git://git.kernel.dk/linux-block.git tags/block-6.0-2022-08-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e5c673f0d75bc22b3c26eade87e4db4f374cd34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
