Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A5BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 19:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbiALTPb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357044AbiALTOm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 14:14:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97444C061212
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 11:12:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34CCD61A94
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 19:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 989D8C36AEB;
        Wed, 12 Jan 2022 19:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642014730;
        bh=XnpekE12H/9UgTuhBuQG0KQQlA9fb2PgHwD/s3kEOOU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LregoxPSkBEInrx0sWzWCBD1wcQdfIX6EdCTCgyAwtRKIYOjg3e8+xfb0A9rMUa8S
         8qlX3a+qG2Pv6XDTJB0dscB2M87IGXnC9Od/CpUdZ+ICHU5bV19Cp8wNhHfo0RiJ8Q
         q8otX6ctb6zz7TR2hM9f66FBACs6knbBxaPEoySPG1wj4C54wsbDIn9OlBlDkKXzyL
         tGQpzMEz1uc3PM/xVWjtDwJb9gS1/sHRm8OFD7nF/p1a1TOiMj8VbVsxFAAzRkQ50/
         CVl9b48GIKaSWio4ARiNWkYw90Ml5KNxNE6Prk3ps+wjViys2LmZfhtFOiQao4tzpz
         qCLa9qTZcfO3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 869A0F6078C;
        Wed, 12 Jan 2022 19:12:10 +0000 (UTC)
Subject: Re: [GIT PULL] Block drivers updates for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5d0c0268-8d1d-fdb4-e054-584a94fb49f3@kernel.dk>
References: <5d0c0268-8d1d-fdb4-e054-584a94fb49f3@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5d0c0268-8d1d-fdb4-e054-584a94fb49f3@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.17/drivers-2022-01-11
X-PR-Tracked-Commit-Id: d85bd8233fff000567cda4e108112bcb33478616
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9193f48e94deaeff0c9abbc67b9584e8ddc42ed
Message-Id: <164201473054.2601.742629205916671586.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 19:12:10 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 14:55:20 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.17/drivers-2022-01-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9193f48e94deaeff0c9abbc67b9584e8ddc42ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
