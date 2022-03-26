Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFFAC433EF
	for <linux-block@archiver.kernel.org>; Sat, 26 Mar 2022 20:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbiCZUT6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Mar 2022 16:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiCZUTw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Mar 2022 16:19:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C84184624
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 13:18:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A4BB60DE3
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 20:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4E85C340ED;
        Sat, 26 Mar 2022 20:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648325890;
        bh=oKbLoCo7V2EBcQ1WeDDYruA5FqrD6dDbHkGj+MyzrAM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OZJ7ByVfSFlaswNgYEdg9+hfa+Wrh5Fca7iWmO1iPkunecxRWLUE06deH4RjnvW5Z
         pQoUmw2AkFvSn5z+lNKcGmrR+V2BzvjAAXef9GWpMxwVzUkg8mxMChsX49QyYK7+ps
         3DDSfxBcR7tdVHLrFLcyfLR5ReuukfqmCo1FJp+xq0D98GWFSJIxaWDPv+WuOxIZDf
         DiyQegymG2IZEpZXuUFFck/tNmP4KS9PS0hbXzXjn6w+VUcPqTYIUI5+WyDwnWXH8p
         WudA44CtRo1ujZ0ttQWUu95/at6c6z9aI8i6D1Ua1fNb5PuoHkKbEtscFPzUBlyvXy
         dMz5DRkCOfgog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3057E6D402;
        Sat, 26 Mar 2022 20:18:10 +0000 (UTC)
Subject: Re: [GIT PULL] Follow up bio allocation fixup
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a3c160b2-1e7d-06cd-4644-b2edf136726a@kernel.dk>
References: <a3c160b2-1e7d-06cd-4644-b2edf136726a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a3c160b2-1e7d-06cd-4644-b2edf136726a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.18/alloc-cleanups-2022-03-25
X-PR-Tracked-Commit-Id: 61285ff72ae59e1603f908b13363e99883d67e09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 752d422e74c41084c3c9c9a159cb8d2795fa0c22
Message-Id: <164832589066.7233.10565568245897793070.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Mar 2022 20:18:10 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 25 Mar 2022 17:32:15 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.18/alloc-cleanups-2022-03-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/752d422e74c41084c3c9c9a159cb8d2795fa0c22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
