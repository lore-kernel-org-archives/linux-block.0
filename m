Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CA0C433DB
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 21:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB27664FA9
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 21:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhCLVwg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 16:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235358AbhCLVwe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 16:52:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A07F164F4C;
        Fri, 12 Mar 2021 21:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615585954;
        bh=KsntWkYZJuaMLv6wAI3STulTAYbFOH9qVWozDsrZ/50=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Eley5cQtFHzZGN41exXLasYU0kHIyw9iuEJojx8MrWw5w+kfNU5LfAyjeY7Lk8Xma
         ByAPmoPpO7OTSS/u3iIIHdCNFbOE9XyiIx/VdD+9TVoqQN8EDns6lD/EJNZhvm8Ckj
         PaP/o2slgCet7Uv4aeybolC7mQHt2DT5eGcYv336VHFJ8KtmrWBvuVx1+D9+M9Wo2j
         Cm//y8AcOxAp2uQzvwoDnmB4kgRJ5AZfF7R+c6QiswFAZCIQ+5BI/nHcyy6nAN4fv6
         lV+FEDf2CX/0F64200dmr0F196asPB1FjTNcNn94t4/f/nScwEEG8lI3YGbJRXi2Vz
         Gx0ZbpgP9Sv/Q==
Subject: Re: [GIT PULL v2] Block fixes for 5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cc2462b6-b7ae-200c-d9f6-1a3d1aac3632@kernel.dk>
References: <cc2462b6-b7ae-200c-d9f6-1a3d1aac3632@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <cc2462b6-b7ae-200c-d9f6-1a3d1aac3632@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.12-2021-03-12-v2
X-PR-Tracked-Commit-Id: f4f9fc29e56b6fa9d7fa65ec51d3c82aff99c99b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce307084c96d0ec92c04fcc38b107241b168df11
Message-Id: <161558595462.23578.17659547125093641353.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Mar 2021 21:52:34 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 12 Mar 2021 13:29:38 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.12-2021-03-12-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce307084c96d0ec92c04fcc38b107241b168df11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
