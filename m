Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89045C43457
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 20:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E0E20872
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 20:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602621192;
	bh=bU+edYJCMx1HEw6K8pRcRgNjl+s8LP1rcHL6mpiZZvs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=e7br5G/l3A25teIEIs3And4foxtvrnfvHSf8k/YUSmGlxOckNiiEWFfmAcUFhdjzC
	 zYGiJTBFzxAU7XchK6Gi1iLiZsQ6ZcRBC9XrVcbXVV+muLQWVVDZ878UzIt8Z82ibx
	 8KIoVk80vgr4pR64noOKKO9ZChIPtFEineAK8h9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgJMUdL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 16:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgJMUdL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 16:33:11 -0400
Subject: Re: [GIT PULL] Block driver updates for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602621190;
        bh=bU+edYJCMx1HEw6K8pRcRgNjl+s8LP1rcHL6mpiZZvs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oA/baEa/tzIOYqum3HqL5X1ikm5eiTLLy5PfQkcd7tEGw+0fy1FtcL1AWKotdlYtO
         tGIaW5C7Gw3XBqtzcayHA9hGOaN0u8XHAYftKoM0ly5giKc+5CtiaVE+Jle8jJ/FuZ
         rkhlueOthzXfNhWtOJut8OpYpuixjmKnVIR/voaM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <70937a19-2f2d-ab26-92da-2e3ce8ef2764@kernel.dk>
References: <70937a19-2f2d-ab26-92da-2e3ce8ef2764@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <70937a19-2f2d-ab26-92da-2e3ce8ef2764@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/drivers-5.10-2020-10-12
X-PR-Tracked-Commit-Id: 79cd16681acccffcf5521f6e3d8c7c50aaffca0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cd4ecd9177b94af783b8e21de7c65b41a871342
Message-Id: <160262119067.22802.6992401610661375955.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 20:33:10 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 08:12:15 -0600:

> git://git.kernel.dk/linux-block.git tags/drivers-5.10-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cd4ecd9177b94af783b8e21de7c65b41a871342

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
