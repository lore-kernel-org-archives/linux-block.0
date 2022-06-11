Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E5FC43334
	for <linux-block@archiver.kernel.org>; Sat, 11 Jun 2022 00:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349564AbiFKAIp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jun 2022 20:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349504AbiFKAIm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jun 2022 20:08:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9432100
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 17:08:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6636961E6C
        for <linux-block@vger.kernel.org>; Sat, 11 Jun 2022 00:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA967C34114;
        Sat, 11 Jun 2022 00:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654906120;
        bh=iTOiq8idrLa6U8hRrrjOLYIQ2u2vcr7ASb14RFedasU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Bt5WDFPlnp3b7uCJBfvGBrtmu2JbVirhYf84b64RPPlsmTdkwD+6ugWSzsv0GltGu
         dOm5jdOzCoM/SHkLkx9F5/84MHw2knStYnUcqXYKXaCDT4kXZVvzpkIkE235C3w8HW
         WiuFb6Jw8rD9uHNuCKpYYirj7lVeZtPFBBHkOmF3FSM9ucBMzvCNObzx3MBlwQKWVY
         RbDaPqzkO8UDKX74AN1P1bZJWX/yBiUxXQiW0anNnrhdsHLrQtEtjCZzbh8jCO1fEH
         wxrxCs/oPrXM5J5Qcx2e+7pYTSa2J6gpBaLgYhrpF4f2MdQaI6CB/8s2PGYMU7VBxH
         GWPb77bNP30GA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF4C8E737EE;
        Sat, 11 Jun 2022 00:08:40 +0000 (UTC)
Subject: Re: [dm-devel] [git pull] device mapper fixes for 5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YqPNd1xK0MIqRnev@redhat.com>
References: <YqPNd1xK0MIqRnev@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <YqPNd1xK0MIqRnev@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes-2
X-PR-Tracked-Commit-Id: dddf30564054796696bcd4c462b232a5beacf72c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90add6d418d02991380595bdbc307e05410af638
Message-Id: <165490612071.9139.6414403585916621511.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jun 2022 00:08:40 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>,
        Alasdair G Kergon <agk@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 10 Jun 2022 19:02:15 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90add6d418d02991380595bdbc307e05410af638

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
