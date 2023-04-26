Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2F7C7618E
	for <linux-block@archiver.kernel.org>; Wed, 26 Apr 2023 20:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbjDZUJt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 16:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbjDZUJr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 16:09:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECEBA0
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 13:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE667638B6
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 20:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D4B0C433EF;
        Wed, 26 Apr 2023 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682539785;
        bh=UuiD9eTKiiWI5L98A9ThY49CVVCbfhhFFPWfSPXeru4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r6ztpAV/QMdMKgTrQExI2Ro75sA5kVDvFZ9apGHccnx9qq+3wODHaNgw3yUMCXr8O
         nihw2BuSmfiIbI6qxBA6DVN+w3oLJClnquzlfGkp/3U1ExuncfJSfc4Y3kUZPr0Hra
         TIVB3jchiQb0THjVf7BvwLxUTBdHUdh614HOis3NaeQeVmbanLwXfRLjKApeopz2Ca
         CCOZ+lcyVp8qqQYVUtGwbbHidBr8zELafpWVy0TMPrJ0Iva4H7bZSbwlTiOkaA/OBf
         Dyz8Y1T8AUYrUHi+agk7xWZA1DVloAMT7FG3FzbpoE/A8cZcoGLS1su3LkmnMiCQef
         km5SCvmb7oHyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A982E5FFC8;
        Wed, 26 Apr 2023 20:09:45 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <360c9052-38c9-ae6d-2bdd-206482d75132@kernel.dk>
References: <360c9052-38c9-ae6d-2bdd-206482d75132@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <360c9052-38c9-ae6d-2bdd-206482d75132@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.4/block-2023-04-21
X-PR-Tracked-Commit-Id: 55793ea54d77719a071b1ccc05a05056e3b5e009
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9dd6956b38923dc1b7b349ca1eee3c0bb1f0163a
Message-Id: <168253978516.23673.18096827487225934672.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 20:09:45 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 21 Apr 2023 14:00:28 -0600:

> git://git.kernel.dk/linux.git tags/for-6.4/block-2023-04-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9dd6956b38923dc1b7b349ca1eee3c0bb1f0163a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
