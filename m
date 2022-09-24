Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905EBC07E9D
	for <linux-block@archiver.kernel.org>; Sat, 24 Sep 2022 15:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiIXPcy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Sep 2022 11:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIXPcw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Sep 2022 11:32:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84C427DE6
        for <linux-block@vger.kernel.org>; Sat, 24 Sep 2022 08:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EC5B60CF6
        for <linux-block@vger.kernel.org>; Sat, 24 Sep 2022 15:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3069C433D7;
        Sat, 24 Sep 2022 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664033570;
        bh=bG1TGkDRm1MkzJREnelP1Iywwkq5lkpP3S+IznE3kWc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j3l+S4aHXjpHFFrkYl0pKkTgfEYk+S/hl3Xd3y1rPouZAgaqWIkQ/6qC+R7LsMfJy
         fVDCuZ+y9EIGAXA8axfSVL2PHmoEan/9wjf9V8tc8Z5fktj4L4T6UT1M5pijgN7NNz
         92iBHKJDl+NMOovlsGGw0CdTE5OOIcRpiKWyPSTpdTfHjGnAuQvIznxqKktFBqkUra
         32FxxeI60bXUma+MBbzx+L9fD6OqB3s1Ka3ST4sgpE9CKuIZXQwz1JgSW2E+Axl/6D
         oRfM6w2P7g++UUtGByS/AoRR+UVZb679ghnWO4fLvHnuDtJ8t7SxKIUC8z4wAlp8Gs
         IqS2XcgrvmnGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D24BDC072E7;
        Sat, 24 Sep 2022 15:32:50 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0e2b98ab-dd42-074d-ebc3-b9bd3deb779a@kernel.dk>
References: <0e2b98ab-dd42-074d-ebc3-b9bd3deb779a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0e2b98ab-dd42-074d-ebc3-b9bd3deb779a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.0-2022-09-22
X-PR-Tracked-Commit-Id: 4c66a326b5ab784cddd72de07ac5b6210e9e1b06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0be27f7be2e5def5577de097fb420af09acf0983
Message-Id: <166403357085.24842.15096547480324127091.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Sep 2022 15:32:50 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 23 Sep 2022 15:07:29 -0600:

> git://git.kernel.dk/linux.git tags/block-6.0-2022-09-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0be27f7be2e5def5577de097fb420af09acf0983

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
