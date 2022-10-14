Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D84C4321E
	for <linux-block@archiver.kernel.org>; Fri, 14 Oct 2022 05:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJNFIC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Oct 2022 01:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJNFIB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Oct 2022 01:08:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83E31946F5
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 22:08:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B376B821E1
        for <linux-block@vger.kernel.org>; Fri, 14 Oct 2022 05:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20E22C433D6;
        Fri, 14 Oct 2022 05:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665724078;
        bh=OPnnE64vZPf65Acvqv9nZt8wLX6bDgR9oJnBldnwcRc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oCSgup7yEWrrjpXHq9kkIRL74bJVtD4sER95bzcdDLCGXfL5psOfntpECGx/U/fjf
         vAx1i82bTgW0IzfMkVtSHjKDKorCJij9NHg15HKnhCRzg3MJ2Cv87szqKOx1rjF/jq
         OOUmRamkpub6SXixwez7W41naoY7mhgErP9tJJeK7LD7erzVtMGoryFeVJDQRhM12D
         5Ie7KntGbUQTCAFbD2hAv8A4s4M0IthnnZzg2+vBiRptnVrMLR1EitU3h1SVt4QQhI
         2PRC2RptMMhbdD/ob4h6dUxBqAw2GuAQkErZh77GLsKYZejXhXEk+OLc7euEewK64d
         CI0vIQSWmuJkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D96CE270EF;
        Fri, 14 Oct 2022 05:07:58 +0000 (UTC)
Subject: Re: [GIT PULL] Followup block fixes for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <57f8b4fd-02a2-94c9-3af0-8b4115356d7a@kernel.dk>
References: <57f8b4fd-02a2-94c9-3af0-8b4115356d7a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <57f8b4fd-02a2-94c9-3af0-8b4115356d7a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.1-2022-10-13
X-PR-Tracked-Commit-Id: 3bc429c1e2cf6fa830057c61ae93d483f270b8ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a521fc3cfbf45f910d6f4438cc222fda15a4987b
Message-Id: <166572407805.12880.14660807988501032857.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Oct 2022 05:07:58 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 13 Oct 2022 13:27:49 -0600:

> git://git.kernel.dk/linux.git tags/block-6.1-2022-10-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a521fc3cfbf45f910d6f4438cc222fda15a4987b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
