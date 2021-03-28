Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38864C433E0
	for <linux-block@archiver.kernel.org>; Sun, 28 Mar 2021 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0509561999
	for <linux-block@archiver.kernel.org>; Sun, 28 Mar 2021 19:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhC1TLo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Mar 2021 15:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhC1TL2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Mar 2021 15:11:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 04BD26196E;
        Sun, 28 Mar 2021 19:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616958688;
        bh=aVZfCrgK6ji0Vh6jiXt12fgtYs9ZTX7L7/37EN6eCf0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gydkNAkp8vBi04bHiKQmoem+foTkEwuC6Q2PDLtahlHADEEDLHa1Rgdjk8Yi2dXI7
         eiBsg0+2vciJMm7xUE+x6uDY6QCv2TUawufst3tkZJ7pVSr4RKfRomXggbEEHaPuXf
         R6h7Eo9nybioPSsFVkGLzlQj58Yooeg1QlqeCCp21FmtcfKduuIZQFSMWJ3PSAuVFx
         AVxudpe6kej+W957bz4MMFFgwb4v3lcnkDQx3qRwVhYY6KdJtOTBM3aSDsYSkxmGpR
         bc+kS65e1a1f+P3Q7HiLyQTtT6MNrdFy3YSWhTh0/qcTA74qs0vk2KUsctg3kiqA44
         ATJ2ULJyTQT1w==
Subject: Re: [GIT PULL] Block fixes for 5.12-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e5bb408c-534d-4255-8a97-e525e686c596@kernel.dk>
References: <e5bb408c-534d-4255-8a97-e525e686c596@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e5bb408c-534d-4255-8a97-e525e686c596@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.12-2021-03-27
X-PR-Tracked-Commit-Id: e82fc7855749aa197740a60ef22c492c41ea5d5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abed516ecd02ceb30fbd091e9b26205ea3192c65
Message-Id: <161695868799.24587.3003965637939966694.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Mar 2021 19:11:27 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 27 Mar 2021 19:04:37 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.12-2021-03-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abed516ecd02ceb30fbd091e9b26205ea3192c65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
