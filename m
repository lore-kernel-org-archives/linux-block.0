Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D215EC61DA3
	for <linux-block@archiver.kernel.org>; Mon, 20 Feb 2023 23:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjBTXAQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Feb 2023 18:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjBTXAP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Feb 2023 18:00:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD8511E99
        for <linux-block@vger.kernel.org>; Mon, 20 Feb 2023 15:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D37460F4D
        for <linux-block@vger.kernel.org>; Mon, 20 Feb 2023 23:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E7ABC433A4;
        Mon, 20 Feb 2023 23:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676934013;
        bh=6DwURp2pPcuvbFwWrNmfJ4cZd6DL7sp8MdzDH/nrjFQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W9oTYAHJrvy0LF2wOMRb9FEfjJyp6cbWSU+lwpAbyI5Q4Ltx9GI8eaM/3PXll2v6o
         4PuG2Fj1yAvJ/hloy+9HmBS/Zozycoi5xUt0mhbfd5CIvm1x/DlWiM1vx2DBJ75p6M
         Jrx/Eg/HR5Uojumnn1mn9yfDdtj3mAxpKKIDQqq6yYbsrrtEFDWtUdKBNk9hRhp3yC
         OofAgLdL3rKfv25bYxliLkEZVqBGgSPyS/OG6+P4aJcqwZZ830EPC+r4EKansxQUqz
         SCJu1ABTLJItwABgLRTgq+gMI01Fr1ybig56460Kjm3X9nrv5/jG/SJwD+sScKhrvW
         0IBNnRICvZ30w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B013E68D20;
        Mon, 20 Feb 2023 23:00:13 +0000 (UTC)
Subject: Re: [GIT PULL for-6.3] Block updates for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5afa0795-775d-f710-7989-4c8e1cd7b56f@kernel.dk>
References: <5afa0795-775d-f710-7989-4c8e1cd7b56f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5afa0795-775d-f710-7989-4c8e1cd7b56f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.3/block-2023-02-16
X-PR-Tracked-Commit-Id: f3ca73862453ac1e64fc6968a14bf66d839cd2d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0aa2988e4fd23c0c8b33999d7b47dfbc5e6bf24b
Message-Id: <167693401330.6080.18367103289380827191.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 23:00:13 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 16 Feb 2023 19:54:31 -0700:

> git://git.kernel.dk/linux.git tags/for-6.3/block-2023-02-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0aa2988e4fd23c0c8b33999d7b47dfbc5e6bf24b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
