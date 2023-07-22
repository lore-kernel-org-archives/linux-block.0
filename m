Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E0DC001E0
	for <linux-block@archiver.kernel.org>; Sat, 22 Jul 2023 18:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGVSQh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Jul 2023 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjGVSQh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Jul 2023 14:16:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9871BB
        for <linux-block@vger.kernel.org>; Sat, 22 Jul 2023 11:16:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DED4460677
        for <linux-block@vger.kernel.org>; Sat, 22 Jul 2023 18:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BC72C433C7;
        Sat, 22 Jul 2023 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690049795;
        bh=8LhxWxoHRRPz1nuA3gC56hk3EgmIMqeqU0W/KXukJvQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hYerlBnyT0lHIBjmSX8ZCBh2EhVFjPbKXf/wkDmfrwfH+1pPOqhGRGM/J4c7v4RAk
         a2OrGG3/Uu3K/nK+SDTtHcYP/MybG9U6RxvLTTtcJWS/bfl/I9nnh+oUmICgiowa0P
         ODLE1ebB41ecpi2xZFw8zgyQFnbdcT32msPqXvFma5FQjv/oMrcX4MAlOk+mQjtg3K
         TazeQY421NgZ32crN85RbPpzI7aGadfGDcsxvziVuTJ6sJ4Uxut9yNPzEA7yhwG72O
         y91ea0hzGi1i6EG3fW273+s2HGrgRf2FKUspdWBJusRClm0QBHxZGaQ1fP4TehhhZS
         pJfAaDeNhGhPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3550EC595C0;
        Sat, 22 Jul 2023 18:16:35 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4f37fe3b-7c26-742a-1fe9-f869b6303f79@kernel.dk>
References: <4f37fe3b-7c26-742a-1fe9-f869b6303f79@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4f37fe3b-7c26-742a-1fe9-f869b6303f79@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.5-2023-07-21
X-PR-Tracked-Commit-Id: bb5faa99f0ce40756ab7bbbce4f16c01ca5ebd5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f036d67c02b6f6966b0d45e9a16c9f2e7ede80a3
Message-Id: <169004979521.7625.7167701761776780882.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jul 2023 18:16:35 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 21 Jul 2023 13:34:16 -0600:

> git://git.kernel.dk/linux.git tags/block-6.5-2023-07-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f036d67c02b6f6966b0d45e9a16c9f2e7ede80a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
