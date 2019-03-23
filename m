Return-Path: <SRS0=7zlQ=R2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847D4C43381
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 18:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DC821902
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 18:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553364015;
	bh=nAy3qJFZwyLXi6GSBI64vjCGF56G31xYPnnmNwOxfqg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nyOgcz8nNtOkFP/bau8sFuvImZjZ/h2kmDmswZOeE1owEE4Jsjp3Y/lhxt4s35TTp
	 VuBzjsGkdkUvx28AxikPffr2rVYX2gVb7OThKCquG+VqMSbCh0rikyrPxVRM4WWDBd
	 X8hwmIxL5CM7XjZLGhINwx2rByOmlKeBd22g8Wc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfCWSAO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Mar 2019 14:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbfCWSAO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Mar 2019 14:00:14 -0400
Subject: Re: [GIT PULL] io_uring fixes/improvements for 5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553364013;
        bh=nAy3qJFZwyLXi6GSBI64vjCGF56G31xYPnnmNwOxfqg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=h4WpQSv0CXCIIgyQJf7eOjO96S59kQ/7puYusCHfCxVHnnW/OwGYTDrZKyy5GBiHu
         Mb1f8o5n/SkhmIpMcK7UByy+OhZJR6bJiuk0hzDjiY/IB1aYOCgFw9cdfPLvssDM4P
         hTSqwfdziYiHHTsPDyzDJU1Phw8KLTX+irLnHlHI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <278dbb07-f4f8-8984-ab1a-0d78ef3c518c@kernel.dk>
References: <278dbb07-f4f8-8984-ab1a-0d78ef3c518c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <278dbb07-f4f8-8984-ab1a-0d78ef3c518c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/io_uring-20190323
X-PR-Tracked-Commit-Id: 399254aaf4892113c806816f7e64cf40c804d46d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bdd3dbfff7a308643c7f9ef74e4a8ef3923e686
Message-Id: <155336401358.30785.1506684071177429088.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Mar 2019 18:00:13 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 23 Mar 2019 09:59:04 -0600:

> git://git.kernel.dk/linux-block.git tags/io_uring-20190323

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bdd3dbfff7a308643c7f9ef74e4a8ef3923e686

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
