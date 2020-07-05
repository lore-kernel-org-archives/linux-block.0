Return-Path: <SRS0=GQ+f=AQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C957C433E1
	for <linux-block@archiver.kernel.org>; Sun,  5 Jul 2020 18:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1C320708
	for <linux-block@archiver.kernel.org>; Sun,  5 Jul 2020 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593972012;
	bh=w0S/yZ42NuGBmH3J+i3JMn1fDwm7UdU6TjLviKlZAnU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=W4zjzs1LHjPnGa8pZKh64R5rQ9mjwpAXGaL/mDLi6pveEgupq3x/V1wdSVL/kslVY
	 r8foKnXIQfVaRCrb306zhIwciTF9jGpampXz0mxg3QugY+sFGVsiyZxelWA/1B5Tdm
	 32Cg94bT1ehcRJkX5ie0XUb+H+xkbYDNpMgxdpEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgGESAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgGESAH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 Jul 2020 14:00:07 -0400
Subject: Re: [GIT PULL] Block fixes for 5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593972007;
        bh=w0S/yZ42NuGBmH3J+i3JMn1fDwm7UdU6TjLviKlZAnU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yasixhHZ03tzU7ZCqoTkOGuxPyTMzuKHrsNTwaMMkB5HnajMPKEYXMf4P0NZ0uUg4
         nhkdh0+sv1xZjl5CsCaheZj9vLzBM1uQhjf6Mv0a13iwtNOvkqyHYHlPo3pjD+hynk
         xJ+Ye3H6SlqZTwDEV+3T7be4sByJ0qo52xytMMi0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <38cb5040-bc16-298d-bc78-624f22a9f0a1@kernel.dk>
References: <38cb5040-bc16-298d-bc78-624f22a9f0a1@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <38cb5040-bc16-298d-bc78-624f22a9f0a1@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.8-2020-07-05
X-PR-Tracked-Commit-Id: 3197d48a7c04eee3e50bd54ef7e17e383b8a919e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29206c6314a3e5242b23b61cd1270cba9e93b415
Message-Id: <159397200729.8921.570699597270958826.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jul 2020 18:00:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 5 Jul 2020 07:05:55 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.8-2020-07-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29206c6314a3e5242b23b61cd1270cba9e93b415

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
