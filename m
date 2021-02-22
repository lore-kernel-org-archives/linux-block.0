Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC5C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 18:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A8464E20
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 18:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhBVSnh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:43:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231414AbhBVSmt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 13:42:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1B98D64E12;
        Mon, 22 Feb 2021 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614019018;
        bh=i+bpqt0nqC/KMLl+YcabW+LizIiF91ncNdMIBeD4FK4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QBDLYuulu1nybpaOS8y5pTJhHkCfDs/aXbrIa8QBD+LkKeMjtv93F16SkITcjyyPL
         K8rYkfQMV5o8tRmIFAHw+2hWjhPVoMLqAchjhSvOUNcErSqMY43dFZJJxz7RFaIijZ
         V5q4FRj+iWBFvCU/zlqnE199Ccry5zCa8fW2Z6ChZnTwCYTMcpWXQ/vOxyHYIF9yUo
         y5Imkoy7Tz+/aNbpYbKMa8BBXYD4pIqpzr2IC5dfZecsORwPg6O+niLHwd52ZH5ajl
         8oQ+e8pCz9ezhzXuQ9zhcTGT0MuqSbg2IIhXSYXl/qciSsKNgsDZdSb0SwGyf6kZpk
         TJDYCNxM4YH6Q==
Subject: Re: [git pull] device mapper changes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210218015337.GA19999@redhat.com>
References: <20210218015337.GA19999@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210218015337.GA19999@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.12/dm-changes
X-PR-Tracked-Commit-Id: a666e5c05e7c4aaabb2c5d58117b0946803d03d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 325b764089c9bef2be45354db4f15e5b12ae406d
Message-Id: <161401901799.24925.12214243411996333301.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:36:57 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Jinoh Kang <jinoh.kang.kr@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Satya Tangirala <satyat@google.com>,
        Tian Tao <tiantao6@hisilicon.com>, Tom Rix <trix@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 17 Feb 2021 20:53:37 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.12/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/325b764089c9bef2be45354db4f15e5b12ae406d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
