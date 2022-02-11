Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F179FC433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 20:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353164AbiBKUFZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:05:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353156AbiBKUFY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 15:05:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA23CE6
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 12:05:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65B31B82C8F
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 20:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA779C340ED;
        Fri, 11 Feb 2022 20:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644609920;
        bh=r+ch6Pdtea4xKaC8sqFQcHd/e2rpw1aQLtGPsfivfew=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R7XVqNpjc4pEHngX6fQZFC5x9rff6CpKUdR7IWk+6RHv5nfXAlYjzs+nYit9lAexf
         8aapM40IByLf+Az/ZrNMNyhISqGlU10WNq9SgzAyuzA7cIGH1SZewLmpQQpMg3x+1g
         T8On3TKdmukldAkxHneSiCsrOMEh+G4VXfVlRs9cSHKMDaZ0Vm5A2ruIJ8RNUj2kXi
         Z8c3Uu/R95djlR+GBbWq4g9vGgFd3XzcCc2MvQ/YrW4XsbvZSUE0AwdWxe2eE6LxZW
         v1Brv8yzRRqQihnFEK4xVd/kNOrOes5Aij/h07M4t5aucqtx/aacAfk6hSiFyTwgnp
         byxiK7LgHmp1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8775E5CF96;
        Fri, 11 Feb 2022 20:05:19 +0000 (UTC)
Subject: Re: [GIT PULL] block changes for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f20f0c25-503c-31d2-aa20-f1205fc5c98b@kernel.dk>
References: <f20f0c25-503c-31d2-aa20-f1205fc5c98b@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f20f0c25-503c-31d2-aa20-f1205fc5c98b@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.17-2022-02-11
X-PR-Tracked-Commit-Id: bf23747ee05320903177809648002601cd140cdd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf26a2360a6e1352a9e0bebabbbcad2b92dd8c6c
Message-Id: <164460991988.1412.6808623437008205784.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Feb 2022 20:05:19 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 11 Feb 2022 09:49:12 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.17-2022-02-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf26a2360a6e1352a9e0bebabbbcad2b92dd8c6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
