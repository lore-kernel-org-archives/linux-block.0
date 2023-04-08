Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A39C77B6C
	for <linux-block@archiver.kernel.org>; Sat,  8 Apr 2023 19:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjDHTBQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Apr 2023 15:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDHTBP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 8 Apr 2023 15:01:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54AAA27B
        for <linux-block@vger.kernel.org>; Sat,  8 Apr 2023 12:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 818D560C24
        for <linux-block@vger.kernel.org>; Sat,  8 Apr 2023 19:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7CD7C433D2;
        Sat,  8 Apr 2023 19:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680980473;
        bh=A6sQ4Lv3wjVZOYoPa8Vi72rBi47xSUs9xUoypFKN1Zc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lNL0O+iMmvuQt1Bloe5lptKxvegjzfhwzTZDnOCDC1KH7CWlqrj4GvkaVag+oLZfC
         dgKCWcg7cx1AqHz3XlvNQFguBQjcgre2s/j6kgqsuuIs9/Fy6xFHXrLkj1m5EWVDkv
         wd6y7aZyC4XNj8pSdfHYgQzt+jKKXdA2AmCv8Rw+6D5jCYhg+yimgwtFWB1OzROYC6
         pOHV+96RPUhH+Pc/CzITaQyAbmM+FIumraHuCal8/da4+5O5Lk00xNqEPQSdBaKJsK
         ylzeNKf1U4fmDrZBhXLba5Nok6p2tOycZKa7K3fLXUrEy0opsakpmVmcfD44EImGN+
         xc+3M9ifw5C1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5CE3C4167B;
        Sat,  8 Apr 2023 19:01:13 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <52f2b320-dbcf-f276-bd86-ec6dd21b88dc@kernel.dk>
References: <52f2b320-dbcf-f276-bd86-ec6dd21b88dc@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <52f2b320-dbcf-f276-bd86-ec6dd21b88dc@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.3-2023-04-06
X-PR-Tracked-Commit-Id: 3723091ea1884d599cc8b8bf719d6f42e8d4d8b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da0af3c55955efceb7d23f40c8f3d9f4b590d34a
Message-Id: <168098047387.1995.10246901589165126582.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Apr 2023 19:01:13 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 7 Apr 2023 10:50:40 -0600:

> git://git.kernel.dk/linux.git tags/block-6.3-2023-04-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da0af3c55955efceb7d23f40c8f3d9f4b590d34a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
