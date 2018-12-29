Return-Path: <SRS0=+PfW=PG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D470DC43387
	for <linux-block@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A393B20869
	for <linux-block@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546047021;
	bh=J1iTSaGCaVDDO5CTyD+oX9gi5RxD8dx6kY3iSN9ZRKY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NYHAl3HJkvMtpojLZ7TOROSY/eTchtXLOg8OSrDnjl5VhPbh1S3WrJCiLop7TySL2
	 +KFQ8MPIyvawc77jWZH3CSNEMTSBZFVSP3LxVk4Xgw3w53U+1Tq38HBHjDgtnj1gtW
	 jd2B/UmxOxlLr6+bDVn/e1/lZOq9faz9mEmv6b7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeL2BaU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:30:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbeL2BaF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Dec 2018 20:30:05 -0500
Subject: Re: [GIT PULL] libata changes for 4.21-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546047005;
        bh=J1iTSaGCaVDDO5CTyD+oX9gi5RxD8dx6kY3iSN9ZRKY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hiHQ/53OG8tRFKb6wdhPevqMi7I+r08JEux455K1Jx6/VW9lJfm8QwLzmgnpe/XFQ
         dGC+6qhsHN4mvPMFo6PhIhtkjx5SHtPnZPn/sygjvd9Vz5Ew3HpECh/ZvufF637pZa
         qvMThzigKj6EJCK5riVbC5GUPMdiFnEw8H/ewn4A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bdc8749a-b777-6e2b-9a8b-f2b1a3e73e12@kernel.dk>
References: <bdc8749a-b777-6e2b-9a8b-f2b1a3e73e12@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <bdc8749a-b777-6e2b-9a8b-f2b1a3e73e12@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-4.21/libata-20181221
X-PR-Tracked-Commit-Id: 9f83cfdb1ace3ef268ecc6fda50058d2ec37d603
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe2b0cdabcd9e6aeca66a104bc03576946e5fee2
Message-Id: <20181229013005.17208.60054.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 01:30:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 20 Dec 2018 21:04:58 -0700:

> git://git.kernel.dk/linux-block.git tags/for-4.21/libata-20181221

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe2b0cdabcd9e6aeca66a104bc03576946e5fee2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
