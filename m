Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CAAC433EF
	for <linux-block@archiver.kernel.org>; Sat,  9 Apr 2022 05:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240874AbiDIFFu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Apr 2022 01:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242716AbiDIFDr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Apr 2022 01:03:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DC71B74E9
        for <linux-block@vger.kernel.org>; Fri,  8 Apr 2022 22:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 62B01CE2E65
        for <linux-block@vger.kernel.org>; Sat,  9 Apr 2022 05:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D51D9C385A0;
        Sat,  9 Apr 2022 05:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649480485;
        bh=NXP6yX9UgfrzrJ79iZVf+7Ox76Y5EiKtOltlzHrOnHc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WQ+f6V98hXBzNK8LVFyX4rMV1zMtR2YzBLm5KzDTKD46w7BpO5DE+DbQQuiMXUClo
         +8iK2pA/gkgoXJ6z22UZ0Io8DVR4vuVLq4ZHGpnv0ar+mSp90Nu0AxvYXYZ9nbxUAo
         crEZcox6q+p3qjK3QzYFQ2XKH7t3FroLANSOcSptztYNVIP+XF7gNnLm4gYik/NoGD
         w2TBqOMu3jZtDN4JNi2sLR/oXrW6fxJ2tLPQ8h5zvOf/VGNXkX9jAP7pI/RBGeEjLV
         jb8VkSnpq1RTsi0++zTtIs5QoJ4P5nSgC25Y9ndh5kZH4wuYIMZ5o1mwZtXiXW7W3N
         rfSEaCEcUfufA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C212CE85D15;
        Sat,  9 Apr 2022 05:01:25 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a3b279bb-2462-54bb-54ac-f72ab6a80d53@kernel.dk>
References: <a3b279bb-2462-54bb-54ac-f72ab6a80d53@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a3b279bb-2462-54bb-54ac-f72ab6a80d53@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.18-2022-04-08
X-PR-Tracked-Commit-Id: 286901941fd18a52b2138fddbbf589ad3639eb00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1b45d8ccb9839b48e5884664470e54520e17f4c
Message-Id: <164948048578.21317.14692746567276815429.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Apr 2022 05:01:25 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 8 Apr 2022 19:53:14 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.18-2022-04-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1b45d8ccb9839b48e5884664470e54520e17f4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
