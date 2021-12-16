Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE0AC433F5
	for <linux-block@archiver.kernel.org>; Thu, 16 Dec 2021 18:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhLPSnQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Dec 2021 13:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhLPSnP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 13:43:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA78C061574
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 10:43:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42D9561EEF
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 18:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7725C36AE2;
        Thu, 16 Dec 2021 18:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639680193;
        bh=6GHqlVivCQ6ATrG48dtoCjuPxxCgIo6Ra5tpUAiAzK8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ds7988R8BOyDRV5hWH6TuDGz/cH8CjL9t9oGxPzHme9uA9laDFj91+9Z3nx0n/q41
         RcRsSyGXNLGAhCB7B0DCP4ezA24Ukpub1oAU+af7P7vzLRWfVIMbzlJHg/3bif9Mcq
         LMZu5K3i+OimXN1hL2yj+A2Efj/X/EhdS9bhQImGVk3x9d95aYLblAXuzAopPdN1B0
         rtsP9hHjm1yUgikxoEeF2nqFa9/VhNV9c5X1ifG3lPlxUbYgSabbNWjHsAhsNIgThc
         SfGdamVD0FVAsLINHYnGNGiTynQ4q4leE/DS5rUWx8cEGF4tIfkvxRbE+t7+pZjhrg
         8y2/SGFy8G8yg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 85187609FE;
        Thu, 16 Dec 2021 18:43:13 +0000 (UTC)
Subject: Re: [git pull] device mapper fixes for 5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ybt8HMQUZn7mlvTG@redhat.com>
References: <Ybt8HMQUZn7mlvTG@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ybt8HMQUZn7mlvTG@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.16/dm-fixes
X-PR-Tracked-Commit-Id: 1cef171abd39102dcc862c6bfbf7f954f4f1f66f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81eebd540511a5e57ed71a0e6221186513c8841f
Message-Id: <163968019348.23045.5413550556384158424.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Dec 2021 18:43:13 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Joe Thornber <ejt@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 16 Dec 2021 12:49:16 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.16/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81eebd540511a5e57ed71a0e6221186513c8841f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
