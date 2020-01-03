Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89972C2D0C2
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 20:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8422253D
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 20:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578084011;
	bh=0NsOmgi90q1K0lU+bt2PIwrj1JnZDmRaUXtbq0qtfko=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nmmRfRzwWp6J+1CjlIZ3iXSa12wBzgJ0r4qZW473SJlBYNX1nIv5vl5+mrpVlIGPZ
	 yIaqLRIMFYvZSWISeds33vWmd5UFjeZngDx0e5Lxy54/+q6Boxt5SoV7IMqMSMp5TW
	 c4igKVwF9ia/cGhRUKhvPS5uZ4lEzbnCnYh28YPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgACUkJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jan 2020 15:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbgACUkJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Jan 2020 15:40:09 -0500
Subject: Re: [GIT PULL] Block fixes for 5.5-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578084008;
        bh=0NsOmgi90q1K0lU+bt2PIwrj1JnZDmRaUXtbq0qtfko=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BMDeB/IHMrR61aF/Edxa4+HrPcZXY0KfCBSvQXRJ1ndl4N/vWCxB+rjq58KgCSWPh
         Z8ZcRiEz5yO532ZD5rgPRq93TGJTWSk8pFjd23nnxYkl36ernTKtcNPlpR3IkXV7f4
         cIMJ4vULY5hHCT9TSAHXOC1RXajv4OAsrt7GVlek=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a947b677-cf96-0126-9e42-31d478d0c897@kernel.dk>
References: <a947b677-cf96-0126-9e42-31d478d0c897@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a947b677-cf96-0126-9e42-31d478d0c897@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.5-20200103
X-PR-Tracked-Commit-Id: c7d776f85dfe5159ebf621ee1e50e555237b1a25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6b4aafc99d7c8dbf7d9429bf054b591daab1ad0
Message-Id: <157808400860.14632.8909034110478439823.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jan 2020 20:40:08 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 3 Jan 2020 09:27:15 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.5-20200103

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6b4aafc99d7c8dbf7d9429bf054b591daab1ad0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
