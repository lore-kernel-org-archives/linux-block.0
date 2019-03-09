Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CD5C10F0C
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 00:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC64020857
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 00:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552090220;
	bh=5Ts5Y4vIfJybDC+aJk+17zlo+mKmlfRyNr71wmZU0m0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ImcOwBe8UPfmzyJz6KsCAaxpXMgsCTmfnsmKX0c/ceDUz3izl6iVm/V0zTdRjey0R
	 0z7frLv6b5nYEfXbdJeTTyirRDatMZr2cgqd3P5JFnc+LDKV/EuHOWi31Bil6QnGVy
	 Ngr7HF6oI4C9jc9qaB438iCZkIkGQnfli8hFuC04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfCIAKU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 19:10:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfCIAKU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 19:10:20 -0500
Subject: Re: [GIT PULL] Block changes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552090219;
        bh=5Ts5Y4vIfJybDC+aJk+17zlo+mKmlfRyNr71wmZU0m0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kBtF+XaiwJw6qgmgy2xqEQYSjeQKToABQbWBwZrDl2BSA/+0gYaS0miVPSKYjI9VH
         Gr1UyWTxQTFqEu2GAMDJCn4V5Zu6LVxXpk+4G7LqZvXO4C3QcKNbJWHNQykQXB3Zj0
         YXxP3nvz4jptxOa61eJp2GEgf7InZZzTLtZPIY74=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <60f2e4cc-b0cb-1d17-bbb1-445e6a28b248@kernel.dk>
References: <60f2e4cc-b0cb-1d17-bbb1-445e6a28b248@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <60f2e4cc-b0cb-1d17-bbb1-445e6a28b248@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.1/block-20190302
X-PR-Tracked-Commit-Id: aaeee62c841cc1e48231e1d60c304d2da9c4e41c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80201fe175cbf7f3e372f53eba0a881a702ad926
Message-Id: <155209021955.17751.12406179379345112463.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Mar 2019 00:10:19 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 3 Mar 2019 18:53:30 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.1/block-20190302

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80201fe175cbf7f3e372f53eba0a881a702ad926

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
