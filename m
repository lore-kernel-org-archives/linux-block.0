Return-Path: <SRS0=STaV=D7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DAAC56201
	for <linux-block@archiver.kernel.org>; Sat, 24 Oct 2020 19:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A21F120BED
	for <linux-block@archiver.kernel.org>; Sat, 24 Oct 2020 19:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603569320;
	bh=NNWznkCUWpX7bwUDLkJO8Tv5f/le2kriYssXIlvWx0s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Gji6GbO7nEZcvyYnY1+Zh991LvBgpNcJvhPST/SpgkFijPn/Ck9TaTGVi1CGtH7Yh
	 JW7jr0dLvmGpCJQErE0Lk6xyjAZslWanC5+XRHjYLzTvHmOb1INRk9hO4EBbnZmzs3
	 tzJ/Edh68K3IVhcFeR4lF8KnQ2Nf+OyQmMWqIEHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764247AbgJXTzT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Oct 2020 15:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764226AbgJXTzR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Oct 2020 15:55:17 -0400
Subject: Re: [GIT PULL] Block fixes for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603569317;
        bh=NNWznkCUWpX7bwUDLkJO8Tv5f/le2kriYssXIlvWx0s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XM2JuQJEr926SJgoIp22Dowq+w4a5zuvBp4qMpVB3qFWwYeqpB+G9UoHtn42ugr4R
         xsplKI25jWZIqhEQtFsJsv5NVaAPFFccyLVP2lD54ieCXdUgoSaXGv25WjrrMDgB0p
         dh0olu226L4mPea96K2Nnn08NBk47kjocA6edGxI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a73a849f-4818-e083-40f3-c61c662e76e9@kernel.dk>
References: <a73a849f-4818-e083-40f3-c61c662e76e9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a73a849f-4818-e083-40f3-c61c662e76e9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.10-2020-10-24
X-PR-Tracked-Commit-Id: 24f7bb8863eb63b97ff7a83e6dd0d188a1c0575e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d76913908102044f14381df865bb74df17a538cb
Message-Id: <160356931699.14356.13163200383284732113.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Oct 2020 19:55:16 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 24 Oct 2020 09:13:36 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.10-2020-10-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d76913908102044f14381df865bb74df17a538cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
