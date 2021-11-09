Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CCFC4332F
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 19:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7A86134F
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 19:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbhKITeh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 14:34:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243320AbhKITeg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Nov 2021 14:34:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6E74C6137F;
        Tue,  9 Nov 2021 19:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636486310;
        bh=38zAKKzTeyEfRFoxX/ZfLFo9OAy2mrS2IyD9ZkWfuNo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OANQnZmzpysh3FK5179NIlpdEz+m4b0zcrZwZcN7Y5Ugl5AMSrTjLe7bbUUnEovIf
         1ZfZEjrKkI0iGwnCYrc1T4eztncYKstFNbCjkbzqJApcU0m0olSWJcH9osfpdNGLgi
         8a1pFNVuWxFyo3melhLZxP4BfC/hZ2q8qzoOU0UmJiRhDYsRR525NbghfvrIlpQ+tb
         jCmxEK/Lesd1aHokt2fDUkuFE+vSfAbzJqppBZ8vn2PDLpcj6BF43+WFxGUam9RqTE
         kkDwoadfwcHHqtRiYbvC1kZKMxWEzkawdbuturcrpUEfvMtJYdmZ/dU90pw0vO+4C4
         obY8j6f+8CK/A==
Subject: Re: [GIT PULL] bdev-size followup
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0b1a05ef-c234-5839-6a73-0e5bf7634526@kernel.dk>
References: <0b1a05ef-c234-5839-6a73-0e5bf7634526@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0b1a05ef-c234-5839-6a73-0e5bf7634526@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.16/bdev-size-2021-11-09
X-PR-Tracked-Commit-Id: 138c1a38113d989416df57e9f8973c10c9e1fa04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dc1f92e24d6a5479ae8ceea3e2fac69f8d9dab7
Message-Id: <163648631042.13393.5215065168690175689.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Nov 2021 19:31:50 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 9 Nov 2021 10:06:40 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.16/bdev-size-2021-11-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dc1f92e24d6a5479ae8ceea3e2fac69f8d9dab7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
