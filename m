Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607D1C00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 21:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiHBVaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbiHBVaT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 17:30:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876BE62E6
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 14:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4881B82104
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 21:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 955ECC4347C;
        Tue,  2 Aug 2022 21:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659475814;
        bh=yUP6mcS7vuRKfy50iKKNO1G0R26msZkRNNUJ3p0xrcc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fxGDtSYuU5/2d9JWB29ZRUm5SNGs+2cqdSwxPa/PzTXkYffz/PSn3TvzDE06sgnA8
         4pdP1u+9xHOgZJyIsrhgLhRbPNKEI3E1IPyWz6f7nGvh0Zp9+ug+fOIVtfMwP5w+mH
         EQz5xY6wV6dKRUA0H6LyQNVHBZOeiPf8e46UF/Fw2JKN/eET8kBkqnmpJemEZ/13mF
         aDLRqeOr6Qbf90BlKL6GyTzJZWZkkVmKYvKlFW5mTsLd5QX/Vm2aQFmjbjOYDPe0mV
         Xsbx+NIB4n/L4J+BAEokYepjS7YRZGnhfmE4HL0D1alwsnWEYljh636XZR0wfrF4pL
         t300VW7SmolJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8129EC43142;
        Tue,  2 Aug 2022 21:30:14 +0000 (UTC)
Subject: Re: [git pull] device mapper changes for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YugiaQ1TO+vT1FQ5@redhat.com>
References: <YugiaQ1TO+vT1FQ5@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <YugiaQ1TO+vT1FQ5@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.0/dm-changes
X-PR-Tracked-Commit-Id: 9dd1cd3220eca534f2d47afad7ce85f4c40118d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8374cfe647a1f360be3228b949dd6d753c55c19c
Message-Id: <165947581452.30731.17701893502534317271.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 21:30:14 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        JeongHyeon Lee <jhs2.lee@samsung.com>,
        Jiang Jian <jiangjian@cdjrlc.com>,
        Luo Meng <luomeng12@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mike Christie <michael.christie@oracle.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Steven Lung <1030steven@gmail.com>,
        Zhang Jiaming <jiaming@nfschina.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 14:58:49 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.0/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8374cfe647a1f360be3228b949dd6d753c55c19c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
