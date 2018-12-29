Return-Path: <SRS0=+PfW=PG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECBCC43387
	for <linux-block@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B966E21909
	for <linux-block@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546047006;
	bh=GTm3/RQ4UofJbQ5TKWoVbuHJjqV+BXMf6Brb3uq7Jmk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NyDANoVCgq6E7IoEK3goBUP8Js53kYCptfgY5eaa0A9K9f1ZxnOeKEKrsXRQQoMfr
	 do6JZwpBZ2X8kI9HZ6JWOFryFp2ktrWvJzLnko8Obn8OqRmob7HEAoYIiLu7xYkr/y
	 OcRFNpviaMqXxfj7NN5GCPs/lzP2+0YRI9HhgS5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeL2BaF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbeL2BaF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Dec 2018 20:30:05 -0500
Subject: Re: [GIT PULL] Block changes for 4.21-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546047004;
        bh=GTm3/RQ4UofJbQ5TKWoVbuHJjqV+BXMf6Brb3uq7Jmk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZrUnXp4qOk5wWTxwsI7Wua6rqnidKHBAA8Unpqv4pj0j4vcdm44v9UUSZ+IaZicMh
         Ya30nKj+ng+DHsSGkaiLlB8W27qf2YN9LNM9FqQiR4S+QD+Kqa6YpNipPeBtm6mP0L
         qNLT7dn7hrBpMZFg65Z0LAaVlnfOvu3/hC070evM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <84df20e9-00af-37e5-c37f-ad7ff2437073@kernel.dk>
References: <84df20e9-00af-37e5-c37f-ad7ff2437073@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <84df20e9-00af-37e5-c37f-ad7ff2437073@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-4.21/block-20181221
X-PR-Tracked-Commit-Id: 00203ba40d40d7f33857416adfb18adaf0e40123
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e9da3fbf7d81f0f913b491c8de1ba7883d4f217
Message-Id: <20181229013004.17208.27269.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 01:30:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 20 Dec 2018 21:04:50 -0700:

> git://git.kernel.dk/linux-block.git tags/for-4.21/block-20181221

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e9da3fbf7d81f0f913b491c8de1ba7883d4f217

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
