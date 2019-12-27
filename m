Return-Path: <SRS0=cIu3=2R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5213C2D0DA
	for <linux-block@archiver.kernel.org>; Fri, 27 Dec 2019 19:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C52120CC7
	for <linux-block@archiver.kernel.org>; Fri, 27 Dec 2019 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577475911;
	bh=lB7IjHJQ8z1+hs8J/Gfr4HB4tr/vjAD7I/Ry2b5LdxY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bZfyd2soDJLQG3ETVS7pNgMdy/DjOkzbtMlCEWv4Aq3iXkAJhGHJxWGM63++JVbvM
	 Lqq+ck13Xz40e0cJ0TLNbTZak09MeUTLaN3QQSr7i5H+JQl+pOZveqs1yEBgUMsNwo
	 OfrFVxn/wOEPMYISfs5YIpUBzKDf4tO4Ka6mj1A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfL0TpK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Dec 2019 14:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfL0TpK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Dec 2019 14:45:10 -0500
Subject: Re: [GIT PULL] Block fixes for 5.5-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577475909;
        bh=lB7IjHJQ8z1+hs8J/Gfr4HB4tr/vjAD7I/Ry2b5LdxY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rwERnuAu67dmoPBDihAHTwPgSH/QNSEUlLGkz6YUgLxuuJFZBKCAkWgsKOkv1zi1M
         ki1RAFgeI6NQSejOCrnFCMK3iqLXkH1jTWpWMR10zSoZH7XMR1TevJ/Wvt4E9PEXxU
         O2XuI9jCmuZzGArna7dHv3H7wl9PbZvjUzTikz+g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1f9f9707-dc6a-38bd-d8fe-0ab67b1f9a03@kernel.dk>
References: <1f9f9707-dc6a-38bd-d8fe-0ab67b1f9a03@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1f9f9707-dc6a-38bd-d8fe-0ab67b1f9a03@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.5-20191226
X-PR-Tracked-Commit-Id: b2c0fcd28772f99236d261509bcd242135677965
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ae40a6951a72c59f2f6a0b721ce0e43bbcffcab
Message-Id: <157747590975.1730.10764164034470811829.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Dec 2019 19:45:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 26 Dec 2019 11:17:04 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.5-20191226

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ae40a6951a72c59f2f6a0b721ce0e43bbcffcab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
