Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6E1C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 20:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF80F217D7
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 20:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360911;
	bh=3L70Ve72+15sqmsi0AY9xMSl/b2kSXdLfxDzXV9RHUg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VfzSPth2PNMVrMg3qYoEBPhks73IRF8K6pf3PiD2LYR0tLcwc72Aau0XIh9uof18e
	 xTC5iDedFy6QX9/N+xSFxIDG/u3x17tX1fihkW8UEIqItzpLfD1gbcj9V6ylZm/GkI
	 fUYatprSzlye82uEu18sNPprWi4T8NGvrZICFdPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfAXUPG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbfAXUPF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 15:15:05 -0500
Subject: Re: [git pull] device mapper fixes for 5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548360904;
        bh=3L70Ve72+15sqmsi0AY9xMSl/b2kSXdLfxDzXV9RHUg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jOnVKE0c9YjMLJsaC9jH91KAwL7qHd9uyBoDZFEgymq6pmbKb5aKyi/Dk5jeNrx/Z
         kCBYmWLDlpzW/3eLZpU7Z6na7qKlQUji0bjGvdqMmrJQB300+R2rChBgx0oWg+YvDj
         jxNXlpnNmWc9Ad57zWAxuEbUGgYzGZYDnPPrxlbk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190124193829.GA22312@redhat.com>
References: <20190124193829.GA22312@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190124193829.GA22312@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.0/dm-fixes
X-PR-Tracked-Commit-Id: 075c18c3e124a1511ebc10a89f1858c8a77dcb01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cffd425b90147296c627dfb13f7ea8f361d962b2
Message-Id: <154836090475.17041.9019633015502052050.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Jan 2019 20:15:04 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Joe Thornber <ejt@redhat.com>, Milan Broz <gmazyland@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 24 Jan 2019 14:38:29 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.0/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cffd425b90147296c627dfb13f7ea8f361d962b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
