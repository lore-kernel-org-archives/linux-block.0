Return-Path: <SRS0=Dd+4=PL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F18BC43387
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AA020833
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546484718;
	bh=rzaIyE9UMcKfKBHmnli8J6R1PF9VnRKzlNcZLoD/VME=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=meFYlprbFqoRX0gkZn5Pce3rgcL+Yww/PEt+HAvEm4m6nHWrKHliq49BRo4QX+Wsp
	 2BMivofuNu4C52lOVdPIZbNxG65MJRt3rsWn+PG7875BrUs3T3J/n/uyEGe1w463Ux
	 +kQfDwl6Vy8fWQgFDTgzG0rQSEJaswXMQiEBwstI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfACDFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfACDFH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Jan 2019 22:05:07 -0500
Subject: Re: [GIT PULL] libata change for this merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546484706;
        bh=rzaIyE9UMcKfKBHmnli8J6R1PF9VnRKzlNcZLoD/VME=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AxdvzsK6vcI5F0AKk28drXn7H8Fwg/fWU7vvZEuKABrUZNPoBBt4OCqKbtZ7kOW6O
         0tS2CLqZv1A3BJVOUsBZz77MhDOKuMd78XvfMpasiZVCYjg+XTPOYFh7QTQlPKzlJg
         XGuNfxv6U4QYj2perCI1u4Rd3hGG1mUGFVEky8nI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <14f317bc-b328-f4e8-30b2-b5e73b2b62c5@kernel.dk>
References: <14f317bc-b328-f4e8-30b2-b5e73b2b62c5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <14f317bc-b328-f4e8-30b2-b5e73b2b62c5@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-4.21/libata-20190102
X-PR-Tracked-Commit-Id: 745d51dc8a29e00e9ba14e090aa3c8a41e7221d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b79f9f93eb483f2757b089bb4e1eb3827a609080
Message-Id: <20190103030506.10885.43467.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 03 Jan 2019 03:05:06 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 2 Jan 2019 12:02:32 -0700:

> git://git.kernel.dk/linux-block.git tags/for-4.21/libata-20190102

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b79f9f93eb483f2757b089bb4e1eb3827a609080

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
