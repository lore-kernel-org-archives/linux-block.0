Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC0DC433E6
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 19:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C67D64D8F
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 19:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhBVTUL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233034AbhBVTQr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 14:16:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A600A64E12;
        Mon, 22 Feb 2021 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614021124;
        bh=Q1sTGzTxxi6QPjTGKOSnKMD0qsEmhUaCdg6a6VyVkC0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QNBis5f8sTaEkbS5uoirUkQPLQG/RxMOeATnUkzKdfwtOv1EK8YcuAbXTB1QKR6Xz
         sdccIFqIUjUaY3dWtja6UjtNtcKs1Adw46vy+75d7ORmc8ZUR5Ukc1jE/OvywpRbqN
         BHyEkOTo4bh8IjR3W5/l0zq0VpkkZTIPwFW/ru+yhe8ugUHpcbDgnY6bKOO5GgMEvb
         kqmIXuayJKvUmHIKc/bcQ9jzxw5SgmRMPIhRKNiO273fVKosI2kooc54C7KyGJzs9I
         Fg5N1EtlTf+3cO1Gap7zsQW9puacOSqngQT2FtJk2nosh6u1Ju2jak6gKj9VNJBd+G
         EkGvJ3T3K/Xew==
Subject: Re: [GIT PULL] Block IPI improvements
From:   pr-tracker-bot@kernel.org
In-Reply-To: <755b2ae7-7b30-fc93-71cb-3492d04a49a9@kernel.dk>
References: <755b2ae7-7b30-fc93-71cb-3492d04a49a9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <755b2ae7-7b30-fc93-71cb-3492d04a49a9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.12/block-ipi-2021-02-21
X-PR-Tracked-Commit-Id: f9ab49184af093f0bf6c0e6583f5b25da2c09ff5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae42c3173ba5cbe12fab0dad330e997c4ff9f68a
Message-Id: <161402112465.16114.12134254274215536236.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 19:12:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 11:33:18 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.12/block-ipi-2021-02-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae42c3173ba5cbe12fab0dad330e997c4ff9f68a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
