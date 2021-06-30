Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370A4C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 20:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F4361457
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 20:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbhF3UXd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 16:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233847AbhF3UXc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 16:23:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7780961456;
        Wed, 30 Jun 2021 20:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625084463;
        bh=sMMBuy53ACXNykMc2AEvFAQutymZs09k+dHkRodjJY0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jn2GOTJIl/clZuaKZdpkROC6FolJDyhimsTAqCvTRMLKCI8DeF/bM9ALpxn9NYryU
         X0IQrVU5CIShJve3MByTOwQLwVkoLuv2OJv0wrTbzhBZgGJeBNzRNpfzDAKZBqtOJA
         Ea+RxNs7azsXWnIgUgSbjzfoRexdAqIrAbc1OA6+dAgnUq9sEvdbW413uX+OpKzWfz
         LjS3V0fSwrWUE9XqSaSo4o6DkKFPx4n8QZpl+TMRVv85UacMitb1BsCMgI/nqMjGeA
         JmIKIQ4c09vptxG2X2rkskk2w9v+YKnPkq6f8CqOoWvtNnUjGOZYEVh414JgaUJfNB
         RfSdY6FTp9Wzw==
Subject: Re: [GIT PULL] Core block changes for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ab2255de-8bbc-8c6f-7309-25cbb506000f@kernel.dk>
References: <ab2255de-8bbc-8c6f-7309-25cbb506000f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ab2255de-8bbc-8c6f-7309-25cbb506000f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.14/block-2021-06-29
X-PR-Tracked-Commit-Id: 2705dfb2094777e405e065105e307074af8965c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df668a5fe461bb9d7e899c538acc7197746038f4
Message-Id: <162508446334.1549.4556852608635303909.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 20:21:03 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 13:39:34 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.14/block-2021-06-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df668a5fe461bb9d7e899c538acc7197746038f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
