Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AE3C7EE21
	for <linux-block@archiver.kernel.org>; Wed, 26 Apr 2023 20:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjDZUJu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 16:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbjDZUJr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 16:09:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E95C2
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 13:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1251563012
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 20:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64BAAC4339B;
        Wed, 26 Apr 2023 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682539785;
        bh=tce/vICA2n9Na3Tc2MPzAM/bgCcv7GKhars7eMtZrVQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rRzhsX6Fr7RdXac5J0jNoutuKROjgo1rKWgCyZNNkPaH5Ib7WVEVofppE8yj2/pih
         Op2LC25uRFOFocFcNAkRgoAOMBKNfWC6hPyajYBsx/M7N1eJyKyXyVbPBUz41QU7XE
         UaQwcVffVHKo08zqLJM5sN+T8k6J3jhYHDCzyfcvxiiSe48Ozrr/O0+qbATa/juAun
         qQVoeyzuy9dRlWjIHA2OIy1I6+nnE+NbgjZpoUzgmUFWNDTOzyFabHOU5HO8dFpVDz
         4L021ycysbdhf08Es8wNLVnLrNlelOIpMOwPeY7RHWBMhERiMhbvunViXN8fyD9Yvm
         +ar2LYwClsFbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DC81C43158;
        Wed, 26 Apr 2023 20:09:45 +0000 (UTC)
Subject: Re: [git pull] device mapper changes for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEa3DOLC3GAX/MVx@redhat.com>
References: <ZEa3DOLC3GAX/MVx@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEa3DOLC3GAX/MVx@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.4/dm-changes
X-PR-Tracked-Commit-Id: 38d11da522aacaa05898c734a1cec86f1e611129
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48dc810012a6b4f4ba94073d6b7edb4f76edeb72
Message-Id: <168253978531.23673.1793015930816014970.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 20:09:45 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Joe Thornber <ejt@redhat.com>,
        Li Lingfeng <lilingfeng3@huawei.com>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Tom Rix <trix@redhat.com>, Yangtao Li <frank.li@vivo.com>,
        Yeongjin Gil <youngjin.gil@samsung.com>,
        Yu Zhe <yuzhe@nfschina.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 13:06:20 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.4/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48dc810012a6b4f4ba94073d6b7edb4f76edeb72

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
