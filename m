Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFDFC77B70
	for <linux-block@archiver.kernel.org>; Sat, 15 Apr 2023 18:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjDOSLg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Apr 2023 14:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjDOSLe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2023 14:11:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80654232
        for <linux-block@vger.kernel.org>; Sat, 15 Apr 2023 11:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C8DC612FB
        for <linux-block@vger.kernel.org>; Sat, 15 Apr 2023 18:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B184AC4339B;
        Sat, 15 Apr 2023 18:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681582292;
        bh=ht8zQClR1hXMzh3KD5d8Tw8QvL9RzPi4mMgpxlwFLdA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l0y8ZSHfzMPSysy8czj2byC8t7hf4XJHZd5gQIE30X2KnibVCYxjOdYDm3Bsyj88w
         RJYoldR6uUXvu8SpyHFJkF8yTHm1YxGqx/j3d3rDLMhprbOeraZERnJAOx9vBURDDM
         zSHG1+x8y7rRTpy49LDcZzI2x3r7DL8OXeoLmGU/2ybB/p4fI02Hls2HNbCO8sXMCE
         erL3PCv/pMy6LCcxdvHT8hIQITrbM/Ov87Z6KlM7ecFk8Acm+BBZiFZ4gONn6gAH2G
         NstH0xp/BUuhZUeNg1KkpsCYSslaJBEFIcQm0RSObrGMPfeXej70FcF8XnaJK0GJfN
         SbENSdF01AVUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9FBB9E52446;
        Sat, 15 Apr 2023 18:11:32 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9d88e759-5201-82c4-792f-dcb6e29c808a@kernel.dk>
References: <9d88e759-5201-82c4-792f-dcb6e29c808a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <9d88e759-5201-82c4-792f-dcb6e29c808a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.3-2023-04-14
X-PR-Tracked-Commit-Id: f7ca1ae32bd89ab035568c63b4443eb55420b423
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cdcc6696d22dbb8fa2982d523d17f6ad2777d0f2
Message-Id: <168158229265.18559.17663123145925182633.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Apr 2023 18:11:32 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 14 Apr 2023 21:43:48 -0600:

> git://git.kernel.dk/linux.git tags/block-6.3-2023-04-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cdcc6696d22dbb8fa2982d523d17f6ad2777d0f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
