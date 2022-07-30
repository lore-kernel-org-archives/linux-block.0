Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90346C04A68
	for <linux-block@archiver.kernel.org>; Sat, 30 Jul 2022 17:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiG3RVx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Jul 2022 13:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiG3RVw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Jul 2022 13:21:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D1417592
        for <linux-block@vger.kernel.org>; Sat, 30 Jul 2022 10:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 887C2B80C70
        for <linux-block@vger.kernel.org>; Sat, 30 Jul 2022 17:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 398D2C433C1;
        Sat, 30 Jul 2022 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659201709;
        bh=teEmT1ez+3rfDPkPxdmDYX1kfJUARIGEcO2CHhVFG5Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VQXP1uBrK/t28QJvFa17OKNgG4JDLZ9AeV/7m7Pffnkew9njxFyu15yxJTuzTe8aA
         zOFCScBwkEB1i+NBfQIpmC1Z2cLnoJnwVIHyUVZtqmHod1bXY81zqgdS6KCvEK2Ces
         Sygv72jnAORvkPw+3aGJAaQUi8i8OXwjcX1oCE/Ps4bZ5xzCR5VtpcvfcPlxPzw0WR
         oSRJgIXPqXoVTU4GmXxN5MuKEhCkpjcRHZ3v8gbdk/5k3lES6iSzP8/XdvuGD+EpNS
         HVw0AYqm5g+mfYfrfB7Pw5/RCF2sMjNLHjJsSoAoPBFVwy75dYf45om7TKzpNDOneA
         huEZbFsmQytig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29324C43142;
        Sat, 30 Jul 2022 17:21:49 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 5.19-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <284e0073-acb8-ba91-a714-0df18187c5be@kernel.dk>
References: <284e0073-acb8-ba91-a714-0df18187c5be@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <284e0073-acb8-ba91-a714-0df18187c5be@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-29
X-PR-Tracked-Commit-Id: eda3953b6a805d6df87a4c51058493ec88bfc622
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a91f86f3e9e9608210166c70aaad4919018c0e7
Message-Id: <165920170916.12403.3302558459598275353.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Jul 2022 17:21:49 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 29 Jul 2022 16:35:07 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a91f86f3e9e9608210166c70aaad4919018c0e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
