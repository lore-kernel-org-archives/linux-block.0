Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FD5C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 18:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiFXSoR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 14:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiFXSoQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 14:44:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A0D7FD15
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 11:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F29B862094
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 18:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 500AAC385A5;
        Fri, 24 Jun 2022 18:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656096254;
        bh=SbsolmzwIQkQ8AIA4JIkulBo5WqPkUQ/WqTYN/sAHhQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aUsoxv2dvxEI1L16HEZLJ3z7MEkCbMhRWX2f3AZLCXVZpBUsF30BdYXldjl8AiNSW
         2gFzzHNub2LUF7BQ/96acNZf9kDZAyqLC/+2Ru8Jgq1sBbXPqAhNsNYwCDBBy2Gsg6
         i0XOUyjMwZF9vcRou7kqqJe7ohpILT3Loy4JPQ9J36T56KXAunChxd4nLIn41vJLBl
         5WrcNJuDdPxpcLwW3NvighT2BGpGYsPyYOAJGOw3y2d7mQIIbC8Fee3I1LiYALrzt5
         j3Soe242CCC5zr2UszUdLdkinhAktvWii2ErmPG1BNiiYXCCfjmI5d6dj5TosGOEex
         TpyjZWUmr8cFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C4ECE737F0;
        Fri, 24 Jun 2022 18:44:14 +0000 (UTC)
Subject: Re: [git pull] device mapper fixes for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH6w=awrSaC5zmPEwR95mr02wtU5ti4qjXa-DiwpVe6XmzzcLQ@mail.gmail.com>
References: <CAH6w=awrSaC5zmPEwR95mr02wtU5ti4qjXa-DiwpVe6XmzzcLQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH6w=awrSaC5zmPEwR95mr02wtU5ti4qjXa-DiwpVe6XmzzcLQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes-4
X-PR-Tracked-Commit-Id: 90736eb3232d208ee048493f371075e4272e0944
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbe232ab07ab7a1c7743c94c53d0e0d50c3d1b88
Message-Id: <165609625424.26462.3009878470008500976.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jun 2022 18:44:14 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 23 Jun 2022 23:22:16 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbe232ab07ab7a1c7743c94c53d0e0d50c3d1b88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
