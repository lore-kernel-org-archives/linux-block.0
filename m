Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BC5C433E0
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 20:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B361F22CB3
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 20:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596832807;
	bh=ehxZzctGhxbUoWwPkR60ec2uLkv3qH2o5s9Q8qXx0o8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=su9ho8zo4kOGflWELgS4IdQrzh3Bn/dZmKIlwng7Jwf4v8MYiJmJk7eb2GHlRkCdV
	 gQHJtF/V8CEv2vXntIRFLCeG93q3gQp+YkWdNUbQ9PAZGtOBm307I3wHiVuBBLWIaW
	 JOmCE3rO/D+FpIi3w/nLCrSu6zSrG8SGd69L0qgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHGUkH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgHGUkG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Aug 2020 16:40:06 -0400
Subject: Re: [git pull] device mapper changes for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596832806;
        bh=ehxZzctGhxbUoWwPkR60ec2uLkv3qH2o5s9Q8qXx0o8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GH3nZ0Uiv2pUer1w/ANI+94Vx+xST6w1FO3ji45rhspBHRPSPBMHC8/pqEQiH2/rX
         nGvXo6SkAH3fmaC2nkYL8ayl3srTyrq/esnTdgXWjymm+Sd+mYouCm27F0sXCk8dby
         g+7yeOxKWxphAf73ypZrH/E+l1Iw8GG5hrVem9Vk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200807160327.GA977@redhat.com>
References: <20200807160327.GA977@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200807160327.GA977@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.9/dm-changes
X-PR-Tracked-Commit-Id: a9cb9f4148ef6bb8fabbdaa85c42b2171fbd5a0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f12d44085dabf5fa5779ff0bb0aaa1b2cc768cb
Message-Id: <159683280645.2860.3665375467005569936.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 20:40:06 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        JeongHyeon Lee <jhs2.lee@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Dorminy <jdorminy@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        yangerkun <yangerkun@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 7 Aug 2020 12:03:27 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.9/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f12d44085dabf5fa5779ff0bb0aaa1b2cc768cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
