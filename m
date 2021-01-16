Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4BBC433E6
	for <linux-block@archiver.kernel.org>; Sat, 16 Jan 2021 20:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D17222CAE
	for <linux-block@archiver.kernel.org>; Sat, 16 Jan 2021 20:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbhAPUCs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Jan 2021 15:02:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbhAPUCr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jan 2021 15:02:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4046722CAE;
        Sat, 16 Jan 2021 20:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610827327;
        bh=lbbx+u5v1/2asYY+rF6qXrwswl2TvVHnjYViOrHQEAQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rPIh356rUynU/si2NmFFwnNMdvr6U9fs53W09GxfvHrCsg24VDRaxadfQVgid5hB/
         /FE+D/5v3Jgqw2Km9PJWwkok5KfyE53GR5VW8gxFiFiM90xIJuAFmAHl7q5BoVE0ve
         qQxqxgztgiZL7P/xEReD1yvl1UZzEiwuZuzLvi2q1iAeaAVEDghGrkFCbw8+HHG4wf
         HAEyLrViHZ8rkLKOFZhc7Acpa+AnHRfdmXV0uLlol39t9VySsQz69b2hczSG+6TWjg
         TteMg+ZM+ibDGNy6s1O6KVMKfwd/L7+OEPz6TJr1G6lE4tP2iqXOQYbMg0EUlvXh6z
         Okmq4VhztUDlw==
Subject: Re: [GIT PULL] Block fixes for 5.11-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <95bd6ed5-4851-bd56-f528-d6aebe55bfba@kernel.dk>
References: <95bd6ed5-4851-bd56-f528-d6aebe55bfba@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <95bd6ed5-4851-bd56-f528-d6aebe55bfba@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-16
X-PR-Tracked-Commit-Id: b4f664252f51e119e9403ef84b6e9ff36d119510
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54c6247d06f110d2129f9ef75e5eb02d39aec316
Message-Id: <161082732723.9271.9519876849434903585.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Jan 2021 20:02:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 16 Jan 2021 11:13:03 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54c6247d06f110d2129f9ef75e5eb02d39aec316

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
