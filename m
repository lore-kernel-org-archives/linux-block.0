Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE319C25B0F
	for <linux-block@archiver.kernel.org>; Sat,  6 Aug 2022 18:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiHFSTr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Aug 2022 14:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbiHFSTm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Aug 2022 14:19:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC3FE0F8
        for <linux-block@vger.kernel.org>; Sat,  6 Aug 2022 11:19:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 481CB60F1A
        for <linux-block@vger.kernel.org>; Sat,  6 Aug 2022 18:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB6FAC43470;
        Sat,  6 Aug 2022 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659809980;
        bh=cdXVIPwRcZsFPL5zjexAZoz6neuuGIwlpDmgW7k058w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h0fs5fiW8oWkAheH4TU35P/zVEKOHgDWhRRRXuBcgiAclAlos2veYe2EJ5vI8V0Kn
         Fyuk9Wm6YQVGHlCCPC2KjZVTWfQcCkzWOn69S+LBRLVUJ9jjNcFHHzUxJWWREJeb+W
         EhqU5iqT6osucjps8l+Wa84+52LnlakHD3zGJEIrolMvK6bbSic2S9UVeNbbp+Qzw4
         NyAqvhFRR1QJDvUUudykTk9fMsADxbkYItzTYhjYEBag6nbp+p3RkvRQKxZf2Ud3SS
         eSFiviYxt9WjPuEUEjQ7yHGjKLqxTAl7rUtNdS3y/vDeev7MSIJJxGz9QQsCmliKs4
         AMEXELeIUlO9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97028C43142;
        Sat,  6 Aug 2022 18:19:40 +0000 (UTC)
Subject: Re: [dm-devel] [git pull] Additional device mapper changes for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yu1rOopN++GWylUi@redhat.com>
References: <YugiaQ1TO+vT1FQ5@redhat.com> <Yu1rOopN++GWylUi@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <Yu1rOopN++GWylUi@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.0/dm-changes-2
X-PR-Tracked-Commit-Id: 12907efde6ad984f2d76cc1a7dbaae132384d8a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20cf903a0c407cef19300e5c85a03c82593bde36
Message-Id: <165980998061.27284.17220964359709259877.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Aug 2022 18:19:40 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Milan Broz <gmazyland@gmail.com>,
        Alasdair G Kergon <agk@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 5 Aug 2022 15:10:50 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.0/dm-changes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20cf903a0c407cef19300e5c85a03c82593bde36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
