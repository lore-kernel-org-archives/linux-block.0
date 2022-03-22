Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC65BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 00:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiCVA1g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 20:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiCVA1c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 20:27:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A75734A132;
        Mon, 21 Mar 2022 17:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9D47B81AD1;
        Tue, 22 Mar 2022 00:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF5DBC340E8;
        Tue, 22 Mar 2022 00:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647908755;
        bh=Vjo5+PPsalFulNYwzdBabsrXzJeAu3sBmR10LVKq8zo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ML5fqKd2gvQCXlIMqPjQoAlgWWtNZmYr4TvIf392fYTmgJQ6Tx+O2dsEVXHQHxb+G
         tnGusBnvz31BPl8Z6vspnBNXehfLvC0dxBlPZwg7Ifkm4ykkuxhxaOkqcPL7mxGLo4
         cRhuS8e4/ntWYokTd/BAl3C7S3isGgRrzmNfzIxluqfTGZgTXpsP4xKAUro6xvwzyN
         XIdJJqE1fNg09nbXPwB3LT99JwIuxtHWojbd/DHvgoJhqM+ISHR1QIeNRFlgj+pTbo
         NpDmxA1ZmqGSbdK4pfS/Jl/S9p+nQrDogcHOPI5+hrGNv5+dmVQX3kWlUNL5YNZPBO
         rr0gzkPcACNUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BC94E6D44B;
        Tue, 22 Mar 2022 00:25:55 +0000 (UTC)
Subject: Re: [GIT PULL] File system related bio_alloc() cleanups
From:   pr-tracker-bot@kernel.org
In-Reply-To: <212e39c2-2e2a-24af-647b-67f3168ea558@kernel.dk>
References: <212e39c2-2e2a-24af-647b-67f3168ea558@kernel.dk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <212e39c2-2e2a-24af-647b-67f3168ea558@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.18/alloc-cleanups-2022-03-18
X-PR-Tracked-Commit-Id: 64bf0eef0171912f7c2f3ea30ee6ad7a2ad0a511
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d347ee54a70e45c082ca7a373fbdf0c34109d575
Message-Id: <164790875563.30750.2257701834373620693.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 00:25:55 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 18 Mar 2022 15:59:34 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.18/alloc-cleanups-2022-03-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d347ee54a70e45c082ca7a373fbdf0c34109d575

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
