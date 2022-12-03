Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC04C4321E
	for <linux-block@archiver.kernel.org>; Sat,  3 Dec 2022 00:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbiLCAag (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Dec 2022 19:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiLCAad (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Dec 2022 19:30:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDB1F2C7A
        for <linux-block@vger.kernel.org>; Fri,  2 Dec 2022 16:30:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 872076245D
        for <linux-block@vger.kernel.org>; Sat,  3 Dec 2022 00:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBD8AC433D6;
        Sat,  3 Dec 2022 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670027431;
        bh=gqcPv1asTCQVD1J6R/fRDUniBpHcCRsXKwg1LDDFmHQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WKNez15ZgnYF4x5IlfuZSdZXzi/Y1I1WP/Iwi/TnxV2BQa1icSGV3HWxlgbhpFs4U
         MzzqYewNy4E7piLrLlX5Qw6XHqwz3Ez1Ch5QP1MA0+GohoUlynMUPqe+Ybp/LQUWwo
         C0b4AHvQ3Dsoh14dmwS3k/LYj0X1hmt0BUDirkZSLdEGCbBjU40DJIH5RES7RY0wj0
         iRe29VAhqhG/6O0hU0VxSSPrKZp/jjxjnQqa1I5mxecB1/hexhS/CPgYcbxQV0DZCe
         K6iW0Uzit1VQZ6Ge0Vcperasm9+bgGWb+dVESE0bjeL5f0oik+tZWjaxS2SAp7wMdj
         hHzcsVDrddo7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D78DDC395F5;
        Sat,  3 Dec 2022 00:30:30 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.1-rc8/final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0429607c-d5b1-6d6f-2cff-7b35f02a562d@kernel.dk>
References: <0429607c-d5b1-6d6f-2cff-7b35f02a562d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0429607c-d5b1-6d6f-2cff-7b35f02a562d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.1-2022-12-02
X-PR-Tracked-Commit-Id: d0f411c0b9bdef85f647e15a2fcc790b29891f2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97ee9d1c16963375eefdf964c429897d27e28956
Message-Id: <167002743087.3308.8740847421687527763.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Dec 2022 00:30:30 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 2 Dec 2022 14:38:06 -0700:

> git://git.kernel.dk/linux.git tags/block-6.1-2022-12-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97ee9d1c16963375eefdf964c429897d27e28956

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
