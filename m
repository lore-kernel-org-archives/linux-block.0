Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3179C61DB3
	for <linux-block@archiver.kernel.org>; Sat, 28 Jan 2023 00:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjA1A1L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjA1A1K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2023 19:27:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA798114
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 16:26:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EF0DB82228
        for <linux-block@vger.kernel.org>; Sat, 28 Jan 2023 00:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4359C43442;
        Sat, 28 Jan 2023 00:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674865236;
        bh=KqGZ/uviYts/w99JS83xrvG3ZXXsG+X5WKfSJvsrPMQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wr+QFGEaTOM7jGMiyvfTb/tB62qj+/Xwy/oWUEovLOzug97+WI8Ue/2yAwGFmZMvf
         cSY58sRhMLzoE6ehGMgU5/+1Z4OQLqOPvcvCMGkQvfNHpshWtl+2Bvzxp8K7dCxEa6
         3Q4wWgpzhSuSkJLmjEN29d/7i3l4Or0Wxgx+Md3+gF9apCGWItMnMp8XkEu5Y/QkgY
         6P9la4zDc4okUvfNdzMcNsHmznSUduAVrSrrTS1RMQhExk2KLC5WEN2wYgWhZm5Qoo
         mPIwpvnT1mqAHzQWJMJlqyZlv9iG/jOuGHZ+3TBmGc5XRpI2683HIDmDEPSIV3t3/9
         ZAsAJr/KhewuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D25DDE451B6;
        Sat, 28 Jan 2023 00:20:36 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7f1de3c6-eab1-4e3c-a5df-e81fde4c5336@kernel.dk>
References: <7f1de3c6-eab1-4e3c-a5df-e81fde4c5336@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <7f1de3c6-eab1-4e3c-a5df-e81fde4c5336@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.2-2023-01-27
X-PR-Tracked-Commit-Id: db3ba974c2bc895ba39689a364cb7a49c0fe779f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90aaef4e35c4a74b0f1593d06e39eda867ef13d3
Message-Id: <167486523685.6770.2270244358378893349.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Jan 2023 00:20:36 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 27 Jan 2023 13:01:34 -0700:

> git://git.kernel.dk/linux.git tags/block-6.2-2023-01-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90aaef4e35c4a74b0f1593d06e39eda867ef13d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
