Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4306DC4361B
	for <linux-block@archiver.kernel.org>; Sat,  5 Dec 2020 23:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1785823121
	for <linux-block@archiver.kernel.org>; Sat,  5 Dec 2020 23:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgLEXPX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Dec 2020 18:15:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbgLEXPX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Dec 2020 18:15:23 -0500
Subject: Re: [GIT PULL] Block fix for 5.10-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607210082;
        bh=wal3ulaXSuFfYsddZ7ug3b7+3Jr5611fuBZKqq4laaQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EhCh79y87F++qjav/tmbcs+7ouCH50OcUSbcomUbjwf/OJYXyC7cbOOlESDzO56e4
         ej9npGVFuzFUDlDAxgggshZuhgtZOSWOw7lZ+ET3AeYyrF9AdyHiLzC+h3Tkh8TpDk
         wU3qEeBn9pke398FmJX2BHVj+xoTiQcCjFAFzdgLx39pw9gHItyAmfGRsFE449XBEW
         0UOXrl+ct5286KsYFFP2qmX47UzpsNnzTmky/AFSCR90wkeowp0Lu2Tfaroy47hvlT
         1qzKSsNTPJ9yDK7NCwUeqL/b8H2mni/Af90YkPIDgscCNmdi0sBJF+PSv1l3HPHBaO
         RfXMC3BX4F8Mw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cdf79314-f43e-644f-910b-f1738d728624@kernel.dk>
References: <cdf79314-f43e-644f-910b-f1738d728624@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <cdf79314-f43e-644f-910b-f1738d728624@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.10-2020-12-05
X-PR-Tracked-Commit-Id: 7e7986f9d3ba69a7375a41080a1f8c8012cb0923
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be1515bad737ee9efe9229ab8313a236bfa03c5c
Message-Id: <160721008274.18780.7311747498079859957.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Dec 2020 23:14:42 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 5 Dec 2020 14:43:25 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.10-2020-12-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be1515bad737ee9efe9229ab8313a236bfa03c5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
