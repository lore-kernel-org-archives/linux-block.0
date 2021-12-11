Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAA9C433EF
	for <linux-block@archiver.kernel.org>; Sat, 11 Dec 2021 17:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhLKR2z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Dec 2021 12:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhLKR2w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Dec 2021 12:28:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59848C061714
        for <linux-block@vger.kernel.org>; Sat, 11 Dec 2021 09:28:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2341AB80B27
        for <linux-block@vger.kernel.org>; Sat, 11 Dec 2021 17:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA5A2C341C8;
        Sat, 11 Dec 2021 17:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639243729;
        bh=FN2mkso79iKAnds5iJei/01CMiGTHDjz0KsDOOn7Mo4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uAmqwkCVfErm+YbBfk9QU/X3NZDCtHcN4y+CHXkR1tYJyHwe94o2TKxaJS1cPfh3J
         /9uz6Y6QgfJ4HJAECBMsVD5griebMUia8BO1XpWvvjLWxrM0X/Dh3fOLpIpGF9U4qU
         BvntVxWe1zlUH3ZF6BFMcLLRmwNFjI8UVV8ceQNOTGz4pFMkg4mQzugLxWK6rgQSWp
         cjLWVvmlo8tmgrJ+mHkaLK9cpM6xhId7qflRj7eiyVudcDiYi/vT1bBJ1xVpN+eoOZ
         dLiiR4NyA7SRmf5t8HddJbHM7Kpf8ZFWKv7L+Ve+EAVMNhxUyp1nTa5hQJ2H4ikdTs
         9T7y4lojUqCPg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DB82660A36;
        Sat, 11 Dec 2021 17:28:48 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b2e03df4-5be8-4e82-54ad-4dfc9b9d47ac@kernel.dk>
References: <b2e03df4-5be8-4e82-54ad-4dfc9b9d47ac@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b2e03df4-5be8-4e82-54ad-4dfc9b9d47ac@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.16-2021-12-10
X-PR-Tracked-Commit-Id: 5eff363838654790f67f4bd564c5782967f67bcc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eccea80be2576dee642bc6cab20f1a242d58a08c
Message-Id: <163924372889.9148.12068632187430685490.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Dec 2021 17:28:48 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 23:09:52 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.16-2021-12-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eccea80be2576dee642bc6cab20f1a242d58a08c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
