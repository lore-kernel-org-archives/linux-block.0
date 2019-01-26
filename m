Return-Path: <SRS0=xZ4d=QC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE01C282C9
	for <linux-block@archiver.kernel.org>; Sat, 26 Jan 2019 23:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA7621903
	for <linux-block@archiver.kernel.org>; Sat, 26 Jan 2019 23:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548544508;
	bh=tI7TmrneRlV0RyD9tzJSpqmtPoheBPcuhg/MWEBa8Sk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EMAaDMJ9nMSezdwI5fGm0eJB7hzofLEt9uNchRHNKctoqOf+wbmStVR6nerCs5DQ+
	 f3NAlUBcAUzB4F9J+7h+GXkSzaAWoiJPi+ctIcBsmJ0bHdpESh43YPJ6NezVzCoUGH
	 T9TMFdzpJVSXXdmUIJcmedd+5nonjvbbyvvC7Yzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfAZXPG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Jan 2019 18:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfAZXPF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Jan 2019 18:15:05 -0500
Subject: Re: [GIT PULL] Block fixes for 5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548544505;
        bh=tI7TmrneRlV0RyD9tzJSpqmtPoheBPcuhg/MWEBa8Sk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kD702VUlPgBixB0YFA9gCiivdAJg38F5B9MsYJ7gJ/iSlK5KxnnBRg3K/AgSCEvJE
         vwxz6wWCIq4TG3KWfssjqvjCdqr8qzwqDj7VZjmKei7PRmFruMp0PTlVwzKswteiWy
         7YTvdXlpx5SnUQNq97uRspfZBYpiiJ95O2HXoE+g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8755a2bb-c583-1b2a-c94e-e2d1cef78035@kernel.dk>
References: <8755a2bb-c583-1b2a-c94e-e2d1cef78035@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8755a2bb-c583-1b2a-c94e-e2d1cef78035@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190125
X-PR-Tracked-Commit-Id: 8367de2c99a13d35960a51d6084631c883e93a4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b8f9159166545e576b2bc8a0c984beaeae9cc05
Message-Id: <154854450533.25415.6999032983454924791.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Jan 2019 23:15:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 25 Jan 2019 13:51:29 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190125

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b8f9159166545e576b2bc8a0c984beaeae9cc05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
