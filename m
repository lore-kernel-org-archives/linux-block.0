Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3215BC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 23:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003C820869
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 23:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545177309;
	bh=PWX3GxJLUfei3pq4d5+bb3EiiDT4fep6WL3xQtSp3zQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=stArRfyxbiqjw0RU8iKydN5kIypurdMOIEHdNjhIHKDqEcpZ32UwqPwjjar+9hK2D
	 DRaFla6Xe1hB/HJnkmzNL4Lozn7olTtxZYxQJl0GM26zHsh+MoyUUqI1mQVM0H3TU9
	 2Ct8b8wh3KyXmdLJmSwzpKkP10ZJWf9TvzExV4Ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeLRXzI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:55:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeLRXzD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 18:55:03 -0500
Subject: Re: [GIT PULL] Single block fix for 4.20-final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545177302;
        bh=PWX3GxJLUfei3pq4d5+bb3EiiDT4fep6WL3xQtSp3zQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ss30qEgyUQVCcDdeZaM94sWLc2m4uVJ2FbUiKnvphgmMav9xgN08zl5Ly3kbdHTwI
         8diYj7II2MEjBYDDO8WJVIgaqHWtQkjiwzT829Uzy7m+Z/0PQkL2XGj60a4UUyjLnA
         r9fotfbl22WHruXqubPFwqGkKtjyI0rBwzwC0W9U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4a76a25a-eac8-c76f-0b0f-e327c56ff44e@kernel.dk>
References: <4a76a25a-eac8-c76f-0b0f-e327c56ff44e@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4a76a25a-eac8-c76f-0b0f-e327c56ff44e@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20181218
X-PR-Tracked-Commit-Id: 98256376f81ab7afd8dd233b99c78356159c21d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62393dbcbe0f3001691e4bd479a25beb5941f2ed
Message-Id: <20181218235502.14649.59760.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 18 Dec 2018 23:55:02 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 18 Dec 2018 15:37:51 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20181218

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62393dbcbe0f3001691e4bd479a25beb5941f2ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
