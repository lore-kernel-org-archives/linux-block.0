Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2F2C433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 22:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJUWvF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJUWvC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 18:51:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A9A18F930
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 15:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D53AB82D87
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 22:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E80EC433D7;
        Fri, 21 Oct 2022 22:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666392655;
        bh=fu0wCNu+2hRFp7EuBF/Z8OgwXT6yVZVEZQ4s+1L5Mto=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X43h9paqJVk5EKnCzTIPV5v8ia9O6/SS1Oq9QVRg1WUA2t5mBHRg0qQ4VMHjlBztn
         eIhbZzL5QaRCkuwIiAb5ZgkjBFpoxYsY75VguqjoEouDS6hEsX4zaSzlQyA43wE8IN
         jzguRckSOGScEGnn4govZ0aBqV1UfeoTWbQImDGGbbmWN1uALnLBB6aRhklHeoPbE9
         L6H1hMExHZQJyMLhUZHKcbLYKayFxstC59H8Ev8H9MQN5OAh2cee4DmAPysjBJZ4U/
         FisQ3ViF/KRPxmgjRByvUekeYToZI66OJxPWV7dd2+Sz7F+tdYrDRu0ouNBndo8v+/
         5WyG2pkV4WURg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB951E270DF;
        Fri, 21 Oct 2022 22:50:54 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.1-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <aee70812-c3a1-43b8-9d7a-92951e1d3d50@kernel.dk>
References: <aee70812-c3a1-43b8-9d7a-92951e1d3d50@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <aee70812-c3a1-43b8-9d7a-92951e1d3d50@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.1-2022-10-20
X-PR-Tracked-Commit-Id: 2db96217e7e515071726ca4ec791742c4202a1b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4b7332eef46ed403061e27b03c71ad26b2f5353
Message-Id: <166639265495.28861.14792840535375073181.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Oct 2022 22:50:54 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 05:02:41 -0700:

> git://git.kernel.dk/linux.git tags/block-6.1-2022-10-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4b7332eef46ed403061e27b03c71ad26b2f5353

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
