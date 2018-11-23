Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FFFC43610
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 19:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAAC2146F
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 19:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAAC2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441384AbeKXGPj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbeKXGPi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Nov 2018 01:15:38 -0500
Subject: Re: [GIT PULL] Block fix for 4.20-rc4
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B3D223CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d4234f36-e387-7eaa-85e8-dbd2eba422f8@kernel.dk>
References: <d4234f36-e387-7eaa-85e8-dbd2eba422f8@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d4234f36-e387-7eaa-85e8-dbd2eba422f8@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20181123
X-PR-Tracked-Commit-Id: 14b04063cc994effc86f976625bf8f806d8d44cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3381918fec9278d14f776d1dabd68da85fd6822e
Message-Id: <20181123193001.17450.42753.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 23 Nov 2018 19:30:01 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 23 Nov 2018 11:22:04 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20181123

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3381918fec9278d14f776d1dabd68da85fd6822e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
