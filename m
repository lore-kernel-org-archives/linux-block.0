Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEACC761A6
	for <linux-block@archiver.kernel.org>; Fri, 31 Mar 2023 20:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjCaUBQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Mar 2023 16:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjCaUAu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2023 16:00:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2143D20629
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 13:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 296C762BA3
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 20:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F204C433D2;
        Fri, 31 Mar 2023 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680292809;
        bh=gMfFomDHiO49wN2BjqJ6zOnMUweQlausIKUuCE0jGzE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dz7VYpvW5DN1EBL3gw6fTm9JTVH0hocehlQfIR1uZuozbIhsDtFzlCMa1MlMOnieV
         RkjyJMOx9cZdMd0+Icws2QI/us1g8qbm9Di/OJwnX54f1iaxWGUH5+dTX3o6pMoykE
         VfZWQ6xaVAy3yEAEfCIO7Uy/n28MjPle+cBmo1QLRhetkEkvMV2L6NybUWwNEecx6f
         Yj0AocqAsSS7UtRmTi6DsD2WXh8ub6b4MTwC0fdYlaD7DvbhgKR8u1LtYb6DxVCYBC
         g8AWHhe4W+B9r8rrNGUBCx4yekdEQeWR0CrLVEs/HtspH1f2Fnno0PMcxJmB3vOUSm
         8CnFf5orlFCIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A40BC0C40E;
        Fri, 31 Mar 2023 20:00:09 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c8733191-0707-6bac-ed60-f28ef537cf92@kernel.dk>
References: <c8733191-0707-6bac-ed60-f28ef537cf92@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c8733191-0707-6bac-ed60-f28ef537cf92@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.3-2023-03-30
X-PR-Tracked-Commit-Id: 24ab70d83784a807c9ddff939ea762ef19bd4ffd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81409e5e483cbdf6930e24c8556a289266fea39f
Message-Id: <168029280949.14353.11449463539986224662.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Mar 2023 20:00:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 31 Mar 2023 09:29:24 -0600:

> git://git.kernel.dk/linux.git tags/block-6.3-2023-03-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81409e5e483cbdf6930e24c8556a289266fea39f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
