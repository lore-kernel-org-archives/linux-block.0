Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC41C4332F
	for <linux-block@archiver.kernel.org>; Sat, 20 Nov 2021 19:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhKTTXS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Nov 2021 14:23:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhKTTXQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Nov 2021 14:23:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EBC3B60D42;
        Sat, 20 Nov 2021 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637436013;
        bh=enrqfuQ7hmdA4ZGQbtwtkGN0WuO1L9LKZC+oYXE0MPk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JzyGzJynOTPRSLUbnOBQBShCdatHec4jq5JbMycmGWr59gTNWdA6y/onfYSYE8CuA
         1pPr3wPizCyM1UMq4jsRoERenUaPL4X3iVYJUi6dBC6LtoC84FKvhTBuTiQvwoHR/Q
         QiqpzzdKjUfXfZDHfaRAxNXWUWRdG6G91h3R0ER9V1aptBLufj5xEjpoEjCBARED0l
         MVtPU+PUBfXVKjvHqt7ZvyEcmskfYmo67mdleD1OcePIjIytKybr1MyJZBcHNK5pnm
         +UVAAu1Cgw3X03Ogt8tr9v5s3lAAd4gh6xMAiv2ZeIV5mY1mBnHgynM+2jw9xqSEKt
         3fRkmm9ZSxlew==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E4D7E604EB;
        Sat, 20 Nov 2021 19:20:12 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5db84f8b-877c-230a-2b1d-f83109d886c0@kernel.dk>
References: <5db84f8b-877c-230a-2b1d-f83109d886c0@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5db84f8b-877c-230a-2b1d-f83109d886c0@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.16-2021-11-19
X-PR-Tracked-Commit-Id: 2b504bd4841bccbf3eb83c1fec229b65956ad8ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61564e7b3abcb67d57b09afdb4b14b85f8bc1976
Message-Id: <163743601293.29153.9853970559803111988.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Nov 2021 19:20:12 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 20 Nov 2021 09:17:31 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.16-2021-11-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61564e7b3abcb67d57b09afdb4b14b85f8bc1976

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
