Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A80DC433DB
	for <linux-block@archiver.kernel.org>; Mon, 28 Dec 2020 23:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7F920757
	for <linux-block@archiver.kernel.org>; Mon, 28 Dec 2020 23:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgL1Xho (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Dec 2020 18:37:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbgL1Xho (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Dec 2020 18:37:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B27FD20829;
        Mon, 28 Dec 2020 23:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609198623;
        bh=ENY5NG2jFZADVA5Akp/4eqfuekd+83Kw9dy419Dh8Cc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tapiVphRzt64jcto0FSQeQ4xhkLwsLnurBDdJN4iGGEWlnLuX6YlzuO9oI/H/9+6e
         SY79rlxkGkGKL2ascpTfC3qtIFWTWZZAtmaYkeU/EtjzuqTiQuR7jquCM0Ujo+82XC
         SdyNh9PyxTa7bFUuIPcs/ywZUG+zebUI5fLVw91FZaHdNIpO9wr05IAsbOnGEU3Rsd
         cl78wxMNc3EDknGuaLfhHNdq8RoMtGs1/PGa/8zIZgRiIzo+6aBcC1gmxZlQaPPoj0
         w6JTdPTYBZRhCN9mMute411SfX6EFWwSne3StTl7GNpQhIg35/uqQ9mv/64F8V6seO
         76bZesiTzjFUA==
Subject: Re: [git pull] device mapper fix for 5.11-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201228212757.GA26267@redhat.com>
References: <20201228212757.GA26267@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201228212757.GA26267@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.11/dm-fix
X-PR-Tracked-Commit-Id: 48b0777cd93dbd800d3966b6f5c34714aad5c203
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dea8dcf2a9fa8cc540136a6cd885c3beece16ec3
Message-Id: <160919862358.31803.16883567741598465631.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Dec 2020 23:37:03 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Milan Broz <gmazyland@gmail.com>,
        Ignat Korchagin <ignat@cloudflare.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 28 Dec 2020 16:27:58 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.11/dm-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dea8dcf2a9fa8cc540136a6cd885c3beece16ec3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
