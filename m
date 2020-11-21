Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B032FC5519F
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 00:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3AB22470
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 00:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQGaz+d6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgKUA3F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:29:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgKUA3E (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 19:29:04 -0500
Subject: Re: [GIT PULL] Block fixes for 5.10-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605918544;
        bh=+e8vSI3xuYITt/LG4Seon7nnNYdOxPkhoHCXGswfmDA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lQGaz+d6hoadnhpeKAN4FQX97MAfMVQ0OikagQN+zV8lYKUd7Sfo8o7sNKUSSsr5g
         I+XVIb/EMYER6gruN0Fl9G+6VeJ8bwv4W9GN9TanRk0nXM+qwwL6ADjKHOGCXkmHGf
         LIYbmssQXhBKokG5QnVOBj2qcSF5NstwKZxl6k3o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5e56dcf2-0320-c637-e6ee-143de81f2c41@kernel.dk>
References: <5e56dcf2-0320-c637-e6ee-143de81f2c41@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5e56dcf2-0320-c637-e6ee-143de81f2c41@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.10-2020-11-20
X-PR-Tracked-Commit-Id: 45f703a0d4b87f940ea150367dc4f4a9c06fa868
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fd84bc9692958cd07b3a3320dba26baa04a17d0
Message-Id: <160591854446.19527.4210552002507911018.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Nov 2020 00:29:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 20 Nov 2020 11:45:35 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.10-2020-11-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fd84bc9692958cd07b3a3320dba26baa04a17d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
