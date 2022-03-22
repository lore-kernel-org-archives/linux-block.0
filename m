Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61030C433FE
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 00:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbiCVA1g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 20:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbiCVA1f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 20:27:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2D43507D6
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 17:26:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7E99B81AD3
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 00:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BB8BC340F0;
        Tue, 22 Mar 2022 00:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647908758;
        bh=pK0eYSmR/Hkcfvvm+9DyjHAJ86/GLdSAXkfX8BeDaks=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fnAH/oS7oAtgQt9xMtmrZUSufm+HfGMfrX1qrguu8AuDhLcCJn2sxWE9VsZycrbyb
         NKUuo0SE/xUByCrWGwfCZH4g0ogRTlBBSEk0cXhkL0OVlTzemKa9/Te4KCkH7ZPtCS
         3ENVz0CgUy9YqkaQQS1TMCcrdVOkNjm7FQorhqEmZM5BfvKy5dgu+gsk0edBLKRehw
         7Ij24f+qBFfbi1AU8td1G3jsFPZwbrEYBrbSWD/3GKINPzvSVTmPksUFm7zvkgfqOa
         xk6txfJlccdcrpTfrA4LzmTMwuJVwSsQwhjJOzK3pSKxjmxwLj9SQ1aWk8s0o1A0cF
         omg2PM298WBEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B7AFE7BB0B;
        Tue, 22 Mar 2022 00:25:58 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e54f7c1a-90d1-1886-cbb4-6a78d490f0a9@kernel.dk>
References: <e54f7c1a-90d1-1886-cbb4-6a78d490f0a9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e54f7c1a-90d1-1886-cbb4-6a78d490f0a9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.18/block-2022-03-18
X-PR-Tracked-Commit-Id: 8f9e7b65f833cb9a4b2e2f54a049d74df394d906
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 616355cc818c6ddadc393fdfd4491f94458cb715
Message-Id: <164790875837.30750.1788351096809595088.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 00:25:58 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 18 Mar 2022 15:59:25 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.18/block-2022-03-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/616355cc818c6ddadc393fdfd4491f94458cb715

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
