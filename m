Return-Path: <SRS0=CX+6=YG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE139C4360C
	for <linux-block@archiver.kernel.org>; Sun, 13 Oct 2019 16:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989252084D
	for <linux-block@archiver.kernel.org>; Sun, 13 Oct 2019 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570983318;
	bh=l6XBWXor6bHxq5/+kJEol0LfgCMDffGfyLDqJaxCZdo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ab3KgkZKn3ABFiDcuXp2w+gacec4a+Ofp9oyZFmAeypn2TG7rY6RD4WBCT+fr9vSe
	 VyhiUxgLOP0E23ZmwjVx4qaArwK678u3brpxI1XFVWvybAOHZgjep3sPsZEhuWX8Z2
	 gjy+W6PlI/sEsleSgT70mOX6pNArg1E04RH7nQGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfJMQPI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Oct 2019 12:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbfJMQPI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Oct 2019 12:15:08 -0400
Subject: Re: [GIT PULL] Single io_uring fix for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570983307;
        bh=l6XBWXor6bHxq5/+kJEol0LfgCMDffGfyLDqJaxCZdo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zppTZiqgYVf4MWpGfgQxmAu38IPg0TzH0RQo6OZDQhyO6XAG3/ibX9e18toInvP21
         bjpPFFnCEMIfZByuy7qcyc4KyZqBKsHlBdV6lf+iwaeGsRp1vi7bSW3ehIGdK4QCHD
         NQYLS7dy0OjXlhzxFN5EbyEc8TBBq9c48XJWf8No=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5d635c9a-7373-2a12-2a0d-e94806c2c114@kernel.dk>
References: <5d635c9a-7373-2a12-2a0d-e94806c2c114@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5d635c9a-7373-2a12-2a0d-e94806c2c114@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20191012
X-PR-Tracked-Commit-Id: 7adf4eaf60f3d8c3584bed51fe7066d4dfc2cbe1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b27528b0279a84d889d40cb1b61962c8562cebb4
Message-Id: <157098330772.26372.7926616565615119046.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Oct 2019 16:15:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 11:03:03 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20191012

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b27528b0279a84d889d40cb1b61962c8562cebb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
