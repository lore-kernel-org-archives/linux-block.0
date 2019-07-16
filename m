Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54918C76195
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 04:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC4C20880
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 04:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563251726;
	bh=S2GhMVUPbMp+b2GX1nviuJD3Ji07mw7JPJVtwp6W3A8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=feb17mNR6gu37B1lJMxZ2Vs14dGyURf/pRbNLU87JpC10uxAP9R/WiGTqTv4PtpgJ
	 dCannrgkSq5f3p40XNsBu30aiYLdiHF30IqUQNRIlMcB7xQQpPLIW8WYPzocp+FLk0
	 xmrH/gfqp/lEO7XrLSrV8T15AjtJGWDXmeJJathE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbfGPEfY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 00:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387400AbfGPEfY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 00:35:24 -0400
Subject: Re: [GIT PULL] Block remainders for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563251723;
        bh=S2GhMVUPbMp+b2GX1nviuJD3Ji07mw7JPJVtwp6W3A8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Dpo49V5Q57gABH0tClaq0o3Nygr8VF/7VIkWKENc/uYFp6mmjsVgNLFFW1lE81vVF
         kGmNCq4iSkBzgaL2tpYQhwpz3xkyVjsk5FpL1H1uPY0UI7Wj/Gu4DT+3vV4pzYuDLy
         YW1WXPSO+dcAKVCGUwymmICCxQi+PDmHBpFpuZvM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c8906a8f-347d-fde8-7f24-f3274fdda50d@kernel.dk>
References: <c8906a8f-347d-fde8-7f24-f3274fdda50d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c8906a8f-347d-fde8-7f24-f3274fdda50d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190715
X-PR-Tracked-Commit-Id: 787c79d6393fc028887cc1b6066915f0b094e92f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9637d517347e80ee2fe1c5d8ce45ba1b88d8b5cd
Message-Id: <156325172392.15429.13231655528488933699.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Jul 2019 04:35:23 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 15 Jul 2019 13:47:19 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190715

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9637d517347e80ee2fe1c5d8ce45ba1b88d8b5cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
