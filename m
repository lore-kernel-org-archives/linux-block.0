Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB05C3F2CD
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C05246A3
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 19:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582919711;
	bh=VnhlLswStTjmBq7H9XxaPX/JSH2QRV9Ny3mxJ90xhTU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZLxIe4Yu1n6KZIxtA7cG+mvuDnqkZzjFDmjxKjODv+v1LQJIy7j3o9WUcu6W5VO8L
	 AbKIzdLeWfRlhpxYjcV0zfz/J3IrAWjzgisy4ap+4YMeQoccnZSjn9GF8KQXY6ncwq
	 l2KwWbeNapq8HV/MyZREqXZoL/rYrnxkDibouI78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgB1TzK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgB1TzI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 14:55:08 -0500
Subject: Re: [GIT PULL] Block fixes for 5.6-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582919707;
        bh=VnhlLswStTjmBq7H9XxaPX/JSH2QRV9Ny3mxJ90xhTU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IU7rC1BAs1b6ylHyNDXRXlhrPK5kbjOQe55gHbSPCmCHtCiZD2xvebLx+wq6H303i
         +/5YAF5+iOLpaJcwmIkDy0T3uZH911yqk+xGQEiXN62zAfymgdO8aZ8YqCDhWaJ+oJ
         998Lae2xa2akEVGp5ge07LcpTJpoLCDsZTP4S0+4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20fc1cef-97db-f9be-e308-58e539b97298@kernel.dk>
References: <20fc1cef-97db-f9be-e308-58e539b97298@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20fc1cef-97db-f9be-e308-58e539b97298@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.6-2020-02-28
X-PR-Tracked-Commit-Id: 5b8ea58b6a338cb981670c4408225331aedb4b89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2edc78b9a4b868d7bfee4f87ea29f2df19b6e955
Message-Id: <158291970770.11737.14703358750997423301.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Feb 2020 19:55:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 28 Feb 2020 11:44:21 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.6-2020-02-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2edc78b9a4b868d7bfee4f87ea29f2df19b6e955

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
