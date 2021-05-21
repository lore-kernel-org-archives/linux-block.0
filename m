Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C84C43460
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 00:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57E5613AD
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 00:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhEUAuH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 20:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235462AbhEUAuH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 20:50:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DB97960200;
        Fri, 21 May 2021 00:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621558124;
        bh=dsnMd1PhHulu16SSSneTy377J6qpPecn4OrfhIFreQw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K5W1d2vXduAET12PTPBRRtOCYiVxLppMDTAVWa9Fpy1ZeqVZJ46y7LR2XYxo1GQb1
         ukUbBvZGRvGESJ3nPVMp1E0sJpFFL4y2mQ5mv0i72bNElsBrkESlEgbi7DgpNZ4PdB
         esKH5ueDxTjEStq74QsMfNejbqKgO917MSMQ7DAsNFUkvTxKmKc83UlfnO7F/EXGvY
         hmVai93B1AhYobOQ/Cnjm7DC4tG1J9Y1HKvQUbA6jRqqHgJREdPCrleoLN3AONcy4L
         odCwUuvCwSsUR3MaHh+u/J0aCDxzRUEvfOMQ2mrlA9bqn4wStnx00X+7B8gY8ntmF8
         hs0Qzv0twmjMQ==
Subject: Re: [git pull] device mapper fixes for 5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YKa8aq2SgXzX7sva@redhat.com>
References: <YKa8aq2SgXzX7sva@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <YKa8aq2SgXzX7sva@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.13/dm-fixes
X-PR-Tracked-Commit-Id: bc8f3d4647a99468d7733039b6bc9234b6e91df4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0eb553b6ff650faa031a470d048555b0b80a309
Message-Id: <162155812486.12405.638192179425446261.pr-tracker-bot@kernel.org>
Date:   Fri, 21 May 2021 00:48:44 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 20 May 2021 15:45:46 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.13/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0eb553b6ff650faa031a470d048555b0b80a309

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
