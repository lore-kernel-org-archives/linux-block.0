Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AB5C6FD20
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 21:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCXVVr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 17:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCXVVq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 17:21:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ABD17CD0
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 14:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCA17B82615
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 21:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A79F3C433EF;
        Fri, 24 Mar 2023 21:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679692902;
        bh=ycY/Wsgntj+pmt1P+caQ5FpG++cNLXTgEtf7ds97wfI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y0/V8FpitcA+7sckKr9QaGuaDd/y4Jr+BDQwKM+ro42+uvkISxIBsx8Oo0wm7IhPv
         OKCfcQ8DQOtsG+OTRKYmuSQSqzWKZf/XTsoHTZ9GxWvfBklqxXv3BJAco/tHsPOMwQ
         eUA5TsPxeX2P9yGBYMie4j/ouGCCgkel6d4tsbl1knrYkIzkbJ1f1yENQIoivNGjwx
         MGC5kvWVg/eqLQorYUCoWVpCjelgcviB+ZYpj26TRafbCpFLbJFyFXfZtYYSzyv/lJ
         uj1yzhoBRmpWt6KU/3kh0NvW5hI1dv9ZT5wdkGVe+XfgjzoJ7MOyZbts/dzooFPV4/
         31HuovwEjZmxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95955E2A039;
        Fri, 24 Mar 2023 21:21:42 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a3e790c2-e454-f49e-b2c0-2353ceb9752c@kernel.dk>
References: <a3e790c2-e454-f49e-b2c0-2353ceb9752c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a3e790c2-e454-f49e-b2c0-2353ceb9752c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.3-2023-03-24
X-PR-Tracked-Commit-Id: f915da0f0dfb69ffea53f62101b38073e0b81f73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83511470af1a734ec47c37957612d2eecf1a2352
Message-Id: <167969290260.24410.12845855669619178324.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Mar 2023 21:21:42 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 24 Mar 2023 10:28:48 -0600:

> git://git.kernel.dk/linux.git tags/block-6.3-2023-03-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83511470af1a734ec47c37957612d2eecf1a2352

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
