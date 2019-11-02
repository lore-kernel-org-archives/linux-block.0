Return-Path: <SRS0=rsSL=Y2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185E5CA9ECF
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 01:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E0E21897
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572657010;
	bh=wT8Z3V1T35jU9zYbGTNxymnrfCJTh5FIIDmo1Ilc+5s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ycofk1WXzs4HRFRtlyMyjUkDrzvSrB/IefzirxzuXCINcH4E0ZcmSjRsRyyJfgT36
	 EtOzSlq42DIkHSFSmHzM2sv8O87vcP7OT3fVHCb/TnOlFwnKYrOFbJuJ8A9X9W1zQp
	 wrcX5x9SnZ8036NTyt1ECXzekh1Twof3mvvxf9+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKBBKJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Nov 2019 21:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbfKBBKF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Nov 2019 21:10:05 -0400
Subject: Re: [GIT PULL] Block fixes for 5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572657005;
        bh=wT8Z3V1T35jU9zYbGTNxymnrfCJTh5FIIDmo1Ilc+5s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xLJvoPKcBPwJ036jzBZCKCAdOa1gFjkSEDs0pGVygygEvqLoaKB6/3ES9itd+dDNO
         AtcAGBXzCVJx2EmzDIIzNCjCHOwF/IBnCzih+sh4N/c+w3+T7A1twW8V7JfFsjKB99
         i4ixxLH++YufunAy2cLVQx5zCZGqPCfUsw4lW9yc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <61bab3c6-d24b-e528-bd01-fa9a61c8b2f3@kernel.dk>
References: <61bab3c6-d24b-e528-bd01-fa9a61c8b2f3@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <61bab3c6-d24b-e528-bd01-fa9a61c8b2f3@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20191101
X-PR-Tracked-Commit-Id: 41591a51f00d2dc7bb9dc6e9bedf56c5cf6f2392
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0821de28961d58df44ed390d2460f05c9b5195a9
Message-Id: <157265700507.2997.7492418452262062262.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Nov 2019 01:10:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 1 Nov 2019 14:30:05 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20191101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0821de28961d58df44ed390d2460f05c9b5195a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
