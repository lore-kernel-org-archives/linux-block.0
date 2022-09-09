Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC9FECAAA1
	for <linux-block@archiver.kernel.org>; Fri,  9 Sep 2022 19:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiIITOH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Sep 2022 15:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiIITOE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2022 15:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D41A1116C9
        for <linux-block@vger.kernel.org>; Fri,  9 Sep 2022 12:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C4D0620BB
        for <linux-block@vger.kernel.org>; Fri,  9 Sep 2022 19:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAD0CC433C1;
        Fri,  9 Sep 2022 19:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662750838;
        bh=LkZ3KifbhgKno0oFDcKtbxzZI0aafpcqqGnDoQAiobs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tbfPn9hfvStyj3GvPZi6VLz7AuNYLzh1X1oid29BEZRq55q6hdWfy4TVhdXh7m6yH
         a2Gzxhkhj8xRiaSZXlRyZIANS/O11SKwTdTRLOTO/SRdahEXJeNDHJWBEQncBk/5j3
         rJy4DA0hj+kz7mPMzO+dGOCeZtuX9ez4ojA5yiVF2QBdlT9pYq5kYkfnPFRDU1JD/L
         Kqvns8sIfuVD5PFwqBhsJ1B+kbDWGyAWds+sXlwuECuxrj4KpFN3BIletQsFXNY2o0
         K8OTFShRx4R2GCHwLTHR874I8W+48oUuRFcRN0dBsfZhIeQThcSAGdOyV4UoRJRG2d
         NN0/DkKLdJxOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9AD3C4166E;
        Fri,  9 Sep 2022 19:13:58 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.0-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <54f4f268-c33c-d1a1-4b38-75f9206be4e9@kernel.dk>
References: <54f4f268-c33c-d1a1-4b38-75f9206be4e9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <54f4f268-c33c-d1a1-4b38-75f9206be4e9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-6.0-2022-09-09
X-PR-Tracked-Commit-Id: 745ed37277c5a7202180aa276c87db1362c90fe5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ebc0ecb21b53e1a592f4ac9af927f7ff605f306
Message-Id: <166275083869.6812.698735554888168084.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Sep 2022 19:13:58 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 9 Sep 2022 11:28:19 -0600:

> git://git.kernel.dk/linux-block.git tags/block-6.0-2022-09-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ebc0ecb21b53e1a592f4ac9af927f7ff605f306

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
