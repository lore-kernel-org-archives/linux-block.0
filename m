Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC88AC77B61
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 21:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjC3VLv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjC3VLK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 17:11:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA71EB7D
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 14:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28708B82A2E
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 21:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E691BC433EF;
        Thu, 30 Mar 2023 21:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680210661;
        bh=hZnoLdstIvl1qCf/07cneHw8LRnKEFtfzOUfY/DhtWY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xxg/uOLDpCXcXvrRG+wgrSr8WqonaVdwB4IfiJsuc8NyOm3Pev1oMKfpkMzC1nfhe
         EmKMM7FAUQf7pP8XuBYYXGOmDLJWMidC8LcxjpgMCeqMc7f81njTNtp3v7JRhgdrZZ
         L/6sY80RU30Yt+tCnvJEVyzEDHFGfnf7wpMgqeB77JG+cL/dtRp6IGHSDCOtW+qRvg
         cp3CdyxwHHq+5uJeyh/FC0F985/MZBOmDMjli8jau4/zZio21mgoWSbonK6fUMXHvw
         K8TCQyV2v9b2AVcH/QpKapZlgqbx7qW6xcaJ7dOHUT6ssGfV5iR7S2wP3Gs4FedOoF
         buLTcsLZqPJyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D489EE49FA7;
        Thu, 30 Mar 2023 21:11:01 +0000 (UTC)
Subject: Re: [dm-devel] [git pull] device mapper fixes for 6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZCXxoMlJVnVH0TQ2@redhat.com>
References: <ZCXxoMlJVnVH0TQ2@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <ZCXxoMlJVnVH0TQ2@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.3/dm-fixes-2
X-PR-Tracked-Commit-Id: 666eed46769d929c3e13636134ecfc67d75ef548
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b527ac44eb1782cf179d4e08ceda7d2a9643aff5
Message-Id: <168021066186.12065.14172018350219387675.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Mar 2023 21:11:01 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-block@vger.kernel.org, Orange Kao <orange@aiven.io>,
        dm-devel@redhat.com, Alasdair G Kergon <agk@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 30 Mar 2023 16:31:28 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.3/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b527ac44eb1782cf179d4e08ceda7d2a9643aff5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
