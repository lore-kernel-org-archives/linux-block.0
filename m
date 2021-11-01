Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EC7C433FE
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 17:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB63460E52
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 17:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhKARb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 13:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhKARb0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Nov 2021 13:31:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1973E60E9C;
        Mon,  1 Nov 2021 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635787733;
        bh=nbi3FT0g/owbxg7KHUyCcQn5uYIDUNQSH0Hf9C5FeLs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TQWmkImI//LUC+NUsgC2IIo+OnWpjZ6rStH1xhZfuBQTyPTjtFubOlixrZy/CUeXH
         a/XqgLXlQ+jXssU4NEfHXPCHwAF8oNwYLBEq+A78xMXqBVZp/1R2qcbHDxSsZWofWr
         qKK+6kBc02VwqXO29tmpfN4Rc6ke6+K7hd/Hl1g22VC+kYKu/Qfr+tZqP/lh1TsoPm
         SEr3UBjV8qemi+fHFfgjINSR/RBMg9pi2uSzPShyde5zktwLkOHR6ns2N30wY9rtZP
         qNzTsPy2INjBMHXyXO0S96a+xOgYOLcwPOKZjHTB67a75Ce5t6dtKtjSKKhRTiYnmI
         B3cUZKH4sK0sg==
Subject: Re: [GIT PULL] Block driver updates for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <36d0a261-bd28-123d-5eb8-4003eac7fad7@kernel.dk>
References: <36d0a261-bd28-123d-5eb8-4003eac7fad7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <36d0a261-bd28-123d-5eb8-4003eac7fad7@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.16/drivers-2021-10-29
X-PR-Tracked-Commit-Id: 15dfc662ef31a20b59097d59b0792b06770255fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 643a7234e0960cf63f1a51a15cfc969fafcbabad
Message-Id: <163578773306.18307.6637286486180893536.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 17:28:53 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 31 Oct 2021 13:41:43 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.16/drivers-2021-10-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/643a7234e0960cf63f1a51a15cfc969fafcbabad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
