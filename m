Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098F6C433F5
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 21:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiEWVP7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiEWVPr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 17:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017B4E52BE
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 14:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55EC7614E5
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 21:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA681C385AA;
        Mon, 23 May 2022 21:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653340502;
        bh=QEm9Wmml26Y4a28QoSLrYEM7wRt+4m0HmUJORVc8yuI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cbsa/FlTgIAbdL6065nbcxZEmXSfzGLP6gBnBOWeuqqh6Ew/H7s/nH5mZ4pJT/EeJ
         RSbgIkztZXpIVMVAhjmYV55LpKY7Uy5Y+ulwWo77Bec7qyZRaO6ObnY4cX7f7AqHe9
         WcFfAlGkCg7IR6tuhaItlqL7XopkSpS9M/2LMPQGf5WrCz7QDTW0eNP1qY8CIXC6g4
         xsqnZY/8zVCzZUtGsbinMzQtLJ9CacvSZAk8dIM2IC6IGy27uR4njYbvR+IOib6lgd
         Nlb9/xGd6AVPRzp60wNLLjiSyTDyMU657rRpjrLLfHrRXT2C4VFhjeTF97JQ8SIZN/
         ttjH7D2P5DMRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7C47EAC081;
        Mon, 23 May 2022 21:15:02 +0000 (UTC)
Subject: Re: [GIT PULL] cdrom updates for 5.19-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f274c991-1e1d-e42a-5f03-59fc49113a25@kernel.dk>
References: <f274c991-1e1d-e42a-5f03-59fc49113a25@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f274c991-1e1d-e42a-5f03-59fc49113a25@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.19/cdrom-2022-05-22
X-PR-Tracked-Commit-Id: 2e10a1d693b9f1c8921bd797838cff0be7cdd537
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6792c877a1cacc3b3eea7cb5b45857b3c484c51
Message-Id: <165334050268.6568.5151158051195281056.pr-tracker-bot@kernel.org>
Date:   Mon, 23 May 2022 21:15:02 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Phillip Potter <phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 22 May 2022 15:37:32 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.19/cdrom-2022-05-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6792c877a1cacc3b3eea7cb5b45857b3c484c51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
