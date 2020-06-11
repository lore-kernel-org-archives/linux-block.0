Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C5CC433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 23:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D634B2074B
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 23:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591919134;
	bh=aOcn6a/dSlPQvj9cF5jVTD4zm2DurpEm56APjWjVZ+I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oRxk8EqyaJTVrg0q1pqvKf8LAb7Xfh8VwJR5Ydx5ZIfQHoBgkYgBew8Zfl1QtWwDB
	 qOQSLjA8JJbbwWz8G6Hm2sJM2egrLv1QY/m2AEbQnPi5CpM9ucN3oU3QXCH7M16jR7
	 1VGCXpPaFMfEy5rITq56qXbUi499VND3iwmdR8Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgFKXpe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgFKXpd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 19:45:33 -0400
Subject: Re: [GIT PULL] Block fixes for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591919133;
        bh=aOcn6a/dSlPQvj9cF5jVTD4zm2DurpEm56APjWjVZ+I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aoo0XWB2QDHVAhKFt9S11Yke1AD+o+EjyMp8Tug1JB175wW8D1ele8v9Le/6GcKNt
         QtE5mofplNGyVOkuqPEd4z7GR91OCf2Kpn3g+qF037chRIHcYhVbihyBVkeW8fSii+
         9aINI/fMYd/8no4rKeejv05T4iZCFFNMLGtQ5bG4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fc27bd22-3954-5733-c503-bd45d51754e0@kernel.dk>
References: <fc27bd22-3954-5733-c503-bd45d51754e0@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <fc27bd22-3954-5733-c503-bd45d51754e0@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.8-2020-06-11
X-PR-Tracked-Commit-Id: 9a6a5738abf82d6f467a31f1f6779e495462f7af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a58dfea29731a93339529ce48fe239b383011c7c
Message-Id: <159191913302.19194.14898622114650456782.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 23:45:33 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 11 Jun 2020 15:31:26 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.8-2020-06-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a58dfea29731a93339529ce48fe239b383011c7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
