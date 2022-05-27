Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C8EC433F5
	for <linux-block@archiver.kernel.org>; Fri, 27 May 2022 04:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbiE0EQz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 May 2022 00:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbiE0EQw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 May 2022 00:16:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752A01838B
        for <linux-block@vger.kernel.org>; Thu, 26 May 2022 21:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22C21B8227F
        for <linux-block@vger.kernel.org>; Fri, 27 May 2022 04:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC3F6C36AE3;
        Fri, 27 May 2022 04:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653625008;
        bh=/wBe3TiXbPMeMWz/O1enAHyltvhE/a+dhkdLmAu2VkU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c3yEVCjuFsoouRC8//frYKZP9FnlofrVqxoSo4nArdERdCJJOKMbiNUXlJsJe65WF
         5l5P9zN5rwDjVnV5kpqr2eD1Cspg9qZueHuUr/aE5OEeqLifsXBNjfWkXQo0DeG3BE
         7bF1gVnLdlXkwMlBOhdVk6ARZOrBRddIXyF4LLAQ43ih/SIg0m59WO1d0+l9oBlHvy
         bSk2VxEPTLduC6y3F16tsLGDuwPqDoF4+Kx37Ix+XoLvkO5O6QR9lQIGE3F+0ggVtO
         VAsuah0FKFkbH1+qDavTjIIVcCUFN6nJzjh0G94X/zABJPrWJyjlLe/gfCnwOB3gof
         Se5F7pKKOB70A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C858BE8DBDA;
        Fri, 27 May 2022 04:16:48 +0000 (UTC)
Subject: Re: [dm-devel] [git pull] device mapper changes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yo+tqngHo5JCZTJc@redhat.com>
References: <Yo+tqngHo5JCZTJc@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <Yo+tqngHo5JCZTJc@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-changes
X-PR-Tracked-Commit-Id: ca522482e3eafd005b8d4e8b1331c911505a58d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e284070abe53d448517b80493863595af4ab5f0
Message-Id: <165362500881.11855.3190444075121150722.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 04:16:48 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 26 May 2022 12:41:14 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e284070abe53d448517b80493863595af4ab5f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
