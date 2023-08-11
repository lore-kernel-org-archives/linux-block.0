Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F23CC001DE
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 19:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbjHKTZF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Aug 2023 15:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbjHKTZF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 15:25:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0766530DB
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 12:25:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DEE267951
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 19:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA48CC433C8;
        Fri, 11 Aug 2023 19:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691781904;
        bh=/BufWBjvXyHP3W0oAZL3EKdIAYAe3679gtSeTjcUWNg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aJJ8cRz+/ObZae/+JbOCh9GkJTpQhgcVhFaNvU1Bf+VbCRvYMjb5XofrpvcuUw0Eg
         m4n4D2JHq+UXAgQXxS9dQml4Eg5uyjISYWp3z896pUkwmSJb9B1suDCHxcMso5T/1V
         N42pDR/90Q5ha07VPlHek/R982umiRlSeBKHKmgQdmZyXAxySE/RDa1t8du8Fa682Y
         i8Ci/vx+W17WHtEm7ty6EHM9uHiVxdm41Y1pUHCK8WHx3iO37o5yFOBskiDWodyEWu
         E8xthpSiyjySuXnv5P6SvOEEOTPjiktCBcR0xOH3En5dPIBX8yLzIBddjeEY2uC+F8
         nuUMRfYhhIjUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8811C3274B;
        Fri, 11 Aug 2023 19:25:03 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <82f36827-2599-4736-ace5-8f9e9cba2e43@kernel.dk>
References: <82f36827-2599-4736-ace5-8f9e9cba2e43@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <82f36827-2599-4736-ace5-8f9e9cba2e43@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.5-2023-08-11
X-PR-Tracked-Commit-Id: a7a7dabb5dd72d2875bc3ce56f94ea5ceb259d5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 360e694282fce69608e2775bf843b2aafd19e4b4
Message-Id: <169178190388.32415.14878973527375019630.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Aug 2023 19:25:03 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 11 Aug 2023 12:34:42 -0600:

> git://git.kernel.dk/linux.git tags/block-6.5-2023-08-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/360e694282fce69608e2775bf843b2aafd19e4b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
