Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70ADC05027
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 19:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjBCTtF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Feb 2023 14:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjBCTtE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2023 14:49:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E87A42A8
        for <linux-block@vger.kernel.org>; Fri,  3 Feb 2023 11:49:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF93AB82BAE
        for <linux-block@vger.kernel.org>; Fri,  3 Feb 2023 19:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A38CCC433EF;
        Fri,  3 Feb 2023 19:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675453737;
        bh=hfwjXwTV4KJZHdINswRsRVwJufb5MZtKEiymevnRjBY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NNQ9Wjgj96QXebwOaZAEYH0h+lRhue9m4G9OC0tddGZyILqs26ceTmgxSb2B6lnX5
         SILwgVQBbY3gS6aF8MaEpRR9B9kBc19mdPHsGdiEtLW60Qw22dr3s83wTkT8tNyuFS
         CpYBga2FHYu5IFdm0DfD0RHhZflwpSGLmzw/YlpqHoh+cw4Jq5ZDKtEfTqQNNrCZLv
         t9lWdgNedIyW81/fh37lwEqJ8wLjWu1rq3tsCBaEzcvHMdqx/xdBL8jrxScmDseRcB
         jkIGC+s9W0yC5ZSiJyRyQ36pHWLjw8mX2n+fsw/YOlKEQ29zODA7Mal8/knd3raqYo
         Q8V1WfjyNRHNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EE60E21ED0;
        Fri,  3 Feb 2023 19:48:57 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0914e4ad-7922-4ac7-b3bf-be5db7075236@kernel.dk>
References: <0914e4ad-7922-4ac7-b3bf-be5db7075236@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0914e4ad-7922-4ac7-b3bf-be5db7075236@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.2-2023-02-03
X-PR-Tracked-Commit-Id: e02bbac74cdde25f71a80978f5daa1d8a0aa6fc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0136d86b78522bbd5755f8194c97a987f0586ba5
Message-Id: <167545373757.32538.17612878412408059320.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Feb 2023 19:48:57 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 3 Feb 2023 12:30:24 -0700:

> git://git.kernel.dk/linux.git tags/block-6.2-2023-02-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0136d86b78522bbd5755f8194c97a987f0586ba5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
