Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792F3C433EF
	for <linux-block@archiver.kernel.org>; Sat, 16 Jul 2022 18:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiGPSuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Jul 2022 14:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiGPSuJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jul 2022 14:50:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F061B7B1
        for <linux-block@vger.kernel.org>; Sat, 16 Jul 2022 11:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA888B80CBC
        for <linux-block@vger.kernel.org>; Sat, 16 Jul 2022 18:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83F04C34114;
        Sat, 16 Jul 2022 18:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657997406;
        bh=DgFs0rPXpvGv430rVcXePLitiVX4Bbkwzn3zejHeIR0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z7CdD7Pf6IUkMWTpKWqP6zDAGv14WggtgaG910jG51fKOcSegSOy13ZXq+c6YBs/V
         mHsWIz6VEJvk/6RUa3wWaQz9J4XFkNd+ojPsY+AhMfs0Li1SS+6urh4izqEas98lgX
         4xzKBK30gtJV5B1D6ZeLBviQ258tqDua8Kh1GHdTe57sDVqoiTabm3viyULjoJmm6E
         FRhG5TCNgO6yJ/kgfbWR0I+7tf+KhbQk9MHKBIlNSneEG3g3fOfpo01dcNbOfF5rrk
         sgmRMXIGkRCMrBlK8VQEfTbdqa7M+k1JYQDDAU89gz653qMmd0RobehrSWe5CTYkJB
         3OYUXDudwV+xA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 654E9E45224;
        Sat, 16 Jul 2022 18:50:06 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5d50557f-e09b-acbf-690c-b82ca2d2e53d@kernel.dk>
References: <5d50557f-e09b-acbf-690c-b82ca2d2e53d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5d50557f-e09b-acbf-690c-b82ca2d2e53d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-15
X-PR-Tracked-Commit-Id: 957a2b345cbcf41b4b25d471229f0e35262f066c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bca047ecd675325eca4bc0753ef91864954bd3d
Message-Id: <165799740636.27449.16052544412246074475.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Jul 2022 18:50:06 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 15 Jul 2022 13:50:32 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bca047ecd675325eca4bc0753ef91864954bd3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
