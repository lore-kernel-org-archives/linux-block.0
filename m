Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFECC74A44
	for <linux-block@archiver.kernel.org>; Sat, 11 Mar 2023 04:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCKEwO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Mar 2023 23:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCKEwL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Mar 2023 23:52:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3470012CBAC
        for <linux-block@vger.kernel.org>; Fri, 10 Mar 2023 20:52:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6057B824B5
        for <linux-block@vger.kernel.org>; Sat, 11 Mar 2023 04:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88933C433D2;
        Sat, 11 Mar 2023 04:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678510327;
        bh=QbLhxGtIQPEGh7yupb+rqMmVVaeBjaUQfKRetfXTgvM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OziSLJNvE/ov4Kx6tWGw2j64mvYJHtvr7fVsMdeEh8sUEnymEcjwufGa8gaSVfKqK
         HmLijYv8EwkeEUSJaHaBKrQlfGJlxMLoX88VisUdkLrY/rf0wH3ttgrkgWcyWUiQcM
         xhmS0OaoAufv4OURyTGdRJ4GEJMMeq1N8bB68ybXm+D3bnBzpoSWzOHEHJjHZEp20U
         6OipqXNeRdbeCAjfWQyAoyVK/U+qZMtyyDZa4d/eUSG9pdgfvHf5SSA1tM3niD3aD0
         CNOOnaDkc+CpOMLdu5r+apJfkprA4ezJrBKQjXqPRx+3UGiGI7fVxtxrqediEJdIOI
         g2Z/bw/ouOM6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78159E61B65;
        Sat, 11 Mar 2023 04:52:07 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.3-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2d435dfb-178e-5055-e0d1-f53a72232465@kernel.dk>
References: <2d435dfb-178e-5055-e0d1-f53a72232465@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2d435dfb-178e-5055-e0d1-f53a72232465@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.3-2023-03-09
X-PR-Tracked-Commit-Id: e2f2a39452c43b64ea3191642a2661cb8d03827a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40f879bdd3450f20ff1db48e7a8366fc24dcc7fe
Message-Id: <167851032748.30895.12520608737240249519.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Mar 2023 04:52:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 10 Mar 2023 10:35:01 -0700:

> git://git.kernel.dk/linux.git tags/block-6.3-2023-03-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40f879bdd3450f20ff1db48e7a8366fc24dcc7fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
