Return-Path: <SRS0=FTzM=TI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952EEC04AAB
	for <linux-block@archiver.kernel.org>; Wed,  8 May 2019 02:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D1321655
	for <linux-block@archiver.kernel.org>; Wed,  8 May 2019 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557283221;
	bh=21SAIdmRIxK2oCUDmef0L2PCY25La7cyMm3VcFIzZaQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nOsQmTxTDYws3ja4veXULdmUOk6AEFGEBglnHRtvedlUeTeYbab60NvXKHfZv6u/A
	 KqFTrtxv08kAbN+VWLwW08FaKpGXs3aciw20A2H7qkXzyjDFOnDkYNz4a7hgeel2x6
	 wEvKx2s2kRttdlEy250FbtGSGuVU+f9PytTrWtAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfEHCkU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 May 2019 22:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfEHCkT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 May 2019 22:40:19 -0400
Subject: Re: [GIT PULL] io_uring changes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557283219;
        bh=21SAIdmRIxK2oCUDmef0L2PCY25La7cyMm3VcFIzZaQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=078qStlXSHAC7RbfR76SVrbx/brGmKqTsiEjC11Ws225RfQUYi6B28xY2t0eeyeDN
         n/VEJ7g3Ci0tM7yCUDWfloiuZ5DbkP/KXGBTrDPwFJuvwdQgMF64yuM2AT0zSBe95w
         ShLifxuPWCzLevEnMrdv+KXr2ak9rzizaH7BKRcI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6031a661-195e-4351-59ff-086b799a50c4@kernel.dk>
References: <6031a661-195e-4351-59ff-086b799a50c4@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <6031a661-195e-4351-59ff-086b799a50c4@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.2/io_uring-20190507
X-PR-Tracked-Commit-Id: 7889f44dd9cee15aff1c3f7daf81ca4dfed48fc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52ae2456d6a455ef958bcf1c2d1965674076887e
Message-Id: <155728321902.19924.5780104773887119786.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 02:40:19 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 13:41:07 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.2/io_uring-20190507

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52ae2456d6a455ef958bcf1c2d1965674076887e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
