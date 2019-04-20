Return-Path: <SRS0=gurp=SW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBEAC282E2
	for <linux-block@archiver.kernel.org>; Sat, 20 Apr 2019 20:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381E32183F
	for <linux-block@archiver.kernel.org>; Sat, 20 Apr 2019 20:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555790714;
	bh=AKkPCmqJN/M+NGWVj22Km6xSd77wew/T8W5FxVbpOwQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sz4L+Gemrwm4Vm+8crZDQTSnTApaQBclW6YrBG0xfwifuI4mkeNobVqwEYxs4E55l
	 6qxOnGilGxLB7oyhsIydJtSiz03uYzV6HwiHA0KU+uE9EHq8YDxnMmj2ZOdKidNrEf
	 2x+lLyffmvkA+oiAnK7sYUPoiigNwZbImD3UZ71g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfDTUFM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Apr 2019 16:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbfDTUFG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Apr 2019 16:05:06 -0400
Subject: Re: [GIT PULL] Block fixes for 5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555790705;
        bh=AKkPCmqJN/M+NGWVj22Km6xSd77wew/T8W5FxVbpOwQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=h8KG0fPBcGA2OQhTNzOKNzI3RxSE/VJsisuz6hjgEAvSyi0agjLv13UJG6SIH7lZR
         J1Sv+STuVNpJLCKz2tR5S6+tzvgQAUZiBgNtM6LXpuAr45zRRZSZBh9MXCDtZDeJXb
         Bf4u7lf64iuGg3md2zuG2R0FKEI/jKzQvOur+c7c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ce3f98a4-7d83-b0b4-bb69-ffd90e5c2520@kernel.dk>
References: <ce3f98a4-7d83-b0b4-bb69-ffd90e5c2520@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ce3f98a4-7d83-b0b4-bb69-ffd90e5c2520@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190420
X-PR-Tracked-Commit-Id: 6bedf00e55e5dd0a4ed1ad3f06131edd6fb56ec8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38a2ca2cac28cd202a364e30f9fd252ac66619be
Message-Id: <155579070580.31475.17291208310161173211.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Apr 2019 20:05:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 20 Apr 2019 07:34:24 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190420

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38a2ca2cac28cd202a364e30f9fd252ac66619be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
