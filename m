Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F9BC433FE
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 21:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiEWVP7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiEWVPr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 17:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1647BE52BF
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 14:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 821A5614EE
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 21:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3AD4C36AE3;
        Mon, 23 May 2022 21:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653340502;
        bh=dWtOEDwUUswOCAKWgjim4aypJs3VIPV7/9yHxyB8ZhA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TKtg3nWA794Anhq7klQQvVMJJ8lp5ibApV37dS0ytiM4JNjVSGPVsVeQ9DndbSH/G
         3/HjyTjnUp+E0gPPSSgVtr/VUHGf5W1F4pMlQAwPMRQOLJQEWSDrC2KoEfwTRWqv35
         AhVxowD6Ay6ToOZQ6wXN0MPgoGX92RfJ4ekKWUJz7YHj6Pld4PS3is9pQ49k/SUeEK
         CrKAR6pC9S4WL/ljy8s1wrjvkq/Ufifj4RY+9OXTd4j488hExVqlH0tcga5hK9xclD
         dsKdgxU6byWxv1bu1Hc66C31wY8yPSEwrVRM2k2ou/IVATWMw2ndwcPS6Nhx1JhEvb
         6p7GlG8UUdpnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAC30F03935;
        Mon, 23 May 2022 21:15:02 +0000 (UTC)
Subject: Re: [GIT PULL] Block driver updates for 5.19-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <78d44e6d-cc98-83a6-8bb3-2b9e75501cfe@kernel.dk>
References: <78d44e6d-cc98-83a6-8bb3-2b9e75501cfe@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <78d44e6d-cc98-83a6-8bb3-2b9e75501cfe@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.19/drivers-2022-05-22
X-PR-Tracked-Commit-Id: 537b9f2bf60f4bbd8ab89cea16aaab70f0c1560d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5dc921868c507c1f0835932d3f255cf1b7415618
Message-Id: <165334050282.6568.15417953678121005889.pr-tracker-bot@kernel.org>
Date:   Mon, 23 May 2022 21:15:02 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 22 May 2022 16:00:33 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.19/drivers-2022-05-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5dc921868c507c1f0835932d3f255cf1b7415618

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
