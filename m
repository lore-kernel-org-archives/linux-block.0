Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E481C7EE29
	for <linux-block@archiver.kernel.org>; Fri,  2 Jun 2023 17:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjFBRlm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jun 2023 13:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbjFBRlj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jun 2023 13:41:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098B7E57
        for <linux-block@vger.kernel.org>; Fri,  2 Jun 2023 10:41:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F96E651BB
        for <linux-block@vger.kernel.org>; Fri,  2 Jun 2023 17:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 880B9C433D2;
        Fri,  2 Jun 2023 17:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685727691;
        bh=wmSUvoK3XLeTQ3dsyj5oRenNjnAJ1tQ5Ku8vMo1ea1k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dx3d7cG0WKay18v7eTgWSTglkR7DuXpTtqBHLXQNzgAjvQlec7gPLL6sOtfkNpEI+
         9bODh1lHT8/1l4S+QTjF4tfn2NJr6MtfxjTNU4I/yp/TMjMyaT6vZ7UewCZUK0Twje
         ZcYcl9FVMop/EgMjkD7IEL13wBM0xpiZPQ5KEiwxhpJxplMpyDeybhD9zAC58rhfdw
         1NHDsn9nuWLyluNZ6F6UnIfJQJdK0bJhVGrYB+ULR3Oo7A4mEgWu+6U2jGS7oUhuZq
         sipGyQRiEVWgOwS+O6VZJYODF+b4YETzxVcK1UFFFwdF5jJWidmKTcv7pYafu+hf35
         t8dU97P9ZdfWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75687C395E5;
        Fri,  2 Jun 2023 17:41:31 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7b49cd00-55fa-5806-39c0-ac0c26051e13@kernel.dk>
References: <7b49cd00-55fa-5806-39c0-ac0c26051e13@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <7b49cd00-55fa-5806-39c0-ac0c26051e13@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.4-2023-06-02
X-PR-Tracked-Commit-Id: 2e45a49531fef55f4abbd6738c052545f53f43d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b7497739fc8b4f411b70b78044a9fc21d34d18d
Message-Id: <168572769147.31437.82878091207434612.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jun 2023 17:41:31 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 2 Jun 2023 07:24:08 -0600:

> git://git.kernel.dk/linux.git tags/block-6.4-2023-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b7497739fc8b4f411b70b78044a9fc21d34d18d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
