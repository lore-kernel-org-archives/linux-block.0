Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ECFC433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 00:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbiCKAzz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 19:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiCKAzw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 19:55:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A381A3600
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 16:54:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8C2FB824C7
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 00:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9442DC340E8;
        Fri, 11 Mar 2022 00:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646960087;
        bh=lWtaM6PI3Rd7/X70ptV5e+6OMTv7vnKAyer2qpdQqaU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z3U6e7vSCmOHS7SizxVRhbECjxEygfDtA9mA1rNgSxp5qMUNZBB3kXW6iV/i/7k0B
         NPwL1adhSDwSDw+RsU7VJuFfvf1GcaaB1wVng5PQYJhkQJd7pOqXf5EnlRg0zpvQb9
         mC8W14pqA/FCAdxgkAbsFSAVR4vsWQX/E2TOAV+23XO0PyaDVYlGnyof5K+qcxqV/L
         u9Iy8RoVm6BfkwLDfDq0Vs7BiFioOnhPBfSVI9MzC0Z75u0rNYQOX6TtpJRBVMgb/I
         TTCoUi2DKhLRsdBE0Dbzh0uaPW2HS7QaUwQTjziV1Al1auB8mI805Oi5N4qC+sgj3U
         XFb556UEzYlwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DB18E8DD5B;
        Fri, 11 Mar 2022 00:54:47 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 5.17-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <70ff8ffa-f118-61d7-d8ab-8c1106d7574e@kernel.dk>
References: <70ff8ffa-f118-61d7-d8ab-8c1106d7574e@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <70ff8ffa-f118-61d7-d8ab-8c1106d7574e@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.17-2022-03-10
X-PR-Tracked-Commit-Id: 0a5aa8d161d19a1b12fd25b434b32f7c885c73bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bcb6451cc96ca38e50120a4f333ecf157245544
Message-Id: <164696008750.2789.862858117898338777.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Mar 2022 00:54:47 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 10 Mar 2022 13:55:41 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.17-2022-03-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bcb6451cc96ca38e50120a4f333ecf157245544

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
