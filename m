Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176E8C433EF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 21:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiFAVxC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiFAVxB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 17:53:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567C315FED
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 14:53:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7ABB6123E
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 21:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53861C385B8;
        Wed,  1 Jun 2022 21:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654120379;
        bh=TvFrCt6AY+Fy6TmSNF9Cg/hjYj+YhwESv3UHDwt5Zhw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FjQydQJI1WCBtDXTx0w0ORcDXo/j166IF1XNxVeFp3yQM46o3olQ4EuChMuzdF/FJ
         4twpAdNKZIYwPV8cbGJCmcKQSXRCpivoLTV3Ib+F37qgyMJd94E5vJdS8mSSgNklHn
         e4BqPy1xhhzzWB9mnZfffJE668Lgx6aLlrIU7avuDletqL/2hCN+k9pfOlbcr8mO4e
         0xbwc7W6mnKqzXKAYUZaCs67B/rsy/LWEy9+V+GB41lYGQ7xdqE+E/V1//5aTvKLsK
         5yG2Nt4FEfN/P33EVWvQZQCQjbIZcKi8M7P3J5AyvZa+J8Dz6R1MpSxR9+XI9zGE8E
         Eo1jkiJayYERA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 428C1F0394E;
        Wed,  1 Jun 2022 21:52:59 +0000 (UTC)
Subject: Re: [git pull] device mapper fixes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpfTQgw6RsEYxSFD@redhat.com>
References: <YpfTQgw6RsEYxSFD@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpfTQgw6RsEYxSFD@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes
X-PR-Tracked-Commit-Id: 4caae58406f8ceb741603eee460d79bacca9b1b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa78526accfd68966fb50a429439e9085f9c88d6
Message-Id: <165412037926.5556.12163341138879689778.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jun 2022 21:52:59 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Sarthak Kukreti <sarthakkukreti@google.com>,
        Kees Cook <keescook@chromium.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 1 Jun 2022 16:59:46 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa78526accfd68966fb50a429439e9085f9c88d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
