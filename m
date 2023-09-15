Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D6DCD37B1
	for <linux-block@archiver.kernel.org>; Fri, 15 Sep 2023 22:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbjIOWQv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Sep 2023 18:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbjIOWQZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2023 18:16:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3180C91
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 15:16:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE08CC433C8;
        Fri, 15 Sep 2023 22:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694816180;
        bh=qwCXZyynHzaOdCwFkP6lrJH3+rUEuXW8D7zqJSgQvpI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PXy40EFzwkSMArPOVzoiDP4GK4GZri4hpOEkJzwt4Rels7sVngv5zqGNdrO5Rxr7J
         C2LF81V0/t0g0iowFBiXALQkWT4/wbx2dt22vvmaDOwKoPmfPEcRizJbe1SSitXEh6
         POqZX19l8L5JvBdBUkLzl7NGeIknEsF1+zFLv3TMMYUalDMHrMzPJi4DjgF3dLbSYY
         vx5VKViz0kkScOBbjL3CIfhYA/XK1WNEcAWwDEl8k3edjVl/vOYU7t86UYuygnfTOv
         9mWhlxBzjMZN8ipeuNPbJM/G/xX8sgVCNDUvHo6MI2+DcSEdfzTy2iSOHtN8XMHTZD
         9pyUrpW2Q7bjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBF70E26881;
        Fri, 15 Sep 2023 22:16:20 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6bda4994-5bda-4b18-9143-c862baa9de35@kernel.dk>
References: <6bda4994-5bda-4b18-9143-c862baa9de35@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <6bda4994-5bda-4b18-9143-c862baa9de35@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.6-2023-09-15
X-PR-Tracked-Commit-Id: c266ae774effb858266e64b0dfd7018e58278523
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bc357b215bdff924c38589e6e043ecda8fb9756
Message-Id: <169481618076.11838.9311433953429315710.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Sep 2023 22:16:20 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 15 Sep 2023 09:46:17 -0600:

> git://git.kernel.dk/linux.git tags/block-6.6-2023-09-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bc357b215bdff924c38589e6e043ecda8fb9756

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
