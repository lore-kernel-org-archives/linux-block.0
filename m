Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116DBC433F5
	for <linux-block@archiver.kernel.org>; Sat,  5 Mar 2022 00:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiCEAfp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiCEAfp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 19:35:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136344A900
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 16:34:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 939DF61F55
        for <linux-block@vger.kernel.org>; Sat,  5 Mar 2022 00:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 011AFC340E9;
        Sat,  5 Mar 2022 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646440496;
        bh=g/C+wUjz8D9V77CVOZutrreNnPxgr4vv/gjqpz+jXsU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xlfb/rJ+uHfFLM0+/wFFEewmFNT/FwhDeCJ69/BPiwmmUFxB6GiNPFyXT496FxZlu
         /KxL2P9rv9UOBp85rpzBe+W6wt64ArHjwgt9r7Jjar0XbTWcDlmzNd+9KF3ns2lVBB
         EsoOPJhbiz0lW0f1D6zM+JKlS0K3FGqUXS0K3xoevMk982fev8UnY0Hq+5ou0nWZef
         hlKrGhxkQVn4JxXCpBI7ZXFoBHejIYJ7sIwFf6IPKscEMxgyXiRp+MCqwO8DjSaffE
         O6addLYi7uH1gWHSKzL4FZdRRO//W7PiCX/lZZ64z+5E0dKZdi9ZXFJzaJ3b8UHmGu
         0c2ElnsBqH7eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0A02E7BB18;
        Sat,  5 Mar 2022 00:34:55 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 5.17-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9d5d4f0d-7028-0505-7463-ec740967b8e2@kernel.dk>
References: <9d5d4f0d-7028-0505-7463-ec740967b8e2@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <9d5d4f0d-7028-0505-7463-ec740967b8e2@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.17-2022-03-04
X-PR-Tracked-Commit-Id: 30939293262eb433c960c4532a0d59c4073b2b84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac84e82f78cb55ce8e760e0b5887d56efd78d6bc
Message-Id: <164644049591.17379.14974430482953901349.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Mar 2022 00:34:55 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 4 Mar 2022 14:39:32 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.17-2022-03-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac84e82f78cb55ce8e760e0b5887d56efd78d6bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
