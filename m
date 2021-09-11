Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B0BC433EF
	for <linux-block@archiver.kernel.org>; Sat, 11 Sep 2021 17:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F0861213
	for <linux-block@archiver.kernel.org>; Sat, 11 Sep 2021 17:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhIKRbS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Sep 2021 13:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232447AbhIKRbS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Sep 2021 13:31:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BF0DF61039;
        Sat, 11 Sep 2021 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631381405;
        bh=05udhESN44bMnRAK5nd1rdhVr4JRM8c12NBYZqbdErg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xdk8paseDai/BMuR9KneufsXWq/g4sIUdTaqmpAtaxTCgYe6liHEVd5iozZG2he5+
         PLia+nakLiTU5XOXaaq0L0H5sOuFvWHmgyY/DcAI4xzxGNvuj/0mfJzPo2E3BDVOBX
         d/VP85qHLnNHYit/E1ZfEPiwCvumYwHSqfAQI/CPteDi9hQw4WkAl/o1RJiggnmBuY
         SYo27f0xPsuIcL+mojLTtoNigRS5HV6Gh1U2Cq0SgTYUOAZv8mT5QU+R2fRwK2Nwhw
         KW9C6xFwskAntNvhdthfHAVsyWgu4aPGwl5tLVCE9luFx2NDMC9lhyNG7lRRUemB3P
         YVlHb5UCCk9yQ==
Subject: Re: [GIT PULL] Block fixes for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e165b1c8-2e0d-13d9-36a5-2a58191d8b0f@kernel.dk>
References: <e165b1c8-2e0d-13d9-36a5-2a58191d8b0f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e165b1c8-2e0d-13d9-36a5-2a58191d8b0f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.15-2021-09-11
X-PR-Tracked-Commit-Id: 221e8360834c59f0c9952630fa5904a94ebd2bb8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0f7e49fc480a97770e448e0c0493e7ba46a9852
Message-Id: <163138140574.31565.13076476979859448479.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Sep 2021 17:30:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 11 Sep 2021 08:29:38 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.15-2021-09-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0f7e49fc480a97770e448e0c0493e7ba46a9852

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
