Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E35C433EF
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 02:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357945AbiCYCso (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 22:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358144AbiCYCsn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 22:48:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48783BD7FB
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 19:47:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8D01616A7
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 02:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CF1DC340EC;
        Fri, 25 Mar 2022 02:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648176430;
        bh=LRRhD/zUQUEEwXLdZD9CtW6cxeVnRQ/dYeb1tHKJPB8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cxZAWHBXrLRP/BpyWXSseDpcGE7gSDm7al1cywNw/IZsF7SyKnzyRBC5FnUIOWr4c
         C6sAZ5gp4UT09wNN/lr3Pe/h0Xsw/N62ihO9aVgKaOI3xUAXE++XL+kNGBriQzbBLo
         iDnyuQoJ5+OwmgSujTFPSzdpNO/wbfW27BqeU43fra9xaXs0s3YlUlu9Hqn2BCyoJc
         a/W2tVz9k9lk7sCwsHSk5V822PHbBk4uQr/sGXuSdjbz8QBeDzi7jXT2c4A7URogr1
         xDkPIk/UkEbIq3D9+X4QUgKFwh+dZYBvJe0f9kNvt1NhaDfrge48rdi2uPn74B3rP3
         1FdwF/LKeRs5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A303E6D44B;
        Fri, 25 Mar 2022 02:47:10 +0000 (UTC)
Subject: Re: [dm-devel] [git pull] device mapper changes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjuFWbp0vdh/7c5A@redhat.com>
References: <YjuFWbp0vdh/7c5A@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <YjuFWbp0vdh/7c5A@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.18/dm-changes
X-PR-Tracked-Commit-Id: 4d7bca13dd9a5033174b0735056c5658cb893e76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1f8ccdaae0310332d16f65bf0f622f9d4ae2391
Message-Id: <164817643023.17034.838620470975420781.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 02:47:10 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Aashish Sharma <shraash@google.com>,
        Wang Qing <wangqing@vivo.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Jordy Zomer <jordy@jordyzomer.github.io>,
        Tom Rix <trix@redhat.com>, Barry Song <21cnbao@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Alasdair G Kergon <agk@redhat.com>,
        Thore Sommer <public@thson.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 16:38:49 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.18/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1f8ccdaae0310332d16f65bf0f622f9d4ae2391

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
