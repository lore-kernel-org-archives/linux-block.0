Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F9BC433E1
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 22:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C25205CB
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591138210;
	bh=vmWUvX8MVLEKR8/l6Ddp/D1prHdoLqrxdM1tgTZD8U4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aUKxobj1SJzd6/JhC9bzVG+7/YHoAVa/QsKBrlRfrvaHf26IFh/KpMcy1ObolENJD
	 Uih3mQOelCDMSP+0c7W+F7PoZrxib/0HsBa/9wbfQ2jgCS9dzFm4GG1hckXwIPtWwi
	 sm98cHEUMrGh2JErrU30tu3XKB126byPPI1+8lKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgFBWuJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 18:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730476AbgFBWuJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jun 2020 18:50:09 -0400
Subject: Re: [GIT PULL] Block driver changes for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591138209;
        bh=vmWUvX8MVLEKR8/l6Ddp/D1prHdoLqrxdM1tgTZD8U4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Gfpjtng8ZTPaD3S8TL3eXFsqy86UC5jCVSHEwPEopvbTpRU3lN2Mxm4erJZHJ5rin
         E/WzWdv9Bva5yUp8DrEBBhDGwFmdzaEH4rU6OYSpI7UDuwdaeMVKwBuTE+5+8PTqPw
         npfh06DG2UdlDeldGKHhzBUHXyeH/XFCgijUOzek=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <aa7e82d7-9ed6-dbb7-458a-12346e867686@kernel.dk>
References: <aa7e82d7-9ed6-dbb7-458a-12346e867686@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <aa7e82d7-9ed6-dbb7-458a-12346e867686@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.8/drivers-2020-06-01
X-PR-Tracked-Commit-Id: 0c8d3fceade2ab1bbac68bca013e62bfdb851d19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bce159d734091fe31340976081577333f52a85e4
Message-Id: <159113820928.13730.4338526493746988576.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Jun 2020 22:50:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 11:50:17 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.8/drivers-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bce159d734091fe31340976081577333f52a85e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
