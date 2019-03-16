Return-Path: <SRS0=01oL=RT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E666C43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 21:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D38218AC
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 21:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552771526;
	bh=M/VW98RgJym6ELbuUUyfD/d1j2fQeWmfuRw3cx65IlI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Jf/+OjlSFx6F7EgAgrf21rhUFEA9VuF0EK4vazLZGWG+YcG+W9Z6csGTvsIoMDikM
	 BkI97VkzGDFn+Shgk5Kn5cCZeYAFLq0ajgI39YQOs9jGcJ/ZppJZyvYodL1xDuwCCm
	 rLi+rXu71g0ycLoeaXA5f6uMrXamDDWOL8MCxTKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfCPVZZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Mar 2019 17:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfCPVZY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Mar 2019 17:25:24 -0400
Subject: Re: [GIT PULL] Late block changes for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552771523;
        bh=M/VW98RgJym6ELbuUUyfD/d1j2fQeWmfuRw3cx65IlI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GinVayupybMLiq7uZEMPYN1hQL/XryMaI+yWXQqsPDpVxwKOETuoWm2fa74xYDC2x
         JstWVFkiv9q8JYbQYa1tLHRkLYUCaAwR4yGeosutJMwmABOGdrlahWFxecAR32sjfA
         r06nJGE6k5e/7Ff2wcIXHB2rcKdu5u727yAhjJ1E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <011c7a37-d0c2-0084-a8a6-4b91875171f6@kernel.dk>
References: <011c7a37-d0c2-0084-a8a6-4b91875171f6@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <011c7a37-d0c2-0084-a8a6-4b91875171f6@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.1/block-post-20190315
X-PR-Tracked-Commit-Id: f6d85f04e29859dd3ea65395c05925da352dae89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11efae3506d882a8782bc89493a32e467defd6b9
Message-Id: <155277152377.28247.3716919657949979567.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Mar 2019 21:25:23 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 15 Mar 2019 10:52:12 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.1/block-post-20190315

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11efae3506d882a8782bc89493a32e467defd6b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
