Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096DDEB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 19:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbjFPTfj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 15:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346255AbjFPTfg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 15:35:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C27D3AB5
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 12:35:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 017B962C7B
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 19:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65B1AC433CA;
        Fri, 16 Jun 2023 19:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686944127;
        bh=xuZPOEljgr7ITvT+k30SIMpuclOKF/8JZrMtUS2FUy0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IlJhzLhIKTP/fT+O+GwfQtgTgscZIsmUms3je93el8vBEGIJumOb1ewAWKvZm9cGl
         n1gH6EkICQdKMcpSK/MdyDvoP7KxcynOjiDQsvIFFBVBXD+szrML43SNAMkGJb6p30
         vo1u2uPpVL60NHgCfsraO888Nn4Lpu/zK4zYLV5a6QPWYe2pCVm7Hvwyz8mmVFZkf9
         J6fk3MOcuBl0prs/hqj/2uvdPK7yp6n/QR0KKqhPSAS24kyYq5BtK2d3oldRX/WUYS
         h2f8geb95Qw3fp/21hkdbbaGjtIijuBbONoMDKpnzXDKq9do2UaRNEVpUux/Dz1Ii5
         xdhl0ySJ4ogLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52FBCE21EE4;
        Fri, 16 Jun 2023 19:35:27 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2045ee6e-6d52-deae-462b-1f87f8bab305@kernel.dk>
References: <2045ee6e-6d52-deae-462b-1f87f8bab305@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2045ee6e-6d52-deae-462b-1f87f8bab305@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.4-2023-06-15
X-PR-Tracked-Commit-Id: 20cb1c2fb7568a6054c55defe044311397e01ddb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9c1133a44a9b1dc485c79c64c8dee51e8869229
Message-Id: <168694412733.25417.12571930496695499352.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 19:35:27 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 16 Jun 2023 10:14:13 -0600:

> git://git.kernel.dk/linux.git tags/block-6.4-2023-06-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9c1133a44a9b1dc485c79c64c8dee51e8869229

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
