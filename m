Return-Path: <SRS0=sA/n=PO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A439EC43387
	for <linux-block@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738F6222A9
	for <linux-block@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546742416;
	bh=abWtrn9jheSLxvUj7GBUOJWP8Tf4Pu02lbe16LRKzK4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aVBV2BjUN3TCt53WLn9+exG/uz1YEjkz+X/HNbwKpTqjh8BzpY7/FVWVyqVfie3Cj
	 Yo8vB6xbRO9NbakgpLv0bcFok9ySRFXWynkdmQlRdnqB+GlWo2Zz2aJ2Q2rcI3v/24
	 zO+eArExPiZHciHfz8xf3+jZvVip67SS9rPKA0TM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfAFCkP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Jan 2019 21:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfAFCkJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Jan 2019 21:40:09 -0500
Subject: Re: [GIT PULL] Block fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546742408;
        bh=abWtrn9jheSLxvUj7GBUOJWP8Tf4Pu02lbe16LRKzK4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nL1VVhFtV+rtejfizgavFHBu8pFIM4x8a6W2HglPzoXIQ1B7vlq3bk1TGJQJ90X/E
         mZockeoH2GT1p7bjH/I5LAkGnR/YZ4isaVkeHA3U/3uK87OaxCj2BJMfP05hekKJGx
         oEG9+r5F9TbqFRQpmYonfMJLpNubj44iCN/FhXRc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <03b6bedf-e57b-0449-1e27-1585720f0432@kernel.dk>
References: <03b6bedf-e57b-0449-1e27-1585720f0432@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <03b6bedf-e57b-0449-1e27-1585720f0432@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190104
X-PR-Tracked-Commit-Id: 59f75fd0e31532bdcf65f754516cac2954d5ddc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7252d0d36375fe8c544098469a21d03fa267a55
Message-Id: <20190106024008.13237.92262.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 02:40:08 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 4 Jan 2019 14:30:25 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190104

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7252d0d36375fe8c544098469a21d03fa267a55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
