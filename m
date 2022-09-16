Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4BAC6FA8B
	for <linux-block@archiver.kernel.org>; Fri, 16 Sep 2022 14:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiIPOWG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Sep 2022 10:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiIPOVw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2022 10:21:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4545B1BAB
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2022 07:21:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70C5962C2C
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2022 14:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4E37C433D6;
        Fri, 16 Sep 2022 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663338106;
        bh=fJOaZCaBWzxOiGnqvQqGXZwpCxqbwMypRw0KJpJD4lk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=smMQZF0ZR+gri9ui1p4oHtxvFvuRtDqzFEivZewYl45spDZNWnPxqkpBigjRlsw2e
         LeUJ6LOC0yywRMzrifTptN+/ioql+bNdtUvYbERFc33MqEgSA0rnJ7w7HNXMyVYxbq
         UUZKfNW4WVxGlTfuidsAotwh5PvmEKOgrKASJtNtB42/bMBLfwns0rC8Ue0nyuhgXs
         Je4tWlygDWQTENU4g/lMJMOJLRU8WtO0FP5OuIva3Lbuz2uYqvbPl80G23oOnFDCeY
         X/33vVeDcptHjoB9ea/jz2ks1mPAvpCayh2UzfMZ6kNIAhB8pc1+f3+xd5+BFdM141
         G4nOF92geY8cg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C275CC59A58;
        Fri, 16 Sep 2022 14:21:46 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.0-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <654cd36f-a42b-3ae3-a92a-3bfc366277fc@kernel.dk>
References: <654cd36f-a42b-3ae3-a92a-3bfc366277fc@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <654cd36f-a42b-3ae3-a92a-3bfc366277fc@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-6.0-2022-09-16
X-PR-Tracked-Commit-Id: c4fa368466cc1b60bb92f867741488930ddd6034
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68e777e44c275e8dbc36f5a187c366e982d6a129
Message-Id: <166333810679.10979.6523292822343819351.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Sep 2022 14:21:46 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 16 Sep 2022 03:08:16 -0600:

> git://git.kernel.dk/linux-block.git tags/block-6.0-2022-09-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68e777e44c275e8dbc36f5a187c366e982d6a129

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
