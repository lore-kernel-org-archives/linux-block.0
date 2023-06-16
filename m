Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42184EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 04:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbjFPEQt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 00:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240880AbjFPEQl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 00:16:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552222D6A
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 21:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEBC260EA0
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 04:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E590C433C0;
        Fri, 16 Jun 2023 04:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686888999;
        bh=3a461/sRZRy7Aji03G6gfaErTpSDIpYaELKOKDGiLAE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MKpJ67wYO5m3/5DsLBjtElKTnnk3xGayJQICtzsKCH0MmhcKuNbXFdo6Mw67auBbQ
         adLYs/NjW7iouNTqW23ch7dS4oaIRQhybnjyXTXhO+pXCF5UoCI9aW61OyScGNI0D9
         Oouxd6pMNDMyorhOL7V2o4WZT4Tm2gEacTjy88U5u0NEzyoDCxtiD9JU36BUA6a099
         5+dqTL+VqsFlxh7tNrghyeuxRctx+WeX5vgSb0bKjV/baE4LmW1WF84iqbltf6Vbpu
         EG0abxR+od2V0oWyRQBBNK3aW3ObwhJB3URORsrq/lnT/KtRl2gKKc9J7hSO7kf0TG
         XdFBXt8FKbC3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFE17C3274B;
        Fri, 16 Jun 2023 04:16:38 +0000 (UTC)
Subject: Re: [git pull] device mapper fixes for 6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZItQzl4ommfR82jP@redhat.com>
References: <ZItQzl4ommfR82jP@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZItQzl4ommfR82jP@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.4/dm-fixes
X-PR-Tracked-Commit-Id: be04c14a1bd262a49e5764e5cf864259b7e740fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e306952d7151afdaa16e9acf280a739d1fe7b29
Message-Id: <168688899897.32380.1290343559572704575.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 04:16:38 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Li Lingfeng <lilingfeng3@huawei.com>,
        Mike Snitzer <snitzer@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 15 Jun 2023 13:56:30 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.4/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e306952d7151afdaa16e9acf280a739d1fe7b29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
