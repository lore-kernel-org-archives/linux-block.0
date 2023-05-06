Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF754C77B7F
	for <linux-block@archiver.kernel.org>; Sat,  6 May 2023 15:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjEFPqW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 May 2023 11:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjEFPqL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 May 2023 11:46:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC21E226B8
        for <linux-block@vger.kernel.org>; Sat,  6 May 2023 08:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 580F260F0D
        for <linux-block@vger.kernel.org>; Sat,  6 May 2023 15:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB023C433D2;
        Sat,  6 May 2023 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683387969;
        bh=uI/JW3OQ+S5gy2leBZxpJ7tQyNFepz/mwj0AhBQme2w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XBrSttB0s6sZVmqelziJyxJxtkCYVAlgGxK4jT/bo5BfgqLiNz8Ouh9EXqQH/BnXf
         MqtYfc3Pm7wXUOkD16BkxKgO/2yL0Bq7QcpowHWHKC7W62elTu1Li3v3rCmvfOJv/x
         hzDrKqEtYoXvZfYdIMZhLKCRYc2KcGN5x4qGUwNQFC18L/k5EE8h3pkSSra4MgGnGY
         6XEB1ny5ZVnfAe3vspShpioxsKqSJaV5PNXosiCq+m7SV1QCGBQB8t7K+gKnV/eg/6
         9GsMMmFRnjnRYpE16cgyQ16wFrElOux8b/fudQqLIri94mfEUFPD8XlCcMy2SpUQia
         R2hT3ToLNCnyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9632C41677;
        Sat,  6 May 2023 15:46:09 +0000 (UTC)
Subject: Re: [GIT PULL] Followup block fixes for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <637e86c5-5a03-7252-bd46-4ec76d9d18bd@kernel.dk>
References: <637e86c5-5a03-7252-bd46-4ec76d9d18bd@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <637e86c5-5a03-7252-bd46-4ec76d9d18bd@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.4/block-2023-05-06
X-PR-Tracked-Commit-Id: c0b79b0ff53be5b05be98e3caaa6a39de1fe9520
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3b111b046f6ce5dff168af203daf2f46f3afb29
Message-Id: <168338796969.28822.18333261998425095254.pr-tracker-bot@kernel.org>
Date:   Sat, 06 May 2023 15:46:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 6 May 2023 04:51:12 -0600:

> git://git.kernel.dk/linux.git tags/for-6.4/block-2023-05-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3b111b046f6ce5dff168af203daf2f46f3afb29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
