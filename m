Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8D1C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 18:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbiFCSuY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349103AbiFCSuJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 14:50:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9870B2870D
        for <linux-block@vger.kernel.org>; Fri,  3 Jun 2022 11:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CF9EB82469
        for <linux-block@vger.kernel.org>; Fri,  3 Jun 2022 18:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A81BC36AEA;
        Fri,  3 Jun 2022 18:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654282203;
        bh=qrbF4NIzQoWUa0lGx1ExUCn+Hfnha6TUf4L7VhpPaec=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VV2fTU6dfp+82mtijRiIT/5P1It+JzraX8ICAIZ+9mBy2guK3ALqwwI6YSE0vNsPx
         ZYUWms0PAJy0wKv+dbdZ3eM6e4tTFm12eAUqT1f1XZfo3ozUvoNYymHvtwlbi8h6y+
         qGmzhdca4tT1dGwRqWU3Pldf/3gTWNP1zyaLKVVHkuhdIelIvuU4xaVwePm/YmUOj6
         qH0a+t9FDkUP02AqVFmO2qL6w0Vqozxu1q9vQcuti3LwkTsooZM7ifX1yGjph/Dbqa
         uDdnYc5wat+b2lYn9S1EN2JqMr18EYu20eMQ18rqetRHULWK5FIEij2gYpWoFG/5qk
         zvOWS7R1twH+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 354DAF03953;
        Fri,  3 Jun 2022 18:50:03 +0000 (UTC)
Subject: Re: [GIT PULL] Block exec cleanup series
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0d5a62fc-6d6a-5dc8-bb15-d494184909b9@kernel.dk>
References: <0d5a62fc-6d6a-5dc8-bb15-d494184909b9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0d5a62fc-6d6a-5dc8-bb15-d494184909b9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.19/block-exec-2022-06-02
X-PR-Tracked-Commit-Id: e2e530867245d051dc7800b0d07193b3e581f5b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72fbbc3d0e3e3117c29a73d0b4d928dc00ed99ce
Message-Id: <165428220321.10974.2428487377776466789.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 18:50:03 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 2 Jun 2022 23:32:23 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.19/block-exec-2022-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72fbbc3d0e3e3117c29a73d0b4d928dc00ed99ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
