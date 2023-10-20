Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE74C001DF
	for <linux-block@archiver.kernel.org>; Fri, 20 Oct 2023 17:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377915AbjJTRnM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Oct 2023 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377919AbjJTRnL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2023 13:43:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C771A4
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 10:43:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0034CC433C7;
        Fri, 20 Oct 2023 17:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697823790;
        bh=NVgdUg253Xa3YzQJiCf+3AHufSOxzQmwzRSEyvMVoNs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rKsnFIStvPcb711d3276K4NMxWnO8g+dCfSFV3a8KFNZi/y50P59mdprTD9twx9/8
         qnfe+xIP9HoVgQi/mQooEgAwUltAt++w6ZBkhcYU6K7eb+wUaSEw724afdtPw/o8AF
         jIbDryUSP0pBhSPLbbB0rcUSmE/X4E/Uil7e0FJMF7KCDwl9NIm6kaFdPegRYPUFgq
         v08kN0mpgeLutsBw9jliO+RQJR+iQ3rBsQbozoMRm6t3i915+Kraln4TXsl9dUgLPw
         AaLtBdg0uaem3PL4/bKWlj8GWt7fAfTKMMTHmaOCzzI9bNdAckxmVFhXHVN+OEcU5n
         1oSpVEyyZx9Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1AC5C595CB;
        Fri, 20 Oct 2023 17:43:09 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <749c0287-422a-4e7b-ba96-e485f777ccda@kernel.dk>
References: <749c0287-422a-4e7b-ba96-e485f777ccda@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <749c0287-422a-4e7b-ba96-e485f777ccda@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.6-2023-10-20
X-PR-Tracked-Commit-Id: c3414550cb0d4dfad1816ee14ff1f44819d270db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3200081020d63f6c6bfd8a6db2ae8a5b99b348a
Message-Id: <169782378991.18812.15261395349328686100.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Oct 2023 17:43:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 20 Oct 2023 05:23:10 -0600:

> git://git.kernel.dk/linux.git tags/block-6.6-2023-10-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3200081020d63f6c6bfd8a6db2ae8a5b99b348a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
