Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C389CC433F5
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 22:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A891B60E74
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 22:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhJIWHW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Oct 2021 18:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230503AbhJIWHV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 Oct 2021 18:07:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 668F660F23;
        Sat,  9 Oct 2021 22:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633817124;
        bh=LqD/buSs9YH7vumRkDqUIw/OX5Ke0GhPFiFoWOGWEgY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fI5rijtKTplQzYvuNRvqoTGVjKVabbHevh1djDSthTxYhqw6aBOhej+ZjtUkH1GOS
         WfoPWiX6Vrc/O2UMfRTLZLpnmu/Jx1/SL8zLYLYU4c+hfaKscYuzlj1XEqfQKV7J+C
         jMZCxrf1WiXI/FaA6Wr6Zm2c9SulnDoqL/SRNX29mhIjjsuiTqDfSGacah5LwnhZSM
         kd9T53EWG9lncYbBGAhfUNxqPLhuonrN1YW4quKwjBR70qIsX/U8xaaQEnJJvCgDo0
         xp81X+F1HR1t+Ik48q/fv2Etbtcip8nAXRw8y8RLxJkKBUYgxA1P9+qOUa6FaSZh2H
         WA1+YArLYkHKQ==
Subject: Re: [GIT PULL] Block fixes for 5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <05521e6b-9f74-0949-43eb-5029f27d9061@kernel.dk>
References: <05521e6b-9f74-0949-43eb-5029f27d9061@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <05521e6b-9f74-0949-43eb-5029f27d9061@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-09
X-PR-Tracked-Commit-Id: 1dbdd99b511c966be9147ad72991a2856ac76f22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50eb0a06e6cae01d8a8d63770030d01ac2fb572a
Message-Id: <163381712438.3348.1010839962749303448.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Oct 2021 22:05:24 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 9 Oct 2021 12:45:49 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50eb0a06e6cae01d8a8d63770030d01ac2fb572a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
