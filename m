Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3AAC636CD
	for <linux-block@archiver.kernel.org>; Fri, 10 Feb 2023 17:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjBJRxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Feb 2023 12:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjBJRw7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2023 12:52:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A695774046
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2023 09:52:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43B8061E79
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2023 17:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD61FC433D2;
        Fri, 10 Feb 2023 17:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676051577;
        bh=VSYSe9LipJ6BJ9SdtPd5sSWTWVeQUZYtHKuxSxMCd0E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pU7jWJWbf+q1vG5zQtQ1ScVHrRCBedNic+s9jLcQh7dQ6EJ4vvycrulpq/DQxVXUC
         hZ6vB73PlQ+x89jGHtWCknVisZk03PwVb36eK42if/e7tgG4/qa+UG6iquUWpbtkT9
         kNMf8tAUE/tz2iKVRKY7S5LG6V41sF7vv4ARqKOIrwF3i/Aja/CW2iDbbOCoCUZFk+
         9AsL88NOS/pNkuiP1wMPjQllO7nhny+LSCuk95rW1ZReASrywCJ+h2OtoVEhI2JxLQ
         WYih01XwGLax3B6Kp61rwP1aXRcWVb+idRQ/3MYG2/HdvfleZkufh5/kiwstHLh/97
         zwhDfDuuSRJ5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D53CE55EFD;
        Fri, 10 Feb 2023 17:52:57 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.2-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0834a42a-fc2c-6847-4f4d-4125d41e60ba@kernel.dk>
References: <0834a42a-fc2c-6847-4f4d-4125d41e60ba@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0834a42a-fc2c-6847-4f4d-4125d41e60ba@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.2-2023-02-10
X-PR-Tracked-Commit-Id: 38c33ece232019c5b18b4d5ec0254807cac06b7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29716680adbb221a5cd1604e11e81c6f2938e06f
Message-Id: <167605157763.13061.10795667905701820039.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Feb 2023 17:52:57 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 10 Feb 2023 09:11:25 -0700:

> git://git.kernel.dk/linux.git tags/block-6.2-2023-02-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29716680adbb221a5cd1604e11e81c6f2938e06f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
