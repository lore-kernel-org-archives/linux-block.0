Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40443C433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 22:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8B120684
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 22:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbhAVWgl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:36:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728420AbhAVWgR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 17:36:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id F3F8623AA1;
        Fri, 22 Jan 2021 22:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611354937;
        bh=nKsot06SVVGVyPb8Gtw+UyWwGDBBNWWxZ3aL2F4Jp4Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FXTGL8P8mQxrdeIJbn0cybDT1BYrjwLoOjxvuWI3QSDHGDBRgSM0wDRUjtn6Pl0tF
         qMVCxwp1wd5pNiLGL/I2RUPFu5Ta69Jve48OARI96horzLC9hWQC8emOC6GXhKv6Bz
         ofdBJEZT/VCg8GDvsS+R0FXc5yvLaOdSQ8p3T4mupZ/wCwmy3GKARS//B07POq3auu
         Uxrf0qKXt7+x8SVv0aCe9kZlXphye90k849brFQIoLMp2auDnG8UffCnJrcLmSG2ap
         ACMZljabb8rs1qAx7NbpWuG/uLZsk5eVEBomPbdi0cnDlmQ+LQ50ZwL3ySYth4S5Pl
         MMR8dwKhFsFnA==
Subject: Re: [git pull] device mapper fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210122222445.GA14822@redhat.com>
References: <20210122222445.GA14822@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210122222445.GA14822@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.11/dm-fixes-2
X-PR-Tracked-Commit-Id: 809b1e4945774c9ec5619a8f4e2189b7b3833c0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe75a21824e78405b8d812421974524092250c63
Message-Id: <161135493682.18620.13368578806910993868.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jan 2021 22:35:36 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Ignat Korchagin <ignat@cloudflare.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 22 Jan 2021 17:24:45 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.11/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe75a21824e78405b8d812421974524092250c63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
