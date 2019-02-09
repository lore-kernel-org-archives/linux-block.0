Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E662FC282CB
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECBF21939
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 20:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549745108;
	bh=pARW5A5hq9UsB6G0zskatWND1sPzKYUV476axaNevwU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JEFPOBLj1U3BVxfZnMPLErbSUPtnLiS+fb0z1Ymm8tH7IqJIuyzaXgE6Go9QTT0OQ
	 qnjM/PoLzyySnctJ/PVyXLG2+1XJGznhmdAiQf+hBAmObqFHUXWzbD+YfTKyXM7Lq1
	 OqeMRnwhacS9l2xsKL6Oh9z6ri9c/aE5KEpjCPdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBIUpH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 15:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfBIUpG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 Feb 2019 15:45:06 -0500
Subject: Re: [GIT PULL] Block fixes for 5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549745106;
        bh=pARW5A5hq9UsB6G0zskatWND1sPzKYUV476axaNevwU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oNTrEM3it2ljOxJTPv0qb9YXZ4rACyd2Sxc+VcGh+NfoNdQIfj6zhbpx4KZSIZzWX
         GgXUbXRynAiGvXVkwlkcDxOln4/MgyLuYfmn+3F5Coq4G5E5/GIN3A8yn5J5E6ssaZ
         SDx/zf/ij5C1fdjRivP7WctrJB3XfiBxw/evIqlM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ba1c1ae7-edcd-c918-069f-23818cf873c4@kernel.dk>
References: <ba1c1ae7-edcd-c918-069f-23818cf873c4@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ba1c1ae7-edcd-c918-069f-23818cf873c4@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190209
X-PR-Tracked-Commit-Id: 2698484178ca5cbfdde189b1d8809e1528f82a10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5a8a1163211e2ab6f71c3545b26d55dc99ff1d3
Message-Id: <154974510645.20101.9207359145856734929.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Feb 2019 20:45:06 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 9 Feb 2019 09:39:07 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190209

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5a8a1163211e2ab6f71c3545b26d55dc99ff1d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
