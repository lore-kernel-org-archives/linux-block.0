Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838ACC433FE
	for <linux-block@archiver.kernel.org>; Sat,  4 Dec 2021 16:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355429AbhLDQ7b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Dec 2021 11:59:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48164 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355446AbhLDQ72 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Dec 2021 11:59:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 526B5B80D28
        for <linux-block@vger.kernel.org>; Sat,  4 Dec 2021 16:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAFBAC341C7;
        Sat,  4 Dec 2021 16:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638636961;
        bh=F8TC5O1KXb+SBVqnGSyrNs+D68K6WSj6KnbqESQpzmA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r+dt1+3k0EjiYwGyauNSZyE7EwW4uPJOWE0QEy7kPTsqyYX68tefl2pUqAB5BiwKr
         Orh1LHodNxOeDPwrmtqDayaDdRKRANLJkNiIVjhl+KVvQENk+4UYlVlnSuF/Otv5Jw
         ds3sRelqXWuIJT5QoNom6vjkuu0cnH0HqwP/n+K49yrFMjRgmxImlZq6TagVzDiUz/
         MNxLxkg55xXtPeCNYsJX+pBvG4jebg5UN9u5AckqE3b/CLHy2K7yxaF0HRd+Onm1yF
         Z1f8YpNnCTBpSqwfsdDSzTwUrIFBvJlnDj7vpohux1hqmKzd63lAJCs5E1oD3wBG+L
         WQu+IRQLyU13g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DA98860A90;
        Sat,  4 Dec 2021 16:56:00 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <193033b8-3652-d5f3-f7e9-29038de4a6a1@kernel.dk>
References: <193033b8-3652-d5f3-f7e9-29038de4a6a1@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <193033b8-3652-d5f3-f7e9-29038de4a6a1@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.16-2021-12-03
X-PR-Tracked-Commit-Id: e3f9387aea67742b9d1f4de8e5bb2fd08a8a4584
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbef3c7a63d2a4cb0f3f839db9e767f168c5e348
Message-Id: <163863696088.3540.16250108247669447870.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Dec 2021 16:56:00 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 4 Dec 2021 08:17:36 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.16-2021-12-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbef3c7a63d2a4cb0f3f839db9e767f168c5e348

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
