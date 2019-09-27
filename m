Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568F3C4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 19:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287F621850
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569612334;
	bh=MLWc8vzj/d5TXoBc6i2GcCB9M9YMbZ8yzXDZp0SiaS8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pL3yr6CwTP+0mkMwH+fe1t/9Bgk69kbdYR15fAM8dEjhRHY/uZqQbBVAV4i3dOjzn
	 ZgrSmxFT/XFker01Khr97/jS/ryObExscdtHGo36o2IUt1HyXa4gPC/kpleiGhKGH+
	 UPSrfoDGS2IMdLk/636Um4Iesa03/C0EiRCU02/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfI0TZd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 15:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfI0TZd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 15:25:33 -0400
Subject: Re: [GIT PULL] Final block fixes for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569612332;
        bh=MLWc8vzj/d5TXoBc6i2GcCB9M9YMbZ8yzXDZp0SiaS8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=O27br0KOrbJ/XZvg21DGwlmSFe5t6dE2PIIPrwuhxKA4q4F3wS3KoKnZkktxILZyd
         EfYdruR0RaMem7DaeoEPDqw01WIrAFyrFhiTEPqtTowov0YnnZiNcguiHNNwnxRB/i
         3qYdXhO430ZvwekfOtX+m8FWg9J3O9to3dtNVYJ8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5a77cfd2-3e9b-3a28-1637-e33d3e4221fb@kernel.dk>
References: <5a77cfd2-3e9b-3a28-1637-e33d3e4221fb@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5a77cfd2-3e9b-3a28-1637-e33d3e4221fb@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-2019-09-27
X-PR-Tracked-Commit-Id: 8d6996630c03d7ceeabe2611378fea5ca1c3f1b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47db9b9a6eba4c5b0872220c8c8ff787a4b06ab0
Message-Id: <156961233286.19941.4216460380146798673.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Sep 2019 19:25:32 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 27 Sep 2019 16:55:06 +0200:

> git://git.kernel.dk/linux-block.git tags/for-linus-2019-09-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47db9b9a6eba4c5b0872220c8c8ff787a4b06ab0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
