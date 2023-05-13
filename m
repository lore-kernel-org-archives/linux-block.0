Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6697C77B7F
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 15:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbjEMP3T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 May 2023 11:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEMP3S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2023 11:29:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C1C2D78
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 08:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 517CE616BD
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 15:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B96A2C433D2;
        Sat, 13 May 2023 15:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683991756;
        bh=qeem/fMLu/3tlu7M46AKe2EvIIRHRdO8OpPy7KA/V/I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HQb/DLfAd5Bq5t7H7FoUcfISWpGYzXhJdVOyOfxHaXof5oJM/6d1gNoaBA8CL7EW7
         LW2uMV+W3CTEauAtGd5+E9JlojJBXjrv0xBHWCjSizgHbdQ7taiKuIQ9bJa4IUOdXw
         k+921EQA8HiH9Ft9HMjRR6hzZIpuWYZXQ1UWatuw6K3RdrMKagAT4UvlWsZQukwiyx
         CHEgM2j4G6wThXI2nVCLehBC0C1k+GMr0vrtasEd4TasfyMCFCr1Yz+cARwBhU4IER
         qvapxVIFbT6rvY46pDluClAt3DIFP3g6fSINt2J5Ju5aSuLFNTPGRCvOkpZDUzCtUw
         ftaJqzWCPPEbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A64C1E450BA;
        Sat, 13 May 2023 15:29:16 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c27ed42c-50d1-ac5c-bace-ca98c8d598be@kernel.dk>
References: <c27ed42c-50d1-ac5c-bace-ca98c8d598be@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c27ed42c-50d1-ac5c-bace-ca98c8d598be@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.4-2023-05-13
X-PR-Tracked-Commit-Id: 56cdea92ed915f8eb37575331fb4a269991e8026
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4d58949a6eac1c45ab022562c8494725e1ac094
Message-Id: <168399175667.14080.16409913101587083693.pr-tracker-bot@kernel.org>
Date:   Sat, 13 May 2023 15:29:16 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 13 May 2023 07:39:00 -0600:

> git://git.kernel.dk/linux.git tags/block-6.4-2023-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4d58949a6eac1c45ab022562c8494725e1ac094

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
