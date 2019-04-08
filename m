Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4590BC282DD
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 00:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AA320645
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554682213;
	bh=txN6qvdQPwlYS0IYOumUy/kyYrErDahLbTLnszTdolE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jTaAWt8t9XHlnOYu7NlPjQ1U7Ig9/auUHUheEGPxieJZhv80x7DaZOk1G0KHrvSPu
	 tq/MB1nORhxHGKGMH7XjHo3MSepmmjvEPMSopI7ht9JDk0/LiXkSW7HzArWU2iLyWK
	 aV57Dbna0uiKOChIdh/iPin43GeSiZy91qfdZDGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDHAKL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Apr 2019 20:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfDHAKJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 7 Apr 2019 20:10:09 -0400
Subject: Re: [GIT PULL] Block fixes for 5.1-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554682208;
        bh=txN6qvdQPwlYS0IYOumUy/kyYrErDahLbTLnszTdolE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lTJ3qY9/bG754NWm3VCpySaYYkrv22QhMz7a3HBmWYfKPT9554M5B+psrZlfWQ6p6
         JH1X1wKfZhuBBWcWDVDriir7Q7c2uWMbnwQGGZHvlNQJtNuxQZgTfBtLfQlt9pC7RE
         7Dyqf00GNF/HE4HkajMRBogdebDr46nnR0AcZHSw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1804e67f-8ec6-1188-6522-467ac8e6be20@kernel.dk>
References: <1804e67f-8ec6-1188-6522-467ac8e6be20@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1804e67f-8ec6-1188-6522-467ac8e6be20@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190407
X-PR-Tracked-Commit-Id: 47b16820c490149c2923e8474048f2c6e7557cab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 429fba106e82e2792010a825b9dbeadd00bf9e9c
Message-Id: <155468220850.5452.10412090562997328364.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Apr 2019 00:10:08 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 7 Apr 2019 13:37:43 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190407

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/429fba106e82e2792010a825b9dbeadd00bf9e9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
