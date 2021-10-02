Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CBBC433F5
	for <linux-block@archiver.kernel.org>; Sat,  2 Oct 2021 18:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8491D61B3B
	for <linux-block@archiver.kernel.org>; Sat,  2 Oct 2021 18:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhJBSJd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Oct 2021 14:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233774AbhJBSJd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 Oct 2021 14:09:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 264DB61B3B;
        Sat,  2 Oct 2021 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633198067;
        bh=b9vG0jHJDkoFiF8RIXpwRx+8sJCPgjEccXd+sPomxpw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oPrNdd0wU/AxN/sBMHLVB4kKWOWRWH6wueePLdXXh5mNxbFnbbSyVc0lbhugo4Ww5
         1aPY2T5j3JJ67GCe+Bigjj5QYzrZdqEbnG2o33B9EhW/D729BHBqHaNy3zL9h+4qIG
         LHcaIfeWYhutLJJ7guNICfaebSzl+sU9e5s+vqFKnIhRBSoyOotUpYG30IxA7s24Xu
         W2Lmljug7tRqadlkIgSEv+CeF+19sdsEK7m6pihCywKiBYBnCyHJ+6fgrxNBcx+Rtp
         WI5cfbriPYb4E0Two0B6sZMT1fQEZSDEkNdAzX1uKt5BQj/HSacM2q0A4P4I5aKj6v
         vYf0s7cBWIyUg==
Subject: Re: [GIT PULL] Block fixes for 5.15-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0ff68ebd-ae42-6b85-74bb-6ef114c948d0@kernel.dk>
References: <0ff68ebd-ae42-6b85-74bb-6ef114c948d0@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0ff68ebd-ae42-6b85-74bb-6ef114c948d0@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-01
X-PR-Tracked-Commit-Id: 41e76c6a3c83c85e849f10754b8632ea763d9be4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab2a7a35c4e7e848de9a7cf70f36b62584154140
Message-Id: <163319806711.17549.13408356132422759412.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Oct 2021 18:07:47 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 1 Oct 2021 20:06:05 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab2a7a35c4e7e848de9a7cf70f36b62584154140

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
