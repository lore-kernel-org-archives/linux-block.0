Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D28C433EF
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 03:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B791760E95
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 03:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhJWDuw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 23:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhJWDuw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 23:50:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C85B860E95;
        Sat, 23 Oct 2021 03:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634960913;
        bh=Fxm5YZTYZeo+aaxqZM8BIY6pmkymAOzk1xHl/SjbbW8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tRJdpujgIP7qeWAN2e6M6Vy586Flz2W99GsZuY0BKr936/8uSAbdAIj0Tv8LED4GJ
         wtLoW2uLvvXYhyZUDYBAhVeam1KvXKZHuo30o7xkpnIACZzECBcB8niBfo9XBeg2ia
         YDfwN9drm1ut1tfa+1x5kg/xZivv8RHN0h65FQ5hTLAd7HQBpn8klOlspu83CIYIpB
         tO+yVJKrhVqjtZDolwLeAMMU/xNwXPlBrw9ml8t979MI+lv5ukr9YgQBeP+ZSo7H6/
         JoCcI6whBVWowh2BYim9+3vVuui74Ve3V16grpfng4nJuXBNyFcvI10+E7WHAeP7HJ
         mSX7uv5efC89A==
Subject: Re: [GIT PULL] Block fixes for 5.15-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e4f72489-1ca0-46c8-65dc-f04b31e337f7@kernel.dk>
References: <e4f72489-1ca0-46c8-65dc-f04b31e337f7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e4f72489-1ca0-46c8-65dc-f04b31e337f7@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-22
X-PR-Tracked-Commit-Id: 9fbfabfda25d8774c5a08634fdd2da000a924890
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c0c4d24ac000e52d55348961d3a3ba42065e0cf
Message-Id: <163496091378.3380.5625829130583189308.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Oct 2021 03:48:33 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 22 Oct 2021 21:25:59 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c0c4d24ac000e52d55348961d3a3ba42065e0cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
