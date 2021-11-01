Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71100C433FE
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 17:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B2760FC4
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 17:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhKARb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 13:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230321AbhKARb0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Nov 2021 13:31:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 30DA260E52;
        Mon,  1 Nov 2021 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635787733;
        bh=bI61pdt08vh8MTLOrrlBnCBY1xNt4cmu6IlWhzCDEk8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HfZhPgqmxBwIwbG169S5QZ7dzKG4oylgmrgA6dN4PEpU5QXH3yIibSncpkseBRYcR
         V/Jw7MAeODT75FBRDjeSxZbA7SKhzw4kFZT6kHEVhbThOHnXBOFwdYmANE01Kgp5sE
         fth2FOoueipsFn3kAzJUqNm8y7Py5u2f/i5gJgxMgTfC5lK/7yHkFIKmwUP9odklmC
         sGedCkV0L2GWFQllkIvs+7YNh0uSkdHFA/2ZBIqTkpIo12Az66W8pXCPF6ifd26qxx
         Rw66BKSpTv1SZBb03LT7kQuxDnrBhlhTPGwNFd13YAwfOyTJ2J6lpb1TrcClhptHLu
         JRCchUIUA3Ivg==
Subject: Re: [GIT PULL] bdev size cleanups
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f870c029-140d-3e77-dcd1-1890025b5795@kernel.dk>
References: <f870c029-140d-3e77-dcd1-1890025b5795@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f870c029-140d-3e77-dcd1-1890025b5795@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.16/bdev-size-2021-10-29
X-PR-Tracked-Commit-Id: 97eeb5fc14cc4b2091df8b841a07a1ac69f2d762
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f01727f750eae3e61b738b57355b2538ab179f4
Message-Id: <163578773315.18307.10696461940630948455.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 17:28:53 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 31 Oct 2021 13:41:51 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.16/bdev-size-2021-10-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f01727f750eae3e61b738b57355b2538ab179f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
