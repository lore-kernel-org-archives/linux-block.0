Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A165C433EF
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 19:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhKYTRH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 14:17:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232601AbhKYTPH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 14:15:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E209D60C3F;
        Thu, 25 Nov 2021 19:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637867515;
        bh=gKjRkYpD62fJYC387aD9GPFsdSjimkz88oXnOTlNxvc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lKB4tRmzjw64lI7WJ4nYSt0Emor9bVAFnXfP+ycIVl8jBeqMHoJWAqT2Tdlnh8CQE
         V3hUrBoHsyezZ2m/n7R9hak+we1jsMc1GNTuM+DjHKXmCpTzPEgt0MygcF2AUc55cz
         Yy1YE2/GHJ8YP7twPZWMG4eNbid1u5csfbvno3e7E4YOfYYXM1+78VgifpK52SMtTh
         MclB6y2BdbMM7m4ZUDUzSeloBLAyvrxn0hSh4P7lfrrboBhSgHvXlAcVj5Vn1I9oc+
         9BiIPI/jXwEclU02ZiaaLPWj6ZfOMmKTTcuWXuon/8CqwKyK+ffDppQkGl2uVmKX9L
         w5pqWvpk4DIXg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D2E0B60A0A;
        Thu, 25 Nov 2021 19:11:55 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ddc913c4-9789-ca29-6cba-60ac173fc2e1@kernel.dk>
References: <ddc913c4-9789-ca29-6cba-60ac173fc2e1@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ddc913c4-9789-ca29-6cba-60ac173fc2e1@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.16-2021-11-25
X-PR-Tracked-Commit-Id: e30028ace8459ea096b093fc204f0d5e8fc3b6ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ced7ca3570333998ad2088d5a6275701970e28e
Message-Id: <163786751580.29201.1645397282997047987.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Nov 2021 19:11:55 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 25 Nov 2021 09:42:48 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.16-2021-11-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ced7ca3570333998ad2088d5a6275701970e28e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
