Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5DAC433F5
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 17:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 301B061181
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 17:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbhJPRa3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 13:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244418AbhJPRa2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 13:30:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3605C61139;
        Sat, 16 Oct 2021 17:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634405300;
        bh=DLfxSRQyg7pHQahVBJif+khJF++RmYVYTpPUPAVnrnU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LQ8+BT9hqTnYpvNyTcK9c+vcSI3cJBleo656RPiCtaR/28sYgZI+Vw42yVI0PT2Wv
         bgCneRDm6rvyg3mZYXMUA9CHxowOrtO06JDLC7BLidF+mXjjeRdplAoObBrVr2XBQF
         aGbE9Ww5wcGZ5+yk3gLdfnXPoRmuVYvzJK5aGjKEeiERuCPAzsgMkh1bMDDXBhBCxr
         jaNVP+mPiOaeu7DaMNehaXpnolRrOilCbuEtbTUYzgOMZstBLJ8DTUBLIN/yI9a/TM
         DZC06QBP/1dyQw3pmeJRT3UuJ8ga/0JOY+jqeNpgWPKXMASyKPTKoLZEUJUKBRFXwf
         BiYFPa6tpbqvw==
Subject: Re: [git pull] device mapper fixes for 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWnprivVeSQHkRxN@redhat.com>
References: <YWnprivVeSQHkRxN@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWnprivVeSQHkRxN@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.15/dm-fixes
X-PR-Tracked-Commit-Id: d208b89401e073de986dc891037c5a668f5d5d95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcd619847ca7b1f3123ba35976225ee77b83f959
Message-Id: <163440530018.22586.16517091888216383062.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Oct 2021 17:28:20 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Akilesh Kailash <akailash@google.com>,
        Colin Ian King <colin.king@canonical.com>,
        Jiazi Li <jqqlijiazi@gmail.com>, Ming Lei <ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 15 Oct 2021 16:50:54 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.15/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcd619847ca7b1f3123ba35976225ee77b83f959

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
