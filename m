Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59357C47097
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 19:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45674613F4
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 19:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFCTLd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 15:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhFCTLd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Jun 2021 15:11:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 63050613F4;
        Thu,  3 Jun 2021 19:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622747388;
        bh=l7hjYQcSQZQ0tSTGHHAjE/ISbT/X/WQDwumUqz+IfHk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GvFUY9MuALqUdC5DngHmh8RNHnomCBWAraiDya2FqUADpibcFALMn6AoTys5yUn2X
         xHX6Fd+k1TOA71mj4090Ub/QGsmAb4TJRefdnuzInqOgNIze/e4zOgNlYkiXEzgbx9
         5JvmQStNdjQu0aJZlV4toDF2FPAIA9f6q64kJSwK3hMCsljkkDXUz64RLglvYCgdkR
         4Ic85PuPuF621GHhYePo3mxXwUESrxn2O2HwCYiV6POl4cCIilyc0vYXFsU1nQ4ght
         C1FjTxIkZoFASZpHA5YecO/9Q2WpHZUGv10npBgEt5zOgwRx8aAaeA22iwX+mTh5yf
         FHqAdp2r/l6IQ==
Subject: Re: [GIT PULL] Block fixes for 5.13-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cdd66f53-8316-a4cf-6cb1-0050dcf8cfe9@kernel.dk>
References: <cdd66f53-8316-a4cf-6cb1-0050dcf8cfe9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <cdd66f53-8316-a4cf-6cb1-0050dcf8cfe9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.13-2021-06-03
X-PR-Tracked-Commit-Id: e369edbb0d8cee50efa6375d5c598a04b7cb3032
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 143d28dcf23837a7e4c6a09e8ab369fdda81c0e7
Message-Id: <162274738837.14300.18100094335716117190.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Jun 2021 19:09:48 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 3 Jun 2021 10:46:09 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.13-2021-06-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/143d28dcf23837a7e4c6a09e8ab369fdda81c0e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
