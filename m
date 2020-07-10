Return-Path: <SRS0=lEwc=AV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F26FC433E2
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 17:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65CC6207D0
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594400707;
	bh=kIW+04iieKLEkZBjehvP5lxiJiALXBX0h/2rGaKm0ck=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UUH05Ex2bKjfQjNIQDfGZlIqKU6Po1gMX8WnGp6SzpJyG6LPVL36mlEEugoQ9UgXJ
	 JpWs/mQeIzYzsywt9UVwSjtt03giA9hlcbUwxZBdIuoBV7rWxWdnZY6ykMwqvSlC7H
	 TjOyDMiFZXBFDyZy2oXS8LQM/Q+RjLtYWagI5h5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGJRFG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbgGJRFG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jul 2020 13:05:06 -0400
Subject: Re: [GIT PULL] Block fixes for 5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594400705;
        bh=kIW+04iieKLEkZBjehvP5lxiJiALXBX0h/2rGaKm0ck=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CDhPeFsX6dSRYU+JFdINg5tuokVMAdwDry2UNpfRHjktcML0/uQnNH1jb1q3megf+
         UmTgt9JA3VBkwqfgW9fofE43joRyzh6DeK6M3SF6JEqGhfCVmFMMWMZcCuh5DEB8FT
         4iXX+UbJ6vBf0ZV0/EIsTN4wMBzEtYnuxt7ohwEY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2f92637d-8261-2cc1-fde0-66731020e435@kernel.dk>
References: <2f92637d-8261-2cc1-fde0-66731020e435@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2f92637d-8261-2cc1-fde0-66731020e435@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.8-2020-07-10
X-PR-Tracked-Commit-Id: 579dd91ab3a5446b148e7f179b6596b270dace46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d33db702745b84fd553d9a5f5db85e122aa45020
Message-Id: <159440070564.31334.2805458829227049249.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 17:05:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 09:59:00 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.8-2020-07-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d33db702745b84fd553d9a5f5db85e122aa45020

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
