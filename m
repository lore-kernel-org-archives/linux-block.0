Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A86C00140
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 16:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiHLQCr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239051AbiHLQCo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 12:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9446E9F0FF
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 09:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3179B60F2A
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 16:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F80CC433D7;
        Fri, 12 Aug 2022 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320162;
        bh=WjT59+m4OwHM4V04aIjDseibB4LMnxt92cCwTFXtYRM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ArB/BmpGp3NrlwXmHQjdXEaJSb9T43amcHqN8/nNv3Bk9JLXX4E25I6rMToMtzM+M
         JbptDDkW/5egZOcZwqsUdAdWqYqCdlhphKSfvbqJclWt9HUsRNpChSfTEQ+zgl7GxN
         +CxOdfNGGlSEh07afuTDvMcuqSar0GgHclYJgtAb62l6pUZGsNwSDCLzzTO6F2/SWB
         0WtLOqgkuUGVbtDQJmvQUrG3sNT33/bdy4haLjVwQxN9vms9Xoi/MiO0Ox4lBxbxoR
         8pMU+g1O2JXR0ny1rEA0BhWPOjxWUvefIRbcsgxHm+nUgaLPyWgrfEfAOJJHLFAO7k
         qrBB4bXyAmo0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A0A7C43141;
        Fri, 12 Aug 2022 16:02:42 +0000 (UTC)
Subject: Re: [git pull] device mapper fixes for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvWtRMgKKKSEcEAr@redhat.com>
References: <YvWtRMgKKKSEcEAr@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <YvWtRMgKKKSEcEAr@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.0/dm-fixes
X-PR-Tracked-Commit-Id: e3a7c2947b9e01b9cedd3f67849c0ae95f0fadfa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3adefb5baf377868f45de78eb9f72f87eb498b0
Message-Id: <166032016249.8665.2518413406570499434.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Aug 2022 16:02:42 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan Huckleberry <nhuck@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 11 Aug 2022 21:30:44 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.0/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3adefb5baf377868f45de78eb9f72f87eb498b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
