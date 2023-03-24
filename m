Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B4BC6FD1C
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 21:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCXVXn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 17:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCXVXn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 17:23:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B7FAD39
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 14:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 065B2B82619
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 21:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 963BFC433D2;
        Fri, 24 Mar 2023 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679693019;
        bh=vxRM5nu+lL2YrBLwN+2df3sXIk54wm0wGAr64Y/hmEE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ILyRgsTaoQfqVsU3KUlpyHiGEdRnJnPU2u51aZdbqVSq0uVFhuPiUJkkuRbdUKn8R
         /XHPwx495Izq8Ml1k7v5MLjqfE+Xq2E8a8n3pLcQr0yBU2soMJ1lN1CiUr531Vspov
         bS836VEPzxgNuyYhZ8OfIhhDG84TUUEeouw7jU+4YBnz0ZHaYHuU8h5FWg9IgAxO7o
         zEQ2HYDkjInoxBe5U1156z5aAnof14q8xxQ1c+hsqMImKC+IovLNrCZ7MZD4IIJWut
         Vu2TdnBx2I9E22zw6NmUCjBwLDkVsWSUWw+NmWFt2wG+VHyxQEbZ+SooZIl4PliCpO
         0cBArKK+NLQvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 812DFE2A039;
        Fri, 24 Mar 2023 21:23:39 +0000 (UTC)
Subject: Re: [git pull] device mapper fixes for 6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZB3cJuV78aKnnWrO@redhat.com>
References: <ZB3cJuV78aKnnWrO@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZB3cJuV78aKnnWrO@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.3/dm-fixes
X-PR-Tracked-Commit-Id: d3aa3e060c4a80827eb801fc448debc9daa7c46b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ad4fe9613cb8c202150f5cce5347fc8926c6c01
Message-Id: <167969301949.25746.12928284570782952004.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Mar 2023 21:23:39 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Coly Li <colyli@suse.de>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 24 Mar 2023 13:21:42 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.3/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ad4fe9613cb8c202150f5cce5347fc8926c6c01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
