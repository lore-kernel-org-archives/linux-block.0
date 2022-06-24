Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29833C43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 18:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiFXSoS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 14:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiFXSoR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 14:44:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F38981247
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 11:44:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA403B82B9B
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 18:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62C0FC385A9;
        Fri, 24 Jun 2022 18:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656096254;
        bh=hoXrfirkI7QkNGS97+uyGswciqk62Ej9Qy82wJf9Q3Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IyEHxt0Ko3e03+0Xk15vJ8mq6wFj83ohT2zNJ3v5oPeAfwYzNui/RNwbeGYh7BRTf
         muyhD6O8HOOB+yyT+MbnehS+FDgEt/4dQC1uRoe010UWLice/VkOp65vXdnDW2zlfD
         vNp3gNE7WHnd5Nke4aKeGVLSAP511GIHe5rmIONLeFjODBiZg86zlR1PYxC6HmY/Jo
         S4IZoMzBdXEMVPd6A9rezQ/PUqWz7uax50jIjyOxp2IW5VO/jOd/B2zkrJPNJ/UH3/
         qDRGesi22F05pBqo8vNSKNpdd5Nak4ZHYJU5RZrP+AGpIblg1HQByU4KjCu2uqcRi8
         VjJe9TZ6k0FTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F11FE85C6D;
        Fri, 24 Jun 2022 18:44:14 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <327e6b6a-eddf-3eb1-be6f-6a527fa1ad9f@kernel.dk>
References: <327e6b6a-eddf-3eb1-be6f-6a527fa1ad9f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <327e6b6a-eddf-3eb1-be6f-6a527fa1ad9f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.19-2022-06-24
X-PR-Tracked-Commit-Id: e531485a0a0e0a06644de1b639502471415d5e12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a237cfd6b7469d6f5eeaa45f30128ab78b5281a5
Message-Id: <165609625432.26462.10181818419184791827.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jun 2022 18:44:14 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 24 Jun 2022 11:46:33 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.19-2022-06-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a237cfd6b7469d6f5eeaa45f30128ab78b5281a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
