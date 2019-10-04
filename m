Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD209C4360C
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 18:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A8D222C0
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 18:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570213523;
	bh=VlQC2rjzJQfOQUWg0LSqQSxYSgsWMr9iO91yGo7vsYU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dR5/EyJAw+2JgEpgceUuk5oV8o0RIAuxbqJWCBA65qPlPnd1bbOj/tFtrbhYHQjnK
	 rhWpqGSDxPzITeqAVaFmsLzqOmkEhFhZjdw9TPUoo+ifOe3L9gZZTrNtR/ogrUozFa
	 PzSEhAIq0+73tCMfc3TPk7y++cF4M8CrbPZKx0Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfJDSZW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730487AbfJDSZW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Oct 2019 14:25:22 -0400
Subject: Re: [GIT PULL] Block fixes for 5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570213521;
        bh=VlQC2rjzJQfOQUWg0LSqQSxYSgsWMr9iO91yGo7vsYU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NpjyCxxpph2wUUSCCPNJGIwjz9dkXAqlQeHCNBCc79Wl7U0AYEWFwMP/57MvWdvNB
         g1SGFWn1aFTLhLFR9HDQePKK+vpebqsjFYJzYR8NxkOKSwDENnyU1Tf2aFtJgDca42
         S/3zTSS+F2/gZ77y4tbDHKlBbmr2igwpUjRPB7dQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0aa232d8-6765-b088-b0da-64e95d58d78c@kernel.dk>
References: <0aa232d8-6765-b088-b0da-64e95d58d78c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0aa232d8-6765-b088-b0da-64e95d58d78c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-2019-10-03
X-PR-Tracked-Commit-Id: a9eb49c964884654dd6394cb6abe7ceb021c9c96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4bd70e8c95b2b045ac686b4c654bf9bfbfe9f3b
Message-Id: <157021352156.30669.8209552504387694603.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Oct 2019 18:25:21 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 3 Oct 2019 20:33:00 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-2019-10-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4bd70e8c95b2b045ac686b4c654bf9bfbfe9f3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
