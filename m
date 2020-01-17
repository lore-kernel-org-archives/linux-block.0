Return-Path: <SRS0=x5xE=3G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8381BC33CB1
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 14:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE9E2083E
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 14:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579269908;
	bh=cc3sqYz90t58t7rjWzjZLNl420jeBvbRG/mZ+ki3w0o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rETk2/J7CMpuzAOU/KnIo0rOxSoEz2fmWZu4tkq0ffu1Xmqwqm9Od6KSAKItsOmFv
	 AoPCQ20q7+DP/aaQpKnJoIfSvP287OBV0xVUBnfXEwmRFEek5N0q3mYlTD0kWFvXv/
	 dceL63RE6amGOvuxf3HTfdOHfC5ZiuvgB09sPfqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgAQOFH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:05:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgAQOFE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 09:05:04 -0500
Subject: Re: [GIT PULL] Block fixes for 5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579269904;
        bh=cc3sqYz90t58t7rjWzjZLNl420jeBvbRG/mZ+ki3w0o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RMgnpMF8rPklIMZT2fglM37vyay/XkKXmz6r9lq34RoX/J4UzLei3On0JcXuJ4G2z
         eWAlTmqmO6KKO83h2D0UMmQACuWc7k1pEB/BxAhhtcNzXGNz7kqX1gLym6Xdg2iC5z
         70J1cFowfCPIRGNZsSN9XKdKr89W+S++9Uta10Fg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3351f62c-671a-11d6-db8d-d78366bbf50b@kernel.dk>
References: <3351f62c-671a-11d6-db8d-d78366bbf50b@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <3351f62c-671a-11d6-db8d-d78366bbf50b@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.5-2020-01-16
X-PR-Tracked-Commit-Id: ad6bf88a6c19a39fb3b0045d78ea880325dfcf15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ffdff81cff9ae697b1d57fea9a86b6c6ede6078
Message-Id: <157926990435.9623.1830717615857427771.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jan 2020 14:05:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 16 Jan 2020 21:33:46 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.5-2020-01-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ffdff81cff9ae697b1d57fea9a86b6c6ede6078

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
