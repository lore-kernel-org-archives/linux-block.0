Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D503CC27C47
	for <linux-block@archiver.kernel.org>; Sat, 28 Oct 2023 00:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjJ1AOs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Oct 2023 20:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjJ1AOr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Oct 2023 20:14:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5001B8
        for <linux-block@vger.kernel.org>; Fri, 27 Oct 2023 17:14:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90ABBC433C8;
        Sat, 28 Oct 2023 00:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698452084;
        bh=OQPOUqYdY/PrP9ga+xsin4aZOy47ZAnu9mlgwhCvF/c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TvDT3zuD8OgF3dldCnUzNqj2wez3FGHzfVuop/fJnyQAxrCnHDJW4iX7FbSWt9dzd
         PtA9ZYgkvS78NVs/TakP2UiWMDcqJfZ2mWMuE+fD1BiLmQdA87UAqvS1EvB5AU2lhe
         8snSPR0s5s7xUmyc3sRDbBlbq4ousTbtqRFXpgjPB8cmUpGZEa40TsklhR/r1ZTH5w
         dqz6j23l0SdsG8SFihVUckkQQ5TnJ+yfau2VvOkkruPB11rSIZwAQol8Jo30SPhvvB
         icjHRUe06dLXkXgOGWcKZJa3n6LM8daSQswRThL3WC4LGwXPDMnaBl1ThEYPkBLkuA
         jhUc0wRVcsQCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AA1CC39563;
        Sat, 28 Oct 2023 00:14:44 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.6-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <51149548-e214-426d-9e89-ceba050569ab@kernel.dk>
References: <51149548-e214-426d-9e89-ceba050569ab@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <51149548-e214-426d-9e89-ceba050569ab@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.6-2023-10-27
X-PR-Tracked-Commit-Id: 2dd710d476f2f1f6eaca884f625f69ef4389ed40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dc4e0f45593abc53d58d0073b3b314f864c522b
Message-Id: <169845208449.29306.14130555054585673642.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Oct 2023 00:14:44 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 13:53:59 -0600:

> git://git.kernel.dk/linux.git tags/block-6.6-2023-10-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dc4e0f45593abc53d58d0073b3b314f864c522b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
