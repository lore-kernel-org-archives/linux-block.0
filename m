Return-Path: <SRS0=o1BL=5G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE124C43332
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 19:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BEB2076E
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 19:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584818109;
	bh=3BsIBDElFqEKB5VGnhYDvC+pfPhT6OvdWqocjfrEkeI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kkfxuIGrczhw2wroo9+BxEyT8G+64arZfn3CaoD7cpFfm0MMGSBmLmOIG6aqJ2Gd/
	 BrC3kl8wAizyXxbIinI4hNrNpcpoj+9iHupoqqZ5RCshQyv2LJlVb7KMpgNarN2x/M
	 YayXeodE1miWfCHuYcfkEKYEQIextBwLEAAISM7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgCUTPI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Mar 2020 15:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbgCUTPH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Mar 2020 15:15:07 -0400
Subject: Re: [GIT PULL] Block fixes for 5.6-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584818107;
        bh=3BsIBDElFqEKB5VGnhYDvC+pfPhT6OvdWqocjfrEkeI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zoz7TL96m2ZD1IGxWHvG4shfNpwNlaKfQe7lxCZVhV+aTDxA1IO6yeE1ayN1gK0uf
         JF1uexK7fRgqyxYYUeTWZwIOX9lXtu/MgA0Tmw7WSj8H0WJS/Ixjao3PlCtKYQQt4y
         A7KGRL0ZPaC7EaBpQTqzVXlNGUBcVlQsvifBDQ2I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9b5bff9b-0999-26c5-9ecb-3aacbe115bce@kernel.dk>
References: <9b5bff9b-0999-26c5-9ecb-3aacbe115bce@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <9b5bff9b-0999-26c5-9ecb-3aacbe115bce@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.6-20200320
X-PR-Tracked-Commit-Id: 83166ac82b53655b63d3a59f6fe44f20511e96f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b74b991fb8b9d642b8fea20d6245c6e19125a305
Message-Id: <158481810730.2095.4096805249565402821.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Mar 2020 19:15:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 21 Mar 2020 12:38:40 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.6-20200320

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b74b991fb8b9d642b8fea20d6245c6e19125a305

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
