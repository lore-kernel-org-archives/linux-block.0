Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFEFC433F5
	for <linux-block@archiver.kernel.org>; Sat, 26 Mar 2022 20:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiCZUUJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Mar 2022 16:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbiCZUTw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Mar 2022 16:19:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD07F195307;
        Sat, 26 Mar 2022 13:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7525B80979;
        Sat, 26 Mar 2022 20:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE0CEC340E8;
        Sat, 26 Mar 2022 20:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648325889;
        bh=v4Ew2qBn5T+NKEBCgc0Jm8dbEJw5u1ZsaiY6KvXBYb4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P0XelicKuEOsabfUOJNqInhJFH4VKt8KimH64Rsev03puV2KNjt7VDV03tON03ffZ
         S4dQR+yEGl33Zh/gsf0uE2cNB7M8d/jpcXzgUxadBaR+MT9n0MVD+EqBW7Qnm2o/el
         xNSt2n2u7XJlwQLpimZfH90APqvJwVyUdnf6c4a+rTJZxoEE4elsUyNRJqwYxelvMu
         XSrlBQlKOHNQJJWcWfdpnsIan1MXg7L/G6HLhbP2YH1dDSQHLaJS+NR18akudtS0Jo
         5GcbO3XbG0U6eHSAy+7ssT+bn8BiGz4gzTUG1LZNeZ4pO6lPNYyrEFhTE3+RwfXAll
         jegO0IngXslBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C1D8E6D402;
        Sat, 26 Mar 2022 20:18:09 +0000 (UTC)
Subject: Re: [GIT PULL] Remove write streams support
From:   pr-tracker-bot@kernel.org
In-Reply-To: <72c1ee9c-2abb-3ee7-7511-e6d972f4413f@kernel.dk>
References: <72c1ee9c-2abb-3ee7-7511-e6d972f4413f@kernel.dk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <72c1ee9c-2abb-3ee7-7511-e6d972f4413f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.18/write-streams-2022-03-18
X-PR-Tracked-Commit-Id: 7b12e49669c99f63bc12351c57e581f1f14d4adf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 561593a048d7d6915889706f4b503a65435c033a
Message-Id: <164832588963.7233.669851893757228499.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Mar 2022 20:18:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 25 Mar 2022 09:08:59 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.18/write-streams-2022-03-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/561593a048d7d6915889706f4b503a65435c033a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
