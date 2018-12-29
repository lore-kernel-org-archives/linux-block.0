Return-Path: <SRS0=+PfW=PG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DB9C43387
	for <linux-block@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF6C218FE
	for <linux-block@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546047018;
	bh=+mgF9Ez394Pte/IY44rsiRIFw5tWoxsdDi+MANmMn1w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hU6pbP/AH9epfS2cH5Cuv6XWu2yrUEGrED8qw7aHHdzPrhhNkEArdJDaIfqk07YS5
	 YdVXg6/UY5MYiYVWunDVtkdncLY6WOmJ9wdYGNhEZxBoLcQ4R6FYIs/Sjyp3SvYizf
	 091v/XYvVf6qCARlVJbzoBOiqD2dO2rtLPXI4HB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbeL2BaR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbeL2BaG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Dec 2018 20:30:06 -0500
Subject: Re: [GIT PULL] Aio changes for 4.21-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546047005;
        bh=+mgF9Ez394Pte/IY44rsiRIFw5tWoxsdDi+MANmMn1w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uPe581ebw0LwvIgwBGENAZHqscwSQQav+C+u3qHsNhL8rm8rqteNer8Z/pzKI8y3N
         Sz/Fvxqj6xxJaHuI587ozntWhBQD6dTkvYdiYZJm0xdMPDH27BkodvKdlwhbpb0buy
         sHV//QFOalFvKCeJBrVCoxnm5ziCNikvrg2Yg+Gk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <947a6dca-5ba5-c8ed-8e64-3cede8fcc028@kernel.dk>
References: <947a6dca-5ba5-c8ed-8e64-3cede8fcc028@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <947a6dca-5ba5-c8ed-8e64-3cede8fcc028@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-4.21/aio-20181221
X-PR-Tracked-Commit-Id: 875736bb3f3ded168469f6a14df7a938416a99d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 956eb6cb36765e3a79a744e6c9364dab1548e460
Message-Id: <20181229013005.17208.36702.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 01:30:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 20 Dec 2018 21:05:03 -0700:

> git://git.kernel.dk/linux-block.git tags/for-4.21/aio-20181221

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/956eb6cb36765e3a79a744e6c9364dab1548e460

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
