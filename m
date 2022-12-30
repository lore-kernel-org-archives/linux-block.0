Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD80C3DA79
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 01:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiL3BBM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Dec 2022 20:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiL3BBL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 20:01:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44ED62D1
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 17:01:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 751DCB81AB8
        for <linux-block@vger.kernel.org>; Fri, 30 Dec 2022 01:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F875C433F0;
        Fri, 30 Dec 2022 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672362068;
        bh=2pz0LcaOPDGcm76H27kZdim4DwcirkpsKuXE6JG9+3U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D+efappkVtLRJ37NA6rA+qOW2KxVA5TrnvyWbkGKjqTfkQaAYFS78Gog8HMDqzrgy
         hwT4FPMCbxnZajzg5g1PuNKT9jBfrhB8VVKglDLme/lLiNAiTV5W6wJ94bq30XFQe3
         Im0YmuOGRG+i+UplILlGMJHo+vEDt5sT8Xh+bOQBrSKskVIOCwBjoz2SDj2kFYXvxn
         wAThoEojhHBBUx/04+qgQOcevez9RxioRRNFiAsrfR4rqaHvQQPpx7xkFYjgGyGN7/
         ugYB5XOtOxESgAcwalI23ssbsMJo+OKWzSl1lYLbwFQqVfWJI8w34TQt3qf0ABA3B0
         TXXnHSIzMzLZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D6E8C43141;
        Fri, 30 Dec 2022 01:01:08 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.2-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <66ad5fb6-f9de-e47f-336c-7ab14424732f@kernel.dk>
References: <66ad5fb6-f9de-e47f-336c-7ab14424732f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <66ad5fb6-f9de-e47f-336c-7ab14424732f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.2-2022-12-29
X-PR-Tracked-Commit-Id: 1551ed5a178ca030adc92b1eb29157b5e92bf134
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bff687b3dad6e0e56b27f4d3ed8a9695f35c7b1a
Message-Id: <167236206805.9684.17957880617362968279.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Dec 2022 01:01:08 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 29 Dec 2022 16:36:29 -0700:

> git://git.kernel.dk/linux.git tags/block-6.2-2022-12-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bff687b3dad6e0e56b27f4d3ed8a9695f35c7b1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
