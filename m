Return-Path: <SRS0=iUg4=CC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D755EC433DF
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 19:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972BD20578
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 19:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598296883;
	bh=A+kmnjrDJh76Q2+i18zjGXYzNGqzMOtqPGgNpN7KN0w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SmMRZ1zj/DnutyTQkAFd3085NvDzQDo4V/+KQ81R7baeOy9vyfgHhx0Ve+Wi4GD8L
	 tpn/AAg02WSuum0Rybh70AZNfQul1DO2aqp0G6MQuZoA9/qilLt5RSugd5O+o2kqBW
	 lszr6hQDAqAvrO9PUMbv5X3bL/Jb/emSKnFHtMWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHXTVW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgHXTVV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 15:21:21 -0400
Subject: Re: [GIT PULL] Block fixes for 5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296881;
        bh=A+kmnjrDJh76Q2+i18zjGXYzNGqzMOtqPGgNpN7KN0w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qOgZnr5ElyrQvgHuOeGTYQT/k5c1s+BiYC8UuZ3ht8xM+gNkehFUkUzgUyNSI0y05
         dEJHbnfvx79ZwnZU92T+t8eYiR6Wn8JWPUKCgBaLq2JLd+puxE5fv//6nRO6/HBSWI
         juaw4bPntEKFwilH0c4g+GSCf7XV++zywnp3NU+s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4945e1c2-a6dd-2827-e7ff-db7aa7ee3bec@kernel.dk>
References: <4945e1c2-a6dd-2827-e7ff-db7aa7ee3bec@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4945e1c2-a6dd-2827-e7ff-db7aa7ee3bec@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/io_uring-5.9-2020-08-23
X-PR-Tracked-Commit-Id: 2d62e6b038e729c3e4bfbfcfbd44800ef0883680
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c41c3ec4a2bcd3f24ab753bb337ec342f24bdf94
Message-Id: <159829688136.31349.13835887894434451471.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Aug 2020 19:21:21 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 23 Aug 2020 13:27:48 -0600:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.9-2020-08-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c41c3ec4a2bcd3f24ab753bb337ec342f24bdf94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
