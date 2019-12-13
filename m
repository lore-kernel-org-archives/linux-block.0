Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAFCC00454
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 23:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC3C2253D
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 23:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576278620;
	bh=XEAR1+ynYVHi761410y7vofACgzyaWGXNdTlUtHnxKQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=s7H5g8riL37lfFILUjmHYYEP57/lz3MqOkxFRBqS7P5tYojMocB926LfpTIQrnMo/
	 drr8GXbq5rI2Z7q1HIq8AXenqwB2cTzPjxgTRHczDcuHrDH1acrwTpgC5UykagdA65
	 eMys7CFazr1BX41mGP2lNUFqXslKV9b50XpRd2mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLMXKS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfLMXKR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 18:10:17 -0500
Subject: Re: [git pull] device mapper fixes for 5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576278617;
        bh=XEAR1+ynYVHi761410y7vofACgzyaWGXNdTlUtHnxKQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zlY6t7AVsdX6Wxas5Pk4mi8U31oc9IY2aYsTV1kRouE9PNty2pblbD9jlWNZ3e9CM
         Gu4lT99r5N3mM+T/tUQHRP/b9l6dbxZV+DM9uu2gr9L5xffuwLPI59o85hH//1zMvH
         H8rPzAK7vth3Y+vd2wDYl1dTOQNUz43GhshLoNAY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191212145857.GA27301@redhat.com>
References: <20191212145857.GA27301@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191212145857.GA27301@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.5/dm-fixes
X-PR-Tracked-Commit-Id: 7fc979f8204fb763e203d3e716c17d352eb96b35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15da849c910da05622c75c5741dd6e176a8b6fe2
Message-Id: <157627861729.1837.4537371197446010276.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Dec 2019 23:10:17 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Diego Calleja <diegocg@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Hou Tao <houtao1@huawei.com>,
        Nikos Tsironis <ntsironis@arrikto.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 12 Dec 2019 09:58:57 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.5/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15da849c910da05622c75c5741dd6e176a8b6fe2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
