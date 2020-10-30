Return-Path: <SRS0=TFq0=EF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4ABC388F9
	for <linux-block@archiver.kernel.org>; Fri, 30 Oct 2020 22:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DE12087E
	for <linux-block@archiver.kernel.org>; Fri, 30 Oct 2020 22:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604095858;
	bh=mMjYvSjQgwUDyGt0G5XhGxbHD5cVTdFORNf2t1EtD3A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mwc5tm7imEZj+5sDG7ARFIWDFuDA2moobKAFyaxnzoDD5PIoFoNDKbT+38BCOdtkP
	 acMvO7gT3ukX7J32sEU4VLFfypJecaYhNUmSHlRGULBnK139PEbSm8cQKUve2pzdTu
	 pn3g1Gehd7ZkKMGDCDrrMVY83IM3vmBzp8BrsgkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgJ3WK4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Oct 2020 18:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgJ3WKz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Oct 2020 18:10:55 -0400
Subject: Re: [GIT PULL] Block fixes for 5.10-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604095854;
        bh=mMjYvSjQgwUDyGt0G5XhGxbHD5cVTdFORNf2t1EtD3A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DCS/txlPOdrcRYo+kWAYzRb/83y9O4+ZHflK1oc/5Ko/gpFah65NbgII6moTmpSYk
         DRosqRY/WIi40Wef0m72LVnQwQbWUebYIrxulBIJb/0y7+rRniF3rGMqKSYd8hwhcB
         8OoJkPgaCFycdOqit8/zJ75h/q+tUQ/mHfYJtR4c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bd2659a5-5cb7-d011-b3b7-25b197982845@kernel.dk>
References: <bd2659a5-5cb7-d011-b3b7-25b197982845@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <bd2659a5-5cb7-d011-b3b7-25b197982845@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.10-2020-10-30
X-PR-Tracked-Commit-Id: 65ff5cd04551daf2c11c7928e48fc3483391c900
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fc6b075e165f641fbc366b58b578055762d5f8c
Message-Id: <160409585486.7779.3257384566547955556.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Oct 2020 22:10:54 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 30 Oct 2020 11:09:26 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.10-2020-10-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fc6b075e165f641fbc366b58b578055762d5f8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
