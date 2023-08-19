Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B77EE4993
	for <linux-block@archiver.kernel.org>; Sat, 19 Aug 2023 16:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjHSQBq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Aug 2023 12:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjHSQBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Aug 2023 12:01:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274B222A18
        for <linux-block@vger.kernel.org>; Sat, 19 Aug 2023 09:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B246560C8C
        for <linux-block@vger.kernel.org>; Sat, 19 Aug 2023 16:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F426C433C8;
        Sat, 19 Aug 2023 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692460903;
        bh=dGPyCdn5zWNYku9cApY3vLXW0QrLof0r1SlB7m6y41M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n99DqYNE1vjrPNGIPXpKEJqTx71pwruGetjoZnKFylEW7oS8Qo+4XAlFHKzD2we0a
         Yp/4GqnhxW/xfXBbzVXrT8BkkfNmiFlE9JSfQFnyaOsfbzJ5uI9BPbW9hTYNbIYPb7
         boEBkTsdT5FEBBHGJD07ZRglBId/S4XwGzuyrL8scqjFa/Xkb5/Y8CJ56WjUepLQVs
         qdUz4yFVt219SSNJUW9MYELooUAZuI84kQuk3gI/ho9gUkRMw1K7NfkEErI1uG3Oz9
         z7ycteWiGhQ6R6sOz/YX9A8lRW9fHBIrG5iHXyDsHaiwZy6IWirhj2VCJEoaiQsc5J
         kGvs6vs8FJjWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BF64C59A4C;
        Sat, 19 Aug 2023 16:01:43 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0ca594f5-3145-4e22-89d0-94c8a8f4ac22@kernel.dk>
References: <0ca594f5-3145-4e22-89d0-94c8a8f4ac22@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0ca594f5-3145-4e22-89d0-94c8a8f4ac22@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.5-2023-08-19
X-PR-Tracked-Commit-Id: e5c0ca13659e9d18f53368d651ed7e6e433ec1cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2383ffc41a7c701c058f6bb18030cd569aecd541
Message-Id: <169246090304.15016.14230852625914387647.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Aug 2023 16:01:43 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 19 Aug 2023 08:57:28 -0600:

> git://git.kernel.dk/linux.git tags/block-6.5-2023-08-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2383ffc41a7c701c058f6bb18030cd569aecd541

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
