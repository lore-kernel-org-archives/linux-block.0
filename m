Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E3BCD37B0
	for <linux-block@archiver.kernel.org>; Fri, 15 Sep 2023 22:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbjIOWQu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Sep 2023 18:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbjIOWQX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2023 18:16:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68478268F
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 15:16:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02DBAC433BA;
        Fri, 15 Sep 2023 22:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694816178;
        bh=qlEhSYHo8svPRlX462l5zLC6y2hf8eqi9KMrzh+xPrY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fRlFxnCtTCc9EjITZN16mRQBApViYbaApq9ATbjHSKyvvn1bdPWQPgTWoBidFEzOb
         bnoAI4/Jh6O1BlJwEAwepfaEMXHdjj/GNNnCT4viCS6rC1i4VGQVU+y7r2NGTIMZRo
         HYg6oiYeL7fo37UoZzw6y8WLWw1hEmWlVrORBrRT1tUwW55lGSZTUk20pR5Rv310IN
         UUVfg4gDQePw259N/y5sUxZGAp+NMTVykqG3NRliTBPc2i0PP6CedpJFBI916HN0Kl
         0xZIGUmVSJJC36PjB99/Uq37hngsxqaKQpPJtszUS7t8GXmBEBqiEhm+1+0HRygqvR
         qnl+IpaHREj5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E65E3E26882;
        Fri, 15 Sep 2023 22:16:17 +0000 (UTC)
Subject: Re: [dm-devel] [git pull] device mapper fixes for 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZQTCEOrIV+JmvfIE@redhat.com>
References: <ZQTCEOrIV+JmvfIE@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <ZQTCEOrIV+JmvfIE@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.6/dm-fixes
X-PR-Tracked-Commit-Id: a9ce385344f916cd1c36a33905e564f5581beae9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e39bfb5925ffac1688cd053d49792a764590bae2
Message-Id: <169481617793.11838.15746982873328147675.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Sep 2023 22:16:17 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 15 Sep 2023 16:44:00 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.6/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e39bfb5925ffac1688cd053d49792a764590bae2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
