Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35A5C433F5
	for <linux-block@archiver.kernel.org>; Sat, 25 Sep 2021 23:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF446108E
	for <linux-block@archiver.kernel.org>; Sat, 25 Sep 2021 23:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhIYXH2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Sep 2021 19:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhIYXH1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Sep 2021 19:07:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B1E086109D;
        Sat, 25 Sep 2021 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632611152;
        bh=zlaa8ich0TlL4aUQfeVC8b3wMWLMz3e0ah5QALw5I8M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KxvId9mDS1JZaQYW6pl8EcVJETLn4BAF7YFQIZ/EkSF3LQUqU+q0hg32yOlljnBFf
         qQnuTo4bUuDTdyH464cqomMP+1cQwREgV5xTELuEobrtrPYoDUZx6VRP4ftbBdqTFe
         qIXNXzp+nu8kbb3YZyvC4K6Ak7NuuSxkJE5o1CinIrfpX4e3GcJYfM4U6g+CbKNc4l
         ZMLA81WMxZZy9XRwOdopEoA2dY5AQWqTY9vM3kRypugLD3IFNHL8y9QhXKUWXo70gb
         2dADgq7LB7JvsWIcPU74qgov/L+Gce65Vz+CeaWa8CpMHMRWGQvVLM81T/xgabG54M
         OAFNMMvP7+dgg==
Subject: Re: [GIT PULL] Block fixes for 5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7bab443c-0410-470b-a95c-b3c2e0ca908e@kernel.dk>
References: <7bab443c-0410-470b-a95c-b3c2e0ca908e@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <7bab443c-0410-470b-a95c-b3c2e0ca908e@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.15-2021-09-25
X-PR-Tracked-Commit-Id: f278eb3d8178f9c31f8dfad7e91440e603dd7f1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d70de4ee5931455811cd0ce692230785ae1c3ce
Message-Id: <163261115269.2532.9729767722193006571.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Sep 2021 23:05:52 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 25 Sep 2021 14:32:32 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.15-2021-09-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d70de4ee5931455811cd0ce692230785ae1c3ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
