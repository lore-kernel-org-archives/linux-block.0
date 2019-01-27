Return-Path: <SRS0=IU7b=QD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24384C282CA
	for <linux-block@archiver.kernel.org>; Sun, 27 Jan 2019 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C912146E
	for <linux-block@archiver.kernel.org>; Sun, 27 Jan 2019 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548615908;
	bh=Efdndb+c5lcIMo3FjnbuDk708FrNQiZ09BVRu67LjUI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZYUp/5ROYWVwzlH2F3sS5/1+kLBMCernGf2Lu+DkDT49w8xYGEs7aYSj9Z2ZFtthF
	 ye5H2HaGj7BerGNrzlrJBeeSN4g3YSFNQP01aRAURdoBYzYmVURZiy1uatmb0NcJ3r
	 PeU5sluIKadTvB4eNOZer28mzuZPy91XStiGtnB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfA0TFG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Jan 2019 14:05:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfA0TFF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Jan 2019 14:05:05 -0500
Subject: Re: [GIT PULL] Single block revert for 5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548615905;
        bh=Efdndb+c5lcIMo3FjnbuDk708FrNQiZ09BVRu67LjUI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ybdhHbstGKWh1t09HruT6tlZFHMzLJAxx0VY6up+PsNsGDOYdXPq6qo7U9r2TTn/c
         g15UUOtCWs0PkyGAfvAqxeXrhA41aSnKqtJkMg5+JAg0ccktDaXICNusP9srdm+TRZ
         9ARSFLwaqKtwhpwjglgce5s7m7xivdRZuxFZOIBM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c47c7c79-5fda-bd0e-f308-5e989cc2cacc@kernel.dk>
References: <c47c7c79-5fda-bd0e-f308-5e989cc2cacc@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c47c7c79-5fda-bd0e-f308-5e989cc2cacc@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190127
X-PR-Tracked-Commit-Id: 947b7ac135b16aa60f9141ff72bd494eda0edb5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 419967d53fc74bb151cdc9a00d0df80a2cc37173
Message-Id: <154861590524.4831.15684644815086199807.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Jan 2019 19:05:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 27 Jan 2019 06:54:23 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190127

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/419967d53fc74bb151cdc9a00d0df80a2cc37173

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
