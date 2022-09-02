Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430B7C54EE9
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 23:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiIBXsO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 19:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiIBXsN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 19:48:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B1F106DA4
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 16:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C847061E2F
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 23:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C312C433D6;
        Fri,  2 Sep 2022 23:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662162487;
        bh=7NtCRWYJLgPmRIoSaKK+qUEaB0/zHmxUChB5HWWBwTc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jGK2C2Oh6v8fat4Wvcqj4KO7TthN3FWkikZbXll2ggmWDl3Jo2w4pek8b5SssOiST
         QU5pdBO59c3fm2X/S4Y+toOoUdL8fE+WQmML49goU5raQpxNCTq9sGhYotJt71KSfV
         FnwjAbpZpdQK24SHNLMB7vbpyF8hjg45Xo5jrBNQSgE2Ys+HOqd9tcH/xWOWqaNXtj
         ljNEDjzRC8AsuUUALCM3G1WpnkwKgqI7K/jfNqWzl76k+ZIvxDa2XeNpzobM4ES7M6
         FX5/2xWLj5SgDmpdSI6W7f/jOCIMbPgRbnk+rAD2xJinP0CAyYy0kIyVYOKsDZ1yLW
         aISXFIc/5bosw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2ACC9E924E0;
        Fri,  2 Sep 2022 23:48:07 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2e744edd-4b72-4071-99c2-c09848460490@kernel.dk>
References: <2e744edd-4b72-4071-99c2-c09848460490@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2e744edd-4b72-4071-99c2-c09848460490@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-6.0-2022-09-02
X-PR-Tracked-Commit-Id: 7a3d2225f1ae9e591fefd65c3bb1715dc54d96f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d895ec7938c431fe61a731939da76a6461bc6133
Message-Id: <166216248716.12135.774948156901432321.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Sep 2022 23:48:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 2 Sep 2022 10:39:11 -0600:

> git://git.kernel.dk/linux-block.git tags/block-6.0-2022-09-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d895ec7938c431fe61a731939da76a6461bc6133

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
