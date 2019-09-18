Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3C4C4CEC9
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 00:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F70821855
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 00:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568766326;
	bh=cTHdtlxrkS03dvudDawB23hdp5gIYMcHzOD/8e3bkrI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=H2WcHgskcJn00MxHj6TDwr5/Qs8AaaN97cf58PVuA2bGa3nj2Uzy6R/RDrNVp+eZr
	 VmyP3qSwblzWCmJNrIWhFHrpzZ9wOuq+nPYRB9/lh00J6QESzhx5+Urs6dUKgaCQa3
	 Ucphbp6yn7tqV6tKotFkhInOFSB9s9lBHj/PaS7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfIRAZ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 20:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfIRAZ0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 20:25:26 -0400
Subject: Re: [GIT PULL] io_uring changes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568766325;
        bh=cTHdtlxrkS03dvudDawB23hdp5gIYMcHzOD/8e3bkrI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JNdvFCsMtsM1c/3ojEbga7XN8FojHn2w9bCx3arAjT8EPuoUOD69D63UmNfspQyTV
         tjTnPZOjKksfJvp1u4qQtdkXiUAX4fqPo11iyZfjbWGSvQb0I2b/njWN21s+l2wp4j
         uLtXuifBdHeZy+Ir7kMUx6J8jpCL9vqpG1jnboGY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1559f166-52c3-532d-3523-d9b3e34a04b6@kernel.dk>
References: <1559f166-52c3-532d-3523-d9b3e34a04b6@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1559f166-52c3-532d-3523-d9b3e34a04b6@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 for-5.4/io_uring-2019-09-15
X-PR-Tracked-Commit-Id: 5277deaab9f98229bdfb8d1e30019b6c25052708
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e6fa3a33e6dbe4f24bcc4690950f2888d4bed3a
Message-Id: <156876632546.801.1849322595314373988.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 00:25:25 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 15 Sep 2019 17:53:13 -0600:

> git://git.kernel.dk/linux-block.git for-5.4/io_uring-2019-09-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e6fa3a33e6dbe4f24bcc4690950f2888d4bed3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
