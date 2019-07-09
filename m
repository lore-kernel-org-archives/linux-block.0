Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDC0C73C53
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 18:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A372166E
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 18:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562695519;
	bh=jDf/abxHNbY9B+yeAK8Ys9SxCwvCM13owCcyUuaazLY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Om1+DJ/iZdZlXb7Pshlgk15DYhTlKTweaeuy3BtpKxX8O1taffL8ZKNIyOCQ6lyzl
	 xxqom/CEgA1CxbCmWv/6O1NqVxIlX4l5iu8aHWhSFCGNFTuhM2k4qjbZope7MIOtzl
	 qKX/aYn9yKQYFCGDrIYeBVn7p1zOpV0xDlqRwr7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfGISFS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbfGISFP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:15 -0400
Subject: Re: [GIT PULL] Block changes for 5.3-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695515;
        bh=jDf/abxHNbY9B+yeAK8Ys9SxCwvCM13owCcyUuaazLY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=i+oLhuo+d03bPdeABNQto+FgSzPElNTWmmF5qWxt4l3hte2GrlmOWSD4am1SA4zwU
         gug8C6VTpoOuJ0/lH2cMW85gL9yZVYKnM2XtCdE6sHLzsEipr/M2R2EbQAOzM9zqxc
         S9Vl1aFJLPk6kkaoXFMU3tL6gzGp9ZNRdp7N+pTU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <14ea5503-b60e-9b1c-5a2a-0c48f7b96990@kernel.dk>
References: <14ea5503-b60e-9b1c-5a2a-0c48f7b96990@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <14ea5503-b60e-9b1c-5a2a-0c48f7b96990@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.3/block-20190708
X-PR-Tracked-Commit-Id: c9b3007feca018d3f7061f5d5a14cb00766ffe9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b99107f0e0298e6fe0787f75b8f3d8306dfb230
Message-Id: <156269551516.14383.2389336891073222130.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:15 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 15:21:21 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.3/block-20190708

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b99107f0e0298e6fe0787f75b8f3d8306dfb230

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
