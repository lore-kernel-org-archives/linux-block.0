Return-Path: <SRS0=qKaS=BD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1779C4345D
	for <linux-block@archiver.kernel.org>; Fri, 24 Jul 2020 21:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7FC206EB
	for <linux-block@archiver.kernel.org>; Fri, 24 Jul 2020 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595626815;
	bh=rDNOJX2sHgDapRMrHc7I4T++waUXuCRjriZCrW9wyPE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WkioLo9HIHOFlb07kADDDP89J4nO0tdD4QHNTzerOj47byriXVidSw67WLtIwwj1y
	 72b4FMYjTYEjx7kn0F6w9Zs5m5VEOpnpyxE0jngzrZ/xyJ8+qp0WP+HdI++GZdW+Bs
	 9DhAXHD/SpmWuK3Sz0vAfSNLcoNtelO4Lm2W/bPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgGXVkO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgGXVkJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jul 2020 17:40:09 -0400
Subject: Re: [git pull] device mapper fix for 5.8-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595626808;
        bh=rDNOJX2sHgDapRMrHc7I4T++waUXuCRjriZCrW9wyPE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z6CZ09jiOkqQA6GTGjLGCbuGMiAoBcAJMtcPk4H9bVoNgL8922Fgl/+RnU/njAN7r
         GMm74gMLCmFk85l0WR7FCoQKfjfHv/Yl9O8K2P0EccA+a/VeLj0sanfXa8kM4o9PK2
         FHOOmZmRqRjRwQOEDsuOzL+URTpOZwhEFeMaq4bw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200724174738.GA84895@lobo>
References: <20200724174738.GA84895@lobo>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200724174738.GA84895@lobo>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.8/dm-fixes-3
X-PR-Tracked-Commit-Id: 5df96f2b9f58a5d2dc1f30fe7de75e197f2c25f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a38a19efcd9b7b536e2820df91e9f0be806f9a42
Message-Id: <159562680874.3064.171223039251599867.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jul 2020 21:40:08 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 24 Jul 2020 13:47:38 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.8/dm-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a38a19efcd9b7b536e2820df91e9f0be806f9a42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
