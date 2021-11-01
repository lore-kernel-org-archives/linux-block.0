Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0ACC433EF
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 17:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FE260E52
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 17:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhKARb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 13:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhKARb0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Nov 2021 13:31:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4183A60EBC;
        Mon,  1 Nov 2021 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635787733;
        bh=ELgTIidxlIGwlqRHR8xrkjtnMTjBJyoZ51AW6Z6IiLw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gmnAmZiQXWpAsQOz1hBWmK/KBnjkzZBILd7c083XgEhKQ+cmb7sNY3mdflYG72kv9
         oyPn2r4WPIt1/yWU1w2FV/9AIz/CvTNQEtN6ICjBjwmx7wpvIJ7UVHH2z6PljmCQLX
         EX+ftbEuWsg3JDrZvacl5AZqcN05JJIIlPaJ8zUtghfU9WWeaphiNrzjb2bt3lvp9D
         sc6mVX2KbaW0dbf3FCStn889UbI24daTRwxVW8VWTSkoLXgZ260AqoE6e4aia7kiqy
         yBcTo3r8GAYrun0qIuzFELa1R37wxKqDGIeLPH1EMKDUphorq6XrOQzTZYDy6Eq6+g
         Rt/PZf8ukiUuA==
Subject: Re: [GIT PULL] block device inode syncing improvements
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9ba39eb9-2f4a-849e-f502-bdd63c6e7d98@kernel.dk>
References: <9ba39eb9-2f4a-849e-f502-bdd63c6e7d98@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <9ba39eb9-2f4a-849e-f502-bdd63c6e7d98@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.16/inode-sync-2021-10-29
X-PR-Tracked-Commit-Id: 1e03a36bdff4709c1bbf0f57f60ae3f776d51adf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19901165d90fdca1e57c9baa0d5b4c63d15c476a
Message-Id: <163578773322.18307.15976957590581838833.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 17:28:53 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 31 Oct 2021 13:41:55 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.16/inode-sync-2021-10-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19901165d90fdca1e57c9baa0d5b4c63d15c476a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
