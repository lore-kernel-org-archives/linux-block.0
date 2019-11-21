Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40F0C432C0
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 20:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB1220708
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 20:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574368210;
	bh=iijrfibMN60y5JpmAgtg4VkodDcZy7GhP/6Obi/zdQo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=u6Xlj1w92hMIiK5fugH1W+yBp/WNp9FVTftZOVE/n14YIzBotFpospDYEJj0bvrk9
	 bvPSx9I5EEZnN3uWAHvwdP2zlIYz3UN7zt/rIRUrS6rZP3zk+ijpl7cbTdmV3PXdUd
	 P1xVJL7D/lIFQq+JUtTdEIDrcUK6lGGlk5c+RhA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKUUaJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfKUUaH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 15:30:07 -0500
Subject: Re: [GIT PULL] Single nbd fix for 5.4-final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574368206;
        bh=iijrfibMN60y5JpmAgtg4VkodDcZy7GhP/6Obi/zdQo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cm9eGaAQmsKvICE7a2fMHeYYgvjrhbWt2jWWV5t+ly4jtvfXo/yrY1/jScgm4bAJ8
         S5jX8Of8XimeqVxUfeEhTnFgInWpkpJZtGR0G1EMAyG0C81n6o19FD1jvYQhCyaSqQ
         iKPBc7yss/ggJ62nfn4JuFLlYrD99sdZs5kY3d0s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f8df6a8b-5326-9367-0592-0220322a3bfe@kernel.dk>
References: <f8df6a8b-5326-9367-0592-0220322a3bfe@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f8df6a8b-5326-9367-0592-0220322a3bfe@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20191121
X-PR-Tracked-Commit-Id: dff10bbea4be47bdb615b036c834a275b7c68133
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be5fa3aac23fde1a00547ed87144e1f3268cdb48
Message-Id: <157436820684.3070.2315276680618519466.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Nov 2019 20:30:06 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 21 Nov 2019 10:00:47 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20191121

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be5fa3aac23fde1a00547ed87144e1f3268cdb48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
