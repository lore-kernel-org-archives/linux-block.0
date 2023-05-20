Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264A5C77B7F
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 18:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjETSdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 14:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjETSda (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 14:33:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7F91712
        for <linux-block@vger.kernel.org>; Sat, 20 May 2023 11:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA5AE612A4
        for <linux-block@vger.kernel.org>; Sat, 20 May 2023 18:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57A50C433D2;
        Sat, 20 May 2023 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684607495;
        bh=W6+ahIKr+DysNSSOzpT+7TFm2KysklrZeARYWExrBX0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oYDSv2MhSywdy+UaF4NaWlKKgoBaPD6IVz/suHgp2E/ulm6bg9gRDtOHqHyQILRK7
         lrPUd9xYG7qYWyga/yzzTMgdz3Y9M585Komu2ZzPXl7p2ycsOdNDJJp/cE/YznFvSd
         OjOdLFCwWThDrIihphAyl7IcZ5B3KhwT3CSjuMhyA8mOypdUN7BS/xKgVySZLHVfH7
         HJebpa9VA5498dq1cZ8YaMwvGw0qjVXTLvlyLvS3XANtanWP9HlYJite+TpkU3fKgA
         Gu2khFS3pAHIa1/Ybqe06v6rjmPR8JuWYVJpslb0Pk/+ID3ws79Dj6ISSqIJToW0XJ
         bh2T4aF7gEFLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43D6CC73FE0;
        Sat, 20 May 2023 18:31:35 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <26d11955-8978-1be6-628d-4b8ecda5f6a8@kernel.dk>
References: <26d11955-8978-1be6-628d-4b8ecda5f6a8@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <26d11955-8978-1be6-628d-4b8ecda5f6a8@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.4-2023-05-20
X-PR-Tracked-Commit-Id: e3afec91aad23c52dfe426c7d7128e4839c3eed8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98be58a6e9310fbfa757d438b0b51f857ce17ee4
Message-Id: <168460749525.29791.8330925647482406935.pr-tracker-bot@kernel.org>
Date:   Sat, 20 May 2023 18:31:35 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 20 May 2023 06:03:13 -0600:

> git://git.kernel.dk/linux.git tags/block-6.4-2023-05-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98be58a6e9310fbfa757d438b0b51f857ce17ee4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
