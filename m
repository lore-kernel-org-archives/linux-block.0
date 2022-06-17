Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF3DC43334
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 17:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382968AbiFQRH2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 13:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382982AbiFQRHX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 13:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E63E248F4
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 10:07:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FE5761E94
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 17:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74677C3411B;
        Fri, 17 Jun 2022 17:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655485641;
        bh=TbdfU6dlEOUCaSv6c8wDjUIQJjHBV4VhfEa7W2AGqnw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FMC+PFjGB3nEMmRX4KWLXbVJHHqMpaTFLSAHfgqTjvB422FJsV88PCKpmaw/HikMd
         K/Qzxz3tk/YBxI0zjOsXkFecDra+djhIV3XTibfo4wYixIWQfOQyHRtp/MMzObrbl8
         Zl88OK1oQjItZ42sgYz3LheW8+WhQMed0QVom4xaWBL5No8wF8rtajRhQv8VDKczHz
         InhMDgcmZA2vR6Iji+NbndQkkJrvDs8wlyP39wOO05/EVrE4JSvl4JDZ+XrIXDT/tj
         4/VQ30rmS8PtHFxg/GuWlYiJc/JgYj2PakJ/x8fp1vqVj6XLW5xR3wgq5rhGecivhH
         Rb1g289AwgZZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54FAFE56ADF;
        Fri, 17 Jun 2022 17:07:21 +0000 (UTC)
Subject: Re: [git pull] device mapper fixes for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YqyqXocn0lrLVJ1R@redhat.com>
References: <YqyqXocn0lrLVJ1R@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <YqyqXocn0lrLVJ1R@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes-3
X-PR-Tracked-Commit-Id: 85e123c27d5cbc22cfdc01de1e2ca1d9003a02d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 274295c6e53f8b8b8dfa8b24a3fcb8a9d670c22c
Message-Id: <165548564134.14433.14161801830891893060.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 17:07:21 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 12:22:54 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/274295c6e53f8b8b8dfa8b24a3fcb8a9d670c22c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
