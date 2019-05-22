Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD1FC282CE
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 16:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BCD21479
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558540832;
	bh=GmqD7AtA6ErScDiQ8O0QMe/qkGJxSpeJh0USFVx656I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=c+Etjk1GlI2gEe+uDXeHCEaH1Tms45zehyvFx12nUfNTSid/Zj3CjNfHE/FmaTUjk
	 fPfqjWcOdPyKaTSIhB7wllEMCeSWriKLxYYIYN0XT7EW7hQbcwop6mfXBduccKyciA
	 4/5IVgsWNuW5JpYgZd7zRYNShW1KJ1REOu72hcMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfEVQAa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 12:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbfEVQA3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 12:00:29 -0400
Subject: Re: [git pull] device mapper fix for 5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558540829;
        bh=GmqD7AtA6ErScDiQ8O0QMe/qkGJxSpeJh0USFVx656I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Lr4RJmJ60x9N8lH5XAK7kVdn2nO7mwfGYzJn9C4kekCw3eBDU2zGbx7dKApnVgB4Y
         ymFbKnuxADQ0Ik7rP7WQ8H3DjybTs2h7/fSjdIK9L8EMN6K5BjBzq0tsp3BDWRw43V
         NmEQNbm4GDxeVS/fyYhQI/aJJHaTN5nyxekgEbhE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190521233844.GA31426@redhat.com>
References: <20190521233844.GA31426@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190521233844.GA31426@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.2/dm-fix-1
X-PR-Tracked-Commit-Id: 51b86f9a8d1c4bb4e3862ee4b4c5f46072f7520d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86f9e56d08852961a1b9e062d59b71491d8c793a
Message-Id: <155854082943.3461.2423715519320359357.pr-tracker-bot@kernel.org>
Date:   Wed, 22 May 2019 16:00:29 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Michael Lass <bevan@bi-co.net>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 21 May 2019 19:38:45 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.2/dm-fix-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86f9e56d08852961a1b9e062d59b71491d8c793a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
