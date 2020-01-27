Return-Path: <SRS0=/Ic2=3Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B335C33CB1
	for <linux-block@archiver.kernel.org>; Mon, 27 Jan 2020 21:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F59224682
	for <linux-block@archiver.kernel.org>; Mon, 27 Jan 2020 21:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580160007;
	bh=/mpPSXrDrHgU//KGtD2Ww1gLZLkj/lBA6lySCd5X5rk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dmfLHlZjHM0wxf2VMn+VV9wADZB4b0r4UMmV077/HrnEaYJoxdusZhxOcgkQUjCTi
	 7DDlz28NUC888hNEviaSAuNlqtsmEP4WmozI3hSL+k2PSIjAXV6n5Iq4BrWGNeU6J0
	 9lljTeCeFgbf+/bPgD9IX5MuyWzipJ1qQnLvb130=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA0VUF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jan 2020 16:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgA0VUF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jan 2020 16:20:05 -0500
Subject: Re: [GIT PULL] Core block changes for 5.6-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580160004;
        bh=/mpPSXrDrHgU//KGtD2Ww1gLZLkj/lBA6lySCd5X5rk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I+hGB0lOA9ZP0cyoIJhDdD3UgoNDo8vmQJETHuZKm5oTUiNvfCcHRjEDfglqgTB9W
         deimo+YGVIWbSKqBys/IJokYTPj6Kv3l1ZFpsjXf0cfAgji4Y7QPG9oNlPoJ5BG7dx
         Utlhz8a6QDu8QnYapKKMb89gaCH4xVbF39sTzLJA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <80ededdb-90de-6120-4250-252f019d78b4@kernel.dk>
References: <80ededdb-90de-6120-4250-252f019d78b4@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <80ededdb-90de-6120-4250-252f019d78b4@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.6/block-2020-01-27
X-PR-Tracked-Commit-Id: 5336da37a5eac761611352707c3890a3cf857aa6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48b4b4ff1ee044a977929bcf80e79f8212f756b4
Message-Id: <158016000462.13304.264153769485146001.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 21:20:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 12:35:07 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.6/block-2020-01-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48b4b4ff1ee044a977929bcf80e79f8212f756b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
