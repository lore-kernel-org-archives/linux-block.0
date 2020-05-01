Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD7BC47253
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 18:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F8621924
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588358120;
	bh=TkhIyTma0zyR6ve/jW8CsfxFwa8J6kLC3eLVYh4zzK0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gdD1hzavNBEbjzKwKERyA9cM4ERYAE7CkUtY6oBk2hFoYLXHiUHJa3lnvj9LphZvO
	 Op0keIX7q096TradcgnWAs9XIMErlnHtjxN4n5xv6d6iu/MuW/GpX1wttcMQC301ch
	 rTxZHSQFuzZ5L6j4RxqMt2LkrqhqJi3BVXnvolYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgEASfT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 14:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730255AbgEASfN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 May 2020 14:35:13 -0400
Subject: Re: [GIT PULL] Block fixes for 5.7-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588358113;
        bh=TkhIyTma0zyR6ve/jW8CsfxFwa8J6kLC3eLVYh4zzK0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dKcpcthfNEEtDESeeIT0/+60xsGNAwRa7HW90HNDxNaramUzxU62RvJ+BWtrymCzI
         L/eTOvDkObzl+IsZ3WOQ/kB2LnrbAnxL+n/w/nfzo7GPjDB6ahL8F3BrI2Vv/en9FX
         ubMLX6/Z875dYzoeqehTIjRpH+Is1QS7nV4JHeJ8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <dfe53ba2-7b06-bf9f-842e-36c06ba03f32@kernel.dk>
References: <dfe53ba2-7b06-bf9f-842e-36c06ba03f32@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <dfe53ba2-7b06-bf9f-842e-36c06ba03f32@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.7-2020-05-01
X-PR-Tracked-Commit-Id: 10c70d95c0f2f9a6f52d0e33243d2877370cef51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 052c467cb58748e302a95546925928e637025acc
Message-Id: <158835811352.18489.17330060870863593075.pr-tracker-bot@kernel.org>
Date:   Fri, 01 May 2020 18:35:13 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 1 May 2020 10:29:58 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.7-2020-05-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/052c467cb58748e302a95546925928e637025acc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
