Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77270C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 20:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiGVUIa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 16:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbiGVUIL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 16:08:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F805AF843
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 13:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92E0DB81EDB
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 20:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 545B6C341C7;
        Fri, 22 Jul 2022 20:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658520484;
        bh=5rYBGgLFt2GppKwXLF9sF2NboUOcyMzizQx7+ZL9kys=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jMAvCUin3eZBQLWLaTU7cKt14Ag5tTENSAIDs5oc/rF7Y9EWjZw+Z51NSTgkA+/Jg
         9a4JV58mC07HRF6efQkG2rGqCB1P62xm6GmEAI7F9V3ARgsvKBsWYPyZ6yUQuqUFOW
         pzksBHtFD1+sFCPOosOLLVI6AuKZEgAU1N4BLeUIySUHtHbmNLE+AaprQgp6oN9Gfw
         jO1cRDWPcFV1SZ1mclrHlqZtGSBDooMZSHL1dwtFx2w9OBgyZZAlMWmrkuFQpI4ryS
         rZtijn+yQ+Qvk4L4Rpo+NLucLfXLD58WaLJYqZV+qObTYQpX0E3/P/bEK40AGcKktF
         GPY7R4Wlo3vDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40E73D9DDDD;
        Fri, 22 Jul 2022 20:08:04 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 5.19-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ebd024bf-f931-1396-bdd8-a9efc444b144@kernel.dk>
References: <ebd024bf-f931-1396-bdd8-a9efc444b144@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ebd024bf-f931-1396-bdd8-a9efc444b144@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-21
X-PR-Tracked-Commit-Id: 82e094f7bd988c02df27f8c8d81af8f750660b2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d945404f74f34b76cb02d73025b92ce8b4729d3f
Message-Id: <165852048426.15752.655262625553705976.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jul 2022 20:08:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 22 Jul 2022 10:19:46 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d945404f74f34b76cb02d73025b92ce8b4729d3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
