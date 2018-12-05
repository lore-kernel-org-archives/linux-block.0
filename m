Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0B3C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 22:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF1F20989
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 22:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544049303;
	bh=VDzvWIML5/Yong7ghWsbIrGXkmZ33R2Z/8uTqPwB2dY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WEnXIwwL1j7hD8OPXE+swwRNhLoplSdE9uKfFBNZN1fEE/0Y/cPs8cs3wgPqT8Ii/
	 EAoYlw8PcJy/Waaa/RprBRxNNxSFhe1wAR4La3Z7OJbbKG+xgrbpaw/XK/TICAChmw
	 xEmvqwuDWciDUPEprWVAfjCZbyQ2WYMrsJQFNGm4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF1F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeLEWfC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbeLEWfC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Dec 2018 17:35:02 -0500
Subject: Re: [GIT PULL] Block fixes for 4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544049302;
        bh=VDzvWIML5/Yong7ghWsbIrGXkmZ33R2Z/8uTqPwB2dY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tJv/bhYydq1465ERBSORq753Pz5I4jwdNzGpo+eJMRh6qB1gxFBcjD+SblW9x953/
         XlSnNHf/dfFPE207jkfIwqb8sCET9emUmMyFX2qcRoD0sDAfKJghmSqWT4YA95iV4C
         VrpdJDO0DudZkq8A6XaT6vE1tMJ+LVm3eJZXErWk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4c60c846-1423-83e2-1795-b94c7f569920@kernel.dk>
References: <4c60c846-1423-83e2-1795-b94c7f569920@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4c60c846-1423-83e2-1795-b94c7f569920@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20181205
X-PR-Tracked-Commit-Id: ffe81d45322cc3cb140f0db080a4727ea284661e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4eaaa2b99e30305f4bc677f4abfe56c1f8b39670
Message-Id: <20181205223502.13581.46122.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 05 Dec 2018 22:35:02 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 5 Dec 2018 13:25:47 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20181205

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4eaaa2b99e30305f4bc677f4abfe56c1f8b39670

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
