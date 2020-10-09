Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D700C433E7
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 02:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B988622255
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 02:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602209445;
	bh=GE3YO7terAs296H/tcz+yFC5n/tB6g0gIrsq6GhX7sM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kRj0YCBw/efjAq2R3aDykiilzWC5inGMphG21Pmf2vDlI9r9A3k7PIEeMIGDglDpq
	 H53GQPiXksIHz/XYL0po4e1UR48FO3+6A977drYJFiGoKxyL7xyxzKoxXPljC/xeOr
	 jcOifcFfXHqtMUAZ0kY4O3OFx377rOhesSBJQjgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgJICKp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 22:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgJICKp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 22:10:45 -0400
Subject: Re: [GIT PULL] Block fixes for 5.9-final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602209444;
        bh=GE3YO7terAs296H/tcz+yFC5n/tB6g0gIrsq6GhX7sM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mPUh2zyZY2dkFO7LzEHoScFpcIhtlsgtKEZZwcD6KkSjvLQJxoVZwzfqB+jTgGfGZ
         1zk2+uxpdRJOulDdMVP+WdjinPdMf8g+iAzj3HLyQPw2VdV+y/Xjz9rdNaWGEoy8SV
         EsG0jSLl41hMM+IFWhH9rRmdIyuuTlcLZcpN+DTA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <29e650f4-7e4b-bd7b-57ab-15e762d38cff@kernel.dk>
References: <29e650f4-7e4b-bd7b-57ab-15e762d38cff@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <29e650f4-7e4b-bd7b-57ab-15e762d38cff@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block5.9-2020-10-08
X-PR-Tracked-Commit-Id: e0894cd618e420d7bacebadcd26b7193780332e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 583090b1b8232e6eae243a9009699666153a13a9
Message-Id: <160220944456.17795.6103535053680344522.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Oct 2020 02:10:44 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 8 Oct 2020 19:15:47 -0600:

> git://git.kernel.dk/linux-block.git tags/block5.9-2020-10-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/583090b1b8232e6eae243a9009699666153a13a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
