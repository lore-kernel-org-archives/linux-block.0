Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFA2C43219
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 17:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68215611AD
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 17:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhKARba (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 13:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhKARb0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Nov 2021 13:31:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 51E1F60F42;
        Mon,  1 Nov 2021 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635787733;
        bh=yZ3oWQNPBIIvE8wZYsfeZQ9wFGyXpLz0+lBlEAC/jR0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E6vEcgG6CST3/AZ11RdPpPBF5UeDqYmrjDYY1LJhxHiwwH94eYGBxGXzPFPF8oT/4
         C90/OrlN2f7LAfYjXHyc9bXYHekFzVOTsChOOh5INIKvqE5tRw36f0wPo8dzv7TnLh
         fDyqjdcKJi0l27ghQ76c1IItyOOCWMRhI4Wl1Rr8VCzJoKiciPMQuA3uu3F478cD0a
         e5m4rQd3QRGosAmwfwJut+5OnUXrG1TS5uUZ50Wb5pQbE5YklDjYgs+wxhLt+CCsf2
         GZO0P+9V454LS9yAU9kiAckhDrYTHrR7BSuzUJG3BjonhKoDlem3OQbJxh79VW2sWO
         AJTIVC9ovqoqw==
Subject: Re: [GIT PULL] Remove QUEUE_FLAG_SCSI_PASSTHROUGH
From:   pr-tracker-bot@kernel.org
In-Reply-To: <24663413-71ff-33be-e874-a0852cad343a@kernel.dk>
References: <24663413-71ff-33be-e874-a0852cad343a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <24663413-71ff-33be-e874-a0852cad343a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.16/passthrough-flag-2021-10-29
X-PR-Tracked-Commit-Id: 0bf6d96cb8294094ce1e44cbe8cf65b0899d0a3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71ae42629e65edab618651c8ff9c88e1edd717aa
Message-Id: <163578773330.18307.12094358253670591924.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 17:28:53 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 31 Oct 2021 13:42:06 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.16/passthrough-flag-2021-10-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71ae42629e65edab618651c8ff9c88e1edd717aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
