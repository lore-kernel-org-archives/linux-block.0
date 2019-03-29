Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ADDC43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 21:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35301218A6
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553896224;
	bh=JU5NFEHF0AavXlOLXg6cq9yGM0LGAD2qDr2lrFme8Tc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KiPvE7hpu9/qK6vnioN7euY2B1lyoiY6FGA8E9p6wBEk5aWYsdga0pDu/5nYznv/1
	 3JSzCNMJhYFycEkb2Al1HlxQ5qkEawtZp+wGKZNQafXw3hKqoDQXWL3SmEk5Zim7Dc
	 UJZ6UXxjHjw1mQ6CEraPeGR384SorTwx2JVX6RFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfC2VuO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730362AbfC2VuO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 17:50:14 -0400
Subject: Re: [GIT PULL] Block fixes for 5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553896214;
        bh=JU5NFEHF0AavXlOLXg6cq9yGM0LGAD2qDr2lrFme8Tc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JqQTNS2JbvETE6puizbXJXB5Cvqw4lNpUWmVUSQ8iE9xBelSP6zTr8vQ3BdSaq76q
         xjTMRCeULlJCxmwfmlH/62uNcQplLcNDXo4aCQgGuDunvxac3wu+dv7DiuvMNWn0By
         3CoojBSByfV3vwBLMBbR9jMSFq1MHJMd5OW68Jfw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <16a4b76d-7a6c-f4b4-7e6a-21f51e4ca527@kernel.dk>
References: <16a4b76d-7a6c-f4b4-7e6a-21f51e4ca527@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <16a4b76d-7a6c-f4b4-7e6a-21f51e4ca527@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190329
X-PR-Tracked-Commit-Id: 7bca889ee9297c3e208dee7c41aed7a56a880400
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffb8e45cf33e14d9a565491aec7abe039bebcfce
Message-Id: <155389621401.28625.8039423637564285326.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Mar 2019 21:50:14 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 29 Mar 2019 10:09:34 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190329

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffb8e45cf33e14d9a565491aec7abe039bebcfce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
