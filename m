Return-Path: <SRS0=FTzM=TI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747BFC004C9
	for <linux-block@archiver.kernel.org>; Wed,  8 May 2019 02:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455A321655
	for <linux-block@archiver.kernel.org>; Wed,  8 May 2019 02:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557283220;
	bh=LMul2wG9S8Aw9BDODzniiYQcXqdqu3C1HB+oTmGXh3Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vQJ4pjcLX4ojOPG5bRMz8z+nMbbjwLOosLFD1PxhOFbz/n7kvxQ2QLbhJoE/S6w7l
	 +uv1UgmofVRnnnq0qs0JHLtly/DiTLFAma6ht+ccsiaOLz6ZtMn/OwOmStMV9xIxEr
	 2GVHkwnV/ETBFqcnRT6QsBh7o/XgZpEhpkTsF00o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfEHCkS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 May 2019 22:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfEHCkS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 May 2019 22:40:18 -0400
Subject: Re: [GIT PULL] Block changes for 5.2-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557283217;
        bh=LMul2wG9S8Aw9BDODzniiYQcXqdqu3C1HB+oTmGXh3Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ukrtpuzQ3kEbW/Cll7e0p5ZVC7KKB8WDAGwr/JIHB+RcWf9RWnXJJr6ndxxXxL/++
         NI/G2Vd/JUuarkQoQEjf+WP7rn1A1r3TYMS85dzB4siO5kl0t83M6IBa7OHpFTSzVs
         2qCQuYt6rX+18qbJbyF2rgeQPLC2RV5evRJxSTDQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7bdf9bf7-d3da-4f1f-f7b8-d972e8610519@kernel.dk>
References: <7bdf9bf7-d3da-4f1f-f7b8-d972e8610519@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <7bdf9bf7-d3da-4f1f-f7b8-d972e8610519@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.2/block-20190507
X-PR-Tracked-Commit-Id: b8753433fc611e23e31300e1d099001a08955c88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67a242223958d628f0ba33283668e3ddd192d057
Message-Id: <155728321791.19924.10564344351584426620.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 02:40:17 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 13:38:33 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.2/block-20190507

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67a242223958d628f0ba33283668e3ddd192d057

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
