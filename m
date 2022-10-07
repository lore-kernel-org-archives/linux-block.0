Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3976AC4332F
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 17:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJGRAa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 13:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiJGRAO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 13:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A910E61122;
        Fri,  7 Oct 2022 10:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDECD61534;
        Fri,  7 Oct 2022 17:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62938C4347C;
        Fri,  7 Oct 2022 17:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665162011;
        bh=owkagnxI42ebTssGLXbwlxRCdBKPF+ieRWZYKekRLg0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F4dvPofocKt7GtsTxPWjrkwlYTN0XLNmzVVzBrT0iaMH+imMO2m2KkABkFQDcHUPs
         qkmVSTqBZdmiw5Ax6lzmA6laMrTz+QBq5Sz1egOBncocWK4QMXvNLYEs2SLR+ghLk/
         9xml1i9oErgSxyvHGh67/TcwMNLE7xZUlHVjiNjWjaX8FaSjgTYZpvNUO4+mAGPYjV
         OCOQiBX+unjY3EhR9ybklyqWwKwWEA8/GbzA+Q1UW6kzqwko9IndsQJs2MbPJzBQJ8
         VEXcjxP2deai1f6AleGULrK1zzICEvL6aX+Lpqvw1GrQRkHfrCbZKG5q5XfxOE+dEV
         djeBVoJFpBkyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A12CE2A05D;
        Fri,  7 Oct 2022 17:00:11 +0000 (UTC)
Subject: Re: [GIT PULL] Passthrough updates for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <dcefcabc-db87-f285-ddce-ad8db26feb2e@kernel.dk>
References: <dcefcabc-db87-f285-ddce-ad8db26feb2e@kernel.dk>
X-PR-Tracked-List-Id: <io-uring.vger.kernel.org>
X-PR-Tracked-Message-Id: <dcefcabc-db87-f285-ddce-ad8db26feb2e@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.1/passthrough-2022-10-03
X-PR-Tracked-Commit-Id: 23fd22e55b767be9c31fda57205afb2023cd6aad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e0abad2a71bcd7ba0f30e7975f5b4199ade4e60
Message-Id: <166516201129.22254.11733817102806284633.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 17:00:11 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 3 Oct 2022 13:40:17 -0600:

> git://git.kernel.dk/linux.git tags/for-6.1/passthrough-2022-10-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e0abad2a71bcd7ba0f30e7975f5b4199ade4e60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
