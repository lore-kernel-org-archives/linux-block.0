Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE87C433F5
	for <linux-block@archiver.kernel.org>; Sat,  7 May 2022 18:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386806AbiEGSPr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 May 2022 14:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446783AbiEGSPp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 May 2022 14:15:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568332ED6B
        for <linux-block@vger.kernel.org>; Sat,  7 May 2022 11:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8535611A9
        for <linux-block@vger.kernel.org>; Sat,  7 May 2022 18:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DCDDC385A5;
        Sat,  7 May 2022 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651947117;
        bh=ZlZadjjfMaZezjT1wNXhNY+bZUT/w3pL+m7wQWaKY/Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lM5rxXhhWwk5BwYHk4wibKNrWjVyb2VYKFY5BbDveQZ9uFLxsBL3YEIF/xnc0oItY
         rk2Vte9fsUsyyZolGwR9plPPAjmvHzzpKxrql0M87/cvl4CF4cxIGOo80mM5kbGY+p
         MWFt6aU8Ns7LdULo4AWoufCPCvvvWnO09Miuq4Ru5djjPT8j9qCUtsfVxfBQupLh7x
         lfxDLVBLnuhHfvIGGEHhNvy0mYZsp0WBw7IXWcvh+w7cAlAORM2O4YNDz+VGTgkyYT
         3GUrbJcSAspWmnVW8ovzzWhmIGUrRw3Stx0zj4fEvO5tcAdzGl1DF+RAQZrqiujLlF
         rDstBM1inVJEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B27FE5D087;
        Sat,  7 May 2022 18:11:57 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c9ef8d83-8f8e-0b03-b197-bd6d6105059a@kernel.dk>
References: <c9ef8d83-8f8e-0b03-b197-bd6d6105059a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c9ef8d83-8f8e-0b03-b197-bd6d6105059a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.18-2022-05-06
X-PR-Tracked-Commit-Id: f1c8781ac9d87650ccf45a354c0bbfa3f9230371
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8967605e7db37a46df69cecf42be2c68774f245c
Message-Id: <165194711730.12019.15927030665958016945.pr-tracker-bot@kernel.org>
Date:   Sat, 07 May 2022 18:11:57 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 6 May 2022 20:10:57 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.18-2022-05-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8967605e7db37a46df69cecf42be2c68774f245c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
