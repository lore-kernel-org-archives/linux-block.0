Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F914C25B50
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 20:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjATU7j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 15:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjATU7h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 15:59:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E801A95AC
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 12:59:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 85ADFCE2AB5
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 20:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB9C9C433D2;
        Fri, 20 Jan 2023 20:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674248372;
        bh=NB8EmiE8vb4+uwtIPCgt5/0+gIikxKh1TRXCAV+0mkU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KcZlp3+VfQMB0WL1QK/VSt4eGqVi9L/iCcMMfplfoIZvA7CKrHNj2ljA/Pa9VSqRs
         mJqFf95FDKJgDAZKctktdd0NqOsY4ZIuxW7iGn6Gq8zbuBUEnFTH3CSGm1TIuaCiyQ
         z8rUZxjVLL2q7X+Gdd790S5eyyRxs5ZJztMCQEb6yCvddJ0UfidORsA+CqcX36lg9E
         ou4rw1lBn4z02Rh6boQFsXnfJkSG5QtjhqVIZZ0NW0lNvCHMl0JPvuD4MU52QVQ0tL
         tN61mHPVuDo7X+Ux7OD2QtVCF3iMK/gseOOa8qeFzVOE4oi4b5E0kb6y0DTHmnjX35
         VGAlCaM1vldag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B974EC04E31;
        Fri, 20 Jan 2023 20:59:32 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <305650d8-0477-19df-c043-f59b9b75cb48@kernel.dk>
References: <305650d8-0477-19df-c043-f59b9b75cb48@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <305650d8-0477-19df-c043-f59b9b75cb48@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.2-2023-01-20
X-PR-Tracked-Commit-Id: 955bc12299b17aa60325e1748336e1fd1e664ed0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: edc00350d205d2de8871b514c8f9b403d588e5d1
Message-Id: <167424837275.22595.7708241474464372958.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Jan 2023 20:59:32 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 20 Jan 2023 13:02:10 -0700:

> git://git.kernel.dk/linux.git tags/block-6.2-2023-01-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/edc00350d205d2de8871b514c8f9b403d588e5d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
