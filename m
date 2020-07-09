Return-Path: <SRS0=YKm5=AU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4632C433E0
	for <linux-block@archiver.kernel.org>; Thu,  9 Jul 2020 20:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B107A207D4
	for <linux-block@archiver.kernel.org>; Thu,  9 Jul 2020 20:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594326007;
	bh=4prF1rgvo43nXEGfhLxB/RWwQ8AvgyWDEYdDNQNiea4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ng+gZnBn/ApvLLwddZw8tYWihRkmQwD7IeWXQ6GifMqdRoBCfYrXErZGClpuzdG/U
	 Ta5UWq/4PHiLzX3BD/U6Zini/H06J26zMBIjPyzAtzwKnIlGG6iurnpo07dMpIjJEN
	 o64TwAWfweeGU50TLJ2VdKmyGz8XvZEs+ZVlUl2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGIUUG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgGIUUF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Jul 2020 16:20:05 -0400
Subject: Re: [git pull] device mapper fixes for 5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594326004;
        bh=4prF1rgvo43nXEGfhLxB/RWwQ8AvgyWDEYdDNQNiea4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Lbfa4TZYIq7BqITpvIWnUFBza+MwyIV/KPVYxm6NE+u68JfG1nAIqLlu8wUOcmCmD
         p7f19LJg2bWI1KNjuF84CKxy6TDpCs530a/HOhuxeFWP1C3BTY9M71vsxsYjKhdRRi
         G7DPif4+pGheSzSQ3n18bkaVPNxbDv5C8/lhf6js=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200709194329.GA14653@redhat.com>
References: <20200709194329.GA14653@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200709194329.GA14653@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.8/dm-fixes-2
X-PR-Tracked-Commit-Id: 6958c1c640af8c3f40fa8a2eee3b5b905d95b677
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a89b99f580371b86ae9bafd6cbeccd3bfab524a
Message-Id: <159432600493.22213.7905594715678061789.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Jul 2020 20:20:04 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 9 Jul 2020 15:43:30 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.8/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a89b99f580371b86ae9bafd6cbeccd3bfab524a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
