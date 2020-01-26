Return-Path: <SRS0=p+1D=3P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB4DC35248
	for <linux-block@archiver.kernel.org>; Sun, 26 Jan 2020 20:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FEE206F0
	for <linux-block@archiver.kernel.org>; Sun, 26 Jan 2020 20:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580071506;
	bh=TkrnnQaRaQJfIweQsIMe3OvlJmCL5qBujSuO9Lwq2F4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cW1Vd5gqix6mweDCHYKL8R62dPX0HopWigd2Cx2go88GJC4AMrAhDkDlgSDvPUHwU
	 V4PLYLymf/dF4R/IUbq6e1QKjAJyW7fRnG3mHKl3Jq/bWEETNG4jsjrgYXxoyhLtEJ
	 HfyTiQsrjofUwYO/wwCsiSrKWCAJhozZwpRQVha0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgAZUpF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jan 2020 15:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgAZUpF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jan 2020 15:45:05 -0500
Subject: Re: [GIT PULL] Block fix for 5.5-final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580071504;
        bh=TkrnnQaRaQJfIweQsIMe3OvlJmCL5qBujSuO9Lwq2F4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RGHX+Pxi/vDHTvZFYpPHFVVEncE/G0GxpSm9mTz6NI7mTApYVjbOYhvdq626vqx08
         s5fSSEj0nWatN7eXYtpuLT+S6fTP9Uiis7HZYoRuJcK7DmAFe+wsL4djEdBEEaL2Cp
         o3UuTJf4aBwd78G3zZj4Qu8BznGv64KxGJmcAqqE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4deb18d9-34fd-c780-dbb4-f544d30ac807@kernel.dk>
References: <4deb18d9-34fd-c780-dbb4-f544d30ac807@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4deb18d9-34fd-c780-dbb4-f544d30ac807@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.5-2020-01-26
X-PR-Tracked-Commit-Id: b72053072c0bbe9f1cdfe2ffa3c201c185da2201
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9dbca16087099b9d9826011cddfdae2a16404336
Message-Id: <158007150468.2238.11529751228269797886.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jan 2020 20:45:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 26 Jan 2020 10:32:04 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.5-2020-01-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9dbca16087099b9d9826011cddfdae2a16404336

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
