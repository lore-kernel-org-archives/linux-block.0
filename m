Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28A1C433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 Jan 2021 02:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769A123A75
	for <linux-block@archiver.kernel.org>; Sat, 16 Jan 2021 02:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbhAPCJr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jan 2021 21:09:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbhAPCJq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jan 2021 21:09:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5CF0620DD4;
        Sat, 16 Jan 2021 02:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610762946;
        bh=XoXWiuQiKRg8St/w66JqYIqAP9eHh2N1Xv3O80OkiLA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ts1sUSBLRH+t/Q1Lnsce4lIj7qZdDzznFLHhO2s89SRypCuM9pdeAz2KvSXR5OmAt
         9ZT9Igh5RzYCFKVJ2oeMxbOP/hWV4vP/xYkaV01eDdNXXDqX1Erq+ztX90pSX/lQER
         23+iXeto2GWBxcUadEmAJqUv/nMqz0pcB3iQ0e6uBkqg7AjYiBGhTAt3NRad/pZ7Yk
         lOrYzt0cd5BYZtL8tKmryCv3DeNA09n0sBOh910r+otpbWhrC6P7mvY1DMg5IVTeQT
         NOyujlxT2iGWcX46HYB+FeOKAIvrUKpxDOr8Ena7ysOR8+bcWIUCQWh0OqsNTSXT47
         xshbc2oSdTK2g==
Subject: Re: [dm-devel] [git pull] device mapper fixes for 5.11-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210115234347.GA1931@redhat.com>
References: <20210115234347.GA1931@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <20210115234347.GA1931@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.11/dm-fixes-1
X-PR-Tracked-Commit-Id: c87a95dc28b1431c7e77e2c0c983cf37698089d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d94330a437a573cfdf848f6743b1ed169242c8a
Message-Id: <161076294623.2772.15225796881420547622.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Jan 2021 02:09:06 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anthony Iliopoulos <ailiop@suse.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        Akilesh Kailash <akailash@google.com>,
        Alasdair G Kergon <agk@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 15 Jan 2021 18:43:47 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.11/dm-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d94330a437a573cfdf848f6743b1ed169242c8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
