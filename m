Return-Path: <SRS0=xX0B=TR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC30CC04E84
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 02:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C520204EC
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 02:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558059937;
	bh=Ay43gEPeriQI1m4agIgRQQ9hsQ1BYZs6rhZH/6cF++E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iClYBLaKWXUV/fDueBk1qSMD5OWkA/tTmwVqvJmRJFyBcmgGoM8tg0HzIgvu9hS7R
	 sDpwmDAe5bsJXDbenSH+cbO0c5SO2kRXSdY7tcWbQ4p8S+9fbDegMdJE17yuK8qevm
	 TDAN8Q+QRQsm3HktWDMNgZdxeEPhCLtLGa5zdrqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfEQCZg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 22:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbfEQCZg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 22:25:36 -0400
Subject: Re: [GIT PULL] io_uring fixes for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558059935;
        bh=Ay43gEPeriQI1m4agIgRQQ9hsQ1BYZs6rhZH/6cF++E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d2u7r0nmBk4upQmJ1n6cJAtobWuYeX8ap3u1tmt+J0pl7TEuazxt1RBUo1elt/f0Q
         vFSdgWrwmYZ1ghR9aLB4uDJS9oagsBlGQjWZ99df/LNRDdqw5Ges9LaeTDZEmC2zTg
         u3xlXZvQ1NByHrNI30MBiz17kxyb85q3QR3/YNAE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <02533e56-7dfb-d8b1-a970-f8129f9f3e3f@kernel.dk>
References: <02533e56-7dfb-d8b1-a970-f8129f9f3e3f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <02533e56-7dfb-d8b1-a970-f8129f9f3e3f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190516
X-PR-Tracked-Commit-Id: fdb288a679cdf6a71f3c1ae6f348ba4dae742681
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6a4b66bd8f41922c543f7a820c66ed59c25995e
Message-Id: <155805993556.6110.7467632459719078801.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 02:25:35 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 17:15:06 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190516

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6a4b66bd8f41922c543f7a820c66ed59c25995e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
