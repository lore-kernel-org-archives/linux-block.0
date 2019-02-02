Return-Path: <SRS0=HKPG=QJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AADEC282DB
	for <linux-block@archiver.kernel.org>; Sat,  2 Feb 2019 18:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5812B20857
	for <linux-block@archiver.kernel.org>; Sat,  2 Feb 2019 18:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549133107;
	bh=y7m4KqGa6hiskitmYuA+ejYVqX4Mj6VgpGriCkHxfl4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VHIuLgec+Vwyhwb5Pyam0z1eJ9e2bPzGnlxbrTGqoOEwcKhfMIsG0VzQff8XUAvWq
	 KZZ1Lgn5XtSG/5WS5wo+A9nbhq3GYFG+PEJHuUauqHtLQfdk0F9kWSBTFjV6ABjTLZ
	 6lAGpDQCnjgT487UO49LRQIx8YOpxAZ0yvN9Urrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBBSpF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Feb 2019 13:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbfBBSpF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 Feb 2019 13:45:05 -0500
Subject: Re: [GIT PULL] Block fixes for 5.0-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549133104;
        bh=y7m4KqGa6hiskitmYuA+ejYVqX4Mj6VgpGriCkHxfl4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DiRoE4deIcui95CpNHnfiwp9rrKfUwRVzPq3Dl6+WYxgnBmoZbNhvgMuQLSxrcLeD
         /TxGaZqR0RbrKprBg2iQlsHYYUuRNFVzXysSMeRpDewAKp15pN7LLzHZ2BcObtUQqJ
         x5DkdwDmmvxZQ8QVvyZnEl5tZ5FIjJqkYbzIfc4w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0c7cef81-1fe7-47fb-06ff-86a9536a9e8f@kernel.dk>
References: <0c7cef81-1fe7-47fb-06ff-86a9536a9e8f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0c7cef81-1fe7-47fb-06ff-86a9536a9e8f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190202
X-PR-Tracked-Commit-Id: 9a6d5488002fdca7134a0e59b0ae252f61042810
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8864cb70fd13beb57211982bf3b78b6629f1a68
Message-Id: <154913310448.3857.12780187813132962893.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Feb 2019 18:45:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 2 Feb 2019 09:34:16 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190202

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8864cb70fd13beb57211982bf3b78b6629f1a68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
