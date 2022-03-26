Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F614C433EF
	for <linux-block@archiver.kernel.org>; Sat, 26 Mar 2022 20:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbiCZUUK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Mar 2022 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbiCZUTx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Mar 2022 16:19:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AC9606D9
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 13:18:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 172FACE0BBC
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 20:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 881B8C36AE2;
        Sat, 26 Mar 2022 20:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648325890;
        bh=Cn7QpZS1h0EgUPz7JHfAIM6uIrl0UGR4MkMzOL0npew=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=omiEJ+tVY/HQgnfnAYmXGFwM33i5mXSmWQz7CAdDXamKU571bW38r/jQYJb3MLprX
         GaovUc/pEOtO70LT+QwIQBbUbKb63eE4RtDWusem/CZHc4lsA9E+nu2zA3GQgkBVN5
         bViTHXt9RtJdyu9CGv0NwyAVzTEfVMXZBSDyWd+FCAjsN8hMS2uWd4AgL2aHMuuwwd
         VM55fcmZHM7u0FW12Kkosfyj/Hfl6fkYmK5L1mDofi2fYzc7t98Aj7R4Z1HfBqlL2x
         VcxtQUKDonEuIcdzraDN8vpEL4FZ5PT5p5PsIXR8YQd0APaFLfUpBz+FoQeX5De240
         ulh8oqvTmsg1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77403E6D402;
        Sat, 26 Mar 2022 20:18:10 +0000 (UTC)
Subject: Re: [GIT PULL] Support for 64-bit data integrity
From:   pr-tracker-bot@kernel.org
In-Reply-To: <37e3c459-0de0-3d23-11d2-7d7d39e5e941@kernel.dk>
References: <37e3c459-0de0-3d23-11d2-7d7d39e5e941@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <37e3c459-0de0-3d23-11d2-7d7d39e5e941@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.18/64bit-pi-2022-03-25
X-PR-Tracked-Commit-Id: 1e21270685ae4c14361dd501da62cdc4be867d4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f7282139fe1594be464b90141d56738e7a0ea8a
Message-Id: <164832589048.7233.14910005659096987314.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Mar 2022 20:18:10 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 25 Mar 2022 09:18:35 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.18/64bit-pi-2022-03-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f7282139fe1594be464b90141d56738e7a0ea8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
