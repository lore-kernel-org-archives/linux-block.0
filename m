Return-Path: <SRS0=gctd=WO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ABCC3A59B
	for <linux-block@archiver.kernel.org>; Sun, 18 Aug 2019 02:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A0A21773
	for <linux-block@archiver.kernel.org>; Sun, 18 Aug 2019 02:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566096609;
	bh=5p72cZMu9CBbU2Dmiz7L4XA+TgUvKJGX7WI9N5hvWC8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0Wj4oNwSsJzRUmVF8cbe8gBB/dEl2UGQ1HVrdntv9FAGES+IVP+Jvnl89quyeObTq
	 0OOa7JcF8V45CZEeUV//ZzjzhMj8g5YhPP+Ai4cm+P17cHsfYs93Yx5PopBjFzSuwE
	 Cu2uWztrBgKgASxU16MwkQPxc4cn6vKeK4D1ksF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfHRCuI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Aug 2019 22:50:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfHRCuI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Aug 2019 22:50:08 -0400
Subject: Re: [GIT PULL] Block fixes for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566096607;
        bh=5p72cZMu9CBbU2Dmiz7L4XA+TgUvKJGX7WI9N5hvWC8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uAwqWp51Ew/xAqp+X3B/q4gaeFjQlqqXFDDHi8lXKUiPQ29MJUNO+FJUAZTjWDHsS
         d149zouWCmXMpR+p6VU2JJRKZLMPVpRu1zTh9WYl7rxDj9NZURO2ubZOJEj30Hk3oZ
         d5x9LoBA+xMYJhW3FXQjYlWvKvRK/BH+lmKT9mL0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cb805bba-1f68-15bc-a8eb-ebbce15e1dfa@kernel.dk>
References: <cb805bba-1f68-15bc-a8eb-ebbce15e1dfa@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <cb805bba-1f68-15bc-a8eb-ebbce15e1dfa@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-2019-08-17
X-PR-Tracked-Commit-Id: a982eeb09b6030e567b8b815277c8c9197168040
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fde2832bd0bdc5a2b57330a9e9c3d2fa16bd1d8
Message-Id: <156609660706.32044.2765283493764559293.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Aug 2019 02:50:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 17 Aug 2019 16:45:14 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-2019-08-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fde2832bd0bdc5a2b57330a9e9c3d2fa16bd1d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
