Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3CFC3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 18:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268A121897
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566583210;
	bh=IlQXMmvJD18w1Kbvv0h569kolYaHA5PVbqNZMhvqNSw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bX7Dl1IPrcfcyHYjYIJwwfZQ5NeLLQfDrxMkTROHJ1e3ahSNl8ulp34m2yStHwamQ
	 tlDt+DVNIS+TQM0yxPFNmvnYab2B2b9U9P0XdCI2srO12txYCaRLqu2b/FZw+d4pgg
	 3rwIEZjsB6eNwobMG7xBONumZesVvl0pWu5XWJlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390219AbfHWSAJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 14:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388081AbfHWSAJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 14:00:09 -0400
Subject: Re: [git pull] device mapper fixes for 5.3-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566583208;
        bh=IlQXMmvJD18w1Kbvv0h569kolYaHA5PVbqNZMhvqNSw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bXTtAGDaWiEd8fj6STpjVXoBD+y4CpoHTu4NB3kk0qrbg7d+gyWGn+mTq/f+X8AUC
         H+2fWviXGtQn47Ygfb+drrCoJBDaIkcQYEswoMKWgXeGctvzcHsRh16SRRNQDtdH/S
         waKmDatpnx7Y+rKxtyEkkAQJm6TXJMvjceKzWx+E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190823154153.GA24648@lobo>
References: <20190823154153.GA24648@lobo>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190823154153.GA24648@lobo>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.3/dm-fixes-2
X-PR-Tracked-Commit-Id: 1cfd5d3399e87167b7f9157ef99daa0e959f395d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd469a456047af5eb1ee0bcfc8fe61f5940ef0e0
Message-Id: <156658320865.8315.6721871049498316785.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Aug 2019 18:00:08 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Bryan Gurney <bgurney@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 23 Aug 2019 11:41:53 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.3/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd469a456047af5eb1ee0bcfc8fe61f5940ef0e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
