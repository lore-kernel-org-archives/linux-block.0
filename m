Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CF6C64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 18:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FC720882
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544208903;
	bh=U/FHUz7Hny9i0m0FmXLQftNNiPcUMkX8tuzIeR6viKo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0XQ+MLdlhVc88qLfanmBrWnC/USbpEIy70f4/DZ4nWGj9YdOdk/z1Y6qeVL0SP1hL
	 vpt6IwiEmgHJQ1UlVAl/e74dc6tzaZqGSX6/eXiQQfYjbvQjx1piSKsVfBgslgHBt1
	 7PpgFjT7SEBJ/uHmRZUd5kpbMxictYhlkeDH0ZH8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FC720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeLGSzC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:55:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbeLGSzC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Dec 2018 13:55:02 -0500
Subject: Re: [GIT PULL] Block fixes for 4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544208902;
        bh=U/FHUz7Hny9i0m0FmXLQftNNiPcUMkX8tuzIeR6viKo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q6Gwg7LxJGzoa6wKv0C5++VbIfTTbBGTAtSMwURpdcMtkO11Ogt7GZLcU0y/vnA09
         33U50NhaKoSrEHVA8F0RK5FrGCmpm0lj+3ZAMiRwnUHtmrdDqGUY9slChMG84JGIjo
         iDjwQrweyWoFzpQvHKvwmaofxaemyDjNKHQYRmYY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8ebbe50a-9f33-21e2-0747-e461cecb40cd@kernel.dk>
References: <8ebbe50a-9f33-21e2-0747-e461cecb40cd@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8ebbe50a-9f33-21e2-0747-e461cecb40cd@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20181207
X-PR-Tracked-Commit-Id: 8b878ee247ef2691bd69e1bc3df5ae93738ea028
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b43a299794ee9dba2dc1b0f0290b1acab9d445d
Message-Id: <20181207185502.30880.47274.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 07 Dec 2018 18:55:02 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 7 Dec 2018 10:12:12 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20181207

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b43a299794ee9dba2dc1b0f0290b1acab9d445d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
