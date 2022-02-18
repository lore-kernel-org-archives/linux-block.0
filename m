Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D36C433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Feb 2022 17:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiBRRkT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Feb 2022 12:40:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbiBRRkS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Feb 2022 12:40:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6E275627
        for <linux-block@vger.kernel.org>; Fri, 18 Feb 2022 09:40:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F91861FF1
        for <linux-block@vger.kernel.org>; Fri, 18 Feb 2022 17:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88654C36AE7;
        Fri, 18 Feb 2022 17:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645206000;
        bh=yrvvWPu3d//w75ddlydDXCcSQK5PQA1993PaMdM0CN4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l2I3AE2BfoFN1fe2c+5DLwj8Z/sFkPIPlE8gIEzIBVvd9Xp4v1JYjgsP+OQaWulLM
         oNsPxvep6jokRm25J8Gfac87oZOpcbfsE6fWQIUJGZqoFJmDXdJ/gqSHSvE4SfYB5s
         9myqa8TviUNVHAzAwOP7mqsS+MNt7cQkZhYeaKi/8Wy9JARrHoDiOqpzKV9ajbe3V/
         XPe6/RYgLCUapLzaHsLPUc/0udrdEV1NIgguh8cdMY+sBpWc+poWX7/am6PQY92u3H
         9O9geP+Kcolz/84qdZrcpHwIcgKAPhgqqSyS5c9H8cU5QYkyYAKfdcVhKFcY3gYQNQ
         lHOFBUwvo6MPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 780E7E6BBD2;
        Fri, 18 Feb 2022 17:40:00 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5922f9b2-a23d-20b5-c8ae-619422a08df7@kernel.dk>
References: <5922f9b2-a23d-20b5-c8ae-619422a08df7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5922f9b2-a23d-20b5-c8ae-619422a08df7@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.17-2022-02-17
X-PR-Tracked-Commit-Id: e92bc4cd34de2ce454bdea8cd198b8067ee4e123
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9889768bda1a326238990b7d75ea179321d9693
Message-Id: <164520600048.19024.8079944301156078799.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Feb 2022 17:40:00 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 17 Feb 2022 20:48:25 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.17-2022-02-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9889768bda1a326238990b7d75ea179321d9693

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
