Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C81C433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Apr 2022 23:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353671AbiDAXqd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Apr 2022 19:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353673AbiDAXqY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Apr 2022 19:46:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBD160DE
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 16:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5831B82685
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 23:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D5DCC2BBE4;
        Fri,  1 Apr 2022 23:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648856636;
        bh=GNFsuA9xvSS8YKNnCp8H0XtKMex6Ptx5d7OqarzayV0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B1CRt8Xjum7XxteKAwxSX6JxSOjGK8usgr5R+24Mzb6PjcDXfBLSYdDsMeM/Hcuq6
         jbhz//q6VL3lZkEDTa4jDqcwwf+ARHSevgNOcXj2foBp74J4hP1mpPTkw62G4fwq3h
         t1xCSKQeNlXHDdM9FLcSkkxIAvlkWVHbfNUXay0jpxyZLOk+vA9jWiTFtQkWPyVjqK
         oy+RATqmzsJdFoPBAFloAZ9h/Bi9TaYuQfM2dhsKnTYbY0+E9+8g9L+T8DdN7oihf7
         zT9cdVm7gymDi8Bq/HGaid7pvNQwpe29Pgb5sJatg9iThdWLFBwz16oML1u08RwA5e
         T/gjWvxhaapJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C5ADE6BBCA;
        Fri,  1 Apr 2022 23:43:56 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b7d7893a-971b-9ac6-b4b9-e39a81038254@kernel.dk>
References: <b7d7893a-971b-9ac6-b4b9-e39a81038254@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b7d7893a-971b-9ac6-b4b9-e39a81038254@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.18/block-2022-04-01
X-PR-Tracked-Commit-Id: 8d7829ebc1e48208b3c02c2a10c5f8856246033c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d589ae0d44607a0af65b83113e4cfba1a8af7eb3
Message-Id: <164885663657.32259.8371267992779715001.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Apr 2022 23:43:56 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 1 Apr 2022 13:34:45 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.18/block-2022-04-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d589ae0d44607a0af65b83113e4cfba1a8af7eb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
