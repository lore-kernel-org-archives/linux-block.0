Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A020FC43217
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 17:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA2A60EBC
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 17:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhKARb3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 13:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230246AbhKARb0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Nov 2021 13:31:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 02E8C60EB4;
        Mon,  1 Nov 2021 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635787733;
        bh=K2P1BoIEAtPWpw5BaAyR5y8z/eaTleJjjRxUbZkTam0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oC+viZzw+d8MmJ7fuAN0X2NsoKJzawOWwk7vNz/QVM73yHrJgONMjA5QAh4vbtjO/
         llXOP7qKtXYG4Ry2VPnVaPQACdOdGcewDUXOY1Hi5d/YMHuhLePICzhhgUvkR/O1zE
         lcWM6iYKhQzjW5SCNAiu66KuTBTPeaW2OgjCqVrmd7Bu2i2yOWZesEQLnAHHuP8Tc5
         ERp5klOgQxctzQ6lvAH+LRa/7Ju1mQvPSuHg+x0g+K8AndYSvv9UMulAx/6X84GbKb
         nbxqxOXvTvQ7df+QoU5cAzoZ/pSoWJ8YxF5Zwl2+KRMTIzaaTd4skoL4TTdyL4wdKQ
         dmuH7q1RCVumQ==
Subject: Re: [GIT PULL] Block updates for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f32307c6-5b97-00f6-3738-0732d3de5e62@kernel.dk>
References: <f32307c6-5b97-00f6-3738-0732d3de5e62@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f32307c6-5b97-00f6-3738-0732d3de5e62@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.16/block-2021-10-29
X-PR-Tracked-Commit-Id: 9b84c629c90374498ab5825dede74a06ea1c775b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33c8846c814c1c27c6e33af005042d15061f948b
Message-Id: <163578773298.18307.7117478126428284843.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 17:28:52 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 31 Oct 2021 13:41:39 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.16/block-2021-10-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33c8846c814c1c27c6e33af005042d15061f948b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
