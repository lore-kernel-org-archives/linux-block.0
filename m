Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17887C432BE
	for <linux-block@archiver.kernel.org>; Fri, 30 Jul 2021 18:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0034A60560
	for <linux-block@archiver.kernel.org>; Fri, 30 Jul 2021 18:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhG3SL3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jul 2021 14:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230335AbhG3SL2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jul 2021 14:11:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 86DF460560;
        Fri, 30 Jul 2021 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627668683;
        bh=1tXfr+9tuYnTxqd1EU/W5Gv6g1H4664MMXoCCbdd8DQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RcXdcbBw6aJ7hjwfZuwLfhvUlqgfcnhA9QO5U32WYtHWSs08zCjNXQJwR943/h3Bz
         bN0nBSgnDD2AzRD6EZkmSuq3dWukyOk9/Fe66rUaGFHM+h9hx82mgI4OA9oZctbKbp
         TeJ55mNNTXJiTTUW+uZsCZg7o9QyZXxKhtU1RjEpSdT4RGpubxL558rCWwovD+tCE4
         OxYJGnHSBYmx0csX4pFzQpQGvyyiPrnR91l4liJ9zqGBa6LnZ7hCX7gRgO/0xWh0Ry
         0Lm7cOUVxsjT+DglvRvmsLbGZFgTOnplFc+9SBAjYoSxnUCd5YGuSmPbmuqZVR8TWx
         W/YqIwK+ejsLA==
Subject: Re: [GIT PULL] Block fixes for 5.14-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c230e91a-74a0-5a78-a538-826ed0c40b94@kernel.dk>
References: <c230e91a-74a0-5a78-a538-826ed0c40b94@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c230e91a-74a0-5a78-a538-826ed0c40b94@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.14-2021-07-30
X-PR-Tracked-Commit-Id: 340e84573878b2b9d63210482af46883366361b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4669e13cd67f8532be12815ed3d37e775a9bdc16
Message-Id: <162766868352.11392.18401440262035449198.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jul 2021 18:11:23 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 30 Jul 2021 09:16:39 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.14-2021-07-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4669e13cd67f8532be12815ed3d37e775a9bdc16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
