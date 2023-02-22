Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B157C61DA4
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 21:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjBVVtv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 16:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjBVVtr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 16:49:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A616A5FCE
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 13:49:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6828BB81894
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 21:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A6F7C433D2;
        Wed, 22 Feb 2023 21:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677102532;
        bh=YH/rQSA3eZJPZQYcnSKwLvZsQSY9heC7bKM3t7+q8VM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k4X/laYVp3ZWdtvW6pMYrBU7rvUdM/sV+6vvQ0ItTaTwY2VvcNlp8Yte2Og909vTq
         +Dzq6VMBos+aS0ItecsmfVVf+gfYolquLSZ1HMN2oJckvA8MiRSWtQgFZvvqfB6uhq
         9QLho+UWYO0oBzF6ke3n8ZKQWikJIMYITsjA4AEr4xeVCSPim0EGDZNNhYbUC55Amj
         zND3o/x0whYtHwM9MXLwA1CPnPRSG9EZJ0IWagQIgQJ+Yn5VpX5Q/hEdmuu9uGrWU7
         9FwNGD1WletiBsOi2PQwM8+/coKXl1A8cZCAhF4cQCVpFLBjkCr9nBa6ZTgEhdxzUp
         xbfYBiCmlRgEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18593C43157;
        Wed, 22 Feb 2023 21:48:52 +0000 (UTC)
Subject: Re: [git pull] device mapper changes for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/OueIbrfUBZRw5J@redhat.com>
References: <Y/OueIbrfUBZRw5J@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/OueIbrfUBZRw5J@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.3/dm-changes
X-PR-Tracked-Commit-Id: d695e44157c8da8d298295d1905428fb2495bc8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0b2769a0185ccf84842a795b5587afc37274c3d
Message-Id: <167710253208.31368.7847865305114307104.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 21:48:52 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Hou Tao <houtao1@huawei.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joe Thornber <ejt@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Pingfan Liu <piliu@redhat.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        XU pengfei <xupengfei@nfschina.com>,
        Yu Zhe <yuzhe@nfschina.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 12:31:36 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.3/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0b2769a0185ccf84842a795b5587afc37274c3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
