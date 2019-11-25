Return-Path: <SRS0=vXr6=ZR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302AEC43141
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 22:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074352084D
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 22:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574721915;
	bh=YGlm+SjW8zLUwNnUFn/8KPcXenLPdnQbH4LiQcBBmxU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RokeIU1XmqPfguCDj2ecWSBalxg1xDlZJleuFGN3JiRwUJdEcruaZ6hh0GIUdu9xS
	 i8SYOMlcN7YCXbblQHNm/ChU905jT0KDxmW6baZ3A2WBAE0htS/GFSVwmPPIUVDI+H
	 +TYvZhNtcwsYSoTdYESm/ffv1oGeUav8TTdwLec0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfKYWpJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbfKYWpH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:07 -0500
Subject: Re: [GIT PULL] libata changes for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574721907;
        bh=YGlm+SjW8zLUwNnUFn/8KPcXenLPdnQbH4LiQcBBmxU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qZe23P4yvkatMWQrYPQn49/JVvEmnOLAtEUYOOj/TLVzbztUtguxNVME2789mOxvY
         yrIcJVNqhoY8P1aOYzE/QudavHf8hRbBV1Iegur+geBTJDZqdA90j4VATYhKJVipYb
         cqJlK+wnWWux8UiSaYyrtkJwMBf/EACwRqW7wWDY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7f58df62-263c-3e2f-edb7-63e526c2222e@kernel.dk>
References: <7f58df62-263c-3e2f-edb7-63e526c2222e@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <7f58df62-263c-3e2f-edb7-63e526c2222e@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.5/libata-20191121
X-PR-Tracked-Commit-Id: 44bdc2fb63aafaa5984caf7d1e9d2b6d0d381766
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e7b06a4c88846c20c2cc01b370564a2423ff0d0
Message-Id: <157472190738.22729.1902549259417359356.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 22:45:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 21 Nov 2019 10:11:57 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.5/libata-20191121

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e7b06a4c88846c20c2cc01b370564a2423ff0d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
