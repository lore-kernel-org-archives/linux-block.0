Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09933C7EE25
	for <linux-block@archiver.kernel.org>; Fri,  9 Jun 2023 21:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjFIVYL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Jun 2023 17:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjFIVYL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2023 17:24:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3D435BE
        for <linux-block@vger.kernel.org>; Fri,  9 Jun 2023 14:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F15360ED3
        for <linux-block@vger.kernel.org>; Fri,  9 Jun 2023 21:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 827E9C433D2;
        Fri,  9 Jun 2023 21:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686345849;
        bh=f5m9GxqfzgS5/SMRZPsPVnAvliF6In5HtosyWM/vboI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wom+oVyyiRy/OmDxfmHSCuj6YazvKrhFVk5vqupDzi1iLu7tA82CNL1amM7wUKlTI
         0BAGG8kCCsyaYGqDCuA4y3ZXpOxi9shWZUFYlvRu9xg+tfB5XCTtA6tlqYbdvDMJQO
         PsvUjuKQin0M/ZN/2YSgY0j498oqJHIVfd+9eXWOLA2jSFh7e4P/7CCu5WW1jKljEi
         LpYwaRDLH69fwINrjPXsvW18TEozQQIXw5qozrsTbngS/15Stxl7qAvlnl5TUvPOCP
         DgdrQuq7VsycUWxk98O1BJWKc6KHRD4aCTcVKevuZ14ul8YG4eDBb2LrNWSLoJVlQO
         Ed0xTItylujIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FE49C43143;
        Fri,  9 Jun 2023 21:24:09 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.4-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <54b8e861-a1a9-32b7-3160-60e323327008@kernel.dk>
References: <54b8e861-a1a9-32b7-3160-60e323327008@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <54b8e861-a1a9-32b7-3160-60e323327008@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.4-2023-06-09
X-PR-Tracked-Commit-Id: ccc45cb4e7271c74dbb27776ae8f73d84557f5c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64569520920a3ca5d456ddd9f4f95fc6ea9b8b45
Message-Id: <168634584945.8966.6518299567363434380.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jun 2023 21:24:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 9 Jun 2023 14:20:18 -0600:

> git://git.kernel.dk/linux.git tags/block-6.4-2023-06-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64569520920a3ca5d456ddd9f4f95fc6ea9b8b45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
