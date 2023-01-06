Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41874C54EBD
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 21:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjAFVTL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Jan 2023 16:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbjAFVTH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2023 16:19:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADAF81D62
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 13:19:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15F5361709
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 21:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73647C4339C;
        Fri,  6 Jan 2023 21:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673039945;
        bh=X7uinhQrpd5ELl9vGIj6tyg0fw6156Ob3soB1LinjKc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JQGHxySgoih7aN9R90XVdKA8jmjemZeHEtfMU2/WDO0hqVzfbf/Hzb54B8U6aEjTk
         ofBxBROZZ8qfUeIbNoGxfC/f7HneQNf5S6ohYPJcY5Q99k6iNu1lqcHNc0E1cAq0HI
         JL/taBBQyQny+EqYw7bx34xY4EgpUkkD5V9I4eJs/Jkmbx1mBWP8I6Gr2ILZrY7khF
         txfiWVipD3wTwxgfd62L3XgR5NBYlyBdrpI+MXYpqJkQSo/7lEVRVmVbHMEBEShQY3
         TI7H1POEeXhP3i6iouJh++FWyFdSu7LDWWN20fkhsUjAtV0p57jxvKMlWI40HmGTf+
         YDkwQDMWB37Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61777E5724D;
        Fri,  6 Jan 2023 21:19:05 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.2-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e9134737-84e2-143c-258b-6945d492a789@kernel.dk>
References: <e9134737-84e2-143c-258b-6945d492a789@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e9134737-84e2-143c-258b-6945d492a789@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-2023-01-06
X-PR-Tracked-Commit-Id: b2b50d572135c5c6e10c2ff79cd828d5a8141ef6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a689b938df39ab513026c53fb7011fd7cd594943
Message-Id: <167303994538.10294.15727857296510305779.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Jan 2023 21:19:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 6 Jan 2023 09:27:53 -0700:

> git://git.kernel.dk/linux.git tags/block-2023-01-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a689b938df39ab513026c53fb7011fd7cd594943

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
