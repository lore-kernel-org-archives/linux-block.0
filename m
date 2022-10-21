Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947FBC43217
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 00:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJUAlk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 20:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJUAld (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 20:41:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8B196EEF
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 17:41:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE905B82A11
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 00:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AA95C433D6;
        Fri, 21 Oct 2022 00:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666312876;
        bh=u6ho9VrMVeJWGaAvTDColdvtuYONIh5JvUWzC4OZePc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M2ifSKhFXW3eFEI6O7eRd8roYJqR8BJSJlQgSWrTz2Pzg9S+u3lNM05lDLsREMu2S
         wfRZQdBqujy75AdKaTh66EHtyEF/CdN7rEmBpOtsdJT0qnP/XHRpn5oPgplFN/KNXk
         iVaFh0wmjspvh5dEeUrW7MnaSPb9JP8PR0ezmTsVgC4gOK6pOr8QzTc4kn0Ngyng/Z
         dGzQlimkdc8cTXvVCVQGXhzIpEXnp3keNEK4/IWjnZ3E/QN7+QuxONle7cGg04xgji
         0AmnhQnno+UB0JIawfP0mexItPQJrQxFJvhidGwKb11bokKkkBeNhvkfp0AygDOrLa
         wUDmxZCDpGNJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 642C0C4166D;
        Fri, 21 Oct 2022 00:41:16 +0000 (UTC)
Subject: Re: [git pull] device mapper fix for 6.1-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y070ExTjLGLStSQ0@redhat.com>
References: <Y070ExTjLGLStSQ0@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y070ExTjLGLStSQ0@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.1/dm-fix
X-PR-Tracked-Commit-Id: 141b3523e9be6f15577acf4bbc3bc1f82d81d6d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43e6c111824c75940a586cd7d3fe6a5ff1d5104f
Message-Id: <166631287640.10394.17455212903841431163.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Oct 2022 00:41:16 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 18 Oct 2022 14:44:35 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.1/dm-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43e6c111824c75940a586cd7d3fe6a5ff1d5104f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
