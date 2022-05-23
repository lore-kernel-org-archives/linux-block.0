Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EE7C433EF
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 21:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiEWVPz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 17:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiEWVPk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 17:15:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C25FE27A8
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 14:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15AD2B81632
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 21:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF533C34115;
        Mon, 23 May 2022 21:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653340502;
        bh=MRbAwsdPcay5LPhIKOWbyGLG23DM9oRlHURQdGShUaU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vDPGLNuOb5CwVPWNOnCqKbogMbGG0fqWGuZOSfwx5QCWbQbDZcpVmgb1hIct7TECZ
         WIkObDifzE0JfKcGEg8MmShzPVRmEqDAaQC7vW5wACglpTluawUYw0MrPQAa0eNyFR
         dXXqEOgovJA9T39A3zvVU9f7gR2cK5QkRx85wIAVBBENRgVkHrEs5CX05vu9o8H56m
         WY+iPDk7DHY+JA7otCKgeHDg/s6rilr7H5rdo85/2ivIlKvSCIiymoyPvM1kT1Vaq5
         rhPmN1sxONlAAMXlNzAb8Wc032pxmC9DatKmvZNKHy3U4oLMrYnz1tok0d6OArNfby
         Xc6QW2glpJG4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BABF8F03938;
        Mon, 23 May 2022 21:15:02 +0000 (UTC)
Subject: Re: [GIT PULL] Block changes for 5.19-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4cf566ad-d7c6-cf62-3dd5-ed2069e3c2de@kernel.dk>
References: <4cf566ad-d7c6-cf62-3dd5-ed2069e3c2de@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4cf566ad-d7c6-cf62-3dd5-ed2069e3c2de@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.19/block-2022-05-22
X-PR-Tracked-Commit-Id: 2aaf516084184e4e6f80da01b2b3ed882fd20a79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 115cd47132d71bd7e4aa1093e15d861a59e73a94
Message-Id: <165334050276.6568.16004522538915587132.pr-tracker-bot@kernel.org>
Date:   Mon, 23 May 2022 21:15:02 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 22 May 2022 15:49:45 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.19/block-2022-05-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/115cd47132d71bd7e4aa1093e15d861a59e73a94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
