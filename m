Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7EEEB64DC
	for <linux-block@archiver.kernel.org>; Mon, 26 Jun 2023 20:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjFZUGM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jun 2023 16:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjFZUF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2023 16:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E9F26BD
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2023 13:05:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 432E960FC5
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2023 20:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3E2DC433C8;
        Mon, 26 Jun 2023 20:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687809758;
        bh=IN5lRk/+Ja+vB1eDr7hYhYm4ub+0/sMJcou/P0oPdHE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ut4rbZVCobxroCddlBhQF0yQD7WIsmkGxgafl7HGDPyhGxcGEa5YhzWQQfCNIZB3f
         gpXlNNNXinLjpkdmyAUIY46f1AWBQKRVV6lna0EC8Vwv5/oEwpS891aTJqLBJSFHyV
         7ITkHD5jVWDqdJPehVyeuwb4TrLxQaQ0Qwre2uiCysPLARhKlveYmptFmMy9WPb3Lb
         TkD1f7dptLN2TKLZ3dzbWiLdm+blVwjBiFqlAFgHdiakvrBHc43xAxdgxjH/alW/nl
         0Xsy1yw6PLs7EHVqgBhGXSyjUaT9MUR+F2gzqzwqMCS3pPTb8yx/9gNxMRzU0+hzTf
         qlJYqvxPZWmig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90BE7C43170;
        Mon, 26 Jun 2023 20:02:38 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f1ee5428-1302-ecaf-e87f-43bdabebfaea@kernel.dk>
References: <f1ee5428-1302-ecaf-e87f-43bdabebfaea@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f1ee5428-1302-ecaf-e87f-43bdabebfaea@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.5/block-2023-06-23
X-PR-Tracked-Commit-Id: fcaa174a9c995cf0af3967e55644a1543ea07e36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0433f8cae3ac51f59b4b1863032822aaa2d8164
Message-Id: <168780975858.7651.16649543652658091422.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 20:02:38 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 25 Jun 2023 20:39:13 -0600:

> git://git.kernel.dk/linux.git tags/for-6.5/block-2023-06-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0433f8cae3ac51f59b4b1863032822aaa2d8164

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
