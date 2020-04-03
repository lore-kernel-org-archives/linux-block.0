Return-Path: <SRS0=iNmo=5T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308B9C43331
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 22:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EA72078C
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 22:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585951521;
	bh=PQJA7zgoUeJX1yGQtOzkFYkU54wSZxSEYhYWdTrfjGk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=P7kGrEaqfvuSg5ugpC4NWHLJcH+16VQdlvMMUlkpwhllzQYDZ1mfMraENhjgGDRMt
	 ykiR6lKX0jncihJB0zyVSf0JfvuoKok3h7wjOVy6fHdE1ns1Zsmm4eN5lbbRbGJE+S
	 c8IZAGtRcKJgxtICM4TaXVTZnFhI6UAAYcMvpMYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgDCWFU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728532AbgDCWFT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Apr 2020 18:05:19 -0400
Subject: Re: [git pull v2] device mapper fixes for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585951519;
        bh=PQJA7zgoUeJX1yGQtOzkFYkU54wSZxSEYhYWdTrfjGk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nbVNIKUVPJN9daTRvhINA4t5n0hhoKxXig9IOWNvUUteny4wlHVlkvLkjyK09JEfH
         BK6c7Hj1gJFRGoDO5bks+6Ep/bYs4Oc1rqwlO90C9FzwHqmtKYGjaguqrH1u8dXfvO
         XFLPg52S/rBPl9xi6s+RTq/pyAnLUQYXtWgbEtH0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200403171543.GA92499@lobo>
References: <20200403154213.GA18386@redhat.com> <20200403171543.GA92499@lobo>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200403171543.GA92499@lobo>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.7/dm-fixes
X-PR-Tracked-Commit-Id: 8267d8fb4819afa76b2a54dca48efdda6f0b1910
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de3c913c6e9d8bbf8b2d3caaed55ff3e40a62e56
Message-Id: <158595151917.22871.12219569331072002461.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 22:05:19 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 3 Apr 2020 13:15:43 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.7/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de3c913c6e9d8bbf8b2d3caaed55ff3e40a62e56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
