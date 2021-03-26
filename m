Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B2DC433C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 19:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52234619C7
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 19:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhCZT0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Mar 2021 15:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhCZT02 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 15:26:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CC6A1619C7;
        Fri, 26 Mar 2021 19:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616786787;
        bh=hlKI4GXQnq0WckvQ7E4zUJC8c1fh5Q5XKdVorn+vjeI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iY0VEx7oRqahsZuSFlRYKyBlFOMct8dwsTwVYQ2965+jXxU5HaBZCqNIIlaCAyy1i
         ZNN24lqIIL6VoTeVjEklCt4qjztphlwJgQS0C5jJ3Wwq+XLTcOL3wDHYhg+THiVphT
         OG9pz2EsOmk/Q/hAcrWAmPpCiQaq3Th3TbM99iqlib3pkCTdI5rLZ1JlKlZBjoc7Gq
         k/LhntbBnSPP6HheFJL3shO6GfLHALohn1dyXz2hpRVAK/Jvy/dbu4rWET2W2X/h5j
         M4/kRFPzF6SDN9WatpX2jE6COV8BpLrwP6NxV5cp/SG0Tj+bJfGH7o2ZoIyRTrMFFY
         pC+YDymr/JP9A==
Subject: Re: [dm-devel] [git pull] device mapper fixes for 5.12-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210326191949.GA24195@redhat.com>
References: <20210326191949.GA24195@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <20210326191949.GA24195@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.12/dm-fixes-2
X-PR-Tracked-Commit-Id: 4edbe1d7bcffcd6269f3b5eb63f710393ff2ec7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f4498cef9f5cd18d7c6639a2a902ec1edc5be4e
Message-Id: <161678678743.25793.365361573220872812.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Mar 2021 19:26:27 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        JeongHyeon Lee <jhs2.lee@samsung.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Alasdair G Kergon <agk@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 26 Mar 2021 15:19:50 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.12/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f4498cef9f5cd18d7c6639a2a902ec1edc5be4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
