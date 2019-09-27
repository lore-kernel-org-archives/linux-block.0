Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2D7C388F4
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 19:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE1520872
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 19:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569612335;
	bh=kv4Re62MmtmryCPrQy4xrv0NQbi0q9OAUiFmP5JJeLs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KBHEtKRlsLAXvVqjfq7tl8DOhBIC8Alv68E/nIDuMcPbTkFg1jZoLpz4UwM2tU3t2
	 AP8kJckMkx5NRuaohekf8WQVw97kEnX8OblPHGRPA0kKcO6gETqQ50Zzb9v+5INmMg
	 mW528GmsaIlGeubyYKilYNfUKkznixY0lsPnxV9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfI0TZe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 15:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfI0TZe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 15:25:34 -0400
Subject: Re: [GIT PULL] io_uring changes for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569612334;
        bh=kv4Re62MmtmryCPrQy4xrv0NQbi0q9OAUiFmP5JJeLs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ALszxhS9Rrnl7tDjNsh/HPltqyfkTYDibn6QtM6uW1trZP1+6bqp8CkJl/7liC4QR
         U2LEfnJIbTpyFydHGIVQXAhMd90f0IQBj8IlBeQqu8qDbxK3VRcPAp0ojOY4k348KF
         CfU6C6WJLXTM/bm1y7Jb/YtqV8Qgvtlc5B3uBW8w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c4e59df0-3fbd-44c8-f696-8eb424028b7c@kernel.dk>
References: <c4e59df0-3fbd-44c8-f696-8eb424028b7c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c4e59df0-3fbd-44c8-f696-8eb424028b7c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.4/io_uring-2019-09-27
X-PR-Tracked-Commit-Id: bda521624e75c665c407b3d9cece6e7a28178cd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 738f531d877ac2b228b25354dfa4da6e79a2c369
Message-Id: <156961233409.19941.8553418662506624408.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Sep 2019 19:25:34 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 27 Sep 2019 16:58:52 +0200:

> git://git.kernel.dk/linux-block.git tags/for-5.4/io_uring-2019-09-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/738f531d877ac2b228b25354dfa4da6e79a2c369

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
