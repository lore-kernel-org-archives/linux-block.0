Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75005C4361A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 21:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B79022D2A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 21:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgLDVgR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 16:36:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgLDVgR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Dec 2020 16:36:17 -0500
Subject: Re: [git pull] device mapper fixes for 5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607117736;
        bh=gDkIUaSYOImpYOM9BtGF+QockZKAxLIQ7RkET0O0bDk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TIllPvNa3bkJePvJtt3YtkHs6J4XQkmV/du/Cv3Vd3fp0X7a3D98nYMDXaiqtcdZC
         v5/YRnYbLcfKV17kcehYteeO7m6C2syRNwuCjSF98jTp6R25pQ6Dc86lnQzqmc8cbs
         NU7KMyNDTAXbc9ASZmF5QpdF9h4prjpHwzLrRaiJXq9nXsBnZM6P8HQShx3sGtrahJ
         GQB5iCKEhOKg7j5IYsWy2QSV+h5rQfk7zhpZKT8zVlLdC2jLeAx3xVVOhFkwcCN709
         C7hSYaAaYioNUSFtPv0kfxTc+X2JX4rJv1eex8lX+F9BKNBlhvo0ebDL6acXO9+MtF
         yK5kwHbBztNUA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201204210521.GA3937@redhat.com>
References: <20201204210521.GA3937@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201204210521.GA3937@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.10/dm-fixes
X-PR-Tracked-Commit-Id: bde3808bc8c2741ad3d804f84720409aee0c2972
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3298500b23f0b53a8d81e0d5ad98a29db71f4f0
Message-Id: <160711773655.16738.13830016046956700847.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Dec 2020 21:35:36 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sergei Shtepa <sergei.shtepa@veeam.com>,
        Thomas Gleixner <tglx@linutronix.de>, axboe@kernel.dk,
        vgoyal@redhat.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 4 Dec 2020 16:05:21 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.10/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3298500b23f0b53a8d81e0d5ad98a29db71f4f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
