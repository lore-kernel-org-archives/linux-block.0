Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC6DC433ED
	for <linux-block@archiver.kernel.org>; Sat,  1 May 2021 18:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF20061494
	for <linux-block@archiver.kernel.org>; Sat,  1 May 2021 18:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhEASjc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 May 2021 14:39:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhEASjb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 May 2021 14:39:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 931EC61481;
        Sat,  1 May 2021 18:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619894321;
        bh=OcEMuqTUXMmhv8bX95xFfgjn160IiVyYQZeZ/w17m+0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FyaToPrst+Dx/m5mbVisSysKm9x40v/NGGgbekdKy9YOPakD1K61Uay1VNlTpcUqi
         iQAoxzUQ1uVkGPUcz7rywF8lnL+nra+deS4Nh3FUeSe71T3QUQkkRWmHlza9jpHTqF
         A57wi32AsHDG0aLaMQ8pnUamN3S4vYgZ2QIcamVCo3PiYpHUUQTy1Ef2MGOBQpN3AS
         2mg7VsH9XcDqWDJGpF0gcjxzah4+k5HARi082cPlrAI38UhUza/5nuusxCNh6oMp52
         AGyP83WX5Ro75R6Kg2xyBFICJkJdE4qp9BbXCnlXBgfpOEbDVlZAzgiwapTr1TaYYZ
         hGH3xnR4Lpp+A==
Subject: Re: [dm-devel] [git pull] device mapper changes for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210430193237.GA7659@redhat.com>
References: <20210430193237.GA7659@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <20210430193237.GA7659@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.13/dm-changes
X-PR-Tracked-Commit-Id: ca4a4e9a55beeb138bb06e3867f5e486da896d44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7af81cd0c4306482b49a3adce0fb2f8655f57d0f
Message-Id: <161989432145.5572.1222837453215569840.pr-tracker-bot@kernel.org>
Date:   Sat, 01 May 2021 18:38:41 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        JeongHyeon Lee <jhs2.lee@samsung.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Joe Thornber <ejt@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Matthew Ruffell <matthew.ruffell@canonical.com>,
        linux-block@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>,
        dm-devel@redhat.com, Mikulas Patocka <mpatocka@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Christoph Hellwig <hch@lst.de>,
        Alasdair G Kergon <agk@redhat.com>,
        Xu Wang <vulab@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 30 Apr 2021 15:32:38 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.13/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7af81cd0c4306482b49a3adce0fb2f8655f57d0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
