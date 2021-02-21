Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3687BC433DB
	for <linux-block@archiver.kernel.org>; Sun, 21 Feb 2021 19:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF636500D
	for <linux-block@archiver.kernel.org>; Sun, 21 Feb 2021 19:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBUTPg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Feb 2021 14:15:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhBUTPe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Feb 2021 14:15:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D02CA64E00;
        Sun, 21 Feb 2021 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613934893;
        bh=WINASJuw3P1RU7a2BEm1hup510gUFZE2csZ1R30DOAU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MwT4a0PsFdA2wiCZtHg8vVAkkTAv1149WX6d71o8BSyyvHhfLJqB2WaCltFCdXiZG
         JZylDfbfCov6bXZgTMj5VhDygVrJE+HWzK7Jj8yFPOQzCGG1Gu5AhfNJWIBpuGJdSN
         beSLY70LsXHHlrrusyIyPW7yXbuQ3fQEn44hKeYxeFbW82wV0KWmbDF2L60YxXiFbx
         4NWsdHM3Kvm2W2Kzc/AVmr9h7jbwWFtDifIVGLyIQ28/Ct1rgtrJsXX5MJfc3vqfE+
         TqMlYpsYhYacGVn7LiSwmjFDDLZNGmBvetYSjpRmVu7KJTYGcOI0Q0YO8ZsYiKBmh5
         g2VomgFYjJfTw==
Subject: Re: [GIT PULL] io_uring changes for 5.12-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6626be56-907e-83fe-2fbb-45f880261fd8@kernel.dk>
References: <6626be56-907e-83fe-2fbb-45f880261fd8@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <6626be56-907e-83fe-2fbb-45f880261fd8@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.12/io_uring-2021-02-17
X-PR-Tracked-Commit-Id: 0b81e80c813f92520667c872d499a2dba8377be6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bbb336ba75d95611a7b9456355b48705016bdb1
Message-Id: <161393489382.9182.9152701289455692038.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 19:14:53 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 17 Feb 2021 11:43:20 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.12/io_uring-2021-02-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bbb336ba75d95611a7b9456355b48705016bdb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
