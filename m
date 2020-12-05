Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B36C4361A
	for <linux-block@archiver.kernel.org>; Sat,  5 Dec 2020 19:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17F12311B
	for <linux-block@archiver.kernel.org>; Sat,  5 Dec 2020 19:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgLETWe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:22:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgLETWT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Dec 2020 14:22:19 -0500
Subject: Re: [dm-devel] [git pull] device mapper induced block fix for 5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607196099;
        bh=vl/ksZFlRXwC5qkUZ25jXVpIAO83WfmPACYxC4QTGjs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bgYzFj2ZLCebWBfpb+s7DAyNGT8/8YEqnXdiqCgJm63/2RV9RbN/TL/1nIvd9Yx35
         wXwejhH5a2Ol9it3G7T4cnIeoihgVgbAPVGlU/QU4j2HTu7HcuAT4ExnKtul4WHLPE
         u/jc5kdnWjMDC2HUs0Q5fRDcULe4oDr3TYiAILQjj4A0pr6qaGoh2xC/DTtwIObcGo
         wdiBo9lklEld0llCPlLl3skNrXVrH26rVx52NmYCpxZ8UQsUAyyOd5g5v+xj3nUwXh
         MK760xARafPn6woerY0+aqgE1pPISniTcuHBkvujQ9uS6IQBNezMTGvsnFiwEWI1Ne
         rsvHB0kGQ7d/w==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201204231225.GA4574@redhat.com>
References: <20201204210521.GA3937@redhat.com>
        <160711773655.16738.13830016046956700847.pr-tracker-bot@kernel.org>
        <20201204223742.GA82260@lobo> <20201204231225.GA4574@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <20201204231225.GA4574@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.10/dm-fixes-2
X-PR-Tracked-Commit-Id: 65f33b35722952fa076811d5686bfd8a611a80fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8762340561397fce0f0b41220ed9619101c870d0
Message-Id: <160719609911.18711.171386792638793811.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Dec 2020 19:21:39 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-block@vger.kernel.org, axboe@kernel.dk, dm-devel@redhat.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 4 Dec 2020 18:12:26 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.10/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8762340561397fce0f0b41220ed9619101c870d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
