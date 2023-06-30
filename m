Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C74EB64DA
	for <linux-block@archiver.kernel.org>; Fri, 30 Jun 2023 19:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjF3T2V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jun 2023 15:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjF3T2U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2023 15:28:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BAFB9
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2023 12:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D07D617E6
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2023 19:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D687CC433C8;
        Fri, 30 Jun 2023 19:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688153297;
        bh=5tDPJASWdhGVk/AeyfemqZUWvkjVD4uGpLnxUKTpFZc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CReZsxy7pRJWlZIC6iAOCc7If3NsDcV3l3uRkm4dcDixMgsauG0UBvntIx10sBMH6
         gkl49XAOJYiYW1bElnQrDF10eIwZtAnY3Ffx2hQXy41v5OphAE0PWlj8sWGMrLlgJL
         8wJORqxYdrBTduRADnqXGxHn0JZbgIdQm+l2VIqJ8KUbpgos0/Gy/zDA4CEtJKS/cj
         4waS4NTMHwBGbXfCREGNVn1Eb1G8l5noewYlOn8k2OVMk777Up7eNCIG50P+WwKzgy
         i+w8pRqXZxAZBTT36WAciZU3M8DFo144TtaPBW7Sd1vI5NrwSsPt9VD3w2Y57zaM1D
         Cbspxyq6VHe6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C55CEC43158;
        Fri, 30 Jun 2023 19:28:17 +0000 (UTC)
Subject: Re: [dm-devel] [git pull] device mapper changes for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJ3vBCypvTQ7w9pN@redhat.com>
References: <ZJ3vBCypvTQ7w9pN@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <ZJ3vBCypvTQ7w9pN@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.5/dm-changes
X-PR-Tracked-Commit-Id: e2c789cab60a493a72b42cb53eb5fbf96d5f1ae3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cdbb0907a3c562723455e351c940037bdec9b7a
Message-Id: <168815329779.22437.16514933042185962447.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 19:28:17 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Li Nan <linan122@huawei.com>,
        Russell Harmon <eatnumber1@gmail.com>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Li Lingfeng <lilingfeng3@huawei.com>,
        Alasdair G Kergon <agk@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 29 Jun 2023 16:52:20 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.5/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cdbb0907a3c562723455e351c940037bdec9b7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
