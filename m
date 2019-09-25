Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1191AC432C2
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 00:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B5920874
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 00:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569369935;
	bh=wt51hCSbuDmA2UBIvn94Fmi/nBjhFgQ3RqAGnd/FDzk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2WLsyOkhvNx29NNGgNFOmb4RNNrtQyIxLMfhpuak9qYM3Rq+Bbe+pUtmPZROB6etf
	 Uzn3UDA3jKiEcwwtACWnkLO/ugE47smEQ/p5LsSgEiHHDE7vffcWE3qPTtmkCnuYUq
	 JeUuf0I5+J5LgnM5ImxtX0NdqeyObyLTy1jf6rSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfIYAFf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 20:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfIYAFe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 20:05:34 -0400
Subject: Re: [GIT PULL] io_uring changes for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569369934;
        bh=wt51hCSbuDmA2UBIvn94Fmi/nBjhFgQ3RqAGnd/FDzk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G1L6/C8wNelt3bmnV91zLiitVsT8YhArZ5nWPg6KQvIj04Rcb2u+ncYNhXySFJPkJ
         aJeOv7w9IpVKT5YoEVY1JctanRisfsQx2ZLBxt4N9exBWMF662tKCQgvRIngzghFHo
         4TixGB3/3j+X931Fw9//UCRtv/+y2YIVjcA7A+7Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <264fe7b8-5f4a-6c1b-dbed-5b73e71ab442@kernel.dk>
References: <264fe7b8-5f4a-6c1b-dbed-5b73e71ab442@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <264fe7b8-5f4a-6c1b-dbed-5b73e71ab442@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.4/io_uring-2019-09-24
X-PR-Tracked-Commit-Id: 32960613b7c3352ddf38c42596e28a16ae36335e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6cb84b4fc580098a5934078e4c8dc39e3925f07
Message-Id: <156936993424.955.14689193160977991202.pr-tracker-bot@kernel.org>
Date:   Wed, 25 Sep 2019 00:05:34 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 24 Sep 2019 12:50:27 +0200:

> git://git.kernel.dk/linux-block.git tags/for-5.4/io_uring-2019-09-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6cb84b4fc580098a5934078e4c8dc39e3925f07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
