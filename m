Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5782C433FE
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 19:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67ED239EF
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgLMTkC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Dec 2020 14:40:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgLMTjy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Dec 2020 14:39:54 -0500
Subject: Re: [GIT PULL] Block fixes for 5.10 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607888350;
        bh=SDCxl9antZd9h3trjeolEPBcL46Ba4cSBPq8ap6A/c8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JNOIkwFmCjGB2WohEQnvsHcofVm1XdeYj2b+YEDRPpJvGSKgvWQUpjqcSeR6Mgcc8
         Ks++TSbSBdeVk+1elx2EC9bldmj5Uss0PMzoO4OlXrxwLFvxfDwUasej6B5028FyC4
         jpDrX74AV1NQBtE4PYPZztxCZIo6CmsxD6NtI71zwE2OAImD+2T0o3yuW1M+ls/8ti
         M2b3rMCb8nHpF1kl2Ckuanntsaw0dzks/NiBbgbshS3NiiYKzz+8XyDto0EM/7yNH1
         uRN3SEJfeao9JgtsWr5TR8LBVwNT4NzV4YmvItFHhs74Qmubz7Lt6xZzRDwM1Tpi8D
         DKtbP4Z03oWYg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6f7f4ba2-2de2-b6e7-cbf9-cbad3eaf72db@kernel.dk>
References: <6f7f4ba2-2de2-b6e7-cbf9-cbad3eaf72db@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <6f7f4ba2-2de2-b6e7-cbf9-cbad3eaf72db@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.10-2020-12-11
X-PR-Tracked-Commit-Id: 4223a5be80b8998d717c6b0e1000070e0e336bf3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ffeb1c3f8226244c08105bcdbeecc04bad6b89a
Message-Id: <160788835055.9552.11968249259025719209.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Dec 2020 19:39:10 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 11 Dec 2020 19:57:52 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.10-2020-12-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ffeb1c3f8226244c08105bcdbeecc04bad6b89a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
