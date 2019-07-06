Return-Path: <SRS0=GXCF=VD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EDDC0650E
	for <linux-block@archiver.kernel.org>; Sat,  6 Jul 2019 18:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4474E20838
	for <linux-block@archiver.kernel.org>; Sat,  6 Jul 2019 18:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562439006;
	bh=UrwTq7iXtLu15+CSMzqLbarnDJ/V+NLB7aWFo7eQVb4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SY1IziGBYO8QazEBFxlGWMkTYQLAMO3oaIqUVKk8s/edMD0VNXNcaMjRiXyiHmOJ2
	 eO0Vy8ce24opvNvNrfBMinRIjdS/SuJc84SQcBqtD22OZAzfBuShMqjZWzCI9iHadb
	 4JypWrjD2JlhIJtZN2n3Xcm10UEcx3mbSk3g9GcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfGFSuF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Jul 2019 14:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfGFSuF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 6 Jul 2019 14:50:05 -0400
Subject: Re: [GIT PULL] Single block fix for 5.2-final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562439004;
        bh=UrwTq7iXtLu15+CSMzqLbarnDJ/V+NLB7aWFo7eQVb4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HORtw54RpReV+ltzrvemWjFtAqm2BHArv8x+gz4NLYf2rFWKls0g0G5RKRcx8Segb
         atGflLBfJi2xd2MthboYPsd4Ma9JZBateH5b+0CXSNs+E8BWNC1yPFXe5Eelp3sKMC
         F6hGsJbpEZsmYGutAuFeP15SJnalZheCxTcf96Xc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c6d22c16-de8e-396c-6a17-982498f3e93f@kernel.dk>
References: <c6d22c16-de8e-396c-6a17-982498f3e93f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c6d22c16-de8e-396c-6a17-982498f3e93f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190706
X-PR-Tracked-Commit-Id: 7e41c3c9b6ceb2da52ba9d2b328d1851f269a48e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46713c3d2f8da5e3d8ddd2249bcb1d9974fb5d28
Message-Id: <156243900468.6423.15724866292086516633.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jul 2019 18:50:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 6 Jul 2019 12:47:39 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190706

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46713c3d2f8da5e3d8ddd2249bcb1d9974fb5d28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
