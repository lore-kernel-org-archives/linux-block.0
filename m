Return-Path: <SRS0=alrN=OK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6865C64EB4
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 20:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B922147D
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 20:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B922147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725732AbeLBHSU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:18:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725735AbeLBHSU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 2 Dec 2018 02:18:20 -0500
Subject: Re: [GIT PULL] Block changes for 4.20-rc5
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B809921486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <356ff70c-9de6-12f6-ddc1-bb49d0f5df30@kernel.dk>
References: <356ff70c-9de6-12f6-ddc1-bb49d0f5df30@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <356ff70c-9de6-12f6-ddc1-bb49d0f5df30@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20181201
X-PR-Tracked-Commit-Id: 1c9b357ced0b2fd2c173c058c2de88af513bc064
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 880584176ed7875117a5ba76cf316cb60f7ad30b
Message-Id: <20181201200502.20294.88940.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 01 Dec 2018 20:05:02 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 1 Dec 2018 11:43:45 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20181201

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/880584176ed7875117a5ba76cf316cb60f7ad30b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
