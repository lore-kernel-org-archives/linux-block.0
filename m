Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1F2C433FE
	for <linux-block@archiver.kernel.org>; Sat, 29 Jan 2022 13:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350630AbiA2NOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jan 2022 08:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350519AbiA2NOp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jan 2022 08:14:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21ADC061714
        for <linux-block@vger.kernel.org>; Sat, 29 Jan 2022 05:14:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83FA460DBF
        for <linux-block@vger.kernel.org>; Sat, 29 Jan 2022 13:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC1CDC340E5;
        Sat, 29 Jan 2022 13:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643462085;
        bh=ZwjGg9YckBML13QCp/jVvb5Y2h2YnGT8+N0RAheAoNk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SlsxVOf4nQEQYS6NA/EBZjTbVK39wDsgzD5krWZg8ltTSs/GYaPtXXPndxIVt2Wjy
         gw8qHofWOGRcr40+GkaG4DoRcE1r8/crcXRdnhXDcWbRCYBBR8WxRSyggV9VV9nsKY
         q2dB6jFbeX4JgfMwGH1m6+A8ZbKGp/u603YV02QfnPZ9N0WtIvE6/I7HYyi3PokfHi
         d/GLTmBufS1GPkSk0tpqoMjUg9evCiiiAYK4cO3P80yCAbh+3W+UCbfgUVBS5wXtEA
         09Ey4uwcDlzJW5N2KZG/JEKnB2YY24mOSkjAM6ffxUYDP2+PWRMfuzmXLb1uRCjCB3
         aLLY5HZnHL/vA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBCFEE5D07E;
        Sat, 29 Jan 2022 13:14:44 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a6c3f018-4235-3707-75b1-3c79adfbd15c@kernel.dk>
References: <a6c3f018-4235-3707-75b1-3c79adfbd15c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a6c3f018-4235-3707-75b1-3c79adfbd15c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.17-2022-01-28
X-PR-Tracked-Commit-Id: b879f915bc48a18d4f4462729192435bb0f17052
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb323ee75d24e7acc2f188d123ba6df46159cf09
Message-Id: <164346208489.11910.14645834482247359854.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jan 2022 13:14:44 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 15:07:29 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.17-2022-01-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb323ee75d24e7acc2f188d123ba6df46159cf09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
