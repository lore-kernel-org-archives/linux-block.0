Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A05C43444
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 20:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C252080F
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 20:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544820010;
	bh=1g5niojlu+s2g4wlEceutGDJVLIWvTbLU9VBzWJv0xg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l89S6y36YlBBpppdokiW/o1gJQWMjvALId+F52Pqbf58AyEoNm5X3gisrvHTfrQw4
	 HQSMu3GhZ6nPwYF/pvxBy3AsmKsYGaCIas1/YfHRPTV/BRHUAoGqXwexQszehsCRVo
	 ES/tBWxZifuk/JCv6XC/7HBM67zUvuiPnz3hazp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbeLNUkI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:40:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730987AbeLNUkC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 15:40:02 -0500
Subject: Re: [GIT PULL] Storage fixes for 4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544820002;
        bh=1g5niojlu+s2g4wlEceutGDJVLIWvTbLU9VBzWJv0xg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b7Og8HaNtjScYiClCp8DacDVKoj/baBnhFivM6/+HFoe76U/LIaNpxBento+CR9JH
         QfHlmCEbLbydHpXg6rKoceSeSzFs6bVPCdZFJttSM6NIWfvY09bt/6YVBj3fw5nsLS
         E00enKQyuBd38HU50GfsImaJBZmoiWcSJDJ8cLws=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2dd937be-804a-7524-d088-83da7e405ed0@kernel.dk>
References: <2dd937be-804a-7524-d088-83da7e405ed0@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2dd937be-804a-7524-d088-83da7e405ed0@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20181214
X-PR-Tracked-Commit-Id: 927b6b2d69b4cc900fa50d7e46d8f1fa91c91b3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 380ef2c9ad4fdd5fdd81055857be21ae5f581877
Message-Id: <20181214204002.7612.57084.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 14 Dec 2018 20:40:02 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 14 Dec 2018 12:54:09 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20181214

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/380ef2c9ad4fdd5fdd81055857be21ae5f581877

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
