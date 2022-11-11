Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FCFC433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Nov 2022 22:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiKKWQl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Nov 2022 17:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiKKWQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Nov 2022 17:16:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076014C271
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 14:16:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AD616210B
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 22:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09376C433D6;
        Fri, 11 Nov 2022 22:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668204999;
        bh=bHKFgDN1dlyblJD686ZDjXI/gbZ8OJEzdOpvqhVDaOQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=prPwx4oXBFmRyoQoSkwgi+KYZpgR2yz7hLbm5nYOsNTX5H87E+N2fKYRwN0g1aON/
         kiWDSwWkO45dk6uX901+bjDY/myhruAHPD2FQgn901fA2NyNm6IVE7Tef3tzRl/64F
         XZrZkLQSsiJ0brgPx4l7S5/0w0j8Qj46+6hJG2kpMrVsuiTNEsFngypickbwidg+U+
         Qyc8551K5h7PPH8L14rNy9QKNocDrHb9Gq8qnEBoDxjsT0ke5uVUGHT8nELp+odYgh
         BF8rTg7k8SKO+YYV0GzJSaEIpMhqC83KY2VuJj2uX8iGPhKyCeinUvZmPqoADrM7hO
         KLsrKSx36/OZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED1DEC395FE;
        Fri, 11 Nov 2022 22:16:38 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <38f29c47-61fb-3882-a054-a577ec41996c@kernel.dk>
References: <38f29c47-61fb-3882-a054-a577ec41996c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <38f29c47-61fb-3882-a054-a577ec41996c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.1-2022-11-11
X-PR-Tracked-Commit-Id: df24560d058d11f02b7493bdfc553131ef60b23d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0b6e2c9d3543c0926a7df5ee6e36507ad491dea
Message-Id: <166820499896.19426.8199753613534225131.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Nov 2022 22:16:38 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 11 Nov 2022 13:53:08 -0700:

> git://git.kernel.dk/linux.git tags/block-6.1-2022-11-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0b6e2c9d3543c0926a7df5ee6e36507ad491dea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
