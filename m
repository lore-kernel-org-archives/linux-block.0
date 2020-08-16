Return-Path: <SRS0=mZfT=B2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FF3C433DF
	for <linux-block@archiver.kernel.org>; Sun, 16 Aug 2020 03:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C2E206F4
	for <linux-block@archiver.kernel.org>; Sun, 16 Aug 2020 03:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597549567;
	bh=z2eUsEBFDQZGSIMm9al56FlYj7GTGRfINXrl57GHlBo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XIFMj21rPeAx3v6BTCfGEIU4DU6HiPcP5wl/Y3OviyKzidXeKZ6fx3oWxQXp97d2d
	 sGlu8PLDX3OCoe9P7fJ9kKdXdemVLsAQ2nN8wG0FsaIS2lCg3Lx8h8OqkRR6kY393e
	 VS6vnPNCDMDxBcuWYvWcRm1Y6j7QNfnaXw3iukNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgHPDqG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Aug 2020 23:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728868AbgHPDqG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Aug 2020 23:46:06 -0400
Subject: Re: [GIT PULL] Final block fixes for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597549566;
        bh=z2eUsEBFDQZGSIMm9al56FlYj7GTGRfINXrl57GHlBo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1pRls4rRjvtAO0d+DQ4fejl8jcfdYaEFLWPt9blLScREJskh06iwn3h5G0i9WiFkF
         XNaHutDysHcgw0vxzEvdp0HWjFDObLDmZckcaX9vdETnFS3795W4az/41lbI/X1Wp6
         WKPdfEmLOxfAb0w05YzsdAtg7h9VxNJONrxvCXmQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fcaf3dc8-5065-30ff-f831-17db615c162d@kernel.dk>
References: <fcaf3dc8-5065-30ff-f831-17db615c162d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <fcaf3dc8-5065-30ff-f831-17db615c162d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.9-2020-08-14
X-PR-Tracked-Commit-Id: c1e2b8422bf946c80e832cee22b3399634f87a2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b6c093e21d36bede0fd88fd0aeb3b03647260e4
Message-Id: <159754956612.1876.15976274547785513345.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Aug 2020 03:46:06 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 15 Aug 2020 16:31:09 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.9-2020-08-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b6c093e21d36bede0fd88fd0aeb3b03647260e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
