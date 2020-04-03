Return-Path: <SRS0=iNmo=5T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987A9C2BA17
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 22:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFFA2078C
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 22:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585951521;
	bh=so1DVV6bVyhmyWePOLc1tNq9C3B7Ary2Yk4rPEcgJiE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QbptXfuTxnqhnzL+ZiEeC6cp/IZO7w3AmH5zBXRq96B9FyoybBaZSL4li1UMCsHFG
	 7FSVFHsc9EXkQ54hfRvZzLrxtDGyvfAU3on9PU10kEJkMvltIVa7AGtXrhzyvAPRn2
	 brrEDLmYJHVJVboK3LAb+dW4FMax/nIylGAipVdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgDCWFU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgDCWFS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Apr 2020 18:05:18 -0400
Subject: Re: [git pull] device mapper fixes for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585951518;
        bh=so1DVV6bVyhmyWePOLc1tNq9C3B7Ary2Yk4rPEcgJiE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Fmybmimj0puY14sXDfVsRXVkipb9vkUBpp/31B0vTqwm14kS4BrlMCXwIK+jhZkkc
         Im73DWZ8p+hhidLveX4U6iPhJCC3OXlxOgBXE2ZXT0m2YuMQa1wH5qHWcIrnhC1HfV
         nn7TSvkZCCEKprMt+HBiQyYc+8AgSxZgouQGdmbc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200403154213.GA18386@redhat.com>
References: <20200403154213.GA18386@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200403154213.GA18386@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.7/dm-fixes
X-PR-Tracked-Commit-Id: 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8267d8fb4819afa76b2a54dca48efdda6f0b1910
Message-Id: <158595151814.22871.4596476609800873653.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 22:05:18 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 3 Apr 2020 11:42:13 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.7/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8267d8fb4819afa76b2a54dca48efdda6f0b1910

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
