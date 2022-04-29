Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE7C433FE
	for <linux-block@archiver.kernel.org>; Fri, 29 Apr 2022 23:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381811AbiD2XdD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Apr 2022 19:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381807AbiD2XdC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Apr 2022 19:33:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153CACD655
        for <linux-block@vger.kernel.org>; Fri, 29 Apr 2022 16:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9414D623C2
        for <linux-block@vger.kernel.org>; Fri, 29 Apr 2022 23:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2B10C385A7;
        Fri, 29 Apr 2022 23:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651274982;
        bh=CuwlQkzzJxR7QabbZmeJ7i7SZClSbthXIPU3VbMa1/k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dWFPl5+wIdQCWMiGQRddf2crfnOASW64m438KUrS3NW87WDEzswalCU88T2sGeKQW
         q3xsonoDp9JKeCfEWoZLatTa3CoyiPhUHAKH6Pe8DPfp2chJG6+GEqxGf+OlQ+oVnk
         KtEtW6nb1KVqZLkygy/BKD1kGvzcIut6BxFlOQsYD1CMDRFLH7NgDeOwKlBx6HXd27
         7x/pi4xG1Knc5IQ58l5w0Sgg6utLlr2CYRbTWlq5srBRSLVqorLkpiRaVnLl9oexLi
         XfwwhRdSKmUjnOrWlHSSZCPt8FGYnBoB2ol0x4QvBH8lCU5jsEz21wdJO9Jtq/I7cc
         zwMTO2a96869g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E11C0E8DBDA;
        Fri, 29 Apr 2022 23:29:41 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7b3769f3-34f4-db1c-8f53-85d47f2e72c3@kernel.dk>
References: <7b3769f3-34f4-db1c-8f53-85d47f2e72c3@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <7b3769f3-34f4-db1c-8f53-85d47f2e72c3@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.18-2022-04-29
X-PR-Tracked-Commit-Id: 09df6a75fffa68169c5ef9bef990cd7ba94f3eef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd3d3adea90e2d4b82efc29eb6f10ee4d9f55e6d
Message-Id: <165127498191.20495.3667699348854625610.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Apr 2022 23:29:41 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 29 Apr 2022 12:40:45 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.18-2022-04-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd3d3adea90e2d4b82efc29eb6f10ee4d9f55e6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
