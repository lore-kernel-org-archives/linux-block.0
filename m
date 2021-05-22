Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D613C2B9F2
	for <linux-block@archiver.kernel.org>; Sat, 22 May 2021 18:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34C86105A
	for <linux-block@archiver.kernel.org>; Sat, 22 May 2021 18:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhEVSSQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 May 2021 14:18:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhEVSSQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 May 2021 14:18:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9FDD861163;
        Sat, 22 May 2021 18:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621707411;
        bh=xc4hvMjWdhGXp4Qo6B/yv6A3ldXoJ9nrKezEVXUZg2w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eVko9oqCthQanHG//2vWjAS/V8yW5Qx0c6psMLyU2/4k0ncplg7HOu2sv6wLlVove
         sHSQNaAI4rUPZGR0UAZhO2IOyf8/sxZN19FkFJocOml/h6yRQsbRYVAGmzfAqkSLND
         U8l05L3wnJMQdHL4AlDTlSF2FAJLym0CAp1GhmhLct0ShKvn/6nYoECJXbthRcbIRy
         YRX139dY/PISmYJq4/XhktDMNBQ0citkOh+afF/lL9hc7JRrpX59pZ5Q4e72UMyjte
         ikmCgSIYeUJThuV+X7JVKZoBg645DPeMN4dRlxKIh5kGQwA+sC8ayAYxRzqaN9fEes
         m/Znl+9MA24hg==
Subject: Re: [GIT PULL] Block fixes for 5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6b2a9507-a892-7c34-dd05-76ea55769a55@kernel.dk>
References: <6b2a9507-a892-7c34-dd05-76ea55769a55@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <6b2a9507-a892-7c34-dd05-76ea55769a55@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-22
X-PR-Tracked-Commit-Id: bc6a385132601c29a6da1dbf8148c0d3c9ad36dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ff2473bdb4cf2bb7d208ccf4418d3d7e6b1652c
Message-Id: <162170741151.21100.7468800321451263649.pr-tracker-bot@kernel.org>
Date:   Sat, 22 May 2021 18:16:51 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 22 May 2021 11:22:26 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ff2473bdb4cf2bb7d208ccf4418d3d7e6b1652c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
