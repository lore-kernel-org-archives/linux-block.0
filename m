Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DBAC433FE
	for <linux-block@archiver.kernel.org>; Sat, 27 Nov 2021 19:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhK0Twg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Nov 2021 14:52:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50910 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbhK0Tuf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Nov 2021 14:50:35 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B92D8B80936
        for <linux-block@vger.kernel.org>; Sat, 27 Nov 2021 19:47:19 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 895F060174;
        Sat, 27 Nov 2021 19:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638042438;
        bh=erKTFU79Ufx6PWlQZRCHI82sZ89kl6cbX68pxtUMkmc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SnYGKFrsPzf7D49X7nhA5wWAeTBYtDcB+33i2OkgqJcbm1v7tMsjSq+cQRjUW7SWJ
         LR5V8kBY2il9dBjPzeQyxZ2VxtoqOEn/Lxto3zpeLJJRu7aiARuwFZogW8p55FJQih
         ZqK94Y0nB3mWsmWislLLGHAUZcSspcz1N+gxYoxIbFGMaSAvTh4bHqOTWVWmWshuqE
         toO/aSr9qO7cxSmX3iv07M/JyKUUkwLktrLWn0avP2jbj9PyEEqZcdqbkhUl9AyYgc
         8e7RyK+YgKhvkyx3Bw8fbOLJTuf+/ZZhjNOWctS4Hs7YQg5uIJ2360gH5IlNZ3U6uW
         8uW0ZaX1NBeaQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 79C22609B8;
        Sat, 27 Nov 2021 19:47:18 +0000 (UTC)
Subject: Re: [GIT PULL] Block followup fixes for 5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <def53d9f-f655-3435-6804-be4482816eed@kernel.dk>
References: <def53d9f-f655-3435-6804-be4482816eed@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <def53d9f-f655-3435-6804-be4482816eed@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.16-2021-11-27
X-PR-Tracked-Commit-Id: d422f40163087408b56290156ba233fc5ada53e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 650c8edf53f7ae2d3ebdd0bf64b7b7fd821bd75b
Message-Id: <163804243849.4525.17650685506702495474.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Nov 2021 19:47:18 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 27 Nov 2021 09:04:29 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.16-2021-11-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/650c8edf53f7ae2d3ebdd0bf64b7b7fd821bd75b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
