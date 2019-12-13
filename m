Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4509FC43603
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 23:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278ED24125
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576278631;
	bh=hJ2ALtgkNjahDJjRvv8M00mzz/lGCqWB/EU6CpidKy8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=os/TNXUHXf0lNz7hN3/eGB8EaPxNzP8dX6c5/fupdNspwhvUMNPcihnZpItZf1pvt
	 zhZgR/ABUqEcvQ8jd/rWB1oCEW+3m94tdQ1NPAUA72DptHLIFSLyyOmtSsbg387tAY
	 ForDPIjOKKt4W54yz1SFQVm8T2BRYJr8Eb/ZeeGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfLMXKW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfLMXKT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 18:10:19 -0500
Subject: Re: [GIT PULL] Block fixes for 5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576278619;
        bh=hJ2ALtgkNjahDJjRvv8M00mzz/lGCqWB/EU6CpidKy8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PlkIn+Ml5+N9DxpRFnGwDlpBbHUJ2Qb6AzVOJIQj1HnEA17FQQTYNv3XLZU3FJs8G
         3i/+UZYSHwpRqwEVzS8upw10xjN5NbKe0WbfmrvRps/4p2EohOFqbE1YVuv65YY26S
         Fdq10xJi2Uv+Pnsjh1EzPxvH0v3nQ6npCH3EOJJU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1202a2e6-8527-4bd1-7b38-806aafe50e2c@kernel.dk>
References: <1202a2e6-8527-4bd1-7b38-806aafe50e2c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1202a2e6-8527-4bd1-7b38-806aafe50e2c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20191212
X-PR-Tracked-Commit-Id: 5addeae1bedc4c126b179f61e43e039bb373581f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1fcd7786ec8e316b69860ab856f29f346a9b301
Message-Id: <157627861902.1837.2707380427846646761.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Dec 2019 23:10:19 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 12 Dec 2019 18:23:32 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20191212

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1fcd7786ec8e316b69860ab856f29f346a9b301

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
