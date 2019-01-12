Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8145EC43387
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9A1206B7
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547329804;
	bh=5ZI3R4ofwruiEhYzSg83rswTmUByBoYFRZx/RuuX2jM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VyNdrgZPwqvIO+gsSKdUVJcdWBmMB04/OEJSzGPCHFZK3LTjx6NBBCmI+hAZoFekX
	 nXak5Cpx2QWX9IOuz/CCHZujNGmjR04E9kanR8st8stCUCMBME5+w1q7Ko/tKaP0Sq
	 i9nJ/FSyUpO68gBKE6iQLjXhJgKK1blAtq/LHZvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfALVuD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfALVuD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jan 2019 16:50:03 -0500
Subject: Re: [GIT PULL] Block fixes for 5.0-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547329802;
        bh=5ZI3R4ofwruiEhYzSg83rswTmUByBoYFRZx/RuuX2jM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tSv5eDsUmQbafRlqmWPfeJZtYk6dxqefNJdPZT0hNn7Gdbi5Y8HpVTU6YHInuK5pi
         mo3ujKSizC7QsljHCifcWJoIuVa5RPTQqGj+0oasy7h/v0heOQQSUORUmNdaBbuUb8
         Sl1FZgVmamFgMjowSARNWRoL6ODmg7bQPJqYawGE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8137c662-f43e-ddc2-807c-155016e46fed@kernel.dk>
References: <8137c662-f43e-ddc2-807c-155016e46fed@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8137c662-f43e-ddc2-807c-155016e46fed@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190112
X-PR-Tracked-Commit-Id: bde0b5c109e8b22b57745e3b9914f9e87ad857ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8c3b8992ff2827482ac1543f84f5024a72c4f2e
Message-Id: <154732980265.30352.1419963682914942000.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jan 2019 21:50:02 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 12 Jan 2019 14:09:16 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190112

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8c3b8992ff2827482ac1543f84f5024a72c4f2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
