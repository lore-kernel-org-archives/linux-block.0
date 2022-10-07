Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3CFC433FE
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 17:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiJGRBQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 13:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiJGRAm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 13:00:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D712B186EA
        for <linux-block@vger.kernel.org>; Fri,  7 Oct 2022 10:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F409561DC7
        for <linux-block@vger.kernel.org>; Fri,  7 Oct 2022 17:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6400C433B5;
        Fri,  7 Oct 2022 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665162026;
        bh=4vJeR18Y9w1104TLDf4R2aVUBw7DM3fI8aM6+pUTjvw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wlc7ZtFGZiaflsHiXjmmjmY7pm4dS5Y2xk14oWi9tNRr874YyH4mJcuSjSzHgtQDM
         t9BXsh45EYTXbPjkfCRNrQv4fA5nea2HlX5xdpvDM75rR93PVst+d3HMe7x0H/BBIM
         PM+OVTawi1g+qB4b4fmeQCpuPznUCauicJZaMVLXTsTUzsjZhIF4BLqbmOoNfr2+Qg
         RVPgT6OoGsNv/eKKh0N5aAD0MS/Y0PyL4KG2dWB8D3vL/2X3uLYcGv2SwafL346ASq
         7AOzTdETq8pdqy3TVTv9wJunquKRuDMk/ZrQ9EYwzp3IQGBZ8wULTlBy8LlXj6ZX6T
         sXof0Z+sWUeJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC77AE2A05D;
        Fri,  7 Oct 2022 17:00:26 +0000 (UTC)
Subject: Re: [GIT PULL] Block changes for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <37a0bf85-4e31-18a1-5a20-7fe9fc5c0f3a@kernel.dk>
References: <37a0bf85-4e31-18a1-5a20-7fe9fc5c0f3a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <37a0bf85-4e31-18a1-5a20-7fe9fc5c0f3a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.1/block-2022-10-03
X-PR-Tracked-Commit-Id: 30514bd2dd4e86a3ecfd6a93a3eadf7b9ea164a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 736feaa3a08124020afe6e51f50bae8598c99f55
Message-Id: <166516202669.22254.13418351510170463181.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 17:00:26 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 3 Oct 2022 13:18:04 -0600:

> git://git.kernel.dk/linux.git tags/for-6.1/block-2022-10-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/736feaa3a08124020afe6e51f50bae8598c99f55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
