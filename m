Return-Path: <SRS0=tC1N=2M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131C2C2D0C8
	for <linux-block@archiver.kernel.org>; Sun, 22 Dec 2019 19:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC118206CB
	for <linux-block@archiver.kernel.org>; Sun, 22 Dec 2019 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577041819;
	bh=gqaF9j8BM3Ui5IXOPilXYa1+9dQtUbFgFoShBVY5H6A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BsOQbCrJJgfOjY7sxMZnbWbDitV/izzbqg4G2tyirPvo/NotS2vGwx1FHIKVkkq5k
	 feY/mlqdl9e31ePBW6hLRdoVHH4nje2m4CpgiFzQnBmx463OONKl13SsKhM3agriNq
	 Apg/3TGBx+4eTzOnNH7C/EEwIGPiVtOOuzCgaJ2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLVTKS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Dec 2019 14:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:32894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbfLVTKP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Dec 2019 14:10:15 -0500
Subject: Re: [GIT PULL v2] Block fixes for 5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577041815;
        bh=gqaF9j8BM3Ui5IXOPilXYa1+9dQtUbFgFoShBVY5H6A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bt5XE8xQriLA6N42CgXNwMK42og5u0UR5bM70R1g3sTIJPgH/DaVMY9H7AljLWu/m
         /fWsLLH7tXu3R0z9xgj+9zjKOM/s5WKZIdp1DPJYE+VW/sRH5dx0G8B7QUTLBP+8O7
         uDwEDIX017rXvlwLuahBd+IUediWY8pwpyLBS8cg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b6a949e1-44b2-097d-4c82-237aa707e43c@kernel.dk>
References: <b6a949e1-44b2-097d-4c82-237aa707e43c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b6a949e1-44b2-097d-4c82-237aa707e43c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.5-20191221
X-PR-Tracked-Commit-Id: df034c93f15ee71df231ff9fe311d27ff08a2a52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44579f35c2d90dfac5ea27308261318c7750e9b5
Message-Id: <157704181514.1067.6320817145094953912.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Dec 2019 19:10:15 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 23:13:17 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.5-20191221

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44579f35c2d90dfac5ea27308261318c7750e9b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
