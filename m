Return-Path: <SRS0=UEoe=DD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D0EC2D0A8
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 18:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 347A72151B
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 18:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601144638;
	bh=D0N9HyNUe+A7FCELht4oV3ouTy4AvqMneYdq4HFweiw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Kn1hYsStIkkBoCYnJRNWQZM79mdyl+BJ63GKnqZh6rIvbnqysKsdpduzQQ9RC+dux
	 P/L5AZSfN1dpykSrNcPGYKthDmDbLBdCn0ZVSiB7zV3T593bPU0vNkSWbjT0mth7pF
	 bSla16BVQV67+M7EJkYbGVuhY0ThCXKwjsKMjZMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgIZSX5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Sep 2020 14:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbgIZSXx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Sep 2020 14:23:53 -0400
Subject: Re: [GIT PULL] block fixes for 5.9-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601144633;
        bh=D0N9HyNUe+A7FCELht4oV3ouTy4AvqMneYdq4HFweiw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1ElZhItgrRQ04RhqahR+y6refZr0SfzePz6eYTG4ZFaDzDBd+XYAJ/3bRpNNJV82y
         qA6jAou9NEylSKZFR/zb5/3QbEpMXnGR4x0AJFh9EfXC5gBA8+QLKxFKmjf6w5orsc
         9u/iF/AAXOR7k5Vy7RMHDTH3qUZofelf8et8Rxj4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a43f5477-7da2-f4b1-bb61-3c1b613da334@kernel.dk>
References: <a43f5477-7da2-f4b1-bb61-3c1b613da334@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a43f5477-7da2-f4b1-bb61-3c1b613da334@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.9-2020-09-25
X-PR-Tracked-Commit-Id: 3aab91774bbd8e571cfaddaf839aafd07718333c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d2fbaefb3b049772b468447ed427204789ea9a5
Message-Id: <160114463355.21242.4236001132235807478.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Sep 2020 18:23:53 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 25 Sep 2020 20:23:42 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.9-2020-09-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d2fbaefb3b049772b468447ed427204789ea9a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
