Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C46C433F5
	for <linux-block@archiver.kernel.org>; Sat,  2 Apr 2022 18:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244777AbiDBSMh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Apr 2022 14:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244728AbiDBSMg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Apr 2022 14:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7048E1AF1B
        for <linux-block@vger.kernel.org>; Sat,  2 Apr 2022 11:10:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D7D160DE7
        for <linux-block@vger.kernel.org>; Sat,  2 Apr 2022 18:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71092C34112;
        Sat,  2 Apr 2022 18:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648923043;
        bh=9NtBmr4TY9XkVXU7aYDIQVMsXcx0YJiPE9mRBJ4nhf0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EknMOIwufAOAv1R9K1kLbzvUrSohoAc4BOY20XIdy7HNmGmfRxBa5ekvLsV0jAE0i
         veWzxhF6YpGo5nr5YQ3jQKzqwGAgAhuGN68esBEAMz1lyQeDN7ne3brfGrZsrIf/GM
         3IhuRc2VamTWCB3k4/q/cZC1/jnppnhTSNC3ZVl50kO0RsR8Hu8zW3/DlDD3eITRMQ
         fa+YzQEi0p1Ut18c4Yer31gDdW2zJXPEIoXJDVLkzCd8u4Wd/KkU83/LlxCOkBIsdX
         z0E1cRV+zK/xXoR92LLKtwzTL0s1o96pjF144oLeie6TuQRtVRIJbYOmWPuIhmsKjc
         8UBh3eYnikLMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E48FE6BBCA;
        Sat,  2 Apr 2022 18:10:43 +0000 (UTC)
Subject: Re: [GIT PULL] Follow up block driver fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6a73de2a-5cba-edd3-ecec-e0206f158b2d@kernel.dk>
References: <6a73de2a-5cba-edd3-ecec-e0206f158b2d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <6a73de2a-5cba-edd3-ecec-e0206f158b2d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.18/drivers-2022-04-02
X-PR-Tracked-Commit-Id: 7198bfc2017644c6b92d2ecef9b8b8e0363bb5fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f34f8c3d6178527d4c02aa3a53c370cc70cb91e
Message-Id: <164892304338.15050.11832608955545328208.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Apr 2022 18:10:43 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "Gabriel L. Somlo" <somlo@cmu.edu>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 2 Apr 2022 11:59:19 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.18/drivers-2022-04-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f34f8c3d6178527d4c02aa3a53c370cc70cb91e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
