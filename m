Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBA5C433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 20:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKRUcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 15:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKRUcq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 15:32:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A34167D2
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 12:32:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 924226276A
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 20:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE6DFC433D6;
        Fri, 18 Nov 2022 20:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668803565;
        bh=EPzZa94bHFk6zHFIjU9I48vu5sTEjvXsDiB4t2Q3G8A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bbQXb0EePUkj8CU2HzDUWAKWXxtwMpU86tx2oCW3Y799L4cVPCZxFJ+BCpd0IELeL
         FpucBQYJYhSLUAfjHPY84wqQOleTJKirFI2gX42LoQy+2GrEujXAk5vx+b7beynYwS
         z/i2T3G1dgl1mKbE9BFxqFNTaHYY1JYueBvYRanqwHi1QgENdnhLmqiMS2N/1wyt61
         bAh1uQ1Cb3RvG4LdcXnUyUZfCGcqx8TS4w0fKgKGfeynAdJgRSZRncFEyQOX48YilC
         qQamsBjqkvFAPIZZdl6bEyQwg3PgO5lMV9b3VkKLMqLQ+0bk/bMvsJ3uTZt9XNQB6u
         bY+T2McW4rZrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9F00E270F6;
        Fri, 18 Nov 2022 20:32:44 +0000 (UTC)
Subject: Re: [dm-devel] [git pull] device mapper fixes for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y3e8nulXd803OoEn@redhat.com>
References: <Y3e8nulXd803OoEn@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <Y3e8nulXd803OoEn@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.1/dm-fixes-2
X-PR-Tracked-Commit-Id: 984bf2cc531e778e49298fdf6730e0396166aa21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5556a78c744347216cff46f20359412445278ac2
Message-Id: <166880356488.16518.18059020681333009152.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Nov 2022 20:32:44 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-block@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        dm-devel@redhat.com, Zhihao Cheng <chengzhihao1@huawei.com>,
        Alasdair G Kergon <agk@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 18 Nov 2022 12:10:54 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.1/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5556a78c744347216cff46f20359412445278ac2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
