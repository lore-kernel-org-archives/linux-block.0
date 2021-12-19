Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FA3C433EF
	for <linux-block@archiver.kernel.org>; Sun, 19 Dec 2021 20:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhLSUza (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Dec 2021 15:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhLSUz3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Dec 2021 15:55:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E8FC061574
        for <linux-block@vger.kernel.org>; Sun, 19 Dec 2021 12:55:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34121B80DC4
        for <linux-block@vger.kernel.org>; Sun, 19 Dec 2021 20:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBA4FC36AE7;
        Sun, 19 Dec 2021 20:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639947326;
        bh=7GjIFkH/3NKk7x0kxI0JjkVRX3q+wH3JqtAS1VTYe6Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RloAHAvTN6IT+i04kRGpxb7JwJboQCtcOH24YvwTb4PKy7UBUzEI6dUYIuvfqiQtz
         CZtP/Xq7qge4486D0U6d5S6AxKec7CoRdB9n5G1+Neuaa359U6rSrFSbV01t09J0jE
         8zAzRFMCop8YCN1PBwQWkKZYbIimq5G5/nH1onEoErRTy0XpXXppMBFnq9OvAep1c6
         dBsrg3TKm6ot/GFU16uwC6B4C8Fuoiytum+fWFV2noEbf7CeMIyulBdZwRSxttKr1A
         UGIUNAtnXF4Pqr0nMO1ElzZbmMXNWVlJEE6OqWC3SR8yeQZJXXWCUcexHMSMnF+CDo
         0qELxCZfNhBCg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BA57160A27;
        Sun, 19 Dec 2021 20:55:26 +0000 (UTC)
Subject: Re: [GIT PULL] Block revert for -rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b49f11c8-11b3-6d81-288a-9ca545763a1d@kernel.dk>
References: <b49f11c8-11b3-6d81-288a-9ca545763a1d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b49f11c8-11b3-6d81-288a-9ca545763a1d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.16-2021-12-19
X-PR-Tracked-Commit-Id: 87959fa16cfbcf76245c11559db1940069621274
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2da09da4ae5e1714606668bdb145806b0afe9c90
Message-Id: <163994732670.21051.9819140458539627584.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Dec 2021 20:55:26 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 19 Dec 2021 10:13:58 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.16-2021-12-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2da09da4ae5e1714606668bdb145806b0afe9c90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
