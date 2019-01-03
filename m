Return-Path: <SRS0=Dd+4=PL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F91C43612
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0714220833
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546484711;
	bh=Th0A4cHPuAYIo31lrI/KJdkWZCCUYuL7BWU3Nw2BP5c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=W6G93xbqPyAMhlTkuUzLGGtCtFphjBlTrRqdgl8W+5RJq7BLgVuiipb3fdhlr+jua
	 r78/RyKaFnt8T4fzsBbcACU5kWvgc62xA/ewn2lWruYRTY/nRdnu7m0p01Lt1K1zd2
	 Hwm0PLHfUfUuv2YitRye/fWAyYVmfog/dTcagaS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfACDFJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:05:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbfACDFH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Jan 2019 22:05:07 -0500
Subject: Re: [GIT PULL] Late block changes for this merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546484707;
        bh=Th0A4cHPuAYIo31lrI/KJdkWZCCUYuL7BWU3Nw2BP5c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NH3w0UioQnsi95U4upencKwvLc8Naz57O8QnOXMCpa6ALk/4c776NUD0mGbQlV6yk
         NUPf2kDG+/6INttaltZL+V4QM9Qi5Bv25mRja5Ca6AAOFexcs171qhNxLJtPQuyAcE
         OfF3K00e3TDW0DAxW3lN5vjWPf5ZLJZA0oXezdaw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f623a113-03ed-aead-33bc-65737ae36cc5@kernel.dk>
References: <f623a113-03ed-aead-33bc-65737ae36cc5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f623a113-03ed-aead-33bc-65737ae36cc5@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-4.21/block-20190102
X-PR-Tracked-Commit-Id: 427c5ce4417cba0801fbf79c8525d1330704759c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77d0b194b2df04a1992f882d96ff4e2bd8bb8fe0
Message-Id: <20190103030507.10885.55812.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 03 Jan 2019 03:05:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 2 Jan 2019 12:07:36 -0700:

> git://git.kernel.dk/linux-block.git tags/for-4.21/block-20190102

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77d0b194b2df04a1992f882d96ff4e2bd8bb8fe0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
