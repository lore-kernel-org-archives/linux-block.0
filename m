Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB673C2BB1D
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872492082D
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586539836;
	bh=pTFG5Sx1p4OYl2PX9fK3g1krUOpWWnVk5XN2VdQU5Bw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mATLvqJcrTsa5M3pNeCXaQpFXqPhuoOo8lIXotwXq88qbeoW9Sz1T+wybt4JKSHv6
	 kBRQKgZcW6GkKx+1/AY8qISTrOyQ/letPxrwojAscAvaxlpYcMQBD1K8YFpG6WU5jH
	 G6B63YoTV+23eRLHFKepp2WQSl4HREzud9pFuxeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDJRae (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgDJRad (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Apr 2020 13:30:33 -0400
Subject: Re: [GIT PULL] Block fixes for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586539834;
        bh=pTFG5Sx1p4OYl2PX9fK3g1krUOpWWnVk5XN2VdQU5Bw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UP0/QPe/+uebEFO6ic5DEz33jDndEOSCn5G7eKcDjMeFknGlYcqsOFE7ps5mX0AuN
         5D1+R/hAuhjNqg1GfLhf1AiVY1zFAyp+Wb16Fu4Fp4MG+vh3rnRdskwf5+yoP0OGI+
         5InBG0t00xJ95D5I2fTJGe5IlAze1Y3kr+xSP+oQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0d580c9a-be04-0b48-0594-17a0339df1b5@kernel.dk>
References: <0d580c9a-be04-0b48-0594-17a0339df1b5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0d580c9a-be04-0b48-0594-17a0339df1b5@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.7-2020-04-09
X-PR-Tracked-Commit-Id: d9a9755a83d706fec22e4364b2f91568dfb8c4ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb6b771b05c3026a85ed4817c1b87c5e6f41d136
Message-Id: <158653983410.6431.17328231284598932887.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Apr 2020 17:30:34 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 9 Apr 2020 18:07:56 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.7-2020-04-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb6b771b05c3026a85ed4817c1b87c5e6f41d136

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
