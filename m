Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5C7C433F5
	for <linux-block@archiver.kernel.org>; Sat, 23 Apr 2022 17:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbiDWROg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Apr 2022 13:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiDWROf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Apr 2022 13:14:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9B81AF3E
        for <linux-block@vger.kernel.org>; Sat, 23 Apr 2022 10:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 292CA60F45
        for <linux-block@vger.kernel.org>; Sat, 23 Apr 2022 17:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CDC8C385A5;
        Sat, 23 Apr 2022 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650733896;
        bh=007ct6jwXTbJQS7rs9kmkWmfcVXNUfdGwk4stLkhz/g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XANd/YC6ZQt9amkNXdXzOixa6VXPFHNxMaXasuXGaq9kBSpkzGXrOhdtCS10dMzAv
         eYzytjtc2IOZGALFDm9Ndu6Cds0mMYiJoszq3WCDLRAYeDjutctj2kDE3XYLJCEsuI
         jnPpXFfdKnutqPZ9kqLuU0IpiMhSfqgejsxhD70Qsbakab2l4zSq/X2Z2ruqs4DW2x
         BR0nHUys0GPwDCeNp6vf93LuAP9CZM519m8zv+1DAtRPh7kj3uasTDYOox9bXzT9y2
         +DsIUW0IHPXJHgzH2kRPRJrM8oDZpH5NgWHv51/qglhz2DPs4jAR++5am6aNhjws12
         VZuRUcLYESR6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79B13E8DBD4;
        Sat, 23 Apr 2022 17:11:36 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.18-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1dbe8c29-19a6-d03f-e693-502080707680@kernel.dk>
References: <1dbe8c29-19a6-d03f-e693-502080707680@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1dbe8c29-19a6-d03f-e693-502080707680@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.18-2022-04-22
X-PR-Tracked-Commit-Id: 9dca4168a37c9cfe182f077f0d2289292e9e3656
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8467f9e34955c6923e0ed63b1c2dbbf1df70b908
Message-Id: <165073389649.30714.5350357575760719388.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Apr 2022 17:11:36 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 22 Apr 2022 20:18:08 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.18-2022-04-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8467f9e34955c6923e0ed63b1c2dbbf1df70b908

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
