Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CFBC433FF
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5287820C01
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565368516;
	bh=GwwC0GsN8qBgoOLpQn7LqtwEV9SyJ/J3C3PDOpJBof8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LBMZ5ZXAf//gIKdXmqqxuQQUqxSnzfw+FqapuQcXnwlOa+5YWhxb0Ndw8c/JyuFzi
	 YxBfFn0y+9vgBCptmDGeLSr/NsYo5ypy40PIDak0h4d+K2l8jDB3/UUTUDYHbz71Lr
	 75N9FriCpO62czdb2tEX9ubrme715cdXzXBM9v/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437362AbfHIQfO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437087AbfHIQfN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Aug 2019 12:35:13 -0400
Subject: Re: [GIT PULL] Block fixes for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565368512;
        bh=GwwC0GsN8qBgoOLpQn7LqtwEV9SyJ/J3C3PDOpJBof8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cTA9rfvI+bhib1+9R3V++xhwwtveEhulDaiWx2iJrLcZtvszRv79t1j81qOZ618PO
         ScsJAmH2y5rOZkhG5Z0rUFkU7g52APGj4pvB398vZW3Rjpkp9YW469gpGYnDNmuyx7
         q63FSAoQSYKocvPjteaOWW4Zer/4Sqe3bL23BHTM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f3f005d2-701c-c943-b906-675d58d1164c@kernel.dk>
References: <f3f005d2-701c-c943-b906-675d58d1164c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f3f005d2-701c-c943-b906-675d58d1164c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190809
X-PR-Tracked-Commit-Id: 20621fedb2a696e4dc60bc1c5de37cf21976abcb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50e73a4a41598f9a785a986d25b731d3968dedb1
Message-Id: <156536851285.6429.2134338807240345548.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 16:35:12 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 9 Aug 2019 09:05:41 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190809

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50e73a4a41598f9a785a986d25b731d3968dedb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
