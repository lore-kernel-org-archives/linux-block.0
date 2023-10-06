Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FB6E9413A
	for <linux-block@archiver.kernel.org>; Fri,  6 Oct 2023 22:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjJFWv2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbjJFWv1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2023 18:51:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9BFBE
        for <linux-block@vger.kernel.org>; Fri,  6 Oct 2023 15:51:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72810C433C9;
        Fri,  6 Oct 2023 22:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632684;
        bh=HS7fkppeQG2PusxCGZ6eBRgx7OHb0rjmyBJeQECgg9w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ftng0r8Ox4gX0bTerfiXE5rb3ytQcIlWW7iArFSG2d2rBOd4reF2w3wK++w2IReiz
         NHay2mWwy9idlqGNpNj/e4FPcjNwPFtJ+hcGLXAzy0r5D14WTqEvMCXgpEqa0fA1td
         FByUVNYKErd689aKgoRKaH2exdnnKuW+y4g1WZ3YAf+vovRRl2NNQrwaGnGgRMl3ZO
         GPsaeooAgoDAhYJBEb6d9hLK1Xb/vOvOgFmy1uxFFy6x/+kiuozVBdhmq5obCsluu9
         heTkfGSvzcZ1AAUXgZvN3lrRbMCPTzqW97gMQ27rf4M/3kvhfPnjARIl5d7pVJYDOB
         Hd23VRIeNbkuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61F55C41671;
        Fri,  6 Oct 2023 22:51:24 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d7b8f468-d533-4658-b185-256c89756fe2@kernel.dk>
References: <d7b8f468-d533-4658-b185-256c89756fe2@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d7b8f468-d533-4658-b185-256c89756fe2@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.6-2023-10-06
X-PR-Tracked-Commit-Id: 07a1141ff170ff5d4f9c4fbb0453727ab48096e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc5b94f1cb405c7129a337db6ae7db3b1e325c48
Message-Id: <169663268439.26682.2187331663221668333.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Oct 2023 22:51:24 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 6 Oct 2023 10:36:42 -0600:

> git://git.kernel.dk/linux.git tags/block-6.6-2023-10-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc5b94f1cb405c7129a337db6ae7db3b1e325c48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
