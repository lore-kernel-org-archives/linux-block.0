Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829C6C7EE2F
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 22:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244315AbjEZWYF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 18:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244178AbjEZWYE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 18:24:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6E1E4D
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 15:23:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF4B86545B
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 22:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CE00C433D2;
        Fri, 26 May 2023 22:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685139808;
        bh=j+i01lrlRtsw8h7i5DhyyFRuEYSnpAlXf0Fams9TpeE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ggNySR5QHHRYwxOhUZ3+k98B1FeiEwNxnAC0aVC+9zuidtKqpVt6rLZybSAGuNC2B
         y08KfnytKE4ChvYlqj8o0QrgBI31N01U3wzLvo1+K8mHmrkz/S3MH9ILsWZzGq5sTt
         AjYcPLXvRFtFl19J3To1uamLNf43YPRLsZn+5+pGCrdgvs8jvwf50/Bi85XOHWNNm8
         DFx6YeI+3XKy7bPkU/f6aQILCNkPn0uWDCoZIDYDoQshrW7TBYe0nlg/htoP7Zkq1+
         ZziwhevEYNrIO0TSCroT+loSrt5Tjq5WmN1XYfIoxst3kVFc4PQmaHb6zLE3qn7/Wy
         9fkE+RY60yKcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0AB84E22B06;
        Fri, 26 May 2023 22:23:28 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <61594ff7-f3ca-b609-7b0f-9c520f6df46a@kernel.dk>
References: <61594ff7-f3ca-b609-7b0f-9c520f6df46a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <61594ff7-f3ca-b609-7b0f-9c520f6df46a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.4-2023-05-26
X-PR-Tracked-Commit-Id: 9491d01fbc550d123d72bf1cd7a0985508a9c469
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a92c9ab69f6696b26ef0c1ca3e8b922d1fc82e86
Message-Id: <168513980803.10240.13900564112662131453.pr-tracker-bot@kernel.org>
Date:   Fri, 26 May 2023 22:23:28 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 26 May 2023 11:17:35 -0600:

> git://git.kernel.dk/linux.git tags/block-6.4-2023-05-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a92c9ab69f6696b26ef0c1ca3e8b922d1fc82e86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
