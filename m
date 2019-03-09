Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1766C43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 00:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C59220684
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 00:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552090220;
	bh=J7zMhpCV1G1iD88AM0IaX9iYnbbCps3X3g0Wziu0kwE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fyDqVOHeaKVVN3Tdxgq99UybzYcU7KAVke1I2EbE2fsPxqmqKiYH229VBGvv+FjlD
	 NjLzICmqDOqq1jBbizDvKY6+HI3pp455t5AjMCXVeFpuSdu5G5NekNy2z0lNURmEb5
	 w+PiL1qoFles3Hl+s6Wri1GBj0j7dpG4f8Gk4oB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCIAKT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 19:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfCIAKT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 19:10:19 -0500
Subject: Re: [GIT PULL] libata changes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552090218;
        bh=J7zMhpCV1G1iD88AM0IaX9iYnbbCps3X3g0Wziu0kwE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2l7CGRbKc5zHdWxpoW2AimacH6pRfIBxGW5LreEdUPVZwI3TzXgQPEcy7CJpqqujs
         pxoGlkRasSgJIFsIW52Z2U9+p/tMyz87wQvZFfo7Q4PwdVD2vXNzH982JevZNjCHQ6
         jl7B0xrFA8aXc2k1PUEe8k3D8imsG99IRj4iGjpk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3a56dea5-a9e3-5766-fd71-e364e13b5220@kernel.dk>
References: <3a56dea5-a9e3-5766-fd71-e364e13b5220@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <3a56dea5-a9e3-5766-fd71-e364e13b5220@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.1/libata-20190301
X-PR-Tracked-Commit-Id: 3bac408a8bcaa2b06e44a3a0254ca26b1ca3025a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4221b807d1f73c03d22543416d303b60a5d1ef31
Message-Id: <155209021866.17751.17942137547466299897.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Mar 2019 00:10:18 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 3 Mar 2019 18:53:22 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.1/libata-20190301

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4221b807d1f73c03d22543416d303b60a5d1ef31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
