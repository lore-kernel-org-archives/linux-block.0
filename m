Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E329DC0650F
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 22:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B826F2087E
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 22:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564783819;
	bh=C0wVo17fKYx2j3ao2c1BYC/5b/RvbXABwmmbVN+QdUc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mwlk5cKLTVur+qY6xCyR9zOxZiOuwbR8nOxLR5Gx+NsR01K/3xFtCHvbqzctHbZBS
	 X51e5eOToqqJ2N/CEHXn4gYk8ISe6eynoyndzNUz6K6cL4pKrhHxiYtka54/2hUkhL
	 wZsbluTj9qT0aHhWKUHb8PHt9SKBviiexpFZEnug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437201AbfHBWKS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731120AbfHBWKO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Aug 2019 18:10:14 -0400
Subject: Re: [git pull] device mapper fixes for 5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564783813;
        bh=C0wVo17fKYx2j3ao2c1BYC/5b/RvbXABwmmbVN+QdUc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=avAomMnpZnQsIIFF7r6kxdWlXpSmz/jcS+O+KZK/POzMxjYBWjfLmFgafaaEIG9ke
         gTzI8E8eCHXNpCx2Bn275iEOgbb0SX8UgoAoYjzpOlI21+IFMW0HjEN6WUJm4jpsay
         kaSRPmTv5uQu9xe6gK09qXlvXE9vSbjTWkj+jwFQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190802151824.GA86075@lobo>
References: <20190802151824.GA86075@lobo>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190802151824.GA86075@lobo>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.3/dm-fixes-1
X-PR-Tracked-Commit-Id: 9c50a98f55f4b123227eebb25009524d20bc4c2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2c742373d19b356b112d9f3ca4e9377c6f9708d
Message-Id: <156478381353.28292.12883710388695934497.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 22:10:13 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 2 Aug 2019 11:18:25 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.3/dm-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2c742373d19b356b112d9f3ca4e9377c6f9708d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
