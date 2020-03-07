Return-Path: <SRS0=wE/y=4Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0655FC3F2C6
	for <linux-block@archiver.kernel.org>; Sat,  7 Mar 2020 20:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFD22073C
	for <linux-block@archiver.kernel.org>; Sat,  7 Mar 2020 20:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583612707;
	bh=wjlzMUKw+o2Kj+Ks3J2doyQ5SEaGG9RrxTJNbSvHOSY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xRQ/uv7M0v4UerqUEjFSIGeF6uED3KufyYxnsZPX3NN2t6Ukrl43mIvKjcFQXQulh
	 nh8/ZFWtlnP0L89PsXH1r/Wze+4QlzowZnjElAebgjKyZhP0fIK3XYBLhno1+/8GSE
	 mN0SPS3rcCmVNaJJ2PzdkK+ZoVFoyr09cjU1/zzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgCGUZG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Mar 2020 15:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgCGUZF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 7 Mar 2020 15:25:05 -0500
Subject: Re: [GIT PULL] Block fixes for 5.6-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583612705;
        bh=wjlzMUKw+o2Kj+Ks3J2doyQ5SEaGG9RrxTJNbSvHOSY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GZtWiGo4q4nZ5vT2itQNrxmBFKUUG3JlsjPnTLho2YZHYGlx1BsCHY8WQsKGdl/bW
         2rgsvUfuhN+zv9Yq9ivMCzgP2zJtpo60uUj83KIxs6Z1wAQ0mS9HwzhVR0pbb+NwdK
         yIAoel25Y8F6+ZKQ6nAPbqoaKcJWbpStZEbgeBUg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fa40d7d0-75b7-b30d-7f00-4346c33dd17e@kernel.dk>
References: <fa40d7d0-75b7-b30d-7f00-4346c33dd17e@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <fa40d7d0-75b7-b30d-7f00-4346c33dd17e@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.6-2020-03-07
X-PR-Tracked-Commit-Id: 14afc59361976c0ba39e3a9589c3eaa43ebc7e1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5dfcc13902bfb6d252b84e234bfc4cdba76c1069
Message-Id: <158361270525.17903.18326796371824410936.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Mar 2020 20:25:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 7 Mar 2020 12:14:14 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.6-2020-03-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5dfcc13902bfb6d252b84e234bfc4cdba76c1069

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
