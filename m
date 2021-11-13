Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4976EC433EF
	for <linux-block@archiver.kernel.org>; Sat, 13 Nov 2021 21:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9B061057
	for <linux-block@archiver.kernel.org>; Sat, 13 Nov 2021 21:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhKMVG0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Nov 2021 16:06:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232203AbhKMVG0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Nov 2021 16:06:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 952F260F6E;
        Sat, 13 Nov 2021 21:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636837413;
        bh=HWnNO4LU0DnBNojWP2HcKvdWCt/pSB4cbKvwws5PQ0I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KQ6nc69Mt5/I71lJ+KbAbHMyDaD8FpIqtmsnEUwB6Ar/ZC18MIEHXWUkrApzTFbit
         gpJUveyEAuvtZnUKUWCfmFLcrHFljpXXvqf4PsDX/9ZYgqpg2rMWnpAN5giJwvC+bW
         hOr9IKgWpv/QPoJptyBZCeVTaEYKxF5jbETLa0IpTzvc+f2OOIRWpple0tr1vkINss
         SWU2pTHBADdq2xcoYZwZ0Qk2BfcJkhxLI8VYlkZ2FfIHtgRhfgOZWTwmY9ldrQqOWQ
         bzZo+d8nYlV+w9Q2ja0aQg+fq6RY+0XEBTYimB5PQ7twYCGH5jLf2CAi5OaWUF4TUH
         FgFBBnGKE1kFw==
Subject: Re: [GIT PULL] Block fixes for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <095f684a-8928-5f91-3382-a8e38fbc8c35@kernel.dk>
References: <095f684a-8928-5f91-3382-a8e38fbc8c35@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <095f684a-8928-5f91-3382-a8e38fbc8c35@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.16-2021-11-13
X-PR-Tracked-Commit-Id: b637108a4022951dcc71b672bd101ebe24ad26d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f44c7dbd74ec1527744e1f673e60265b6f5fd084
Message-Id: <163683741347.30883.12736410795777227494.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Nov 2021 21:03:33 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 13 Nov 2021 09:51:05 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.16-2021-11-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f44c7dbd74ec1527744e1f673e60265b6f5fd084

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
