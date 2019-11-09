Return-Path: <SRS0=JpzN=ZB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A9AC17441
	for <linux-block@archiver.kernel.org>; Sat,  9 Nov 2019 02:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79232215EA
	for <linux-block@archiver.kernel.org>; Sat,  9 Nov 2019 02:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573266916;
	bh=2guWFBGYpQdHQWeEkVcJyV2zdETzktIPG/xecqZXK9A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DZGDhDQnJQdwwdIk24vFp2UrwHvnTdhvh5Ut7a3ZHzySl5lTsPekbyOG8K8ODYcjv
	 uEBd7HAZgnDieKacflioN4P0pW8RjT1nYU8QzAo1qddvoruvh+3mM0GBZIVCh2fyIN
	 y8v5fBQDyqeTj53HSne5cBaY4Enw3lRY100CXqcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfKICfG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 21:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfKICfG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Nov 2019 21:35:06 -0500
Subject: Re: [GIT PULL] Block fixes for 5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573266905;
        bh=2guWFBGYpQdHQWeEkVcJyV2zdETzktIPG/xecqZXK9A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jaoCFVkhbcqBTo00Ac9iqdxpTHHX4VVzhonnl3WJWHBDwTnILbrqeCNXNoPLexwKM
         lcwkv/rAq5qcwBJMNE4Y1xNYKNqgHyL5a4KfUDGCRg7owUPlJATOV5XZHRV7fcK8nm
         czWQ50nlCxovePnU+R5q7nmga3M0CnJ+zBI45NAs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <81051323-ef16-30a4-805b-029e2358fbac@kernel.dk>
References: <81051323-ef16-30a4-805b-029e2358fbac@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <81051323-ef16-30a4-805b-029e2358fbac@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-2019-11-08
X-PR-Tracked-Commit-Id: 65de03e251382306a4575b1779c57c87889eee49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5cb8418cb533222709f362d264653a634eb8c7ac
Message-Id: <157326690559.18517.15171522100379545274.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Nov 2019 02:35:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 8 Nov 2019 16:23:29 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-2019-11-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5cb8418cb533222709f362d264653a634eb8c7ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
