Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404B1C433F5
	for <linux-block@archiver.kernel.org>; Fri, 21 Jan 2022 14:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381032AbiAUO1Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jan 2022 09:27:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60112 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381061AbiAUO1I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jan 2022 09:27:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AA85617C4
        for <linux-block@vger.kernel.org>; Fri, 21 Jan 2022 14:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81D6FC340E3;
        Fri, 21 Jan 2022 14:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642775227;
        bh=ZGxRIaAiZIkNAgdBGNhAvuRt47w1gyKYhYaLnE4uayU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dm7RuRTFwoEHCsjjju+QhyjCPMDEHCBKcSCcdC+WUOBg69ZZwFro91IGnSTt7vIDv
         tMfbfJCL5YIOwOEmBl4eVSbkuHkBwy1TsJSb08dYQz/6EQoWRh7hQ8EJ0M/oHQHSug
         iB5nQMdappjGWNE4Avd22OYHLaiDzHvrB+Pk5EETIsJte5t1LgLQ/N8SGpKSnRPmJO
         tWl3XcuNcWCG4W/2IZhRb09U2DHx1WioCKEkSCXCOPNzGUMtIOz6xtyX9KaFXdHm8Z
         bb0RCYjXOmgS+PdvRXKrLFbM78fOMGxlKu1UnI+1favJkbcYKSyV/V6iILjM3K2MwB
         hlh4dzmuUsgFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 713CEF60798;
        Fri, 21 Jan 2022 14:27:07 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bc78bf16-3c07-66a3-fa1b-a07cbc95ac84@kernel.dk>
References: <bc78bf16-3c07-66a3-fa1b-a07cbc95ac84@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <bc78bf16-3c07-66a3-fa1b-a07cbc95ac84@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.17-2022-01-21
X-PR-Tracked-Commit-Id: 46cdc45acb089c811d9a54fd50af33b96e5fae9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c7c25038b6c7d66a6816028219914379be6a5cc
Message-Id: <164277522745.13796.13493167825211771643.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jan 2022 14:27:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 06:41:01 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.17-2022-01-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c7c25038b6c7d66a6816028219914379be6a5cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
