Return-Path: <SRS0=FzxQ=5P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9496BC43331
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 19:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F6620784
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585597822;
	bh=nDyrWb68rr8XejDHw4IW2Z3Xamw+RPSRjGWRG1sk7gA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WdWpqvng2eX2invKshZVe7TfXDdOVmv9NK6yJktM3o3w+FmAvlBr14CyZOBuEyFPI
	 cxVhIrU0HLoCYoqJETP1PNhqik4wkxBclbL5RklN0e49kTJvXVtTtOdV523zvhX45Q
	 VvwFpi9vOFoMhQ5yDTYLkcaq1sLa7HxkORZgq/8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgC3TuV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbgC3TuM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 15:50:12 -0400
Subject: Re: [GIT PULL] Block driver changes for 5.7-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585597811;
        bh=nDyrWb68rr8XejDHw4IW2Z3Xamw+RPSRjGWRG1sk7gA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fXaHD8knCnvC/iO67AGgpmjaVzuHbm8k7o95n113b1Wma6ZqtwXL7CHdkhpXDwQWa
         QJ548tK2NrUzhm2dps8kVcjeo3/yrWI5RTTjGb3bwb/WcTUR2cQv5vniMfxq3+7DvU
         CWpjALPpYzb4PRZZPHlLt9pQ9gkAC4Iyrl4G30cE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2e5a9ae1-d97f-da23-12f7-4672e3302035@kernel.dk>
References: <2e5a9ae1-d97f-da23-12f7-4672e3302035@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2e5a9ae1-d97f-da23-12f7-4672e3302035@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.7/drivers-2020-03-29
X-PR-Tracked-Commit-Id: 766c3297d7e1584394d4af0cc8368e838124b023
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1592614838cb52f4313ceff64894e2ca78591498
Message-Id: <158559781172.12131.2995863544951399357.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 19:50:11 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 29 Mar 2020 16:56:58 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.7/drivers-2020-03-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1592614838cb52f4313ceff64894e2ca78591498

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
