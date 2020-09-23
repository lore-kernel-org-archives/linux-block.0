Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A30C2D0A8
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 21:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D58023899
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 21:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600898073;
	bh=bv8zv8cNrXfxqZC9xuRiIRmdBIdfWMgbRPgVFTRWEj8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GA5a59cU2nty2xnBEVHcjOKUHc53hqUjTH4xg2tcoMnktQGKBzCq9Hxc9Z9/z9Dik
	 covoGBOTBEZPy1ECNkbO1EXtL2jCjsNydvzNLuswM4DZptyBzcLTuVd3/ECa31WRNm
	 miFJUIdBEm8oK9pCZBdBIyjTivJUbXgaNK/v/X/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgIWVyb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 17:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgIWVyb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 17:54:31 -0400
Subject: Re: [git pull] device mapper fixes for 5.9 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600898070;
        bh=bv8zv8cNrXfxqZC9xuRiIRmdBIdfWMgbRPgVFTRWEj8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=O10zDkWKUPr6p7MCMb34+8xD5LT/VMfwE8db8Z570HUfvPKfDNisUp44ixsuOFupG
         3TkrE4BQwNIC9zO3mHosdn3tz0662zuj61lZbTk3JiYwdI2OnKoaIq3s38eQCCtq45
         PGPhTHc0IZ9M+uQUcBeUnwJThwok6KgA9qyuHeUg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200923173024.GA97173@lobo>
References: <20200923173024.GA97173@lobo>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200923173024.GA97173@lobo>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.9/dm-fixes-2
X-PR-Tracked-Commit-Id: 4c07ae0ad493b7b2d3dd3e53870e594f136ce8a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a969324fe7cc38e4af05eea44fde385a2853c91e
Message-Id: <160089807067.12557.15709225773189841280.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Sep 2020 21:54:30 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 23 Sep 2020 13:30:24 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.9/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a969324fe7cc38e4af05eea44fde385a2853c91e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
