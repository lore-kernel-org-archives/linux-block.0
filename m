Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0D0C433F5
	for <linux-block@archiver.kernel.org>; Fri, 30 Sep 2022 16:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiI3QiY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Sep 2022 12:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiI3QiW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2022 12:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD8F1739FA
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 09:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1199623D5
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 16:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1281DC433D6;
        Fri, 30 Sep 2022 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664555901;
        bh=p5mKqGXiFEecvU7/DWkKj/05cwBNwPQYeHBeKff32O0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ROdL2ddVz/phmKCVxFWmhNBHvy6Ml5UmXKRtwfDsCaGVxcW7FyCNEIP2sPPUXN2GL
         l34ygpP89bZeH0BNyy0HR8fxADV8bAn+cF/vDemzJiMlnQd5FI8Qot1LLsaQgDGypd
         S1cMQZfCzplgUwcH4N7/04dCNvNFZpwgruXGw+vPduI3CDweMa7E/kokS7tajO5oiY
         qGkwiiiqu8MA76N/KR+0dv0XHiodNNy8gSpYjYyisscpwKb2nJGFP59pUckbva+G2y
         RQFJlVul+wOVQ+RHBCyV2sbAJ9CRb4KmLpPHBKOV1AK3NCjzgz9fxR1+pJTydJOuBO
         jeetX9l0wwKMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 006CBC04E59;
        Fri, 30 Sep 2022 16:38:21 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.0-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e5c2a0e5-1a04-50b1-78f0-08d998a8d4e7@kernel.dk>
References: <e5c2a0e5-1a04-50b1-78f0-08d998a8d4e7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e5c2a0e5-1a04-50b1-78f0-08d998a8d4e7@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.0-2022-09-29
X-PR-Tracked-Commit-Id: 6c84501a3c38adaf1c3486fb80b972f728ad8fd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bc6e90d7aa4170039abe80b9f4e8c8e4eb35091
Message-Id: <166455590099.13600.978141470278001046.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Sep 2022 16:38:20 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 30 Sep 2022 07:43:08 -0600:

> git://git.kernel.dk/linux.git tags/block-6.0-2022-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bc6e90d7aa4170039abe80b9f4e8c8e4eb35091

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
