Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B1BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 00:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiCVA1k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 20:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiCVA1g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 20:27:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A5A3235F1
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 17:26:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B67B615AD
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 00:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91F60C340EE;
        Tue, 22 Mar 2022 00:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647908758;
        bh=vylH8xV8ST+ejd7uTCD9I7+NMdHgdnwfaXYrRQkSUM0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kzxC7kxBBMjYZ2biQgd9LWGf7BsIDzGYmOfuk2bgmW2eSL+2DSOwEtDZWvOGFos59
         J6XEm12cEWJ0SkLQl2cT6juq8KcGbSRfvNl1Eaw4V5g1FYb0I/OFfDHRoEY2UncyDc
         3QRkl5QUbwJsTbQdKsbeOYPg5bFNuPN6CRfMGl/5YJGf1uEqrcE+cM2UftNWQ0+4nU
         oc2Cs3V5Voa/5fvw+ccjLEuLqTgkeUPZMNVVwgAiGa0ji0eB0vqc5molN8zfsnqR1j
         yjVQqbzRbjBfI8CMZGZJWV1K1/y8aE6QVuDsmYIbYI1xdLSvLCaXKAliPyzRmLlEaU
         TIDj8wjHrVdKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80730EAC09C;
        Tue, 22 Mar 2022 00:25:58 +0000 (UTC)
Subject: Re: [GIT PULL] Block driver updates for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <83ce22b4-bae1-9c97-1ad5-10835d6c5424@kernel.dk>
References: <83ce22b4-bae1-9c97-1ad5-10835d6c5424@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <83ce22b4-bae1-9c97-1ad5-10835d6c5424@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.18/drivers-2022-03-18
X-PR-Tracked-Commit-Id: ae53aea611b7a532a52ba966281a8b7a8cfd008a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69d1dea852b54eecd8ad2ec92a7fd371e9aec4bd
Message-Id: <164790875852.30750.8607653540305972177.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 00:25:58 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 18 Mar 2022 15:59:30 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.18/drivers-2022-03-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69d1dea852b54eecd8ad2ec92a7fd371e9aec4bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
