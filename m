Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F60C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 17:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3368B21925
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550250619;
	bh=RmsxXulCLGWSEVRfnTkZp6PZIzK/eqf1LiURPDHw7tI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jPFh6ipXJ4hxSuQwv9UYGqJRbyanQkmY5z06gilklUdxe+bsTdfK1k3FgAMPYIWJp
	 4dYKpn78Fn+sgp64RcGLKLq479wO5Sv/bystB3glUzbEWyxPm9ud1xW0uK+57t38Mb
	 ltP0WWhX88rGiAlfyRb5OHYxJK2ASgBTgRXZRXkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfBORKS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbfBORKF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 12:10:05 -0500
Subject: Re: [git pull] device mapper fixes for 5.0 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550250605;
        bh=RmsxXulCLGWSEVRfnTkZp6PZIzK/eqf1LiURPDHw7tI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EIO0rkxL4ervTbBQ1T3jJjUcBvApuhIthtJdKzu+0buuYtuJFikGnexYW1gLOfXAJ
         i2+ZwLDN9NCsNTrOHbwAB/0A8iB/F8cmOVeSd0LXW7UKTrj+dhmF1YhnHUNWb440v8
         dzweptkvKyWXbj+GxCEDkPU1lZMkWaztS2QOOBQ8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190215143832.GA20900@redhat.com>
References: <20190215143832.GA20900@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190215143832.GA20900@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.0/dm-fixes-3
X-PR-Tracked-Commit-Id: 4ae280b4ee3463fa57bbe6eede26b97daff8a0f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae3fa8bd73c9b64416816ec0e9951cd8695c9854
Message-Id: <155025060496.11780.7034405835420282822.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Feb 2019 17:10:04 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 15 Feb 2019 09:38:32 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.0/dm-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae3fa8bd73c9b64416816ec0e9951cd8695c9854

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
