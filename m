Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F87C433F5
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 19:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344661AbiALTPc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357043AbiALTOm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 14:14:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56FBC0254B0
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 11:12:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65FD5619FE
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 19:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCF57C36AEA;
        Wed, 12 Jan 2022 19:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642014730;
        bh=kqYP7tVhIUBxPZyHPkL2WEiXOpWIFn/NPQXNzncSSh8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T9h22OSQGJgtbBPnbaPFwPiCbienA4sG01H2VGARi/kWInk/MsvgrX2VAf/3DoBj5
         bqlJhryVpPn2tgF29Y4XRXENp0I9MFLX3z1w1MwTIQmV89ZQxiAU6QeesftGqzzCWF
         phkrMbU0lctnufPCe3ZTlFJgPfG6ayxZb+YU1tlSVQ3xje77EiRKtUhLsQpUl7F5uA
         hTB5UK5AHPLiN2yID/5FnTSDNAdjTNiLE0gBI1l1ozotzeIFpAYM6zAeMljvaPRIcg
         jfuvsMVxKa/elkL3rc4L9I3SatXcCClKF4fcc/hPWuLojBc6kGyJG00YdPv3TxNGKN
         8caDF3nRLAqUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB5D8F6078C;
        Wed, 12 Jan 2022 19:12:10 +0000 (UTC)
Subject: Re: [git pull] device mapper changes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd8AveH8D+Nk2ILp@redhat.com>
References: <Yd8AveH8D+Nk2ILp@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd8AveH8D+Nk2ILp@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.17/dm-changes
X-PR-Tracked-Commit-Id: eaac0b590a47c717ef36cbfd1c528cd154c965a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49008f0cc1ef0b86ccfa0d1d99e67741d46bd35b
Message-Id: <164201473075.2601.9666209549315511909.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 19:12:10 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Thornber <ejt@redhat.com>,
        Kees Cook <keescook@chromium.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 11:24:29 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.17/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49008f0cc1ef0b86ccfa0d1d99e67741d46bd35b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
