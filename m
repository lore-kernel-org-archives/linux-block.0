Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D866C2BB84
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 20:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0821420C09
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 20:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599252569;
	bh=tYqiK1Xe6f7EYzBcqQfmwIi+i1tWLNxPjSW3UT9wa3Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JTXjXqqJYggcWCNDvxejRQyn3YqO+ILgHaGN1JX6WygMWVq6ShSzJ+3TmL9pHdpsA
	 fGJ/fcCyqxknrhg6KvDavC3UVz5/5zPrzkYFrd9aeeEYC4VLCGiq1xMM5CTdYXxk+g
	 qyI1e3ZJMnXF7OXyYSEYz/vyQ8t6sKl8aNYJcUe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgIDUt1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:32952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbgIDUtV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Sep 2020 16:49:21 -0400
Subject: Re: [GIT PULL] Block fixes for 5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599252561;
        bh=tYqiK1Xe6f7EYzBcqQfmwIi+i1tWLNxPjSW3UT9wa3Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AGnXIVIXZW4acZk47rTkiC3k6R6T87nv8S+hOJYTzxh2Y+tX+MZn8IgItLCrhORde
         VOHAiULo4cLjiwoI2f9Emya/dWGa1HXqVoeCjPSMP4wGRPXYOldsczWhFL0h07YyUW
         rLbc7a9z6MB3swQ46ofYdwPvS0/Y7wMT8TpsOqyM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <48487797-7770-0c9b-2a6f-bd3b3dae86f7@kernel.dk>
References: <48487797-7770-0c9b-2a6f-bd3b3dae86f7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <48487797-7770-0c9b-2a6f-bd3b3dae86f7@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.9-2020-09-04
X-PR-Tracked-Commit-Id: 7e24969022cbd61ddc586f14824fc205661bb124
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8075fc3b113dee1531106aaec3dfa19c8158374d
Message-Id: <159925256140.25529.9506623681970593529.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 20:49:21 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 4 Sep 2020 09:23:42 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.9-2020-09-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8075fc3b113dee1531106aaec3dfa19c8158374d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
