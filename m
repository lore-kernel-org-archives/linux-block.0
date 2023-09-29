Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEF0E728F3
	for <linux-block@archiver.kernel.org>; Fri, 29 Sep 2023 20:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjI2UsN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Sep 2023 16:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjI2UsM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Sep 2023 16:48:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D981BB
        for <linux-block@vger.kernel.org>; Fri, 29 Sep 2023 13:48:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4599BC433C7;
        Fri, 29 Sep 2023 20:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696020490;
        bh=LNwqZ729V+pR1zOeLVnqNoyd1BZoCY9+C4tk9ejhwGE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H55al57ndF4MC0gnpQHG3vRuOCuiAXDLZjgTRLEvTMdYz/sf/FnzG13/mviT8Arye
         hfBvpj4xrcSHfOyAVmYXvMkxP+7jbQx/FZJ59LpLK1j7JtEAL3J/FwBGCi08Z8jw3F
         d4lzOd4uj8hqbO9YrkABaRBEKVtLtEGj9nXTsi4P93qbU+uBOoxQXd1D6REAgj85Kw
         AWkTpev8KM0+Uq/qb3kSES4j/Zfu7o9XXYtgqCgR1qvoddjdjWAC3VgLbBeQ2wygCQ
         PnPpurQ/P2wHQhYqompOAJ9TFflTdB+oFkiXWvz13UcIs2v4s9cNGZq381v1U2wtYk
         EMDkWw6n5Di+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32C33C395C5;
        Fri, 29 Sep 2023 20:48:10 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4d46a68a-8810-442a-8f6e-249ba8283c98@kernel.dk>
References: <4d46a68a-8810-442a-8f6e-249ba8283c98@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4d46a68a-8810-442a-8f6e-249ba8283c98@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.6-2023-09-28
X-PR-Tracked-Commit-Id: a578a25339aca38e23bb5af6e3fc6c2c51f0215c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eafdc5071351314702175a3cd083cf6f7eef6488
Message-Id: <169602049019.6106.13456194621414403023.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Sep 2023 20:48:10 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 29 Sep 2023 00:06:13 -0600:

> git://git.kernel.dk/linux.git tags/block-6.6-2023-09-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eafdc5071351314702175a3cd083cf6f7eef6488

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
