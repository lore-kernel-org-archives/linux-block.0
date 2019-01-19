Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47976C6369F
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 22:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1743D2087E
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547935224;
	bh=/UQJy4/9s9NkcK4Tg0KwSNMSBJiKy+3x3QBAlguaP2M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aT87HSBduBXQ+U1f9W7U3k0SIB7h5gDv1tCroGwHDoiQEktNljIS9DQXfv2O4+wAq
	 4B/zlSQ024ZAsNct/yNc88mdf1vSHJpBi+ov6SHX+BY2WBhy6vRyS/95N5920qneRp
	 a70A3Wf6U6DwtyujFJXydQwCNC8w+Lmhg8JQm8Bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfASWAD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 17:00:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729886AbfASWAC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 17:00:02 -0500
Subject: Re: [GIT PULL] Block fixes for 5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547935202;
        bh=/UQJy4/9s9NkcK4Tg0KwSNMSBJiKy+3x3QBAlguaP2M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OzeP3XAeKRwTYL+gmL9m0LTZYNNY9RZH9KpFEj049oMOdh8eR7IgGVpUSGoDCOpAU
         U9ZZZKtF/lnPnUa7Pn/4bW/DX1LkPmGRU4keoPIH0OKyTc5fDprIgqztjbX71rf9cv
         rLvkc97OhXojWMdCwlMf9gUdxedVZWfJveRLYlY8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c2a330c3-0acb-6f39-8cf2-e1659fe39440@kernel.dk>
References: <c2a330c3-0acb-6f39-8cf2-e1659fe39440@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c2a330c3-0acb-6f39-8cf2-e1659fe39440@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190118
X-PR-Tracked-Commit-Id: 38197ca176fc259fa4c871d07bcf8389d044a895
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0facb892456ff922924e704f78cafcaa7be85e8c
Message-Id: <154793520216.21907.15567196662680209995.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Jan 2019 22:00:02 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 18 Jan 2019 12:59:07 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190118

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0facb892456ff922924e704f78cafcaa7be85e8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
