Return-Path: <SRS0=tJY/=UH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33CAC28CC5
	for <linux-block@archiver.kernel.org>; Sat,  8 Jun 2019 19:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF02214C6
	for <linux-block@archiver.kernel.org>; Sat,  8 Jun 2019 19:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560022218;
	bh=50yy++sW+Lj4Nkk1WGLslkZ2Hjk2kOJuzae0conpIL0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qW/L57gCQfvQAPWMgpPEA/eOUUu/VbXE2GZ7nHG+kbU16yniai0PSVn350uWMbg31
	 0rmanEwgFf82S5P/wz5vbXP7bhD3I8LDvQjjU0j3zyDqpU1gB3W3yaX16fQ5lYscPl
	 NP1DefhjhRc4jafpCsgID3BHBj7VP+yEj8P6wFyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfFHTaL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbfFHTaL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 8 Jun 2019 15:30:11 -0400
Subject: Re: [GIT PULL] Block fixes for 5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560022210;
        bh=50yy++sW+Lj4Nkk1WGLslkZ2Hjk2kOJuzae0conpIL0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yfqEV1VGhzhgEEVEyHh3+SYlYHH/9Xhj+A9KPx3Y/tedFt85KhQby8+DnAobCOfav
         cscC7x7uyDHipZIcmtO6BAkkCe7cyyXW0TKAb1DYLb2O6elu5LQEglz4zuPmgG90kh
         +E3dWOiGnhsx9E/E/cSqscsk4y05cP9tFWJMWS3U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
References: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190608
X-PR-Tracked-Commit-Id: 6c70f899b8089ae23cdb4aa63050e3df4e20c71e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d72e5bd86cb405d8d8b9e92905d8cfffd08dde8
Message-Id: <156002221090.30045.10442404340543429314.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jun 2019 19:30:10 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 8 Jun 2019 02:20:57 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190608

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d72e5bd86cb405d8d8b9e92905d8cfffd08dde8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
