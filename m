Return-Path: <SRS0=xoF3=VK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46089C31E40
	for <linux-block@archiver.kernel.org>; Sat, 13 Jul 2019 19:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1918E2064A
	for <linux-block@archiver.kernel.org>; Sat, 13 Jul 2019 19:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563046814;
	bh=PF8iQYV/8TxirKXHYU9i9JtEf4Z9fczxePdpzDBIyaI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=eVbSZvzv4vc9RUJVFQtaYt44NaX2C3Vez32E9L348rW+cVuQ+ccwroQ7B5si41144
	 CsQZ2MG/UdEUUiLRRxZqKV6EwIZqMFHPw5qslv72FEMLj8/uhVuIizCIAfeHZzSev0
	 zEs+nLoShtBFcJ5tX2LfhH4C8ujIdwFOyv8XmhRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfGMTkN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Jul 2019 15:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbfGMTkN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Jul 2019 15:40:13 -0400
Subject: Re: [GIT PULL] io_uring changes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563046812;
        bh=PF8iQYV/8TxirKXHYU9i9JtEf4Z9fczxePdpzDBIyaI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XOBPkybEec5K5J9XUVhRzew+FLDiYbNHPb2O19Aq8JQicSdswcx7iHuzGlj6xS0U3
         YKh3mGwRh4wLPTUZ51pGZJ7J/VRADImiRbytW5zwWt9CDDY7L/5/2U4o0ld+D9AXC9
         kE55THlZrRfwzFlCTW2BSIe8XIOQsbUCE6KMde+w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <10c55cd5-8fd2-12ad-248e-09ea58accd15@kernel.dk>
References: <10c55cd5-8fd2-12ad-248e-09ea58accd15@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <10c55cd5-8fd2-12ad-248e-09ea58accd15@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.3/io_uring-20190711
X-PR-Tracked-Commit-Id: a4c0b3decb33fb4a2b5ecc6234a50680f0b21e7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2d79c7174aeb43b13020dd53d85a7aefdd9f3e5
Message-Id: <156304681247.8604.1935307179680393763.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 19:40:12 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 09:19:27 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.3/io_uring-20190711

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2d79c7174aeb43b13020dd53d85a7aefdd9f3e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
