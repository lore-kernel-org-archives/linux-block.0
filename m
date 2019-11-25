Return-Path: <SRS0=vXr6=ZR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEA9C432C0
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 22:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459EE20862
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 22:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574721912;
	bh=GFoTCCb7dDPPbykgiNvXlxDlTjCdGI3x3rzIDroqX1I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=I7BN4O5LM1wEc+Tdpxc89wG+e/e75uzINCkq37c7pnu64Rwt/FIhJ1IUIp2Jm8TsW
	 8UU1AOECCWDwujNjX9hB481IvMWCDV+c8iGtvp7xsq4lv2ZIQrZxlfGm4x5nBWamVr
	 G+pMjjw/L86xzNNSGUCur7KyS6v0Y7ws1eD0hQvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfKYWpL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfKYWpK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:10 -0500
Subject: Re: [GIT PULL] Post pull for block drivers
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574721909;
        bh=GFoTCCb7dDPPbykgiNvXlxDlTjCdGI3x3rzIDroqX1I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=azLBU+nNtObfcR/SPJttGa2lhA46e346rx6JOOsq18bRy5InXK8GwTj9rOeteQmK1
         LwtVKvWVQmhv4oNZ3zAj1Z4u0KjVa1toiJauafuEqCxs2AVj64vxxLV6Y7vEzFbqvR
         5/K/z/EAVnySm6Yj7H+ikH3vZsfwZ80DRqL2MnHE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3b9c21af-321a-535c-1192-08fe3961230d@kernel.dk>
References: <3b9c21af-321a-535c-1192-08fe3961230d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <3b9c21af-321a-535c-1192-08fe3961230d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.5/drivers-post-20191122
X-PR-Tracked-Commit-Id: 03bf73c315edca28f47451913177e14cd040a216
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 323264eefba1ea288d5962c0a9e23ebd62107ca8
Message-Id: <157472190990.22729.4512000875975255747.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 22:45:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 22 Nov 2019 08:37:07 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.5/drivers-post-20191122

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/323264eefba1ea288d5962c0a9e23ebd62107ca8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
