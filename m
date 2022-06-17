Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73650C433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 18:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiFQS0f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 14:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiFQS0e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 14:26:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29A53388F
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 11:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7083B82A03
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 18:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 526F8C3411F;
        Fri, 17 Jun 2022 18:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655490390;
        bh=OZSYaHqdHbwGCbrnw1smhTVYmFfQWSP94v6h8Sdkrho=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gzOLiv/gG5pKAR1LCCm2xtF/obS3ohrcqqnlQy3Y2myoEPATnMIH0eVFld0DyKvzc
         335Pau4uzhSuD8mfs+aJy9qAoqTmmCC+Lkucp8fB8rE4zMDk4ejoF943PkpkQCV3kW
         OU3kIlEPffCdIA3Fkm634G8p3Tcwa4B+bILtxImyA1GHBWrlhzKrnk0jN6V+gM8WMw
         UpfvvLagmWEtewH0tKCFVJ8b+Wcs9E94952hrRpxtW8rISrybcZB+s7ywbSGidwGL9
         ksSysxpqK8mIi2VGmJPEZzhsuMy/etOvyMNr2d7kjPIYnWm65eP2lmWLvQF757L/tZ
         prhsJ+nv+sKfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41117FD99FF;
        Fri, 17 Jun 2022 18:26:30 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <de7e4802-15b6-fbe7-f793-4454c3913f6a@kernel.dk>
References: <de7e4802-15b6-fbe7-f793-4454c3913f6a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <de7e4802-15b6-fbe7-f793-4454c3913f6a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.19-2022-06-16
X-PR-Tracked-Commit-Id: b96f3cab59654ee2c30e6adf0b1c13cf8c0850fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 462abc9de7a13d90c5dcb81f440465041d06ba75
Message-Id: <165549039025.23060.15634396521569303767.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 18:26:30 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 11:11:39 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.19-2022-06-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/462abc9de7a13d90c5dcb81f440465041d06ba75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
