Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE79C433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Jul 2022 18:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiGASCv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiGASCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2022 14:02:50 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC86403E1
        for <linux-block@vger.kernel.org>; Fri,  1 Jul 2022 11:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 82E0ACE34B1
        for <linux-block@vger.kernel.org>; Fri,  1 Jul 2022 18:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C2D2C341C6;
        Fri,  1 Jul 2022 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656698565;
        bh=ErBETlepGky9yuqdTZwwMEZrPBpiANpFL5eQ+JXUdWE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Sd0A/5FVCi1WLgEe9Q+72IVFRr9wjRaVgNS+PUj1jarkIll1XLrPNmE6kclBbhFDd
         FHxQJMblGdPRN6LIb2oNsRdpFE3WBgAe3MqlGLRBdr9Yhic4niqpvM3axt+qXzopou
         trzuotPjva68U93DPPD3LNlhGc8hzTUXPygKiSS8t/NqQ2bDi/lxVehQIxc2guPAZQ
         1Dn9YjshZnFs6a/B7VYBnu39vGh7rah2aCC4oJAn2WMEGY+YAQqshUXdqEKLAIPdXw
         L41z2bGJQMSS439hcfesJhTN5XMc7ZqA9qLK8zR6d12H6l68odHVDAT5llpC8f5rVp
         ObCQYGoIfmTww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A02FE49BB8;
        Fri,  1 Jul 2022 18:02:45 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <12cce414-ca5b-3787-5cc3-956ab75d7155@kernel.dk>
References: <12cce414-ca5b-3787-5cc3-956ab75d7155@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <12cce414-ca5b-3787-5cc3-956ab75d7155@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-01
X-PR-Tracked-Commit-Id: f3163d8567adbfebe574fb22c647ce5b829c5971
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d516e221e2fb88cd31c7ea29d743045efc4e69dd
Message-Id: <165669856543.14842.2280583621813531956.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Jul 2022 18:02:45 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 1 Jul 2022 09:33:53 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d516e221e2fb88cd31c7ea29d743045efc4e69dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
