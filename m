Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3751C433DF
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 21:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC34E2054F
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 21:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590786635;
	bh=B8iYZQ1amxoUDzmMIWye+TnVYu/Ax0vXaQ258Xx/pq0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bBjiqHPJIU6GuDBwKFKxDSkA3Zve1e3+FB4nQM+HOLqkJPSYk1nXLHvtAWFUtxFHN
	 GVQGjWkocPGoWcnzc0IC59S9ZQKrZrDhIeWfarSAoWIYJEaIYrIpRrpZFsNDE/Y4aT
	 a9UUw2y2HHtg9dptdw34MndBL66AL3mYQVZTMbc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgE2VKe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 17:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbgE2VKH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 17:10:07 -0400
Subject: Re: [GIT PULL] Block fixes for 5.7 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786607;
        bh=B8iYZQ1amxoUDzmMIWye+TnVYu/Ax0vXaQ258Xx/pq0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MpKBqHXza28Qf06GMIC9GgaqMp7vm+zvf196MxL7O4FPt3BGUymOiq+s4EY0xblMi
         R+L8kJYqpP3itrLyW2gpjJWzgKmZAD6fdI6/e0RMdaArZLIowpzpzZocKQn/D3UV8s
         06mBmT95YFh/h9GdxZMWkd/7boJZ0byG+cpTAvbQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <19c1adb7-0bd0-9657-2cce-0a6393631b46@kernel.dk>
References: <19c1adb7-0bd0-9657-2cce-0a6393631b46@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <19c1adb7-0bd0-9657-2cce-0a6393631b46@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.7-2020-05-29
X-PR-Tracked-Commit-Id: b0beb28097fa04177b3769f4bb7a0d0d9c4ae76e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75574f1212a7b4833367ad56626c30e64a94aa18
Message-Id: <159078660748.32003.5319549390694887092.pr-tracker-bot@kernel.org>
Date:   Fri, 29 May 2020 21:10:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 29 May 2020 14:11:12 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.7-2020-05-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75574f1212a7b4833367ad56626c30e64a94aa18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
