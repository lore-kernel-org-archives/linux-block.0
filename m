Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D9EC433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 22:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD77320780
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 22:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593729013;
	bh=fs5x2iuusTFQA1FO/XXkeZ6ZkpMa2NTHaua2aMR2AwE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ePXvH56Yv5wECRTSHgG2lPgtb685JfqNzagMO/PK3TeAr3ck79akddRraVd/eh1jQ
	 fGdwhNsKISOxhvC7xzB/8CDydVavIRKVZ8Hx14aoiVsg3txYN5fgc6MXAV63TV7kSI
	 3dAT0HeOUKr7lhaCm0inrVtlWBkD7vpK7jvrW484=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGBWaM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 18:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgGBWaL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Jul 2020 18:30:11 -0400
Subject: Re: [GIT PULL] Block fixes for 5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593729011;
        bh=fs5x2iuusTFQA1FO/XXkeZ6ZkpMa2NTHaua2aMR2AwE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R6r9HdRteUHCftJN1AisIwcVrfKFxL9YXTK4LeUywzbVG0UyElWxogEwy7NgbypWp
         B5bFvx44zcQDZLi/6JavOfXqssZwoSap/Fm7UwmgyXfsFAP9aHDdm1cJyGVE3mGW+g
         5FZ5bE5+ZfMrhRKky108rGEtWS1Xp26nguY89SOY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <70c99f08-5396-92d3-ff45-091a56216452@kernel.dk>
References: <70c99f08-5396-92d3-ff45-091a56216452@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <70c99f08-5396-92d3-ff45-091a56216452@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.8-2020-07-01
X-PR-Tracked-Commit-Id: e7eea44eefbdd5f0345a0a8b80a3ca1c21030d06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cc2a8ea104820dd9e702202621e8fd4d9f6c8cf
Message-Id: <159372901107.6563.14124092494857442078.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Jul 2020 22:30:11 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 1 Jul 2020 22:31:45 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.8-2020-07-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cc2a8ea104820dd9e702202621e8fd4d9f6c8cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
