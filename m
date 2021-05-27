Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A192C4708A
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 22:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6109F6113B
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 22:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhE0WGa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 18:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235664AbhE0WG3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 18:06:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7E742613D4;
        Thu, 27 May 2021 22:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622153095;
        bh=kwr/4Yp8BVXHSpaWOaZHWC3GLcNfoV0IsXtSZnQtJ6U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sJ+BfwDgHk5OSD2CurlEp2gEIt4DYn7s80g52dlhPOHSWKdweb110int1+l6PKMgb
         +WErxfcOSCb+KPWe00HDRd3zuZlEI2u1HQVO0FRHhq51AW/FDPTiTg3h4Csxgrfs/Y
         L7uHAcqpNpMv9hyxoUOmVti9rAb3fLXqE0o5kY2XA10FQmK7i51z6DNWYxr+MkqsLy
         VNsBmUo9Zu1hKfahAvyixeGwVqxAdOin3kHuPfm+/76vihnbojgWfH5NcVHizz0DU2
         o6IOLdmkxVJWZ8iTZTbdlHDGyAtmnx5kdFYcsqHRsD6k5wUcirTbcJ6X/UBvuVLVRu
         E940+0k8KTp0A==
Subject: Re: [git pull] device mapper fixes for 5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YK/qaSCdhqDlKh1l@redhat.com>
References: <YK/qaSCdhqDlKh1l@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <YK/qaSCdhqDlKh1l@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.13/dm-fixes-2
X-PR-Tracked-Commit-Id: 7e768532b2396bcb7fbf6f82384b85c0f1d2f197
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38747c9a2d221ad899a1a861777ee79a11ab6e73
Message-Id: <162215309548.27580.15255164845255433920.pr-tracker-bot@kernel.org>
Date:   Thu, 27 May 2021 22:04:55 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        John Keeping <john@metanate.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 27 May 2021 14:52:25 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.13/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38747c9a2d221ad899a1a861777ee79a11ab6e73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
