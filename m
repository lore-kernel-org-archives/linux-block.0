Return-Path: <SRS0=SSPg=VX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1118DC7618F
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D861322BEF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564165534;
	bh=HAtGwrtSsGDOs8POStUOgbgxktkPRyynPVvg6wwDoAc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UzdWOyycoeK2UGILQ57VQzbnqiDLEKObzEPxRqCVDcPsSFBVxYpJod/D5fzhc2j3F
	 o2r5lablB5CNjZ1ReaKAeDNNiBX8eKczKgEVbDNhvQnKMrNLpXZrOyrWXluqLmusew
	 kcqUNGKuhO2JIx3qUomAcctYng3mf5cTbPIwrHZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbfGZSZe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387458AbfGZSZd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 14:25:33 -0400
Subject: Re: [GIT PULL] Block fixes for 5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564165532;
        bh=HAtGwrtSsGDOs8POStUOgbgxktkPRyynPVvg6wwDoAc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0TYjC2Z9M6vxHypnFNQVKqfp/QLWJl7zEnYu3kgbf/uoHKw7SEFVVo1MAKHdpH30E
         ungbxJ4PNJZso6rCq6sKu1mfmxUzUSCvJGP2Hl2mUcl9qTXle+yFIRChm+P0tB4W+b
         alp30GKrYqM5LkjIhXC6+oVchH7bguPgxD4oKH8k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2b22063e-660c-a238-f109-fcf3f1b888b5@kernel.dk>
References: <2b22063e-660c-a238-f109-fcf3f1b888b5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2b22063e-660c-a238-f109-fcf3f1b888b5@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190726
X-PR-Tracked-Commit-Id: 9c0b2596f2ac30967af0b8bb9f038b65926a6f00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04412819652fe30f900d11e96c67b4adfdf17f6b
Message-Id: <156416553289.19332.3924118421674813735.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jul 2019 18:25:32 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 09:12:42 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190726

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04412819652fe30f900d11e96c67b4adfdf17f6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
