Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC05EC433FE
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 19:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4CC61360
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 19:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhKITeU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 14:34:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230245AbhKITeU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Nov 2021 14:34:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 42ADE6134F;
        Tue,  9 Nov 2021 19:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636486294;
        bh=S3lBCu7AVUQcdGn8J6GSPYu8WZkZLa0BAtzHpvnr/94=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Sr61BsWwI5UIo8H0y6zzDoMTKPQ2jtu+Rz6bwDug0dRPHhRJCo/s7cExyCxC+HfEm
         MifkBn7sebWtRzH6l69I6XJPV2PGkBf+FRYEe62hU+mT9b23FGnXDpjMy+Y7DDX39y
         N1H2GGuMPziSrhdOrnKmVkbObAXN/Fo7ybsSE8Lpl33slqktniW4R6+6evK7XaZjXW
         HdgQ9sRGNubFeAu0vSFTuQg4isSUksSm4WslGxoOHnFK9/MkNQ+qolfzj+7ibRnRbS
         fz2LbqH/JygivElLx7nSpPk5LorRTuRXPaO65gwwEDIUYKw0wHtqVKSQcdqg9czkK5
         5mNtGrBboFEiw==
Subject: Re: [dm-devel] [git pull] device mapper changes for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYmVyArwFwN/FdfA@redhat.com>
References: <YYmVyArwFwN/FdfA@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <YYmVyArwFwN/FdfA@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.16/dm-changes
X-PR-Tracked-Commit-Id: 7552750d0494fdd12f71acd8a432f51334a4462d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c183e1707aba2c707837569b473d1e9fd48110c4
Message-Id: <163648629413.13393.2993481418181438712.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Nov 2021 19:31:34 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Christoph Hellwig <hch@lst.de>,
        Alasdair G Kergon <agk@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 8 Nov 2021 16:25:28 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.16/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c183e1707aba2c707837569b473d1e9fd48110c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
