Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218DCC43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 17:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D9521925
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550251204;
	bh=GBa0mznLpTAjxfJ+s1ZwsoQvFFvD4K9CAdpEnYit758=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=q43t7MYjG5UroB1cZc6yVxjCI5waOAbuO1FqBydeuQzRl8JKgb/5E6vXqs+0eEbJL
	 3uafRzRd4dvZVIplFPrIlvuWKdmk9RlvCgXFNxUeoRkUEYli8r8rmwHJ3DfN0Qb84/
	 tVd3JASL1KE+bqXQRvaJBrsFSg09vb1dMR00BEvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfBORUD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:20:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfBORUD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 12:20:03 -0500
Subject: Re: [GIT PULL] Block fixes for 5.0-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550251202;
        bh=GBa0mznLpTAjxfJ+s1ZwsoQvFFvD4K9CAdpEnYit758=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=r/gKjHoyHczJxkUUh9AvQtVY20H2b6tSeNQbAyCNLT8KpMwDTevAkU1D7e7LrYqcG
         g7VRgLfzy07EAjTBkkSCpwa3JIXHkKGMly649PlCYiA4XkICW5ZllwLfwHUhRDkjlT
         QJqNVtUVAikDq0XdIQ2yz29TtegkVhHF7YdhsOUg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c74b7382-dbe3-ecc9-17fe-b0e6e3b32b26@kernel.dk>
References: <c74b7382-dbe3-ecc9-17fe-b0e6e3b32b26@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c74b7382-dbe3-ecc9-17fe-b0e6e3b32b26@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190215
X-PR-Tracked-Commit-Id: ace74f73c200df4254788210ac70e00a7aeca4b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24f0a48743a256bdec1bcb80708bc309da4aa261
Message-Id: <155025120281.18592.12000726959545282467.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Feb 2019 17:20:02 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 15 Feb 2019 09:56:16 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190215

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24f0a48743a256bdec1bcb80708bc309da4aa261

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
