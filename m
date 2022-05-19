Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821A5C433EF
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 00:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiESAfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 20:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiESAf2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 20:35:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330F4CEB8D
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 17:35:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2FDC617B5
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 00:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30E7BC385A5;
        Thu, 19 May 2022 00:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652920527;
        bh=eT99SxJjblR35KBrIMsRkpJ3Zznq4pDgZMdbdzyILho=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MMZbJAMSQ8B1Jq3NBfigJuBRfCi6QRYOlfupdng+KUfe7Kr5ulbW7PoORcCVgO5FE
         4qt9AUPRoSvnNAkYWOpylZDuh0ccTFwPzNWFdw/uqMCwVgsEwV+x0BcIieI1ywp94t
         vsOMkYvK3aGUIgC7gT+yvFvCoq7YqgAFL40MrU46WT+tkjM/e6oD57vBW3RhbDH54C
         ThL5OOxn6Dt5fQsnEHwNFlTkN7pkFQcHPO8Ch0HPW3qfnW4SMmaXERd8VVE2LGNm9i
         HPoK8xfRqtttgr9wkVfs0wu+cHlGxSI0eaqrKNN+azEuDBz8T5lrToEM1vCsy+IS7G
         gVsowFvhdP0aQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EEAFF03935;
        Thu, 19 May 2022 00:35:27 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 5.18-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9adae644-3856-a84e-b3d4-47106c91e09f@kernel.dk>
References: <9adae644-3856-a84e-b3d4-47106c91e09f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <9adae644-3856-a84e-b3d4-47106c91e09f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.18-2022-05-18
X-PR-Tracked-Commit-Id: 725f22a1477c9c15aa67ad3af96fe28ec4fe72d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f993aed406eaf968ba3867a76bb46c95336a33d0
Message-Id: <165292052712.29647.14817703874793601282.pr-tracker-bot@kernel.org>
Date:   Thu, 19 May 2022 00:35:27 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 18 May 2022 17:11:50 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.18-2022-05-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f993aed406eaf968ba3867a76bb46c95336a33d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
