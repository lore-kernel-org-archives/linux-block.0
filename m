Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80362C3A5A4
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 22:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559C3206E0
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566597609;
	bh=Q8oVIP6kvwk/O8zBR6pGpms8shm29QhKyVpcIjuIeAQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ttq3Lr8R+7TLovFzika0rtQwpzq9br+NjgWZDytAD9pnXsFSFc3r5Uy0owDye3UMC
	 8Okhlo5cZVDSS7CcHkYHjRWQBSZsd7HgwFpSAAdT4t9jffinohTWjwvGaZ/0Ik1ev9
	 NFfctgS4iTfXZGLiUX6pZM49DD49PxXiZw0WOvVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392995AbfHWWAI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 18:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390764AbfHWWAI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 18:00:08 -0400
Subject: Re: [GIT PULL] Block fixes for 5.3-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566597607;
        bh=Q8oVIP6kvwk/O8zBR6pGpms8shm29QhKyVpcIjuIeAQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kzCve6Q1FhU/iWu70lQmqCZT5pzH0anQsMcVsrcT5JvZu/bADx5QjqImLBd/lf4aF
         w8oHggjJp2pCqyvzFzqxvlmt3wVWaWkDiw9pvp7+/RdVsYpoSq+BX9beEukAapwgq/
         TyDZSL+C+PpobbGQT2ybUqHP0cSs6OuHAz4sy4bQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <afe09b99-7e3b-ccd4-8443-3957be2807b9@kernel.dk>
References: <afe09b99-7e3b-ccd4-8443-3957be2807b9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <afe09b99-7e3b-ccd4-8443-3957be2807b9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190823
X-PR-Tracked-Commit-Id: 08f5439f1df25a6cf6cf4c72cf6c13025599ce67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9bd6806d014f7d3647caa66ea245329a3ee0253
Message-Id: <156659760791.30868.5711847296993832266.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Aug 2019 22:00:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 23 Aug 2019 12:14:33 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190823

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9bd6806d014f7d3647caa66ea245329a3ee0253

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
