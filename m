Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0776BC4332F
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 18:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347610AbiDOStd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 14:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347170AbiDOStc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 14:49:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6E772446
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 11:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42161B82ECD
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 18:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF081C385A4;
        Fri, 15 Apr 2022 18:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650048420;
        bh=SMERHxjK95pCnHwsJKP0CqYCQ6ZPt4RsVyttAggblLg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IQ0wpOLogUKKUCYF8YuDwA3UXWhegS8MQsi4Q1zpRqY+Rm87JgpcHSwH0mp4R+701
         SMuCfYElPp3Z0CzwNGlO49Z4ITrBzXLvkC60LKAfNXP6BMC6BZsrUgcJWjJrtJEjkU
         sNl7T+cFXLBrm9hmnKIjn5LVjlknmbyczppLO4WvffZOzoIoynfWDtd+UTDuvaJ0bp
         SHjED7DTx6w3VlfpjYNweay7Likbd0KFr5LiB9JLUeywVONWwb7c97o3uOnWA0Gi+x
         MexA37/T9EeZGXgcWZ3ZNIatBvQ8HE/Urge9S8FHNTm7rf/A1stjMmF0QbmsSz1qjK
         fq70EO4w/xWYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB155E8DBD4;
        Fri, 15 Apr 2022 18:47:00 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3a9f60a9-01f7-64fc-cd84-b76d162b528f@kernel.dk>
References: <3a9f60a9-01f7-64fc-cd84-b76d162b528f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <3a9f60a9-01f7-64fc-cd84-b76d162b528f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.18-2022-04-15
X-PR-Tracked-Commit-Id: 89a2ee91edd9c555c59e4d38dc54b99141632cc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb649bda6f5642f173ee3429a965c769554f23d8
Message-Id: <165004842082.6717.4928396518546930576.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Apr 2022 18:47:00 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 15 Apr 2022 07:24:46 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.18-2022-04-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb649bda6f5642f173ee3429a965c769554f23d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
