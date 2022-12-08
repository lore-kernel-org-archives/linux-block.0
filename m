Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BEFC4332F
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 23:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiLHX55 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 18:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiLHX5x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 18:57:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB4879CAA
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 15:57:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 728AAB826A7
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 23:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32DEDC433EF;
        Thu,  8 Dec 2022 23:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670543869;
        bh=zPpdzUvXzJOEDJzPmmPTy8q4FfQjOpTNsDovy11Yup0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LYR3KAcbyAagZg9oScCf5TZ/3sXn4GOKKi1CLl1NPwy4whRkJbp9ctsHJJMiZ/DWp
         ClAcCO4xRv+KlfJe/7yq8PnOY31K1tQ8zQXxmIx5xDKQvXbzc7CW0tk+HxPiCSZp8z
         +C+e4yeDtQfgXpOhsd+zL9tKxY1Qy3n3hvPMFIgCo9SkKc5uh29rFg04DmPlrKUNqN
         OnwcCoNko4n4l7VtqAOt+RBMVe1od3/fwr6k4mJavcauk5pE4Al4W8OUo/NYpL5G6I
         5ZnRy0i4ptKJVwR31fTm3/vNQYag618gBujjsnBu4idHUlJNHQUal+IAANyBRG1LAS
         ZbN6/P2e5YdgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23AE2E1B4D8;
        Thu,  8 Dec 2022 23:57:49 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.1-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <40dbd6f1-be33-6536-4e2a-e7f0120a2fa1@kernel.dk>
References: <40dbd6f1-be33-6536-4e2a-e7f0120a2fa1@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <40dbd6f1-be33-6536-4e2a-e7f0120a2fa1@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.1-2022-12-08
X-PR-Tracked-Commit-Id: e18a9c18c38f523ae45416e2b75ed4ddf8ad107b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 859c73d439cd9113333a75e683e9433c0092990d
Message-Id: <167054386914.21053.8832680620140116865.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Dec 2022 23:57:49 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 8 Dec 2022 14:03:01 -0700:

> git://git.kernel.dk/linux.git tags/block-6.1-2022-12-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/859c73d439cd9113333a75e683e9433c0092990d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
