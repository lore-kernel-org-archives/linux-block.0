Return-Path: <SRS0=BT6h=UB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E922BC282DC
	for <linux-block@archiver.kernel.org>; Sun,  2 Jun 2019 16:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF75027970
	for <linux-block@archiver.kernel.org>; Sun,  2 Jun 2019 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559493018;
	bh=J3hQPapPGdsCEOxewun+voBab3J4VNn0Dsn+ohM1TWE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ktjUfWpxPQ0v6IPp1EtSwYIjbm9Njoq+p5p6tGy3H6Go4qLi5UGr10ul0zQgCnzIA
	 akJJJn2VWChihd3re0rR0uMUtdYcdv5T2StpSgXD6XOADKL/GHNvS5wxtiRHalXXZ0
	 Yrq7SRGRkdHqGY4b0OGnDeF+9SIVR18KrsHGGIRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfFBQaR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbfFBQaR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 2 Jun 2019 12:30:17 -0400
Subject: Re: [GIT PULL] Block fixes for 5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559493017;
        bh=J3hQPapPGdsCEOxewun+voBab3J4VNn0Dsn+ohM1TWE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=if0tJ8LJXM6n44mwyazESIbr1Ecu78Sk+FaSuUH1XhJAIosNkbY19P6ZADw7OuwQX
         s5KvSw80LwZuf9y893hJ92F0YkOfmALTFul5K63afXl/wBGP/T1WN5gAK/oB0ESRFE
         fTn/arN7yDUx7twoCo6neqm7rgrVwDeTik8i7mn8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b08832e3-1ae2-1c9d-7b82-0b31fb4ece62@kernel.dk>
References: <b08832e3-1ae2-1c9d-7b82-0b31fb4ece62@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b08832e3-1ae2-1c9d-7b82-0b31fb4ece62@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190601
X-PR-Tracked-Commit-Id: 61939b12dc24d0ac958020f261046c35a16e0c48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9221dced3069cc9ae2986ba1191b02dae560df28
Message-Id: <155949301694.9110.17740754518312812381.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jun 2019 16:30:16 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 1 Jun 2019 11:20:09 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190601

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9221dced3069cc9ae2986ba1191b02dae560df28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
