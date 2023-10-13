Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19DFCDB474
	for <linux-block@archiver.kernel.org>; Fri, 13 Oct 2023 02:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjJMCtw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Oct 2023 22:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMCtv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2023 22:49:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E6B83
        for <linux-block@vger.kernel.org>; Thu, 12 Oct 2023 19:49:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DF18C433C8;
        Fri, 13 Oct 2023 02:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697165389;
        bh=KW+8hZiCM8bE5r1C+5fT091/V0ElMaVKurQFVrSF+rQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c5XOJOs2JZc4YVbi8++0SCzEUxzKMHg2Cko3X/U3ADEuI/hpR0RZMZEEdUXe2MBFO
         hKaY0NTHBtEVmY8AujCto6cQA8DxNR6EjcHgJsR0D9pgeyFIG1RqmzApTT8ab150GW
         GeVILfHOwxlLLf0DU/jTCQAHluyQg+HWBlFEV192ltWZFQS8VbwvhZS2MDDZc7nKUE
         TKjlArnC600ePSkOzoR6/Kb5mLuqMjxPGiMCcg5JqqGyeTowdvJy8EOjyVr+ZDa0ud
         jrsg5rgWNkwP4MxrFU21Q6XtE+Yr31U0ZnQWHNrbQ5Yr4ouRZ5EL8OenctzCFztxyn
         UXiEPoVxk1Xwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C064C595C3;
        Fri, 13 Oct 2023 02:49:49 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e211ae0d-0231-4087-ab0a-fb9bc24940c6@kernel.dk>
References: <e211ae0d-0231-4087-ab0a-fb9bc24940c6@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e211ae0d-0231-4087-ab0a-fb9bc24940c6@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.6-2023-10-12
X-PR-Tracked-Commit-Id: 1364a3c391aedfeb32aa025303ead3d7c91cdf9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ee22162ae5fa34ac70e4ae06330395409921c5c
Message-Id: <169716538950.12343.1196039392205999637.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Oct 2023 02:49:49 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 12 Oct 2023 19:09:35 -0600:

> git://git.kernel.dk/linux.git tags/block-6.6-2023-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ee22162ae5fa34ac70e4ae06330395409921c5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
