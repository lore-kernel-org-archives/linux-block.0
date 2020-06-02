Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3671EC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 22:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F84C206C3
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591138210;
	bh=ycKR6lIIIC/KvNCZRUxnttmwdBT1qF3XVAK8EGRY22k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sZG1bKYa4k+yZQ/CxSlMF1W8pV4WPypm832ej/vw+5oTKRsvNlOM4mfoiz3v73c0X
	 /rJSGNscM6Z4G5sadF9u+zuBtx+EjgFm9B2ICXUC6/UblI6022qPa9Sum8/ZB956do
	 zSApHA4rU8ivOY1uBCD2sZykOq47Mop2z3qi7z4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgFBWuJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 18:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730472AbgFBWuI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jun 2020 18:50:08 -0400
Subject: Re: [GIT PULL] Core block changes for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591138208;
        bh=ycKR6lIIIC/KvNCZRUxnttmwdBT1qF3XVAK8EGRY22k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v3U2qOsfOlm5Nr+2yLFY4BpBMeUQVgQuaswOvDWMl/2fj/9yJPxtBDBzQH5ASmbvd
         MvaCB6Mrrb2X1jUHp6tQ/k4jrZOyc32iO0nLX6TpwfBeAlLARjpWqsAQbPT8smxcX1
         1yvNWwQq5QH9W1qOL2w5MNPkul/zPyEEdbJNSZkU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <88e3cc9b-efba-055f-880a-1b7ae8d1e6cb@kernel.dk>
References: <88e3cc9b-efba-055f-880a-1b7ae8d1e6cb@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <88e3cc9b-efba-055f-880a-1b7ae8d1e6cb@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.8/block-2020-06-01
X-PR-Tracked-Commit-Id: abb30460bda232f304f642510adc8c6576ea51ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 750a02ab8d3c49ca7d23102be90d3d1db19e2827
Message-Id: <159113820855.13730.10251941557917657886.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Jun 2020 22:50:08 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 11:41:19 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.8/block-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/750a02ab8d3c49ca7d23102be90d3d1db19e2827

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
